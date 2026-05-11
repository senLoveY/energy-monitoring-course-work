from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from datetime import date, datetime, time, timedelta
import random
from typing import Iterable

from sqlalchemy import and_, asc, delete, select
from sqlalchemy.orm import Session

from app.models import EnergyConsumption


@dataclass(frozen=True)
class DeviceKey:
    device_class: str
    device_type: str
    device_name: str
    id_in_group: str | None


def _daterange(start: date, end: date) -> Iterable[date]:
    day = start
    while day <= end:
        yield day
        day += timedelta(days=1)


def backfill_like_excel_profile(
    db: Session,
    profile_start: datetime,
    profile_end: datetime,
    target_start: date,
    target_end: date,
) -> int:
    stmt = (
        select(EnergyConsumption)
        .where(
            and_(
                EnergyConsumption.save_time >= profile_start,
                EnergyConsumption.save_time <= profile_end,
            )
        )
        .order_by(asc(EnergyConsumption.save_time))
    )
    profile_rows = list(db.scalars(stmt).all())
    if not profile_rows:
        return 0

    # Очистка целевого диапазона, чтобы backfill был идемпотентным.
    db.execute(
        delete(EnergyConsumption).where(
            and_(
                EnergyConsumption.save_time >= datetime.combine(target_start, time.min),
                EnergyConsumption.save_time <= datetime.combine(target_end, time.max),
            )
        )
    )
    db.commit()

    by_slot_and_device: dict[tuple[int, DeviceKey], list[float]] = defaultdict(list)
    for row in profile_rows:
        slot = row.save_time.hour * 60 + row.save_time.minute
        key = DeviceKey(
            device_class=row.device_class,
            device_type=row.device_type,
            device_name=row.device_name,
            id_in_group=row.id_in_group,
        )
        by_slot_and_device[(slot, key)].append(float(row.energy_kwh or 0.0))

    slot_device_avg: dict[tuple[int, DeviceKey], float] = {
        k: (sum(v) / len(v) if v else 0.0) for k, v in by_slot_and_device.items()
    }

    # Небольшая дневная вариативность, чтобы не было идеально одинаковых суток.
    rng = random.Random(20250501)
    total_inserted = 0
    batch: list[EnergyConsumption] = []

    for current_day in _daterange(target_start, target_end):
        weekday = current_day.weekday()
        # По выходным чуть ниже средняя нагрузка.
        day_factor = 0.95 if weekday >= 5 else 1.02
        day_factor += rng.uniform(-0.04, 0.04)

        for (slot, key), avg in slot_device_avg.items():
            hh, mm = divmod(slot, 60)
            base = max(0.0, avg * day_factor)
            # Шум пропорционален нагрузке.
            noise = rng.uniform(-0.12, 0.12) * max(0.6, avg)
            value = max(0.0, round(base + noise, 4))

            batch.append(
                EnergyConsumption(
                    device_class=key.device_class,
                    device_type=key.device_type,
                    device_name=key.device_name,
                    id_in_group=key.id_in_group,
                    save_time=datetime.combine(current_day, time(hour=hh, minute=mm)),
                    energy_kwh=value,
                )
            )

            if len(batch) >= 5000:
                db.add_all(batch)
                db.commit()
                total_inserted += len(batch)
                batch.clear()

    if batch:
        db.add_all(batch)
        db.commit()
        total_inserted += len(batch)

    return total_inserted
