from __future__ import annotations

from datetime import datetime, timezone
import json
import os
import random
import time
import urllib.request


def _env(name: str, default: str) -> str:
    return os.getenv(name, default)


APP_INGEST_URL = _env("APP_INGEST_URL", "http://app:8081/ingest/measurement")
DEVICE_GROUP = _env("DEVICE_GROUP", "PZS")
SIM_INTERVAL_SECONDS = int(_env("SIM_INTERVAL_SECONDS", "30"))
AMPLITUDE = float(_env("AMPLITUDE", "5.0"))
NOISE = float(_env("NOISE", "0.8"))


DEVICE_GROUPS: dict[str, list[dict]] = {
    "PZS": [
        {"id": "038", "device_class": "QF 1,26", "device_name": "PzS 12V 1", "base": 20.0},
        {"id": "039", "device_class": "QF 1,27", "device_name": "PzS 12V 2", "base": 8.0},
        {"id": "040", "device_class": "QF 1,28", "device_name": "PzS 12V 3", "base": 16.0},
        {"id": "041", "device_class": "QF 2,28", "device_name": "PzS 12V 4", "base": 7.0},
        {"id": "042", "device_class": "QF 2,27", "device_name": "PzS 12V 5", "base": 19.0},
        {"id": "043", "device_class": "QF 2,26", "device_name": "PzS 12V 6", "base": 18.0},
    ],
    "CHINA": [
        {"id": "044", "device_class": "QF 1,20", "device_name": "China 1", "base": 11.0},
        {"id": "045", "device_class": "QF 1,21", "device_name": "China 2", "base": 10.0},
        {"id": "046", "device_class": "QF 1,22", "device_name": "China 3", "base": 13.0},
        {"id": "047", "device_class": "QF 2,20", "device_name": "China 4", "base": 18.0},
        {"id": "048", "device_class": "QF 2,21", "device_name": "China 5", "base": 20.0},
        {"id": "049", "device_class": "QF 2,22", "device_name": "China 6", "base": 19.0},
        {"id": "050", "device_class": "QF 2,23", "device_name": "China 7", "base": 9.0},
        {"id": "051", "device_class": "QF 2,19", "device_name": "China 8", "base": 14.0},
    ],
    "DIG": [{"id": "061", "device_class": "Q8", "device_name": "DIG", "base": 45.0}],
    "BG": [
        {"id": "062", "device_class": "Q4", "device_name": "BG 1", "base": 20.0},
        {"id": "063", "device_class": "Q9", "device_name": "BG 2", "base": 32.0},
    ],
    "SM": [
        {"id": "064", "device_class": "Q10", "device_name": "SM 2", "base": 18.0},
        {"id": "065", "device_class": "Q11", "device_name": "SM 3", "base": 21.0},
        {"id": "066", "device_class": "Q12", "device_name": "SM 4", "base": 0.5},
        {"id": "067", "device_class": "Q13", "device_name": "SM 5", "base": 0.5},
        {"id": "068", "device_class": "Q14", "device_name": "SM 6", "base": 0.5},
        {"id": "069", "device_class": "Q15", "device_name": "SM 7", "base": 0.5},
        {"id": "070", "device_class": "Q16", "device_name": "SM 8", "base": 2.0},
    ],
    "MO": [
        {"id": "071", "device_class": "Q17", "device_name": "MO 9", "base": 0.5},
        {"id": "072", "device_class": "Q20", "device_name": "MO 10", "base": 13.0},
        {"id": "073", "device_class": "Q21", "device_name": "MO 11", "base": 0.5},
        {"id": "074", "device_class": "Q22", "device_name": "MO 12", "base": 0.5},
        {"id": "075", "device_class": "Q23", "device_name": "MO 13", "base": 0.5},
        {"id": "076", "device_class": "Q24", "device_name": "MO 14", "base": 0.5},
        {"id": "077", "device_class": "Q25", "device_name": "MO 15", "base": 0.5},
    ],
    "CP": [{"id": "078", "device_class": "TP3", "device_name": "CP-300 New", "base": 5.0}],
}


def _generate_value(now: datetime, base: float) -> float:
    hour = now.hour + now.minute / 60
    daylight_factor = max(0.0, 1 - abs(hour - 12) / 12)
    return max(0.0, round(base + AMPLITUDE * daylight_factor + random.uniform(-NOISE, NOISE), 4))


def _send(payload: dict) -> None:
    data = json.dumps(payload, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(
        APP_INGEST_URL,
        method="POST",
        data=data,
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=10) as response:
        response.read()


def main() -> None:
    group_key = DEVICE_GROUP.strip().upper()
    devices = DEVICE_GROUPS.get(group_key)
    if not devices:
        raise RuntimeError(f"Unsupported DEVICE_GROUP={DEVICE_GROUP}. Use one of: {', '.join(sorted(DEVICE_GROUPS))}")

    while True:
        now = datetime.now(tz=timezone.utc)
        for device in devices:
            payload = {
                "device_class": device["device_class"],
                "device_type": "ЗУ",
                "device_name": device["device_name"],
                "id_in_group": device["id"],
                "save_time": now.isoformat(),
                "energy_kwh": _generate_value(now, float(device["base"])),
            }
            try:
                _send(payload)
                print(f"[{group_key}] sent: {payload}", flush=True)
            except Exception as exc:  # noqa: BLE001
                print(f"[{group_key}] send failed: {exc}", flush=True)
        time.sleep(SIM_INTERVAL_SECONDS)


if __name__ == "__main__":
    main()
