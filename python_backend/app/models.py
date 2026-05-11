from __future__ import annotations

from datetime import date, datetime

from sqlalchemy import BigInteger, Boolean, Date, DateTime, Float, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from app.database import Base
from app.timeutils import now_local_naive


class EnergyConsumption(Base):
    __tablename__ = "energy_consumption"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    device_class: Mapped[str] = mapped_column(String(100), nullable=False)
    device_type: Mapped[str] = mapped_column(String(50), nullable=False)
    device_name: Mapped[str] = mapped_column(String(50), nullable=False, index=True)
    id_in_group: Mapped[str | None] = mapped_column(String(50))
    save_time: Mapped[datetime] = mapped_column(DateTime, nullable=False, index=True)
    energy_kwh: Mapped[float | None] = mapped_column(Float)


class AppSetting(Base):
    __tablename__ = "app_settings"

    key: Mapped[str] = mapped_column(String(64), primary_key=True)
    value: Mapped[str] = mapped_column(String(255), nullable=False)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, onupdate=now_local_naive, nullable=False)


class AppUser(Base):
    __tablename__ = "app_users"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    username: Mapped[str] = mapped_column(String(64), unique=True, nullable=False, index=True)
    password_hash: Mapped[str] = mapped_column(String(256), nullable=False)
    role: Mapped[str] = mapped_column(String(16), nullable=False, default="observer", index=True)
    is_blocked: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)
    blocked_at: Mapped[datetime | None] = mapped_column(DateTime)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False, index=True)


class AdminInviteCode(Base):
    __tablename__ = "admin_invite_codes"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    code: Mapped[str] = mapped_column(String(40), unique=True, nullable=False, index=True)
    created_by_user_id: Mapped[int] = mapped_column(ForeignKey("app_users.id"), nullable=False)
    used_by_user_id: Mapped[int | None] = mapped_column(ForeignKey("app_users.id"))
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False)
    used_at: Mapped[datetime | None] = mapped_column(DateTime, index=True)


class ReportSchedule(Base):
    __tablename__ = "report_schedules"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    recipient_email: Mapped[str] = mapped_column(String(255), nullable=False)
    group_id: Mapped[str] = mapped_column(String(32), nullable=False, default="all")
    export_format: Mapped[str] = mapped_column(String(16), nullable=False, default="both")
    template_mode: Mapped[str] = mapped_column(String(16), nullable=False, default="detailed")
    send_time: Mapped[str] = mapped_column(String(5), nullable=False, default="08:00", index=True)
    is_enabled: Mapped[bool] = mapped_column(Boolean, nullable=False, default=True, index=True)
    created_by_user_id: Mapped[int] = mapped_column(ForeignKey("app_users.id"), nullable=False)
    last_run_on: Mapped[date | None] = mapped_column(Date)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False, index=True)


class ReportDispatchQueue(Base):
    __tablename__ = "report_dispatch_queue"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    recipient_email: Mapped[str] = mapped_column(String(255), nullable=False)
    report_date: Mapped[date] = mapped_column(Date, nullable=False)
    group_id: Mapped[str] = mapped_column(String(32), nullable=False, default="all")
    export_format: Mapped[str] = mapped_column(String(16), nullable=False)
    template_mode: Mapped[str] = mapped_column(String(16), nullable=False, default="detailed")
    status: Mapped[str] = mapped_column(String(24), nullable=False, default="pending", index=True)
    attempts: Mapped[int] = mapped_column(Integer, nullable=False, default=0)
    max_attempts: Mapped[int] = mapped_column(Integer, nullable=False, default=3)
    next_attempt_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=now_local_naive, index=True)
    last_error: Mapped[str | None] = mapped_column(Text)
    requested_by_user_id: Mapped[int | None] = mapped_column(ForeignKey("app_users.id"))
    schedule_id: Mapped[int | None] = mapped_column(ForeignKey("report_schedules.id"))
    sent_at: Mapped[datetime | None] = mapped_column(DateTime)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False, index=True)


class EmailReportLog(Base):
    __tablename__ = "email_report_logs"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    queue_item_id: Mapped[int | None] = mapped_column(ForeignKey("report_dispatch_queue.id"))
    requested_by_user_id: Mapped[int | None] = mapped_column(ForeignKey("app_users.id"))
    recipient_email: Mapped[str] = mapped_column(String(255), nullable=False)
    report_date: Mapped[date] = mapped_column(Date, nullable=False)
    group_id: Mapped[str] = mapped_column(String(32), nullable=False, default="all")
    export_format: Mapped[str] = mapped_column(String(16), nullable=False)
    template_mode: Mapped[str] = mapped_column(String(16), nullable=False, default="detailed")
    status: Mapped[str] = mapped_column(String(24), nullable=False, index=True)
    error_message: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False, index=True)
    sent_at: Mapped[datetime | None] = mapped_column(DateTime)


class AuditLog(Base):
    __tablename__ = "audit_logs"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    actor_user_id: Mapped[int | None] = mapped_column(ForeignKey("app_users.id"))
    action: Mapped[str] = mapped_column(String(64), nullable=False)
    entity_type: Mapped[str] = mapped_column(String(64), nullable=False)
    entity_id: Mapped[str | None] = mapped_column(String(64))
    details_json: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False, index=True)


class IncidentLog(Base):
    __tablename__ = "incident_logs"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    occurred_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, index=True)
    incident_type: Mapped[str] = mapped_column(String(32), nullable=False)
    severity: Mapped[str] = mapped_column(String(16), nullable=False, default="medium")
    group_id: Mapped[str] = mapped_column(String(32), nullable=False, default="all", index=True)
    device_name: Mapped[str | None] = mapped_column(String(120), index=True)
    title: Mapped[str] = mapped_column(String(160), nullable=False)
    description: Mapped[str | None] = mapped_column(Text)
    created_by_user_id: Mapped[int] = mapped_column(ForeignKey("app_users.id"), nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=now_local_naive, nullable=False, index=True)
