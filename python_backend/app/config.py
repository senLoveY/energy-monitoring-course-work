from __future__ import annotations

import os

TIMEZONE_OFFSET_MIN = -12
TIMEZONE_OFFSET_MAX = 14


class Settings:
    app_host: str = os.getenv("APP_HOST", "0.0.0.0")
    app_port: int = int(os.getenv("APP_PORT", "8081"))
    timezone_offset_hours: int = int(os.getenv("TIMEZONE_OFFSET_HOURS", "3"))
    database_url: str = os.getenv(
        "DATABASE_URL",
        "postgresql+psycopg2://user:root@localhost:5455/energy_monitoring",
    )
    report_server_base_url: str = os.getenv(
        "REPORT_SERVER_BASE_URL",
        "http://localhost:8081",
    )
    excel_data_path: str = os.getenv("EXCEL_DATA_PATH", "/app/data/input.xlsx")
    session_secret: str = os.getenv("SESSION_SECRET", "change-this-secret")
    admin_invite_code: str = os.getenv("ADMIN_INVITE_CODE", "admin123")
    default_admin_username: str = os.getenv("DEFAULT_ADMIN_USERNAME", "admin")
    default_admin_password: str = os.getenv("DEFAULT_ADMIN_PASSWORD", "admin123")
    mail_mailer: str = os.getenv("MAIL_MAILER", "smtp")
    mail_host: str = os.getenv("MAIL_HOST", "")
    mail_port: int = int(os.getenv("MAIL_PORT", "587"))
    mail_encryption: str = os.getenv("MAIL_ENCRYPTION", "tls").lower()
    mail_username: str = os.getenv("MAIL_USERNAME", "")
    mail_password: str = os.getenv("MAIL_PASSWORD", "")
    mail_from: str = os.getenv("MAIL_FROM", os.getenv("MAIL_USERNAME", "noreply@energy-monitoring.local"))


settings = Settings()
_timezone_offset_hours = settings.timezone_offset_hours


def get_timezone_offset_hours() -> int:
    return _timezone_offset_hours


def set_timezone_offset_hours(value: int) -> None:
    global _timezone_offset_hours
    if value < TIMEZONE_OFFSET_MIN or value > TIMEZONE_OFFSET_MAX:
        raise ValueError(f"Timezone offset must be between {TIMEZONE_OFFSET_MIN} and {TIMEZONE_OFFSET_MAX}")
    _timezone_offset_hours = value
