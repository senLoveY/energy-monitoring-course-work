from __future__ import annotations

from datetime import date, datetime, timedelta, timezone

from app.config import get_timezone_offset_hours


def now_local_naive() -> datetime:
    tz = timezone(timedelta(hours=get_timezone_offset_hours()))
    return datetime.now(timezone.utc).astimezone(tz).replace(tzinfo=None)


def today_local() -> date:
    return now_local_naive().date()
