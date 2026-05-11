import React, { createContext, useContext, useEffect, useMemo, useRef, useState } from "react";
import { createRoot } from "react-dom/client";
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);
const LanguageContext = createContext({ language: "ru", setLanguage: () => {} });

function useThemeToggle() {
  const [isDark, setIsDark] = useState(() => {
    try {
      return localStorage.getItem("theme") === "dark";
    } catch {
      return false;
    }
  });

  useEffect(() => {
    document.documentElement.classList.toggle("theme-dark", isDark);
    try {
      localStorage.setItem("theme", isDark ? "dark" : "light");
    } catch {
      // ignore storage errors
    }
  }, [isDark]);

  return { isDark, setIsDark };
}

function useLanguageState() {
  const [language, setLanguage] = useState(() => {
    try {
      return localStorage.getItem("language") || "ru";
    } catch {
      return "ru";
    }
  });

  useEffect(() => {
    document.documentElement.lang = language;
    try {
      localStorage.setItem("language", language);
    } catch {
      // ignore storage errors
    }
  }, [language]);

  return { language, setLanguage };
}

function useI18n() {
  const { language, setLanguage } = useContext(LanguageContext);
  const tr = (ru, en, de) => {
    if (language === "en") return en;
    if (language === "de") return de;
    return ru;
  };
  return { language, setLanguage, tr };
}

function translateServerMessage(message, tr) {
  const map = {
    "Неверный логин или пароль": tr("Неверный логин или пароль", "Invalid username or password", "Falscher Benutzername oder falsches Passwort"),
    "Пользователь заблокирован. Обратитесь к администратору.": tr(
      "Пользователь заблокирован. Обратитесь к администратору.",
      "User is blocked. Contact administrator.",
      "Benutzer ist gesperrt. Kontaktieren Sie den Administrator."
    ),
    "Введите username и пароль минимум из 6 символов": tr(
      "Введите username и пароль минимум из 6 символов",
      "Enter username and password with at least 6 characters",
      "Geben Sie Benutzernamen und Passwort mit mindestens 6 Zeichen ein"
    ),
    "Неверный или уже использованный код администратора": tr(
      "Неверный или уже использованный код администратора",
      "Invalid or already used admin code",
      "Ungültiger oder bereits verwendeter Admin-Code"
    ),
    "Пользователь с таким username уже существует": tr(
      "Пользователь с таким username уже существует",
      "A user with this username already exists",
      "Ein Benutzer mit diesem Benutzernamen existiert bereits"
    ),
    "Укажите+название+инцидента": tr("Укажите название инцидента", "Specify incident title", "Geben Sie den Vorfalltitel an"),
    "Для+инцидента+по+устройству+выберите+группу": tr(
      "Для инцидента по устройству выберите группу",
      "Select a group for a device-specific incident",
      "Wählen Sie eine Gruppe für einen gerätespezifischen Vorfall"
    ),
    "Выберите+устройство": tr("Выберите устройство", "Select a device", "Wählen Sie ein Gerät"),
    "Выбранное+устройство+не+принадлежит+выбранной+группе": tr(
      "Выбранное устройство не принадлежит выбранной группе",
      "Selected device does not belong to selected group",
      "Das ausgewählte Gerät gehört nicht zur ausgewählten Gruppe"
    ),
    "Выбранное+устройство+не+найдено": tr(
      "Выбранное устройство не найдено",
      "Selected device was not found",
      "Das ausgewählte Gerät wurde nicht gefunden"
    ),
    "Инцидент+добавлен": tr("Инцидент добавлен", "Incident added", "Vorfall hinzugefügt"),
  };
  const normalized = String(message || "").trim();
  return map[normalized] || normalized;
}

function useServiceWorker() {
  useEffect(() => {
    if ("serviceWorker" in navigator) {
      navigator.serviceWorker.register("/static/service-worker.js?v=7").catch(() => {});
    }
  }, []);
}

function ThemeSwitch() {
  const { isDark, setIsDark } = useThemeToggle();
  const { tr } = useI18n();
  return (
    <label className="theme-switch" htmlFor="theme-toggle">
      <span>{tr("Темная тема", "Dark theme", "Dunkles Design")}</span>
      <input
        id="theme-toggle"
        type="checkbox"
        aria-label={tr("Переключить тему", "Toggle theme", "Design umschalten")}
        checked={isDark}
        onChange={() => setIsDark((v) => !v)}
      />
      <span className="slider" aria-hidden="true"></span>
    </label>
  );
}

function UserDropdown({ username }) {
  const [open, setOpen] = useState(false);
  const menuRef = useRef(null);
  const { isDark, setIsDark } = useThemeToggle();
  const { language, setLanguage, tr } = useI18n();

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (menuRef.current && !menuRef.current.contains(event.target)) {
        setOpen(false);
      }
    };
    const handleEscape = (event) => {
      if (event.key === "Escape") {
        setOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    document.addEventListener("keydown", handleEscape);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
      document.removeEventListener("keydown", handleEscape);
    };
  }, []);

  useEffect(() => {
    if (!open) {
      document.body.style.overflow = "";
      return;
    }
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = previousOverflow;
    };
  }, [open]);

  return (
    <div className="user-dropdown" ref={menuRef}>
      <button
        type="button"
        className="user-dropdown-trigger"
        onClick={() => setOpen((v) => !v)}
        aria-haspopup="menu"
        aria-expanded={open}
      >
        <span className="user-dropdown-name">{username}</span>
        <span className={`user-dropdown-arrow ${open ? "open" : ""}`} aria-hidden="true">
          ▼
        </span>
      </button>
      {open ? (
        <>
          <div className="user-dropdown-backdrop" onClick={() => setOpen(false)}></div>
          <div className="user-dropdown-modal" role="dialog" aria-modal="true" onClick={(e) => e.stopPropagation()}>
            <div className="user-dropdown-modal-head">
              <strong>{username}</strong>
              <button
                type="button"
                className="user-dropdown-close"
                onClick={() => setOpen(false)}
                aria-label={tr("Закрыть меню", "Close menu", "Menü schließen")}
              >
                ×
              </button>
            </div>
            <label className="user-dropdown-label" htmlFor="lang-select">
              {tr("Язык интерфейса", "Interface language", "Sprache der Benutzeroberfläche")}
            </label>
            <select id="lang-select" className="user-dropdown-select" value={language} onChange={(e) => setLanguage(e.target.value)}>
              <option value="ru">{tr("Русский", "Russian", "Russisch")}</option>
              <option value="en">English</option>
              <option value="de">Deutsch</option>
            </select>
            <div className="user-dropdown-theme">
              <span>{tr("Темная тема", "Dark theme", "Dunkles Design")}</span>
              <button
                type="button"
                className={`user-dropdown-theme-btn ${isDark ? "active" : ""}`}
                onClick={() => setIsDark((v) => !v)}
                aria-label={tr("Переключить тему", "Toggle theme", "Design umschalten")}
              >
                {isDark ? tr("Вкл", "On", "An") : tr("Выкл", "Off", "Aus")}
              </button>
            </div>
            <a className="user-dropdown-logout" href="/logout" onClick={() => setOpen(false)}>
              {tr("Выйти", "Sign out", "Abmelden")}
            </a>
          </div>
        </>
      ) : null}
    </div>
  );
}

function LandingPage({ props }) {
  useServiceWorker();
  const { tr } = useI18n();
  return (
    <>
      <header className="header">
        <div className="header-row">
          <div className="user-panel">
            <span className="brand-mark">Energy Monitoring</span>
            <p className="number">{tr("Промышленный мониторинг энергопотребления", "Industrial energy monitoring", "Industrielle Energieüberwachung")}</p>
          </div>
          <div className="user-panel">
            <ThemeSwitch />
            {props.current_user ? (
              <a className="link-btn" href="/activity">
                {tr("Открыть панель", "Open dashboard", "Dashboard öffnen")}
              </a>
            ) : null}
            <a className="link-btn" href="/login">
              {tr("Войти", "Sign in", "Anmelden")}
            </a>
          </div>
        </div>
      </header>
      <main>
        <section className="landing-wrap">
          <article className="hero-card">
            <span className="hero-badge">Energy Monitoring Platform</span>
            <h1>{tr("Контроль энергопотребления в реальном времени", "Real-time energy consumption control", "Echtzeitkontrolle des Energieverbrauchs")}</h1>
            <p>
              {tr(
                "Система показывает живые показатели по устройствам и группам, формирует отчеты, ведет журнал инцидентов и помогает быстро находить причины пиковых нагрузок.",
                "The system shows live metrics by devices and groups, generates reports, keeps an incident log, and helps quickly find causes of peak loads.",
                "Das System zeigt Live-Metriken nach Geräten und Gruppen, erstellt Berichte, führt ein Vorfallsprotokoll und hilft, Ursachen von Lastspitzen schnell zu finden."
              )}
            </p>
            <div className="hero-actions">
              <a className="hero-btn primary" href="/login">
                {tr("Перейти ко входу", "Go to sign in", "Zur Anmeldung")}
              </a>
              {props.current_user ? (
                <a className="hero-btn secondary" href="/activity">
                  {tr("Открыть рабочую панель", "Open workspace", "Arbeitsbereich öffnen")}
                </a>
              ) : null}
            </div>
          </article>
          <section className="feature-grid">
            <article className="feature-card">
              <h3>{tr("Realtime дашборд", "Realtime dashboard", "Echtzeit-Dashboard")}</h3>
              <p>{tr("Поток данных обновляется без перезагрузки страницы через SSE и показывает состояние сети в реальном времени.", "Data stream updates via SSE without page reload and shows network state in real time.", "Der Datenstrom wird per SSE ohne Neuladen aktualisiert und zeigt den Zustand des Netzes in Echtzeit.")}</p>
            </article>
            <article className="feature-card">
              <h3>{tr("Гибкие отчеты", "Flexible reports", "Flexible Berichte")}</h3>
              <p>{tr("Аналитика по дате и группам, экспорт в PDF/XLSX и рассылка отчетов по расписанию для разных ролей.", "Analytics by date and groups, export to PDF/XLSX, and scheduled report delivery for different roles.", "Analysen nach Datum und Gruppen, Export in PDF/XLSX und geplante Berichtsversendung für verschiedene Rollen.")}</p>
            </article>
            <article className="feature-card">
              <h3>{tr("Журнал инцидентов", "Incident log", "Vorfallsprotokoll")}</h3>
              <p>{tr("Ручная фиксация пусков, ремонтов и аварий помогает объяснять всплески и связывать события с графиками.", "Manual logging of starts, maintenance, and failures helps explain spikes and connect events with charts.", "Die manuelle Erfassung von Starts, Wartungen und Störungen hilft, Spitzen zu erklären und Ereignisse mit Diagrammen zu verknüpfen.")}</p>
            </article>
            <article className="feature-card">
              <h3>{tr("RBAC доступ", "RBAC access", "RBAC-Zugriff")}</h3>
              <p>{tr("Роли наблюдателя, оператора, инженера и администратора с разграничением действий в интерфейсе.", "Observer, operator, engineer, and admin roles with action-level access control.", "Rollen Beobachter, Operator, Ingenieur und Administrator mit differenzierten Berechtigungen.")}</p>
            </article>
            <article className="feature-card">
              <h3>{tr("PWA и мобильность", "PWA and mobility", "PWA und Mobilität")}</h3>
              <p>{tr("Интерфейс адаптирован под мобильные устройства, поддерживает установку как приложение и офлайн-кэш статики.", "The interface is mobile-friendly, supports installation as an app, and offline cache for static assets.", "Die Oberfläche ist mobilfreundlich, unterstützt Installation als App und Offline-Cache für statische Assets.")}</p>
            </article>
            <article className="feature-card">
              <h3>{tr("Единая админ-панель", "Unified admin panel", "Einheitliches Admin-Panel")}</h3>
              <p>{tr("Управление пользователями, ролями, очередью отправки, аудитом действий и системными настройками времени.", "Manage users, roles, delivery queue, action audit, and system time settings.", "Verwaltung von Benutzern, Rollen, Versandwarteschlange, Aktionsaudit und Systemzeiteinstellungen.")}</p>
            </article>
          </section>
        </section>
      </main>
    </>
  );
}

function LoginPage({ props }) {
  useServiceWorker();
  const { tr } = useI18n();
  return (
    <main className="auth-main">
      <section className="auth-layout">
        <aside className="auth-aside">
          <span className="auth-badge">Energy Monitoring</span>
          <h2 className="auth-title">{tr("Управляй энергопотреблением в реальном времени", "Control energy usage in real time", "Steuern Sie den Energieverbrauch in Echtzeit")}</h2>
          <p className="auth-subtitle">{tr("Единая панель для анализа потребления, контроля аномалий и работы с устройствами.", "Unified dashboard for consumption analysis, anomaly control, and device operations.", "Ein zentrales Dashboard für Verbrauchsanalyse, Anomaliekontrolle und Gerätebetrieb.")}</p>
          <ul className="auth-list">
            <li>{tr("Интерактивные отчеты по дате", "Interactive date-based reports", "Interaktive Berichte nach Datum")}</li>
            <li>{tr("Онлайн-поток показаний от симуляторов", "Online stream of simulator readings", "Online-Datenstrom der Simulatoren")}</li>
            <li>{tr("Роли: Администратор / Инженер / Оператор / Наблюдатель", "Roles: Admin / Engineer / Operator / Observer", "Rollen: Administrator / Ingenieur / Operator / Beobachter")}</li>
          </ul>
        </aside>
        <section className="auth-card">
          <h1>{tr("Вход", "Sign in", "Anmeldung")}</h1>
          <p className="auth-note">{tr("Авторизуйтесь, чтобы открыть рабочую панель.", "Sign in to open the workspace.", "Melden Sie sich an, um den Arbeitsbereich zu öffnen.")}</p>
          {props.error ? <p className="error">{translateServerMessage(props.error, tr)}</p> : null}
          <form method="post" action="/login" className="auth-form">
            <label>
              Username
              <input name="username" type="text" placeholder={tr("например, admin", "e.g., admin", "z. B. admin")} required />
            </label>
            <label>
              {tr("Пароль", "Password", "Passwort")}
              <input name="password" type="password" placeholder={tr("Введите пароль", "Enter password", "Passwort eingeben")} required />
            </label>
            <button type="submit">{tr("Войти в систему", "Sign in", "Anmelden")}</button>
          </form>
          <p className="auth-switch">
            {tr("Нет аккаунта?", "No account?", "Kein Konto?")} <a href="/register">{tr("Создать", "Create one", "Erstellen")}</a>
          </p>
        </section>
      </section>
    </main>
  );
}

function RegisterPage({ props }) {
  useServiceWorker();
  const { tr } = useI18n();
  return (
    <main className="auth-main">
      <section className="auth-layout">
        <aside className="auth-aside">
          <span className="auth-badge">Access Provisioning</span>
          <h2 className="auth-title">{tr("Создай аккаунт и подключись к системе", "Create an account and connect to the system", "Erstellen Sie ein Konto und verbinden Sie sich mit dem System")}</h2>
          <p className="auth-subtitle">{tr("Для роли Администратор требуется специальный код, остальные роли доступны при регистрации.", "An admin code is required for the Administrator role; other roles are available during registration.", "Für die Rolle Administrator ist ein spezieller Code erforderlich, andere Rollen sind bei der Registrierung verfügbar.")}</p>
          <ul className="auth-list">
            <li>{tr("Защищенная аутентификация", "Secure authentication", "Sichere Authentifizierung")}</li>
            <li>{tr("Роли и разделение доступа", "Roles and access separation", "Rollen und Zugriffstrennung")}</li>
            <li>{tr("Быстрый переход в аналитическую панель", "Quick access to analytics dashboard", "Schneller Zugriff auf das Analyse-Dashboard")}</li>
          </ul>
        </aside>
        <section className="auth-card">
          <h1>{tr("Регистрация", "Registration", "Registrierung")}</h1>
          <p className="auth-note">{tr("Заполните форму и начните работу.", "Fill in the form to get started.", "Füllen Sie das Formular aus und starten Sie.")}</p>
          {props.error ? <p className="error">{translateServerMessage(props.error, tr)}</p> : null}
          <form method="post" action="/register" className="auth-form">
            <label>
              Username
              <input name="username" type="text" placeholder={tr("например, pavel", "e.g., pavel", "z. B. pavel")} required />
            </label>
            <label>
              {tr("Пароль (минимум 6 символов)", "Password (at least 6 characters)", "Passwort (mindestens 6 Zeichen)")}
              <input name="password" type="password" required minLength={6} />
            </label>
            <label>
              {tr("Роль", "Role", "Rolle")}
              <select name="role" defaultValue="observer">
                <option value="observer">{tr("Наблюдатель", "Observer", "Beobachter")}</option>
                <option value="operator">{tr("Оператор", "Operator", "Operator")}</option>
                <option value="engineer">{tr("Инженер", "Engineer", "Ingenieur")}</option>
                <option value="admin">{tr("Администратор", "Administrator", "Administrator")}</option>
              </select>
            </label>
            <label>
              {tr("Код администратора (для Администратора)", "Admin code (for Administrator role)", "Admin-Code (für Administrator-Rolle)")}
              <input name="admin_code" type="text" placeholder={tr("Введите код при необходимости", "Enter code if needed", "Code bei Bedarf eingeben")} />
            </label>
            <button type="submit">{tr("Создать аккаунт", "Create account", "Konto erstellen")}</button>
          </form>
          <p className="auth-switch">
            {tr("Уже есть аккаунт?", "Already have an account?", "Haben Sie bereits ein Konto?")} <a href="/login">{tr("Войти", "Sign in", "Anmelden")}</a>
          </p>
        </section>
      </section>
    </main>
  );
}

function buildRecentWindow(labels, datasets, hoursBack) {
  const toMinutes = (label) => {
    const match = String(label || "").match(/^(\d{1,2}):(\d{2})/);
    if (!match) return null;
    return Number(match[1]) * 60 + Number(match[2]);
  };
  const minutes = labels.map(toMinutes);
  const valid = minutes.filter((item) => item !== null);
  if (!valid.length) {
    const start = Math.max(0, labels.length - 12);
    return {
      labels: labels.slice(start),
      datasets: datasets.map((dataset) => ({ ...dataset, data: (dataset.data || []).slice(start) })),
    };
  }
  const maxMinute = Math.max(...valid);
  const minMinute = Math.max(0, maxMinute - hoursBack * 60);
  let startIdx = minutes.findIndex((minute) => minute !== null && minute >= minMinute);
  if (startIdx < 0) startIdx = 0;
  return {
    labels: labels.slice(startIdx),
    datasets: datasets.map((dataset) => ({ ...dataset, data: (dataset.data || []).slice(startIdx) })),
  };
}

function ActivityPage({ props }) {
  useServiceWorker();
  const { tr } = useI18n();
  const [selectedDate, setSelectedDate] = useState(props.report_date);
  const [selectedGroup, setSelectedGroup] = useState(props.selected_group || "all");
  const [email, setEmail] = useState("");
  const [emailStatus, setEmailStatus] = useState("");
  const [emailStatusError, setEmailStatusError] = useState(false);
  const [format, setFormat] = useState("xlsx");
  const [templateMode, setTemplateMode] = useState("detailed");
  const [modalOpen, setModalOpen] = useState(false);
  const [mainChartType, setMainChartType] = useState("line");
  const [liveData, setLiveData] = useState({
    server_time: "-",
    last_seen: "-",
    total_last_5m: 0,
    active_samples_1m: 0,
    status: tr("подключение...", "connecting...", "verbinde..."),
    online: false,
  });
  const mainRef = useRef(null);
  const shareRef = useRef(null);
  const topRef = useRef(null);
  const loadRef = useRef(null);
  const chartRefs = useRef([]);

  const labels = props.chart_labels || [];
  const datasets = props.chart_datasets || [];
  const recentHourWindow = useMemo(() => buildRecentWindow(labels, datasets, 1), [labels, datasets]);

  const anomaly = useMemo(() => {
    const totals = recentHourWindow.labels.map((_, idx) =>
      recentHourWindow.datasets.reduce((sum, dataset) => sum + Number((dataset.data || [])[idx] || 0), 0)
    );
    if (!totals.length) {
      return { current: "-", avg: "-", delta: "-", status: tr("норма", "normal", "normal"), className: "anomaly-normal" };
    }
    const current = totals[totals.length - 1];
    const avg = totals.reduce((acc, value) => acc + value, 0) / totals.length;
    const deltaPercent = avg > 0 ? ((current - avg) / avg) * 100 : current > 0 ? 100 : 0;
    if (deltaPercent > 35) {
      return {
        current: current.toFixed(3),
        avg: avg.toFixed(3),
        delta: `${deltaPercent >= 0 ? "+" : ""}${deltaPercent.toFixed(1)}%`,
        status: tr("пик", "peak", "spitze"),
        className: "anomaly-peak",
      };
    }
    if (deltaPercent > 15) {
      return {
        current: current.toFixed(3),
        avg: avg.toFixed(3),
        delta: `${deltaPercent >= 0 ? "+" : ""}${deltaPercent.toFixed(1)}%`,
        status: tr("выше нормы", "above normal", "über normal"),
        className: "anomaly-warn",
      };
    }
    return {
      current: current.toFixed(3),
      avg: avg.toFixed(3),
      delta: `${deltaPercent >= 0 ? "+" : ""}${deltaPercent.toFixed(1)}%`,
      status: tr("норма", "normal", "normal"),
      className: "anomaly-normal",
    };
  }, [recentHourWindow, tr]);

  useEffect(() => {
    const colors = {
      text: document.documentElement.classList.contains("theme-dark") ? "#d1d5db" : "#4b5366",
      ticks: document.documentElement.classList.contains("theme-dark") ? "#c7d2fe" : "#56607a",
      gridStrong: document.documentElement.classList.contains("theme-dark")
        ? "rgba(148,163,184,0.22)"
        : "rgba(40,60,90,0.12)",
      gridSoft: document.documentElement.classList.contains("theme-dark")
        ? "rgba(148,163,184,0.16)"
        : "rgba(40,60,90,0.08)",
    };
    const palette = ["#3d63dd", "#16a083", "#d35400", "#9b59b6", "#f39c12", "#2f80ed", "#27ae60", "#e74c3c"];
    const chartAnimation = {
      duration: 800,
      easing: "easeOutQuart",
    };
    chartRefs.current.forEach((chart) => chart?.destroy());
    chartRefs.current = [];
    if (!mainRef.current || !shareRef.current || !topRef.current || !loadRef.current || props.error_message) return;

    const makeTotals = () =>
      datasets.map((dataset) => ({
        label: dataset.label,
        total: (dataset.data || []).reduce((sum, point) => sum + Number(point || 0), 0),
      }));
    const totalsBySlot = recentHourWindow.labels.map((_, idx) =>
      recentHourWindow.datasets.reduce((sum, dataset) => sum + Number((dataset.data || [])[idx] || 0), 0)
    );

    const mainChart = new Chart(mainRef.current.getContext("2d"), {
      type: mainChartType,
      data: {
        labels: recentHourWindow.labels,
        datasets: recentHourWindow.datasets.map((dataset, index) => ({
          ...dataset,
          fill: mainChartType === "line",
          borderWidth: 2,
          tension: mainChartType === "line" ? 0.28 : 0,
          pointRadius: mainChartType === "line" ? 0 : 2,
          pointHoverRadius: mainChartType === "line" ? 3 : 4,
          backgroundColor: dataset.backgroundColor || `${palette[index % palette.length]}33`,
        })),
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: chartAnimation,
        plugins: { legend: { labels: { color: colors.text } } },
        scales:
          mainChartType === "radar"
            ? {}
            : {
                x: { ticks: { color: colors.ticks, maxRotation: 0 }, grid: { color: colors.gridSoft } },
                y: { ticks: { color: colors.ticks }, grid: { color: colors.gridStrong } },
              },
      },
    });
    const shareChart = new Chart(shareRef.current.getContext("2d"), {
      type: "doughnut",
      data: {
        labels: makeTotals().map((item) => item.label),
        datasets: [{ data: makeTotals().map((item) => Number(item.total.toFixed(3))), backgroundColor: palette }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: chartAnimation,
        plugins: { legend: { position: "bottom", labels: { color: colors.text } } },
      },
    });
    const top = makeTotals()
      .sort((a, b) => b.total - a.total)
      .slice(0, 8);
    const topChart = new Chart(topRef.current.getContext("2d"), {
      type: "bar",
      data: {
        labels: top.map((item) => item.label),
        datasets: [{ label: "kWh за день", data: top.map((item) => Number(item.total.toFixed(3))), backgroundColor: palette }],
      },
      options: {
        indexAxis: "y",
        responsive: true,
        maintainAspectRatio: false,
        animation: chartAnimation,
        plugins: { legend: { labels: { color: colors.text } } },
        scales: {
          x: { ticks: { color: colors.ticks }, grid: { color: colors.gridStrong } },
          y: { ticks: { color: colors.ticks }, grid: { display: false } },
        },
      },
    });
    const loadChart = new Chart(loadRef.current.getContext("2d"), {
      type: "bar",
      data: {
        labels: recentHourWindow.labels,
        datasets: [
          {
            label: "Суммарно kWh",
            data: totalsBySlot.map((v) => Number(v.toFixed(3))),
            backgroundColor: "rgba(61, 99, 221, 0.45)",
            borderColor: "#3d63dd",
            borderWidth: 1.2,
            borderRadius: 6,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: chartAnimation,
        plugins: { legend: { labels: { color: colors.text } } },
        scales: {
          x: { ticks: { color: colors.ticks, maxRotation: 0 }, grid: { color: colors.gridSoft } },
          y: { ticks: { color: colors.ticks }, grid: { color: colors.gridStrong } },
        },
      },
    });
    chartRefs.current = [mainChart, shareChart, topChart, loadChart];
    return () => chartRefs.current.forEach((chart) => chart?.destroy());
  }, [mainChartType, datasets, props.error_message, recentHourWindow]);

  useEffect(() => {
    if (!window.EventSource) return;
    const stream = new EventSource(`/activity/stream?group=${encodeURIComponent(selectedGroup || "all")}`);
    stream.addEventListener("open", () => setLiveData((v) => ({ ...v, status: tr("online", "online", "online"), online: true })));
    stream.addEventListener("error", () => setLiveData((v) => ({ ...v, status: tr("переподключение...", "reconnecting...", "verbinde neu..."), online: false })));
    stream.addEventListener("stats", (event) => {
      try {
        const payload = JSON.parse(event.data || "{}");
        setLiveData({
          server_time: payload.server_time || "-",
          last_seen: payload.last_seen || "-",
          total_last_5m: payload.total_last_5m ?? 0,
          active_samples_1m: payload.active_samples_1m ?? 0,
          status: tr("online", "online", "online"),
          online: true,
        });
      } catch {
        // ignore malformed payloads
      }
    });
    return () => stream.close();
  }, [selectedGroup, tr]);

  const navigateByFilters = () => {
    const params = new URLSearchParams();
    params.set("date", selectedDate);
    if (selectedGroup && selectedGroup !== "all") params.set("group", selectedGroup);
    window.location.href = `/activity?${params.toString()}`;
  };

  const startExport = () => {
    const params = new URLSearchParams();
    params.set("date", selectedDate);
    params.set("format", format);
    params.set("template", templateMode);
    if (selectedGroup && selectedGroup !== "all") params.set("group", selectedGroup);
    window.location.href = `/activity/export?${params.toString()}`;
  };

  const sendEmailReport = async () => {
    if (!email.trim()) {
      setEmailStatus(tr("Введите email для отправки", "Enter email for delivery", "E-Mail für Versand eingeben"));
      setEmailStatusError(true);
      return;
    }
    setEmailStatus(tr("Отправляем письмо...", "Sending email...", "E-Mail wird gesendet..."));
    setEmailStatusError(false);
    try {
      const response = await fetch("/activity/email-report", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          email: email.trim(),
          report_date: selectedDate,
          group: selectedGroup || "all",
          export_format: format,
          template_mode: templateMode,
        }),
      });
      const payload = await response.json();
      if (!response.ok) {
        setEmailStatus(translateServerMessage(payload.error || tr("Ошибка отправки письма", "Email send error", "Fehler beim Senden der E-Mail"), tr));
        setEmailStatusError(true);
        return;
      }
      setEmailStatus(tr("Письмо отправлено успешно", "Email sent successfully", "E-Mail erfolgreich gesendet"));
      setEmailStatusError(false);
    } catch {
      setEmailStatus(tr("Ошибка сети при отправке", "Network error while sending", "Netzwerkfehler beim Senden"));
      setEmailStatusError(true);
    }
  };

  return (
    <>
      <header className="header">
        <div className="header-row">
          <div className="user-panel">
            <span className="brand-mark">Energy Monitoring</span>
            <p className="number">+375 (29) 824 11 67</p>
          </div>
          <div className="user-panel">
            <span>{props.current_user_role_label}</span>
            <a className="link-btn" href="/incidents">
              {tr("Инциденты", "Incidents", "Vorfälle")}
            </a>
            {props.current_user.role === "admin" ? (
              <a className="link-btn" href="/admin/users">
                {tr("Админ-панель", "Admin panel", "Admin-Panel")}
              </a>
            ) : null}
            <UserDropdown username={props.current_user.username} />
          </div>
        </div>
      </header>
      <main>
        <section className="activity-reports">
          <section className="page-head">
            <div>
              <h1 className="page-title">{tr("Отчеты о статусах активности", "Activity status reports", "Aktivitätsstatusberichte")}</h1>
              <p className="page-subtitle">
                {tr("Мониторинг энергопотребления по устройствам и времени", "Energy monitoring by devices and time", "Energieüberwachung nach Geräten und Zeit")} (UTC{props.timezone_offset_hours >= 0 ? "+" : ""}
                {props.timezone_offset_hours}).
              </p>
            </div>
            <span className="brand-mark">{props.report_date}</span>
          </section>
          <section className="controls">
            <div className="date-selector">
              <label htmlFor="report-date">{tr("Выберите дату:", "Select date:", "Datum auswählen:")}</label>
              <input id="report-date" type="date" value={selectedDate} onChange={(e) => setSelectedDate(e.target.value)} />
            </div>
            <div className="date-selector">
              <label htmlFor="group-select">{tr("Группа устройств:", "Device group:", "Gerätegruppe:")}</label>
              <select id="group-select" value={selectedGroup} onChange={(e) => setSelectedGroup(e.target.value)}>
                <option value="all">{tr("Все группы", "All groups", "Alle Gruppen")}</option>
                {props.available_groups.map((group) => (
                  <option key={group.id} value={group.id}>
                    {group.label}
                  </option>
                ))}
              </select>
            </div>
            <button className="refresh-btn" onClick={navigateByFilters}>
              {tr("Обновить данные", "Refresh data", "Daten aktualisieren")}
            </button>
            {!props.error_message ? (
              <button className="export-btn" type="button" onClick={() => setModalOpen(true)}>
                {tr("Экспорт отчета", "Export report", "Bericht exportieren")}
              </button>
            ) : null}
          </section>

          <section className="insight-grid">
            <article className="insight-card">
              <h3>{tr("Поток за последний час", "Last hour stream", "Datenstrom der letzten Stunde")}</h3>
              <p>
                {tr("Новых измерений:", "New samples:", "Neue Messungen:")} <strong>{props.insights.recent_samples}</strong>
              </p>
              <div className="insight-groups">
                {props.insights.group_stats.length ? (
                  props.insights.group_stats.map((item) => (
                    <span className="insight-pill" key={item.group_id}>
                      {item.group_id}: {item.samples} ({tr("ср.", "avg", "Ø")} {item.avg_kwh} kWh)
                    </span>
                  ))
                ) : (
                  <span className="insight-pill">{tr("Нет свежих данных", "No fresh data", "Keine aktuellen Daten")}</span>
                )}
              </div>
            </article>
            <article className="insight-card">
              <h3>{tr("Аномалия к среднему", "Anomaly vs average", "Anomalie zum Durchschnitt")}</h3>
              <p>
                {tr("Текущая нагрузка:", "Current load:", "Aktuelle Last:")} <strong>{anomaly.current}</strong> kWh
              </p>
              <p>
                {tr("Средняя за час:", "Hourly average:", "Stundendurchschnitt:")} <strong>{anomaly.avg}</strong> kWh
              </p>
              <p>
                {tr("Отклонение:", "Deviation:", "Abweichung:")} <strong>{anomaly.delta}</strong>
              </p>
              <span className={`status-badge ${anomaly.className}`}>{anomaly.status}</span>
            </article>
            <article className="insight-card">
              <h3>{tr("Live мониторинг (SSE)", "Live monitoring (SSE)", "Live-Monitoring (SSE)")}</h3>
              <p>
                {tr("Сервер:", "Server:", "Server:")} <strong>{liveData.server_time}</strong>
              </p>
              <p>
                {tr("Последняя точка:", "Last data point:", "Letzter Punkt:")} <strong>{liveData.last_seen}</strong>
              </p>
              <p>
                {tr("Сумма за 5 мин:", "Total for 5 min:", "Summe für 5 Min:")} <strong>{liveData.total_last_5m}</strong> kWh
              </p>
              <p>
                {tr("Новых измерений за минуту:", "New samples per minute:", "Neue Messungen pro Minute:")} <strong>{liveData.active_samples_1m}</strong>
              </p>
              <span className={`status-badge ${liveData.online ? "active" : ""}`}>{liveData.status}</span>
            </article>
          </section>

          {props.error_message ? (
            <section className="empty-state">
              <h2>{tr("Нет данных за выбранную дату", "No data for selected date", "Keine Daten für ausgewähltes Datum")}</h2>
              <p>{props.error_message}</p>
              <p>{tr("Попробуйте выбрать другую дату или дождитесь новых показаний от симуляторов.", "Try another date or wait for new simulator readings.", "Wählen Sie ein anderes Datum oder warten Sie auf neue Simulatordaten.")}</p>
            </section>
          ) : (
            <>
              <section className="summary-cards">
                <div className="summary-card total">
                  <h3>{tr("Общее потребление", "Total consumption", "Gesamtverbrauch")}</h3>
                  <div className="value">{props.total_consumption} kWh</div>
                  {props.trend >= 0 ? (
                    <div className="trend up">↑ {props.trend}% {tr("с прошлого дня", "from previous day", "zum Vortag")}</div>
                  ) : (
                    <div className="trend down">↓ {Math.abs(props.trend)}% {tr("с прошлого дня", "from previous day", "zum Vortag")}</div>
                  )}
                </div>
                <div className="summary-card peak">
                  <h3>{tr("Пиковое потребление", "Peak consumption", "Spitzenverbrauch")}</h3>
                  <div className="value">{props.peak_consumption.value} kWh</div>
                  <div className="time">{tr("в", "at", "um")} {props.peak_consumption.time}</div>
                </div>
                <div className="summary-card low">
                  <h3>{tr("Минимальное потребление", "Minimum consumption", "Minimaler Verbrauch")}</h3>
                  <div className="value">{props.low_consumption.value} kWh</div>
                  <div className="time">{tr("в", "at", "um")} {props.low_consumption.time}</div>
                </div>
              </section>
              <section className="consumption-graph">
                <h2>{tr("Визуализация потребления за", "Consumption visualization for", "Verbrauchsvisualisierung für")} {props.report_date}</h2>
                <div className="viz-toolbar">
                  <label htmlFor="main-chart-type">{tr("Основной график:", "Main chart:", "Hauptdiagramm:")}</label>
                  <select id="main-chart-type" value={mainChartType} onChange={(e) => setMainChartType(e.target.value)}>
                    <option value="line">{tr("Линейный", "Line", "Linie")}</option>
                    <option value="bar">{tr("Столбчатый", "Bar", "Balken")}</option>
                    <option value="radar">{tr("Радар", "Radar", "Radar")}</option>
                  </select>
                </div>
                <div className="viz-grid">
                  <article className="viz-card">
                    <h3>{tr("Потребление по времени (последний час)", "Consumption over time (last hour)", "Verbrauch über Zeit (letzte Stunde)")}</h3>
                    <div className="graph-container">
                      <canvas ref={mainRef}></canvas>
                    </div>
                  </article>
                  <article className="viz-card">
                    <h3>{tr("Структура по устройствам", "Distribution by devices", "Verteilung nach Geräten")}</h3>
                    <div className="graph-container">
                      <canvas ref={shareRef}></canvas>
                    </div>
                  </article>
                  <article className="viz-card">
                    <h3>{tr("Топ устройств по сумме", "Top devices by total", "Top-Geräte nach Summe")}</h3>
                    <div className="graph-container">
                      <canvas ref={topRef}></canvas>
                    </div>
                  </article>
                  <article className="viz-card">
                    <h3>{tr("Суммарная нагрузка (последний час)", "Total load (last hour)", "Gesamtlast (letzte Stunde)")}</h3>
                    <div className="graph-container">
                      <canvas ref={loadRef}></canvas>
                    </div>
                  </article>
                </div>
              </section>
              <section className="detailed-report">
                <h2>{tr("Детальный отчет по устройствам (последний час)", "Detailed device report (last hour)", "Detaillierter Gerätebericht (letzte Stunde)")}</h2>
                <div className="table-container">
                  <table>
                    <thead>
                      <tr>
                        <th>{tr("Время", "Time", "Zeit")}</th>
                        {props.devices.map((device) => (
                          <th key={device.id || device.name}>{device.name}</th>
                        ))}
                      </tr>
                    </thead>
                    <tbody>
                      {props.consumption_records_last_hour.map((record, idx) => (
                        <tr key={`${record.time}-${idx}`}>
                          <td>{record.time}</td>
                          {record.consumptions.map((consumption, index) => (
                            <td key={`${record.time}-${index}`}>{consumption.value} kWh</td>
                          ))}
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </section>
            </>
          )}
        </section>
      </main>

      <div id="export-modal" className={`modal-overlay ${modalOpen ? "open" : ""}`} onClick={() => setModalOpen(false)}>
        <div className="modal-card" onClick={(e) => e.stopPropagation()}>
          <h3>{tr("Экспорт отчета", "Report export", "Berichtsexport")}</h3>
          <p>{tr("Выберите формат выгрузки отчета за текущую дату и группу.", "Choose export format for current date and group.", "Wählen Sie das Exportformat für aktuelles Datum und Gruppe.")}</p>
          <label htmlFor="export-format">{tr("Формат файла:", "File format:", "Dateiformat:")}</label>
          <select id="export-format" value={format} onChange={(e) => setFormat(e.target.value)}>
            <option value="pdf">PDF</option>
            <option value="xlsx">Excel (.xlsx)</option>
          </select>
          <label htmlFor="export-template">{tr("Шаблон отчета:", "Report template:", "Berichtsvorlage:")}</label>
          <select id="export-template" value={templateMode} onChange={(e) => setTemplateMode(e.target.value)}>
            <option value="brief">{tr("Краткий (1 страница)", "Brief (1 page)", "Kurz (1 Seite)")}</option>
            <option value="detailed">{tr("Детальный (графики + таблица)", "Detailed (charts + table)", "Detailliert (Diagramme + Tabelle)")}</option>
          </select>
          <label htmlFor="export-email">{tr("Email для отправки:", "Email for delivery:", "E-Mail für Versand:")}</label>
          <input id="export-email" type="email" placeholder={tr("example@mail.com", "example@mail.com", "beispiel@mail.com")} value={email} onChange={(e) => setEmail(e.target.value)} />
          <p id="export-email-status" className={`modal-status ${emailStatusError ? "error" : ""}`}>
            {emailStatus}
          </p>
          <div className="modal-actions">
            <button className="link-btn" type="button" onClick={() => setModalOpen(false)}>
              {tr("Отмена", "Cancel", "Abbrechen")}
            </button>
            <button className="export-btn" type="button" onClick={sendEmailReport}>
              {tr("Отправить на почту", "Send by email", "Per E-Mail senden")}
            </button>
            <button className="refresh-btn" type="button" onClick={startExport}>
              {tr("Скачать", "Download", "Herunterladen")}
            </button>
          </div>
        </div>
      </div>
    </>
  );
}

function IncidentsPage({ props }) {
  useServiceWorker();
  const { tr } = useI18n();
  const [selectedDate, setSelectedDate] = useState(props.report_date);
  const [selectedGroup, setSelectedGroup] = useState(props.selected_group || "all");
  const [incidentGroup, setIncidentGroup] = useState(
    props.selected_group || "all"
  );
  const [incidentDeviceName, setIncidentDeviceName] = useState("__all__");
  const devicesByGroup = props.devices_by_group || {};
  const incidentDevices = devicesByGroup[incidentGroup] || [];

  useEffect(() => {
    const availableOptions = ["__all__", ...incidentDevices];
    if (!availableOptions.includes(incidentDeviceName)) {
      setIncidentDeviceName("__all__");
    }
  }, [incidentDevices, incidentDeviceName]);

  const updatePage = () => {
    const params = new URLSearchParams();
    params.set("date", selectedDate);
    if (selectedGroup && selectedGroup !== "all") params.set("group", selectedGroup);
    window.location.href = `/incidents?${params.toString()}`;
  };

  return (
    <>
      <header className="header">
        <div className="header-row">
          <div className="user-panel">
            <span className="brand-mark">Energy Monitoring</span>
            <p className="number">+375 (29) 824 11 67</p>
          </div>
          <div className="user-panel">
            <span>{props.current_user_role_label}</span>
            <a className="link-btn" href="/activity">
              {tr("Активность", "Activity", "Aktivität")}
            </a>
            {props.current_user.role === "admin" ? (
              <a className="link-btn" href="/admin/users">
                {tr("Админ-панель", "Admin panel", "Admin-Panel")}
              </a>
            ) : null}
            <UserDropdown username={props.current_user.username} />
          </div>
        </div>
      </header>
      <main>
        <section className="activity-reports">
          <section className="page-head">
            <div>
              <h1 className="page-title">{tr("Журнал инцидентов", "Incident log", "Vorfallsprotokoll")}</h1>
              <p className="page-subtitle">
                {tr("Ручные отметки событий и причин пиков нагрузки", "Manual log of events and peak-load causes", "Manuelle Erfassung von Ereignissen und Lastspitzenursachen")} (UTC{props.timezone_offset_hours >= 0 ? "+" : ""}
                {props.timezone_offset_hours}).
              </p>
            </div>
            <span className="brand-mark">{props.report_date}</span>
          </section>
          {props.incident_message ? <p className="generated-code">{translateServerMessage(props.incident_message, tr)}</p> : null}
          {props.can_manage_incidents ? (
            <section className="detailed-report">
              <h2>{tr("Добавить инцидент", "Add incident", "Vorfall hinzufügen")}</h2>
              <form className="schedule-form" method="post" action="/incidents">
                <input type="hidden" name="date" value={props.report_date} />
                <input type="hidden" name="group" value={props.selected_group} />
                <label htmlFor="incident-group">{tr("Группа инцидента", "Incident group", "Vorfallsgruppe")}</label>
                <select id="incident-group" name="incident_group" value={incidentGroup} onChange={(e) => setIncidentGroup(e.target.value)}>
                  <option value="all">{tr("Все группы", "All groups", "Alle Gruppen")}</option>
                  {props.available_groups.map((group) => (
                    <option key={group.id} value={group.id}>
                      {group.label}
                    </option>
                  ))}
                </select>
                <label htmlFor="incident-device">{tr("Устройство", "Device", "Gerät")}</label>
                <select
                  id="incident-device"
                  name="incident_device_name"
                  value={incidentDeviceName}
                  onChange={(e) => setIncidentDeviceName(e.target.value)}
                >
                  <option value="__all__">
                    {incidentGroup === "all"
                      ? tr("Все устройства", "All devices", "Alle Geräte")
                      : tr("Все устройства группы", "All group devices", "Alle Geräte der Gruppe")}
                  </option>
                  {incidentDevices.map((deviceName) => (
                    <option key={deviceName} value={deviceName}>
                      {deviceName}
                    </option>
                  ))}
                </select>
                <label htmlFor="incident-occurred-at">{tr("Время инцидента", "Incident time", "Vorfallszeit")}</label>
                <input id="incident-occurred-at" name="occurred_at" type="datetime-local" />
                <label htmlFor="incident-type">{tr("Тип", "Type", "Typ")}</label>
                <select id="incident-type" name="incident_type">
                  {props.incident_types.map((item) => (
                    <option key={item} value={item}>
                      {props.incident_type_labels[item] || item}
                    </option>
                  ))}
                </select>
                <label htmlFor="incident-severity">{tr("Критичность", "Severity", "Schweregrad")}</label>
                <select id="incident-severity" name="severity" defaultValue="medium">
                  {props.incident_severities.map((item) => (
                    <option key={item} value={item}>
                      {props.incident_severity_labels[item] || item}
                    </option>
                  ))}
                </select>
                <label htmlFor="incident-title">{tr("Заголовок", "Title", "Titel")}</label>
                <input id="incident-title" name="title" type="text" required placeholder={tr("Например: Пуск линии №2", "Example: Line #2 start", "Beispiel: Start Linie Nr. 2")} />
                <label htmlFor="incident-description">{tr("Комментарий", "Comment", "Kommentar")}</label>
                <input id="incident-description" name="description" type="text" placeholder={tr("Краткое описание", "Short description", "Kurzbeschreibung")} />
                <button className="refresh-btn" type="submit">
                  {tr("Добавить инцидент", "Add incident", "Vorfall hinzufügen")}
                </button>
              </form>
            </section>
          ) : null}
          <section className="detailed-report">
            <h2>{tr("События за", "Events for", "Ereignisse für")} {selectedDate}</h2>
            <section className="controls">
              <div className="date-selector">
                <label htmlFor="report-date">{tr("Выберите дату:", "Select date:", "Datum auswählen:")}</label>
                <input id="report-date" type="date" value={selectedDate} onChange={(e) => setSelectedDate(e.target.value)} />
              </div>
              <div className="date-selector">
                <label htmlFor="group-select">{tr("Группа устройств:", "Device group:", "Gerätegruppe:")}</label>
                <select id="group-select" value={selectedGroup} onChange={(e) => setSelectedGroup(e.target.value)}>
                  <option value="all">{tr("Все группы", "All groups", "Alle Gruppen")}</option>
                  {props.available_groups.map((group) => (
                    <option key={group.id} value={group.id}>
                      {group.label}
                    </option>
                  ))}
                </select>
              </div>
              <button className="refresh-btn" onClick={updatePage}>
                {tr("Обновить данные", "Refresh data", "Daten aktualisieren")}
              </button>
            </section>
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>{tr("Время", "Time", "Zeit")}</th>
                    <th>{tr("Тип", "Type", "Typ")}</th>
                    <th>{tr("Критичность", "Severity", "Schweregrad")}</th>
                    <th>{tr("Группа", "Group", "Gruppe")}</th>
                    <th>{tr("Устройство", "Device", "Gerät")}</th>
                    <th>{tr("Заголовок", "Title", "Titel")}</th>
                    <th>{tr("Комментарий", "Comment", "Kommentar")}</th>
                  </tr>
                </thead>
                <tbody>
                  {props.incidents.length ? (
                    props.incidents.map((incident) => (
                      <tr key={incident.id}>
                        <td>{incident.occurred_at}</td>
                        <td>{props.incident_type_labels[incident.incident_type] || incident.incident_type}</td>
                        <td>{props.incident_severity_labels[incident.severity] || incident.severity}</td>
                        <td>{incident.group_id}</td>
                        <td>
                          {incident.device_name
                            ? incident.device_name
                            : incident.group_id === "all"
                            ? tr("Все устройства", "All devices", "Alle Geräte")
                            : tr("Все устройства группы", "All group devices", "Alle Geräte der Gruppe")}
                        </td>
                        <td>{incident.title}</td>
                        <td>{incident.description || "-"}</td>
                      </tr>
                    ))
                  ) : (
                    <tr>
                      <td colSpan={7}>{tr("Нет записей об инцидентах за выбранный день", "No incident records for selected day", "Keine Vorfallsdaten für den ausgewählten Tag")}</td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </section>
        </section>
      </main>
    </>
  );
}

function AdminPage({ props }) {
  useServiceWorker();
  const { tr } = useI18n();
  const queryTab = new URLSearchParams(window.location.search).get("tab");
  const [activeTab, setActiveTab] = useState(
    ["users", "schedules", "settings", "queue", "history", "audit"].includes(queryTab || "") ? queryTab : "users"
  );
  const tabs = ["users", "schedules", "settings", "queue", "history", "audit"];
  const [userSearch, setUserSearch] = useState("");
  const [userRoleFilter, setUserRoleFilter] = useState("all");
  const [userStatusFilter, setUserStatusFilter] = useState("all");
  const [userSortField, setUserSortField] = useState("created_at");
  const [userSortDirection, setUserSortDirection] = useState("desc");
  const [auditSearch, setAuditSearch] = useState("");
  const [auditActionFilter, setAuditActionFilter] = useState("all");
  const [auditEntityFilter, setAuditEntityFilter] = useState("all");
  const [auditActorFilter, setAuditActorFilter] = useState("all");
  const [auditSortField, setAuditSortField] = useState("created_at");
  const [auditSortDirection, setAuditSortDirection] = useState("desc");
  const [selectedAuditEntry, setSelectedAuditEntry] = useState(null);
  const tabLabels = {
    users: tr("Пользователи", "Users", "Benutzer"),
    schedules: tr("Расписания", "Schedules", "Zeitpläne"),
    settings: tr("Настройки", "Settings", "Einstellungen"),
    queue: tr("Очередь", "Queue", "Warteschlange"),
    history: tr("История", "History", "Verlauf"),
    audit: tr("Аудит", "Audit", "Audit"),
  };
  const filteredUsers = useMemo(() => {
    const searchNeedle = userSearch.trim().toLowerCase();
    let items = props.users.filter((user) => {
      if (searchNeedle && !String(user.username || "").toLowerCase().includes(searchNeedle)) {
        return false;
      }
      if (userRoleFilter !== "all" && user.role !== userRoleFilter) {
        return false;
      }
      if (userStatusFilter === "active" && user.is_blocked) {
        return false;
      }
      if (userStatusFilter === "blocked" && !user.is_blocked) {
        return false;
      }
      return true;
    });
    const direction = userSortDirection === "asc" ? 1 : -1;
    items = [...items].sort((a, b) => {
      if (userSortField === "id") {
        return (Number(a.id) - Number(b.id)) * direction;
      }
      if (userSortField === "username") {
        return String(a.username || "").localeCompare(String(b.username || ""), undefined, { sensitivity: "base" }) * direction;
      }
      if (userSortField === "role") {
        return String(a.role || "").localeCompare(String(b.role || ""), undefined, { sensitivity: "base" }) * direction;
      }
      if (userSortField === "status") {
        const av = a.is_blocked ? 1 : 0;
        const bv = b.is_blocked ? 1 : 0;
        return (av - bv) * direction;
      }
      return String(a.created_at || "").localeCompare(String(b.created_at || "")) * direction;
    });
    return items;
  }, [props.users, userRoleFilter, userSearch, userSortDirection, userSortField, userStatusFilter]);
  const auditLogs = useMemo(() => (Array.isArray(props.audit_logs) ? props.audit_logs : []), [props.audit_logs]);
  const auditActionOptions = useMemo(
    () =>
      [...new Set(auditLogs.map((item) => String(item.action || "").trim()).filter(Boolean))].sort((a, b) =>
        a.localeCompare(b, undefined, { sensitivity: "base" })
      ),
    [auditLogs]
  );
  const auditEntityOptions = useMemo(
    () =>
      [...new Set(auditLogs.map((item) => String(item.entity_type || "").trim()).filter(Boolean))].sort((a, b) =>
        a.localeCompare(b, undefined, { sensitivity: "base" })
      ),
    [auditLogs]
  );
  const auditActorOptions = useMemo(
    () =>
      [...new Set(auditLogs.map((item) => String(item.actor_username || "").trim()).filter(Boolean))].sort((a, b) =>
        a.localeCompare(b, undefined, { sensitivity: "base" })
      ),
    [auditLogs]
  );
  const filteredAuditLogs = useMemo(() => {
    const searchNeedle = auditSearch.trim().toLowerCase();
    let items = auditLogs.filter((item) => {
      if (auditActionFilter !== "all" && String(item.action || "") !== auditActionFilter) {
        return false;
      }
      if (auditEntityFilter !== "all" && String(item.entity_type || "") !== auditEntityFilter) {
        return false;
      }
      if (auditActorFilter !== "all" && String(item.actor_username || "") !== auditActorFilter) {
        return false;
      }
      if (!searchNeedle) {
        return true;
      }
      const detailsText = JSON.stringify(item.details || {}).toLowerCase();
      const searchText = [item.created_at, item.action, item.entity_type, item.entity_id, item.actor_username, detailsText]
        .map((v) => String(v || "").toLowerCase())
        .join(" ");
      return searchText.includes(searchNeedle);
    });
    const direction = auditSortDirection === "asc" ? 1 : -1;
    items = [...items].sort((a, b) => {
      if (auditSortField === "action") {
        return String(a.action || "").localeCompare(String(b.action || ""), undefined, { sensitivity: "base" }) * direction;
      }
      if (auditSortField === "entity_type") {
        return String(a.entity_type || "").localeCompare(String(b.entity_type || ""), undefined, { sensitivity: "base" }) * direction;
      }
      if (auditSortField === "actor") {
        return String(a.actor_username || "").localeCompare(String(b.actor_username || ""), undefined, { sensitivity: "base" }) * direction;
      }
      if (auditSortField === "entity_id") {
        return String(a.entity_id || "").localeCompare(String(b.entity_id || ""), undefined, { numeric: true, sensitivity: "base" }) * direction;
      }
      return String(a.created_at || "").localeCompare(String(b.created_at || "")) * direction;
    });
    return items;
  }, [
    auditActionFilter,
    auditActorFilter,
    auditEntityFilter,
    auditLogs,
    auditSearch,
    auditSortDirection,
    auditSortField,
  ]);
  const selectedAuditDetailsText = useMemo(() => {
    if (!selectedAuditEntry) {
      return "";
    }
    const serialized = JSON.stringify(selectedAuditEntry.details || {}, null, 2);
    return serialized === "{}" ? "-" : serialized;
  }, [selectedAuditEntry]);

  return (
    <>
      <header className="header">
        <div className="header-row">
          <div className="user-panel">
            <span className="brand-mark">Energy Monitoring</span>
            <p className="number">{tr("Админ-панель пользователей", "User admin panel", "Benutzer-Adminpanel")}</p>
          </div>
          <div className="user-panel">
            <span>{props.current_user_role_label}</span>
            <a className="link-btn" href="/activity">
              {tr("К отчету", "To report", "Zum Bericht")}
            </a>
            <UserDropdown username={props.current_user.username} />
          </div>
        </div>
      </header>
      <main>
        <section className="activity-reports">
          <nav className="admin-tabs" aria-label={tr("Разделы админки", "Admin sections", "Admin-Bereiche")}>
            {tabs.map((tab) => (
              <button key={tab} className={`admin-tab ${activeTab === tab ? "active" : ""}`} type="button" onClick={() => setActiveTab(tab)}>
                {tabLabels[tab]}
              </button>
            ))}
          </nav>

          <section className={`admin-panel ${activeTab === "users" ? "active" : ""}`} data-tab-panel="users">
            <section className="admin-tools">
              <article className="insight-card">
                <h3>{tr("Коды администратора", "Administrator codes", "Administrator-Codes")}</h3>
                <p>{tr("Создавайте одноразовые коды для регистрации новых администраторов.", "Generate one-time codes for registering new administrators.", "Erstellen Sie Einmalcodes zur Registrierung neuer Administratoren.")}</p>
                <form method="post" action="/admin/invite-codes/generate">
                  <button className="refresh-btn" type="submit">
                    {tr("Сгенерировать код", "Generate code", "Code generieren")}
                  </button>
                </form>
                {props.generated_code ? (
                  <p className="generated-code">
                    {tr("Новый код:", "New code:", "Neuer Code:")} <strong>{props.generated_code}</strong>
                  </p>
                ) : null}
              </article>
              <article className="insight-card">
                <h3>{tr("Последние коды", "Recent codes", "Letzte Codes")}</h3>
                <div className="admin-code-list">
                  {props.invite_codes.length ? (
                    props.invite_codes.map((code) => (
                      <div className="admin-code-item" key={code.id}>
                        <span className="admin-code-value">{code.code}</span>
                        <span className={`status-badge ${code.used_at ? "blocked" : "active"}`}>
                          {code.used_at ? tr("использован", "used", "verwendet") : tr("активен", "active", "aktiv")}
                        </span>
                      </div>
                    ))
                  ) : (
                    <p className="page-subtitle">{tr("Коды еще не создавались.", "No codes have been created yet.", "Es wurden noch keine Codes erstellt.")}</p>
                  )}
                </div>
              </article>
            </section>
            <section className="insight-card user-filters-card">
              <div className="user-filters-row">
                <label htmlFor="user-search">{tr("Поиск по имени", "Search by username", "Suche nach Benutzername")}</label>
                <input
                  id="user-search"
                  type="text"
                  value={userSearch}
                  onChange={(e) => setUserSearch(e.target.value)}
                  placeholder={tr("Введите имя пользователя", "Type username", "Benutzernamen eingeben")}
                />
              </div>
              <div className="user-filters-row">
                <label htmlFor="user-role-filter">{tr("Роль", "Role", "Rolle")}</label>
                <select id="user-role-filter" value={userRoleFilter} onChange={(e) => setUserRoleFilter(e.target.value)}>
                  <option value="all">{tr("Все роли", "All roles", "Alle Rollen")}</option>
                  {props.role_choices.map((role) => (
                    <option key={role} value={role}>
                      {props.role_labels[role] || role}
                    </option>
                  ))}
                </select>
              </div>
              <div className="user-filters-row">
                <label htmlFor="user-status-filter">{tr("Статус", "Status", "Status")}</label>
                <select id="user-status-filter" value={userStatusFilter} onChange={(e) => setUserStatusFilter(e.target.value)}>
                  <option value="all">{tr("Все", "All", "Alle")}</option>
                  <option value="active">{tr("Активные", "Active", "Aktiv")}</option>
                  <option value="blocked">{tr("Заблокированные", "Blocked", "Gesperrt")}</option>
                </select>
              </div>
              <div className="user-filters-row">
                <label htmlFor="user-sort-field">{tr("Сортировать по", "Sort by", "Sortieren nach")}</label>
                <select id="user-sort-field" value={userSortField} onChange={(e) => setUserSortField(e.target.value)}>
                  <option value="created_at">{tr("Дате создания", "Created date", "Erstellungsdatum")}</option>
                  <option value="id">{tr("ID", "ID", "ID")}</option>
                  <option value="username">{tr("Имени", "Username", "Benutzername")}</option>
                  <option value="role">{tr("Роли", "Role", "Rolle")}</option>
                  <option value="status">{tr("Статусу", "Status", "Status")}</option>
                </select>
              </div>
              <div className="user-filters-row">
                <label htmlFor="user-sort-direction">{tr("Порядок", "Order", "Reihenfolge")}</label>
                <select id="user-sort-direction" value={userSortDirection} onChange={(e) => setUserSortDirection(e.target.value)}>
                  <option value="desc">{tr("По убыванию", "Descending", "Absteigend")}</option>
                  <option value="asc">{tr("По возрастанию", "Ascending", "Aufsteigend")}</option>
                </select>
              </div>
            </section>
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>{tr("Идентификатор", "ID", "ID")}</th>
                    <th>{tr("Пользователь", "User", "Benutzer")}</th>
                    <th>{tr("Роль", "Role", "Rolle")}</th>
                    <th>{tr("Смена роли", "Change role", "Rolle ändern")}</th>
                    <th>{tr("Статус", "Status", "Status")}</th>
                    <th>{tr("Создан", "Created", "Erstellt")}</th>
                    <th>{tr("Действия", "Actions", "Aktionen")}</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredUsers.map((user) => (
                    <tr key={user.id}>
                      <td>{user.id}</td>
                      <td>{user.username}</td>
                      <td>
                        <span className={`role-badge ${user.role}`}>{props.role_labels[user.role] || user.role}</span>
                      </td>
                      <td>
                        {user.id === props.current_user.id ? (
                          <span className="page-subtitle">{tr("нельзя изменить себя", "cannot change yourself", "Sie können sich selbst nicht ändern")}</span>
                        ) : (
                          <form method="post" action={`/admin/users/${user.id}/role`} className="inline-actions role-edit-form">
                            <select name="role" className="role-select" defaultValue={user.role}>
                              {props.role_choices.map((role) => (
                                <option key={role} value={role}>
                                  {props.role_labels[role] || role}
                                </option>
                              ))}
                            </select>
                            <button className="action-btn ghost" type="submit">
                              {tr("Сохранить", "Save", "Speichern")}
                            </button>
                          </form>
                        )}
                      </td>
                      <td>
                        <span className={`status-badge ${user.is_blocked ? "blocked" : "active"}`}>
                          {user.is_blocked ? tr("заблокирован", "blocked", "gesperrt") : tr("активен", "active", "aktiv")}
                        </span>
                      </td>
                      <td>{user.created_at}</td>
                      <td>
                        {user.id === props.current_user.id ? (
                          <span className="page-subtitle">{tr("текущий админ", "current admin", "aktueller Admin")}</span>
                        ) : user.is_blocked ? (
                          <form method="post" action={`/admin/users/${user.id}/unblock`}>
                            <button className="action-btn ok" type="submit">
                              {tr("Разблокировать", "Unblock", "Entsperren")}
                            </button>
                          </form>
                        ) : (
                          <form method="post" action={`/admin/users/${user.id}/block`}>
                            <button className="action-btn danger" type="submit">
                              {tr("Заблокировать", "Block", "Sperren")}
                            </button>
                          </form>
                        )}
                      </td>
                    </tr>
                  ))}
                  {!filteredUsers.length ? (
                    <tr>
                      <td colSpan={7}>{tr("Пользователи не найдены", "No users found", "Keine Benutzer gefunden")}</td>
                    </tr>
                  ) : null}
                </tbody>
              </table>
            </div>
          </section>

          <section className={`admin-panel ${activeTab === "schedules" ? "active" : ""}`}>
            <article className="insight-card">
              <h3>{tr("Расписания рассылки", "Delivery schedules", "Versandzeitpläne")}</h3>
              <form method="post" action="/admin/schedules/create" className="schedule-form">
                <label htmlFor="sch-email">Email</label>
                <input id="sch-email" name="email" type="email" required placeholder="example@mail.com" />
                <label htmlFor="sch-group">{tr("Группа", "Group", "Gruppe")}</label>
                <select id="sch-group" name="group" defaultValue="all">
                  <option value="all">{tr("Все группы", "All groups", "Alle Gruppen")}</option>
                  {props.available_groups.map((group) => (
                    <option key={group.id} value={group.id}>
                      {group.label}
                    </option>
                  ))}
                </select>
                <label htmlFor="sch-time">{tr("Время (HH:MM)", "Time (HH:MM)", "Zeit (HH:MM)")}</label>
                <input id="sch-time" name="send_time" type="time" defaultValue="08:00" required />
                <label htmlFor="sch-format">{tr("Формат", "Format", "Format")}</label>
                <select id="sch-format" name="export_format" defaultValue="both">
                  <option value="both">{tr("PDF + XLSX", "PDF + XLSX", "PDF + XLSX")}</option>
                  <option value="pdf">{tr("Только PDF", "PDF only", "Nur PDF")}</option>
                  <option value="xlsx">{tr("Только XLSX", "XLSX only", "Nur XLSX")}</option>
                </select>
                <label htmlFor="sch-template">{tr("Шаблон PDF", "PDF template", "PDF-Vorlage")}</label>
                <select id="sch-template" name="template_mode" defaultValue="detailed">
                  <option value="brief">{tr("Краткий", "Brief", "Kurz")}</option>
                  <option value="detailed">{tr("Детальный", "Detailed", "Detailliert")}</option>
                </select>
                <button className="refresh-btn" type="submit">
                  {tr("Создать расписание", "Create schedule", "Zeitplan erstellen")}
                </button>
              </form>
              {props.schedule_message ? <p className="generated-code">{props.schedule_message}</p> : null}
              <div className="admin-code-list">
                {props.schedules.length ? (
                  props.schedules.map((item) => (
                    <div className="admin-code-item" key={item.id}>
                      <span className="admin-code-value">
                        {item.send_time} | {item.recipient_email} | {item.export_format} | {item.template_mode}
                      </span>
                      <div className="inline-actions">
                        <span className={`status-badge ${item.is_enabled ? "active" : "blocked"}`}>
                          {item.is_enabled ? tr("включено", "enabled", "aktiviert") : tr("выключено", "disabled", "deaktiviert")}
                        </span>
                        <form method="post" action={`/admin/schedules/${item.id}/toggle`}>
                          <button className="action-btn ghost" type="submit">
                            {item.is_enabled ? tr("Выключить", "Disable", "Deaktivieren") : tr("Включить", "Enable", "Aktivieren")}
                          </button>
                        </form>
                      </div>
                    </div>
                  ))
                ) : (
                  <p className="page-subtitle">{tr("Расписаний пока нет.", "No schedules yet.", "Noch keine Zeitpläne.")}</p>
                )}
              </div>
            </article>
          </section>

          <section className={`admin-panel ${activeTab === "settings" ? "active" : ""}`}>
            <article className="insight-card">
              <h3>{tr("Системные настройки времени", "System time settings", "Systemzeiteinstellungen")}</h3>
              <p>
                {tr("Текущее смещение:", "Current offset:", "Aktueller Offset:")} <strong>UTC{props.timezone_offset_hours >= 0 ? "+" : ""}{props.timezone_offset_hours}</strong>
              </p>
              <form method="post" action="/admin/settings/timezone" className="schedule-form">
                <label htmlFor="tz-offset">{tr("Смещение UTC (часы)", "UTC offset (hours)", "UTC-Verschiebung (Stunden)")}</label>
                <select id="tz-offset" name="timezone_offset_hours" defaultValue={props.timezone_offset_hours}>
                  {Array.from({ length: 27 }, (_, index) => -12 + index).map((offset) => (
                    <option key={offset} value={offset}>
                      UTC{offset >= 0 ? "+" : ""}
                      {offset}
                    </option>
                  ))}
                </select>
                <button className="refresh-btn" type="submit">
                  {tr("Сохранить часовой пояс", "Save timezone", "Zeitzone speichern")}
                </button>
              </form>
              {props.settings_message ? <p className="generated-code">{props.settings_message}</p> : null}
            </article>
          </section>

          <section className={`admin-panel ${activeTab === "queue" ? "active" : ""}`}>
            <article className="insight-card">
              <h3>{tr("Очередь отправки", "Delivery queue", "Versandwarteschlange")}</h3>
              <div className="admin-code-list">
                {props.queue_items.length ? (
                  props.queue_items.map((item) => (
                    <div className="admin-code-item" key={item.id}>
                      <span className="admin-code-value">
                        #{item.id} {item.recipient_email} {item.export_format} {item.report_date}
                      </span>
                      <div className="inline-actions">
                        {item.status === "sent" ? <span className="status-badge active">{tr("отправлено", "sent", "gesendet")}</span> : null}
                        {item.status === "failed" ? (
                          <>
                            <span className="status-badge blocked">{tr("ошибка", "error", "fehler")}</span>
                            <form method="post" action={`/admin/queue/${item.id}/retry-now`}>
                              <button className="action-btn ok" type="submit">
                                {tr("Повторить сейчас", "Retry now", "Jetzt erneut versuchen")}
                              </button>
                            </form>
                          </>
                        ) : null}
                        {item.status === "pending" ? <span className="status-badge">{tr("в очереди", "queued", "in Warteschlange")}</span> : null}
                        {item.status === "retry" ? <span className="status-badge">{tr("повтор", "retry", "erneut")}</span> : null}
                        {!["sent", "failed", "pending", "retry"].includes(item.status) ? (
                          <span className="status-badge">{item.status}</span>
                        ) : null}
                      </div>
                    </div>
                  ))
                ) : (
                  <p className="page-subtitle">{tr("Очередь пуста.", "Queue is empty.", "Warteschlange ist leer.")}</p>
                )}
              </div>
            </article>
          </section>

          <section className={`admin-panel ${activeTab === "history" ? "active" : ""}`}>
            <article className="insight-card">
              <h3>{tr("История отправок email", "Email delivery history", "E-Mail-Versandverlauf")}</h3>
              <form method="get" action="/admin/users" className="log-filter-form">
                <input type="hidden" name="tab" value="history" />
                <label htmlFor="log-status">{tr("Фильтр по статусу:", "Filter by status:", "Nach Status filtern:")}</label>
                <select id="log-status" name="log_status" defaultValue={props.selected_log_status}>
                  <option value="all">{tr("Все", "All", "Alle")}</option>
                  <option value="queued">queued</option>
                  <option value="sent">sent</option>
                  <option value="retry">retry</option>
                  <option value="failed">failed</option>
                  <option value="retry_manual">retry_manual</option>
                </select>
                <button className="action-btn ghost" type="submit">
                  {tr("Применить", "Apply", "Anwenden")}
                </button>
              </form>
              <div className="admin-code-list">
                {props.email_logs.length ? (
                  props.email_logs.map((log) => (
                    <div className="admin-code-item" key={log.id}>
                      <span className="admin-code-value">
                        {log.created_at} | {log.recipient_email} | {log.export_format} | {log.status}
                      </span>
                      <span
                        className={`status-badge ${
                          log.status === "sent"
                            ? "active"
                            : ["failed", "retry"].includes(log.status)
                            ? "blocked"
                            : ""
                        }`}
                      >
                        {log.status === "sent"
                          ? tr("успех", "success", "erfolg")
                          : ["failed", "retry"].includes(log.status)
                          ? tr("ошибка", "error", "fehler")
                          : ["queued", "retry_manual"].includes(log.status)
                          ? tr("в обработке", "processing", "in Bearbeitung")
                          : log.status}
                      </span>
                    </div>
                  ))
                ) : (
                  <p className="page-subtitle">{tr("Пока нет отправок.", "No deliveries yet.", "Noch keine Sendungen.")}</p>
                )}
              </div>
            </article>
          </section>

          <section className={`admin-panel ${activeTab === "audit" ? "active" : ""}`}>
            <article className="insight-card">
              <h3>{tr("Аудит действий", "Action audit", "Aktionsaudit")}</h3>
              <section className="insight-card user-filters-card audit-filters-card">
                <div className="user-filters-row">
                  <label htmlFor="audit-search">{tr("Поиск", "Search", "Suche")}</label>
                  <input
                    id="audit-search"
                    type="text"
                    value={auditSearch}
                    onChange={(e) => setAuditSearch(e.target.value)}
                    placeholder={tr("Поиск по действию, сущности, ID, пользователю", "Search by action, entity, id, user", "Suche nach Aktion, Entität, ID, Benutzer")}
                  />
                </div>
                <div className="user-filters-row">
                  <label htmlFor="audit-action-filter">{tr("Действие", "Action", "Aktion")}</label>
                  <select id="audit-action-filter" value={auditActionFilter} onChange={(e) => setAuditActionFilter(e.target.value)}>
                    <option value="all">{tr("Все действия", "All actions", "Alle Aktionen")}</option>
                    {auditActionOptions.map((value) => (
                      <option key={value} value={value}>
                        {value}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="user-filters-row">
                  <label htmlFor="audit-entity-filter">{tr("Сущность", "Entity", "Entität")}</label>
                  <select id="audit-entity-filter" value={auditEntityFilter} onChange={(e) => setAuditEntityFilter(e.target.value)}>
                    <option value="all">{tr("Все сущности", "All entities", "Alle Entitäten")}</option>
                    {auditEntityOptions.map((value) => (
                      <option key={value} value={value}>
                        {value}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="user-filters-row">
                  <label htmlFor="audit-actor-filter">{tr("Пользователь", "User", "Benutzer")}</label>
                  <select id="audit-actor-filter" value={auditActorFilter} onChange={(e) => setAuditActorFilter(e.target.value)}>
                    <option value="all">{tr("Все", "All", "Alle")}</option>
                    <option value="">{tr("Система", "System", "System")}</option>
                    {auditActorOptions.map((value) => (
                      <option key={value} value={value}>
                        {value}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="user-filters-row">
                  <label htmlFor="audit-sort-field">{tr("Сортировать по", "Sort by", "Sortieren nach")}</label>
                  <select id="audit-sort-field" value={auditSortField} onChange={(e) => setAuditSortField(e.target.value)}>
                    <option value="created_at">{tr("Дате", "Date", "Datum")}</option>
                    <option value="action">{tr("Действию", "Action", "Aktion")}</option>
                    <option value="entity_type">{tr("Сущности", "Entity", "Entität")}</option>
                    <option value="entity_id">{tr("ID сущности", "Entity ID", "Entitäts-ID")}</option>
                    <option value="actor">{tr("Пользователю", "User", "Benutzer")}</option>
                  </select>
                </div>
                <div className="user-filters-row">
                  <label htmlFor="audit-sort-direction">{tr("Порядок", "Order", "Reihenfolge")}</label>
                  <select id="audit-sort-direction" value={auditSortDirection} onChange={(e) => setAuditSortDirection(e.target.value)}>
                    <option value="desc">{tr("По убыванию", "Descending", "Absteigend")}</option>
                    <option value="asc">{tr("По возрастанию", "Ascending", "Aufsteigend")}</option>
                  </select>
                </div>
              </section>
              <p className="page-subtitle">
                {tr("Показано записей:", "Displayed records:", "Angezeigte Einträge:")} <strong>{filteredAuditLogs.length}</strong>
              </p>
              <div className="table-container">
                <table>
                  <thead>
                    <tr>
                      <th>{tr("Время", "Time", "Zeit")}</th>
                      <th>{tr("Пользователь", "User", "Benutzer")}</th>
                      <th>{tr("Действие", "Action", "Aktion")}</th>
                      <th>{tr("Сущность", "Entity", "Entität")}</th>
                      <th>{tr("ID сущности", "Entity ID", "Entitäts-ID")}</th>
                      <th>{tr("Детали", "Details", "Details")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filteredAuditLogs.length ? (
                      filteredAuditLogs.map((item) => {
                        return (
                          <tr key={item.id}>
                            <td>{item.created_at}</td>
                            <td>{item.actor_username || tr("Система", "System", "System")}</td>
                            <td>
                              <span className="status-badge">{item.action}</span>
                            </td>
                            <td>{item.entity_type}</td>
                            <td>{item.entity_id || "-"}</td>
                            <td>
                              <button className="action-btn ghost" type="button" onClick={() => setSelectedAuditEntry(item)}>
                                {tr("Просмотреть детали", "View details", "Details anzeigen")}
                              </button>
                            </td>
                          </tr>
                        );
                      })
                    ) : (
                      <tr>
                        <td colSpan={6}>{tr("По выбранным фильтрам ничего не найдено.", "No results for current filters.", "Keine Treffer für aktuelle Filter.")}</td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>
            </article>
          </section>
        </section>
      </main>

      <div
        className={`modal-overlay ${selectedAuditEntry ? "open" : ""}`}
        onClick={() => setSelectedAuditEntry(null)}
      >
        <div className="modal-card modal-card-wide" onClick={(e) => e.stopPropagation()}>
          <h3>{tr("Детали записи аудита", "Audit record details", "Details des Audit-Eintrags")}</h3>
          {selectedAuditEntry ? (
            <>
              <p>
                <strong>{tr("Время:", "Time:", "Zeit:")}</strong> {selectedAuditEntry.created_at}
              </p>
              <p>
                <strong>{tr("Пользователь:", "User:", "Benutzer:")}</strong>{" "}
                {selectedAuditEntry.actor_username || tr("Система", "System", "System")}
              </p>
              <p>
                <strong>{tr("Действие:", "Action:", "Aktion:")}</strong> {selectedAuditEntry.action}
              </p>
              <p>
                <strong>{tr("Сущность:", "Entity:", "Entität:")}</strong> {selectedAuditEntry.entity_type}
              </p>
              <p>
                <strong>{tr("ID сущности:", "Entity ID:", "Entitäts-ID:")}</strong> {selectedAuditEntry.entity_id || "-"}
              </p>
              <p>
                <strong>{tr("Подробные данные", "Detailed payload", "Detaillierte Daten")}</strong>
              </p>
              <pre className="audit-details">{selectedAuditDetailsText}</pre>
            </>
          ) : null}
          <div className="modal-actions">
            <button className="link-btn" type="button" onClick={() => setSelectedAuditEntry(null)}>
              {tr("Закрыть", "Close", "Schließen")}
            </button>
          </div>
        </div>
      </div>
    </>
  );
}

function App() {
  const { language, setLanguage } = useLanguageState();
  const dataEl = document.getElementById("app-payload");
  if (!dataEl) return null;
  const payload = JSON.parse(dataEl.textContent || "{}");
  const page = payload.page;
  const props = payload.props || {};
  let content = null;
  if (page === "landing") content = <LandingPage props={props} />;
  if (page === "login") content = <LoginPage props={props} />;
  if (page === "register") content = <RegisterPage props={props} />;
  if (page === "activity") content = <ActivityPage props={props} />;
  if (page === "incidents") content = <IncidentsPage props={props} />;
  if (page === "admin_users") content = <AdminPage props={props} />;
  return <LanguageContext.Provider value={{ language, setLanguage }}>{content}</LanguageContext.Provider>;
}

createRoot(document.getElementById("root")).render(<App />);
