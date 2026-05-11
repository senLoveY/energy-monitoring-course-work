from __future__ import annotations

from datetime import datetime, timedelta
from random import Random

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.models import EnergyConsumption


def seed_energy_data_if_empty(db: Session) -> None:
    total_rows = db.scalar(select(func.count()).select_from(EnergyConsumption)) or 0
    if total_rows > 0:
        return

    devices = [
        ("QF 1,26", "ЗУ", "PzS 12V", "1"),
        ("QF 1,27", "ЗУ", "PzS 12V", "2"),
        ("QF 1,28", "ЗУ", "PzS 12V", "3"),
        ("QF 2,28", "ЗУ", "PzS 12V", "4"),
        ("QF 2,27", "ЗУ", "PzS 12V", "5"),
        ("QF 2,26", "ЗУ", "PzS 12V", "6"),
    ]
    rng = Random(42)

    base_day = datetime(2025, 3, 31, 0, 0, 0)
    rows: list[EnergyConsumption] = []

    # Два дня по 48 получасовых интервалов на каждое устройство.
    for day_offset in range(2):
        for step in range(48):
            save_time = base_day + timedelta(days=day_offset, minutes=30 * step)
            hour = save_time.hour + save_time.minute / 60.0

            for idx, (device_class, device_type, device_name, group_id) in enumerate(devices):
                # Простая синтетика: ночное падение + дневной рост + небольшой шум.
                base = 8 + idx * 2.5
                activity = 12 * max(0, 1 - abs(hour - 10) / 10)
                noise = rng.uniform(-1.2, 1.2)
                value = max(0.0, round(base + activity + noise, 2))

                rows.append(
                    EnergyConsumption(
                        device_class=device_class,
                        device_type=device_type,
                        device_name=device_name,
                        id_in_group=group_id,
                        save_time=save_time,
                        energy_kwh=value,
                    )
                )

    db.add_all(rows)
    db.commit()
