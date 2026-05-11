# Energy Monitoring

Веб-система мониторинга потребления электроэнергии с отчетами, ролями пользователей, загрузкой данных из Excel и симуляцией телеметрии устройств.

## Возможности

- Backend на `FastAPI` с HTML-интерфейсом на `Jinja2`.
- Авторизация и регистрация пользователей с ролями `admin` и `user`.
- Отчет активности по адресу `/activity` с фильтрацией по группе устройств.
- Прием измерений через endpoint `POST /ingest/measurement`.
- Работа с `PostgreSQL` через `SQLAlchemy`.
- Автоматическая инициализация данных из Excel при первом запуске.
- Docker-окружение с отдельными симуляторами групп устройств.

## Структура проекта

- `python_backend/app` — основная серверная логика, шаблоны, статика и модели.
- `python_backend/tests` — тесты backend.
- `python_backend/frontend` — React/Vite frontend-часть.
- `compose.yaml` — запуск backend, PostgreSQL и симуляторов.

## Быстрый старт (Docker)

```bash
docker compose up --build -d
```

После запуска доступны:

- Приложение: [http://localhost:8081](http://localhost:8081)
- Проверка состояния: [http://localhost:8081/health](http://localhost:8081/health)
- Отчет: [http://localhost:8081/activity?date=2025-04-01](http://localhost:8081/activity?date=2025-04-01)
- Пример фильтра по группе: [http://localhost:8081/activity?date=2025-04-01&group=PZS](http://localhost:8081/activity?date=2025-04-01&group=PZS)
- Вход: [http://localhost:8081/login](http://localhost:8081/login)

Учетные данные администратора по умолчанию:

- Логин: `admin`
- Пароль: `admin123`

## Локальный запуск (без Docker)

1. Поднять PostgreSQL:

```bash
docker compose up -d postgres
```

2. Установить зависимости backend:

```bash
cd python_backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

3. Запустить сервер:

```bash
uvicorn app.main:app --reload --port 8081
```

## Переменные окружения

Основные переменные backend:

- `DATABASE_URL` (по умолчанию `postgresql+psycopg2://user:root@localhost:5455/energy_monitoring`)
- `APP_HOST` (по умолчанию `0.0.0.0`)
- `APP_PORT` (по умолчанию `8081`)
- `REPORT_SERVER_BASE_URL` (по умолчанию `http://localhost:8081`)
- `EXCEL_DATA_PATH` (в Docker по умолчанию `/app/data/input.xlsx`)
- `SESSION_SECRET` (секрет подписи сессий)
- `ADMIN_INVITE_CODE` (код регистрации администратора)
- `DEFAULT_ADMIN_USERNAME` (по умолчанию `admin`)
- `DEFAULT_ADMIN_PASSWORD` (по умолчанию `admin123`)

## Поведение при первом запуске

- Backend автоматически создает таблицы в базе данных.
- Если таблица `energy_consumption` пуста, данные импортируются из Excel.
- Если Excel-файл недоступен, добавляются демо-данные.

## Docker-сервисы симуляции

В `compose.yaml` добавлены сервисы симуляторов:

- `simulator_pzs`
- `simulator_china`
- `simulator_bg`
- `simulator_sm`
- `simulator_mo`
- `simulator_dig`
- `simulator_cp`

Каждый симулятор отправляет показания своей группы в `POST /ingest/measurement` с заданным интервалом.
