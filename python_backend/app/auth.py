from __future__ import annotations

from datetime import datetime
import hashlib
import hmac
import os
import secrets

from sqlalchemy import select, text
from sqlalchemy.orm import Session

from app.config import settings
from app.models import AdminInviteCode, AppUser
from app.timeutils import now_local_naive


def hash_password(password: str) -> str:
    salt = os.urandom(16)
    digest = hashlib.pbkdf2_hmac("sha256", password.encode("utf-8"), salt, 120_000)
    return f"{salt.hex()}${digest.hex()}"


def verify_password(password: str, password_hash: str) -> bool:
    try:
        salt_hex, digest_hex = password_hash.split("$", maxsplit=1)
    except ValueError:
        return False
    salt = bytes.fromhex(salt_hex)
    expected = bytes.fromhex(digest_hex)
    actual = hashlib.pbkdf2_hmac("sha256", password.encode("utf-8"), salt, 120_000)
    return hmac.compare_digest(actual, expected)


def ensure_default_admin(db: Session) -> None:
    stmt = select(AppUser).where(AppUser.username == settings.default_admin_username)
    existing = db.scalar(stmt)
    if existing is not None:
        return

    db.add(
        AppUser(
            username=settings.default_admin_username,
            password_hash=hash_password(settings.default_admin_password),
            role="admin",
        )
    )
    db.commit()


def ensure_auth_schema(db: Session) -> None:
    # create_all не обновляет уже существующие таблицы, поэтому добавляем новые поля безопасно.
    db.execute(text("ALTER TABLE app_users ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN NOT NULL DEFAULT FALSE"))
    db.execute(text("ALTER TABLE app_users ADD COLUMN IF NOT EXISTS blocked_at TIMESTAMP NULL"))
    db.execute(
        text(
            """
            CREATE TABLE IF NOT EXISTS admin_invite_codes (
                id BIGSERIAL PRIMARY KEY,
                code VARCHAR(40) UNIQUE NOT NULL,
                created_by_user_id BIGINT NOT NULL REFERENCES app_users(id),
                used_by_user_id BIGINT NULL REFERENCES app_users(id),
                created_at TIMESTAMP NOT NULL DEFAULT NOW(),
                used_at TIMESTAMP NULL
            )
            """
        )
    )
    db.execute(
        text(
            """
            CREATE TABLE IF NOT EXISTS incident_logs (
                id BIGSERIAL PRIMARY KEY,
                occurred_at TIMESTAMP NOT NULL,
                incident_type VARCHAR(32) NOT NULL,
                severity VARCHAR(16) NOT NULL DEFAULT 'medium',
                group_id VARCHAR(32) NOT NULL DEFAULT 'all',
                device_name VARCHAR(120) NULL,
                title VARCHAR(160) NOT NULL,
                description TEXT NULL,
                created_by_user_id BIGINT NOT NULL REFERENCES app_users(id),
                created_at TIMESTAMP NOT NULL DEFAULT NOW()
            )
            """
        )
    )
    db.execute(text("ALTER TABLE incident_logs ADD COLUMN IF NOT EXISTS device_name VARCHAR(120) NULL"))
    # Индексы для ускорения отчетов, ленты инцидентов и фоновой очереди.
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_energy_consumption_save_time ON energy_consumption (save_time)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_energy_consumption_device_name ON energy_consumption (device_name)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_app_users_role ON app_users (role)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_app_users_created_at ON app_users (created_at)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_admin_invite_codes_used_at ON admin_invite_codes (used_at)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_incident_logs_occurred_at ON incident_logs (occurred_at)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_incident_logs_group_id ON incident_logs (group_id)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_incident_logs_device_name ON incident_logs (device_name)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_report_schedules_send_time ON report_schedules (send_time)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_report_schedules_is_enabled ON report_schedules (is_enabled)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_report_schedules_created_at ON report_schedules (created_at)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_report_dispatch_queue_status ON report_dispatch_queue (status)"))
    db.execute(
        text("CREATE INDEX IF NOT EXISTS ix_report_dispatch_queue_next_attempt_at ON report_dispatch_queue (next_attempt_at)")
    )
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_report_dispatch_queue_created_at ON report_dispatch_queue (created_at)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_email_report_logs_status ON email_report_logs (status)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_email_report_logs_created_at ON email_report_logs (created_at)"))
    db.execute(text("CREATE INDEX IF NOT EXISTS ix_audit_logs_created_at ON audit_logs (created_at)"))
    db.execute(text("UPDATE app_users SET role = 'operator' WHERE role = 'user'"))
    db.commit()


def _build_admin_code() -> str:
    return f"ADM-{secrets.token_hex(4).upper()}-{secrets.token_hex(3).upper()}"


def generate_admin_invite_code(db: Session, created_by_user_id: int) -> AdminInviteCode:
    for _ in range(5):
        candidate = _build_admin_code()
        exists = db.scalar(select(AdminInviteCode).where(AdminInviteCode.code == candidate))
        if exists is None:
            record = AdminInviteCode(code=candidate, created_by_user_id=created_by_user_id)
            db.add(record)
            db.commit()
            db.refresh(record)
            return record
    raise RuntimeError("Не удалось сгенерировать уникальный admin-код")


def get_available_admin_invite(db: Session, code: str) -> AdminInviteCode | None:
    normalized = code.strip().upper()
    if not normalized:
        return None
    return db.scalar(
        select(AdminInviteCode).where(
            AdminInviteCode.code == normalized,
            AdminInviteCode.used_at.is_(None),
        )
    )


def consume_admin_invite(db: Session, invite: AdminInviteCode, used_by_user_id: int) -> None:
    invite.used_by_user_id = used_by_user_id
    invite.used_at = now_local_naive()
