from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from datetime import date, datetime, time, timedelta
import json

from sqlalchemy import asc, func, select
from sqlalchemy.orm import Session

from app.models import EnergyConsumption
from app.timeutils import now_local_naive


class ReportDataNotFound(Exception):
    pass


@dataclass
class DeviceActivity:
    id: str
    name: str


@dataclass
class DeviceGroup:
    id: str
    label: str


class EnergyConsumptionService:
    def __init__(self, db: Session) -> None:
        self.db = db

    @staticmethod
    def _group_key(device_name: str | None) -> str:
        if not device_name:
            return "UNKNOWN"
        return device_name.split()[0].upper()

    @staticmethod
    def _group_label(device_name: str | None) -> str:
        if not device_name:
            return "Unknown"
        return device_name.split()[0]

    def _for_day(self, day: date) -> list[EnergyConsumption]:
        start = datetime.combine(day, time.min)
        end = start + timedelta(days=1)
        stmt = (
            select(EnergyConsumption)
            .where(EnergyConsumption.save_time >= start, EnergyConsumption.save_time < end)
            .order_by(asc(EnergyConsumption.save_time))
        )
        return list(self.db.scalars(stmt).all())

    def _filter_by_group(self, rows: list[EnergyConsumption], group: str) -> list[EnergyConsumption]:
        if group == "all":
            return rows
        return [row for row in rows if self._group_key(row.device_name) == group]

    def get_available_groups(self) -> list[DeviceGroup]:
        stmt = select(EnergyConsumption.device_name).distinct().order_by(asc(EnergyConsumption.device_name))
        names = [row[0] for row in self.db.execute(stmt).all() if row[0]]
        groups: dict[str, str] = {}
        for name in names:
            key = self._group_key(name)
            groups.setdefault(key, self._group_label(name))
        return [DeviceGroup(id=gid, label=label) for gid, label in sorted(groups.items())]

    def build_activity_report(self, day: date, group: str = "all") -> dict:
        all_day_consumptions = self._for_day(day)
        consumptions = self._filter_by_group(all_day_consumptions, group)
        available_groups = self.get_available_groups()

        if not consumptions:
            suffix = "" if group == "all" else f" для группы {group}"
            raise ReportDataNotFound(f"Нет данных о потреблении за {day.isoformat()}{suffix}")

        peak = max(consumptions, key=lambda x: x.energy_kwh or 0.0)
        low = min(consumptions, key=lambda x: x.energy_kwh or 0.0)
        total = round(sum(x.energy_kwh or 0.0 for x in consumptions), 2)
        trend = self._calculate_consumption_trend(day, total, group)
        devices = self._distinct_devices(consumptions)
        records = self._activity_records(consumptions, devices)
        chart_labels, chart_datasets = self._chart_data(consumptions, group=group)

        return {
            "report_date": day.isoformat(),
            "selected_group": group,
            "available_groups": available_groups,
            "devices": devices,
            "consumption_records": records,
            "consumption_records_last_hour": self._records_last_hour(records),
            "total_consumption": total,
            "peak_consumption": {
                "value": peak.energy_kwh or 0.0,
                "time": peak.save_time.strftime("%H:%M"),
            },
            "low_consumption": {
                "value": low.energy_kwh or 0.0,
                "time": low.save_time.strftime("%H:%M"),
            },
            "trend": trend,
            "chart_labels_json": json.dumps(chart_labels, ensure_ascii=False),
            "chart_datasets_json": json.dumps(chart_datasets, ensure_ascii=False),
        }

    def build_data_insights(self, excel_max_time: datetime | None) -> dict:
        total_rows = self.db.scalar(select(func.count()).select_from(EnergyConsumption)) or 0

        excel_rows = 0
        simulator_rows = total_rows
        if excel_max_time is not None:
            excel_rows = (
                self.db.scalar(
                    select(func.count())
                    .select_from(EnergyConsumption)
                    .where(EnergyConsumption.save_time <= excel_max_time)
                )
                or 0
            )
            simulator_rows = max(0, total_rows - excel_rows)

        last_hour_since = now_local_naive() - timedelta(hours=1)
        recent_stmt = (
            select(EnergyConsumption.device_name, EnergyConsumption.energy_kwh)
            .where(EnergyConsumption.save_time >= last_hour_since)
            .order_by(asc(EnergyConsumption.device_name))
        )
        recent_rows = self.db.execute(recent_stmt).all()

        by_group: dict[str, dict[str, float]] = defaultdict(lambda: {"count": 0.0, "sum": 0.0})
        for device_name, energy_kwh in recent_rows:
            key = self._group_key(device_name)
            by_group[key]["count"] += 1
            by_group[key]["sum"] += float(energy_kwh or 0.0)

        group_stats = []
        for group_id in sorted(by_group.keys()):
            count = int(by_group[group_id]["count"])
            total_energy = by_group[group_id]["sum"]
            avg = round(total_energy / count, 3) if count else 0.0
            group_stats.append(
                {
                    "group_id": group_id,
                    "samples": count,
                    "avg_kwh": avg,
                }
            )

        return {
            "total_rows": int(total_rows),
            "excel_rows": int(excel_rows),
            "simulator_rows": int(simulator_rows),
            "recent_samples": len(recent_rows),
            "group_stats": group_stats,
        }

    def _calculate_consumption_trend(self, day: date, current_total: float, group: str) -> float:
        previous_day = day - timedelta(days=1)
        previous_rows = self._filter_by_group(self._for_day(previous_day), group)
        previous_total = round(sum(x.energy_kwh or 0.0 for x in previous_rows), 2)
        if previous_total == 0:
            return 0.0
        trend = ((current_total - previous_total) / previous_total) * 100
        return round(trend, 2)

    def _distinct_devices(self, consumptions: list[EnergyConsumption]) -> list[DeviceActivity]:
        uniq: dict[str, str] = {}
        for row in consumptions:
            device_id = row.id_in_group or ""
            if device_id not in uniq:
                uniq[device_id] = row.device_name or ""
        return [DeviceActivity(id=device_id, name=name) for device_id, name in sorted(uniq.items())]

    def _activity_records(
        self, consumptions: list[EnergyConsumption], devices: list[DeviceActivity]
    ) -> list[dict]:
        by_time: dict[datetime, list[EnergyConsumption]] = defaultdict(list)
        for row in consumptions:
            by_time[row.save_time].append(row)

        device_ids = [device.id for device in devices]
        records: list[dict] = []

        for ts in sorted(by_time.keys()):
            ec_list = by_time[ts]
            consumption_map = {ec.id_in_group or "": ec.energy_kwh or 0.0 for ec in ec_list}
            name_map = {ec.id_in_group or "": ec.device_name or "" for ec in ec_list}

            row_data = []
            values = []
            for device_id in device_ids:
                value = consumption_map.get(device_id, 0.0)
                values.append(value)
                row_data.append(
                    {
                        "device_id": device_id,
                        "device_name": name_map.get(device_id, ""),
                        "value": value,
                    }
                )

            records.append(
                {
                    "time": ts.strftime("%H:%M"),
                    "consumptions": row_data,
                    "status": self._calculate_status(values),
                }
            )
        return records

    @staticmethod
    def _records_last_hour(records: list[dict]) -> list[dict]:
        if not records:
            return []
        # Данные приходят раз в минуту, поэтому последних 60 строк = последний час.
        return records[-60:]

    @staticmethod
    def _calculate_status(values: list[float]) -> str:
        all_zero = all(v == 0 for v in values)
        any_active = any(v > 0.5 for v in values)
        if all_zero:
            return "INACTIVE"
        if any_active:
            return "ACTIVE"
        return "PARTIAL"

    def _chart_data(self, consumptions: list[EnergyConsumption], group: str = "all") -> tuple[list[str], list[dict]]:
        by_series: dict[str, list[EnergyConsumption]] = defaultdict(list)
        all_times: set[str] = set()

        for ec in consumptions:
            if group == "all":
                key = self._group_key(ec.device_name)
            else:
                key = f"{ec.device_name} ({ec.id_in_group})"
            by_series[key].append(ec)
            all_times.add(ec.save_time.replace(second=0, microsecond=0).strftime("%H:%M"))

        labels = sorted(all_times)
        group_colors = {
            "BG": "#e74c3c",
            "CHINA": "#3498db",
            "CP-300": "#f39c12",
            "DIG": "#1abc9c",
            "MO": "#9b59b6",
            "PZS": "#e84393",
            "SM": "#2ecc71",
        }
        fallback_colors = [
            "#ff6b6b",
            "#4d96ff",
            "#ffd93d",
            "#00c2a8",
            "#a66cff",
            "#ff8fab",
            "#7bd389",
            "#ff922b",
            "#38bdf8",
            "#94d82d",
        ]
        datasets: list[dict] = []

        for index, (series_name, rows) in enumerate(sorted(by_series.items(), key=lambda x: x[0])):
            time_to_value: dict[str, float] = defaultdict(float)
            for row in rows:
                key = row.save_time.replace(second=0, microsecond=0).strftime("%H:%M")
                time_to_value[key] += row.energy_kwh or 0.0

            color = group_colors.get(series_name, fallback_colors[index % len(fallback_colors)])
            datasets.append(
                {
                    "label": series_name,
                    "data": [round(time_to_value.get(label, 0.0), 2) for label in labels],
                    "borderColor": color,
                    "backgroundColor": f"{color}33",
                    "fill": True,
                    "tension": 0.1,
                }
            )

        return labels, datasets
