from __future__ import annotations

from datetime import datetime
from types import SimpleNamespace

from fastapi.testclient import TestClient

from app import main
from app.services import EnergyConsumptionService


class FakeDB:
    def add(self, _obj):
        return None

    def flush(self):
        return None

    def commit(self):
        return None

    def get(self, _model, _id):
        return None


def sample_payload() -> dict:
    devices = [SimpleNamespace(name="PZS 1"), SimpleNamespace(name="PZS 2")]
    records = [
        {
            "time": "07:30",
            "consumptions": [
                {"device_name": "PZS 1", "value": 2.1},
                {"device_name": "PZS 2", "value": 1.2},
            ],
        },
        {
            "time": "08:00",
            "consumptions": [
                {"device_name": "PZS 1", "value": 2.5},
                {"device_name": "PZS 2", "value": 1.7},
            ],
        },
    ]
    return {
        "report_date": "2026-05-09",
        "selected_group": "all",
        "devices": devices,
        "consumption_records": records,
        "total_consumption": 7.5,
        "peak_consumption": {"value": 2.5, "time": "08:00"},
        "low_consumption": {"value": 1.2, "time": "07:30"},
        "trend": 4.8,
    }


def test_smoke_generates_pdf_and_xlsx() -> None:
    payload = sample_payload()
    pdf_bytes = main._build_pdf_export(payload, template_mode="brief")
    xlsx_bytes = main._build_xlsx_export(payload)
    assert isinstance(pdf_bytes, (bytes, bytearray))
    assert isinstance(xlsx_bytes, (bytes, bytearray))
    assert len(pdf_bytes) > 1000
    assert len(xlsx_bytes) > 500


def test_export_endpoint_integration(monkeypatch) -> None:
    fake_db = FakeDB()

    class FakeService:
        def __init__(self, _db):
            pass

        def build_activity_report(self, _day, group="all"):
            payload = sample_payload()
            payload["selected_group"] = group
            return payload

    monkeypatch.setattr(main, "EnergyConsumptionService", FakeService)
    monkeypatch.setattr(main, "require_user", lambda _req, _db: SimpleNamespace(id=1, role="admin"))
    monkeypatch.setattr(main, "_log_audit", lambda *_args, **_kwargs: None)
    main.app.dependency_overrides[main.get_db] = lambda: fake_db
    client = TestClient(main.app)

    try:
        pdf_res = client.get("/activity/export?date=2026-05-09&format=pdf&template=brief")
        xlsx_res = client.get("/activity/export?date=2026-05-09&format=xlsx&template=detailed")
    finally:
        main.app.dependency_overrides.clear()

    assert pdf_res.status_code == 200
    assert xlsx_res.status_code == 200
    assert pdf_res.headers["content-type"].startswith("application/pdf")
    assert xlsx_res.headers["content-type"].startswith("application/vnd.openxmlformats-officedocument")


def test_email_report_endpoint_integration(monkeypatch) -> None:
    fake_db = FakeDB()
    queued: list[dict] = []

    def fake_queue(_db, **kwargs):
        queued.append(kwargs)
        return SimpleNamespace(id=1)

    monkeypatch.setattr(main, "require_min_role", lambda _req, _db, _min_role: SimpleNamespace(id=10, role="admin"))
    monkeypatch.setattr(main, "_smtp_is_configured", lambda: True)
    monkeypatch.setattr(main, "_queue_report_send", fake_queue)
    monkeypatch.setattr(main, "_log_audit", lambda *_args, **_kwargs: None)
    main.app.dependency_overrides[main.get_db] = lambda: fake_db
    client = TestClient(main.app)

    try:
        res = client.post(
            "/activity/email-report",
            json={
                "email": "receiver@example.com",
                "report_date": "2026-05-09",
                "group": "all",
                "export_format": "pdf",
                "template_mode": "detailed",
            },
        )
    finally:
        main.app.dependency_overrides.clear()

    assert res.status_code == 200
    assert res.json()["status"] == "ok"
    assert len(queued) == 1
    assert queued[0]["recipient_email"] == "receiver@example.com"


def test_role_checks_for_user_admin_and_blocked() -> None:
    blocked_user = SimpleNamespace(id=1, role="user", is_blocked=True)
    admin_user = SimpleNamespace(id=2, role="admin", is_blocked=False)
    normal_user = SimpleNamespace(id=3, role="user", is_blocked=False)

    class DB:
        def __init__(self, obj):
            self.obj = obj

        def get(self, _model, _id):
            return self.obj

    blocked_req = SimpleNamespace(session={"user_id": 1})
    assert main.get_current_user(blocked_req, DB(blocked_user)) is None

    admin_req = SimpleNamespace(session={"user_id": 2})
    assert main.require_admin(admin_req, DB(admin_user)).role == "admin"

    user_req = SimpleNamespace(session={"user_id": 3})
    redirect = main.require_admin(user_req, DB(normal_user))
    assert hasattr(redirect, "status_code")
    assert redirect.status_code == 303


def test_chart_data_is_group_aggregated_for_all_group() -> None:
    service = EnergyConsumptionService(db=None)
    rows = [
        SimpleNamespace(device_name="PZS 12V 1", id_in_group="038", save_time=datetime(2026, 5, 10, 10, 0), energy_kwh=2.0),
        SimpleNamespace(device_name="PZS 12V 2", id_in_group="039", save_time=datetime(2026, 5, 10, 10, 0), energy_kwh=3.0),
        SimpleNamespace(device_name="CHINA 1", id_in_group="044", save_time=datetime(2026, 5, 10, 10, 0), energy_kwh=4.0),
        SimpleNamespace(device_name="CHINA 2", id_in_group="045", save_time=datetime(2026, 5, 10, 10, 30), energy_kwh=5.0),
    ]
    labels, datasets = service._chart_data(rows, group="all")

    by_label = {item["label"]: item for item in datasets}
    assert labels == ["10:00", "10:30"]
    assert sorted(by_label.keys()) == ["CHINA", "PZS"]
    assert by_label["PZS"]["data"] == [5.0, 0.0]
    assert by_label["CHINA"]["data"] == [4.0, 5.0]
    assert by_label["PZS"]["borderColor"] == "#e84393"
    assert by_label["CHINA"]["borderColor"] == "#3498db"


def test_chart_data_keeps_device_details_for_single_group() -> None:
    service = EnergyConsumptionService(db=None)
    rows = [
        SimpleNamespace(device_name="BG 1", id_in_group="062", save_time=datetime(2026, 5, 10, 11, 0), energy_kwh=1.5),
        SimpleNamespace(device_name="BG 2", id_in_group="063", save_time=datetime(2026, 5, 10, 11, 0), energy_kwh=2.5),
    ]
    labels, datasets = service._chart_data(rows, group="BG")

    assert labels == ["11:00"]
    assert sorted(item["label"] for item in datasets) == ["BG 1 (062)", "BG 2 (063)"]


def test_records_last_hour_returns_last_60_points() -> None:
    service = EnergyConsumptionService(db=None)
    records = [{"time": f"{(i // 60) % 24:02d}:{i % 60:02d}"} for i in range(100)]

    last_hour = service._records_last_hour(records)

    assert len(last_hour) == 60
    assert last_hour[0]["time"] == records[40]["time"]
    assert last_hour[-1]["time"] == records[-1]["time"]


def test_parse_measurement_save_time_converts_utc_to_local(monkeypatch) -> None:
    monkeypatch.setattr(main, "get_timezone_offset_hours", lambda: 3)
    converted = main._parse_measurement_save_time("2026-05-09T21:49:00+00:00")
    assert converted == datetime(2026, 5, 10, 0, 49)
    assert converted.tzinfo is None


def test_role_label_and_min_role_checks() -> None:
    assert main._role_label("admin") == "Администратор"
    assert main._role_label("observer") == "Наблюдатель"
    assert main._role_label("custom") == "custom"

    engineer = SimpleNamespace(role="engineer")
    observer = SimpleNamespace(role="observer")
    assert main._has_min_role(engineer, "operator") is True
    assert main._has_min_role(observer, "operator") is False
