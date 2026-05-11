--
-- PostgreSQL database dump
--

\restrict 5ZlTa6haS8YHsvwGfuEpnKz5UVC1Zue16wWa1u6DMBgkjA45Uljj2HZejyTVmWu

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_invite_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_invite_codes (
    id bigint NOT NULL,
    code character varying(40) NOT NULL,
    created_by_user_id bigint NOT NULL,
    used_by_user_id bigint,
    created_at timestamp without time zone NOT NULL,
    used_at timestamp without time zone
);


--
-- Name: admin_invite_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_invite_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_invite_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_invite_codes_id_seq OWNED BY public.admin_invite_codes.id;


--
-- Name: app_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_settings (
    key character varying(64) NOT NULL,
    value character varying(255) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: app_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_users (
    id bigint NOT NULL,
    username character varying(64) NOT NULL,
    password_hash character varying(256) NOT NULL,
    role character varying(16) NOT NULL,
    is_blocked boolean NOT NULL,
    blocked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: app_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.app_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: app_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.app_users_id_seq OWNED BY public.app_users.id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    actor_user_id bigint,
    action character varying(64) NOT NULL,
    entity_type character varying(64) NOT NULL,
    entity_id character varying(64),
    details_json text,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: email_report_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_report_logs (
    id bigint NOT NULL,
    queue_item_id bigint,
    requested_by_user_id bigint,
    recipient_email character varying(255) NOT NULL,
    report_date date NOT NULL,
    group_id character varying(32) NOT NULL,
    export_format character varying(16) NOT NULL,
    template_mode character varying(16) NOT NULL,
    status character varying(24) NOT NULL,
    error_message text,
    created_at timestamp without time zone NOT NULL,
    sent_at timestamp without time zone
);


--
-- Name: email_report_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_report_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_report_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_report_logs_id_seq OWNED BY public.email_report_logs.id;


--
-- Name: energy_consumption; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.energy_consumption (
    id bigint NOT NULL,
    device_class character varying(100) NOT NULL,
    device_type character varying(50) NOT NULL,
    device_name character varying(50) NOT NULL,
    id_in_group character varying(50),
    save_time timestamp without time zone NOT NULL,
    energy_kwh double precision
);


--
-- Name: energy_consumption_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.energy_consumption_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: energy_consumption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.energy_consumption_id_seq OWNED BY public.energy_consumption.id;


--
-- Name: incident_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.incident_logs (
    id bigint NOT NULL,
    occurred_at timestamp without time zone NOT NULL,
    incident_type character varying(32) NOT NULL,
    severity character varying(16) NOT NULL,
    group_id character varying(32) NOT NULL,
    title character varying(160) NOT NULL,
    description text,
    created_by_user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: incident_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.incident_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incident_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.incident_logs_id_seq OWNED BY public.incident_logs.id;


--
-- Name: report_dispatch_queue; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.report_dispatch_queue (
    id bigint NOT NULL,
    recipient_email character varying(255) NOT NULL,
    report_date date NOT NULL,
    group_id character varying(32) NOT NULL,
    export_format character varying(16) NOT NULL,
    template_mode character varying(16) NOT NULL,
    status character varying(24) NOT NULL,
    attempts integer NOT NULL,
    max_attempts integer NOT NULL,
    next_attempt_at timestamp without time zone NOT NULL,
    last_error text,
    requested_by_user_id bigint,
    schedule_id bigint,
    sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: report_dispatch_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.report_dispatch_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: report_dispatch_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.report_dispatch_queue_id_seq OWNED BY public.report_dispatch_queue.id;


--
-- Name: report_schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.report_schedules (
    id bigint NOT NULL,
    recipient_email character varying(255) NOT NULL,
    group_id character varying(32) NOT NULL,
    export_format character varying(16) NOT NULL,
    template_mode character varying(16) NOT NULL,
    send_time character varying(5) NOT NULL,
    is_enabled boolean NOT NULL,
    created_by_user_id bigint NOT NULL,
    last_run_on date,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: report_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.report_schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: report_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.report_schedules_id_seq OWNED BY public.report_schedules.id;


--
-- Name: admin_invite_codes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_invite_codes ALTER COLUMN id SET DEFAULT nextval('public.admin_invite_codes_id_seq'::regclass);


--
-- Name: app_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users ALTER COLUMN id SET DEFAULT nextval('public.app_users_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: email_report_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_report_logs ALTER COLUMN id SET DEFAULT nextval('public.email_report_logs_id_seq'::regclass);


--
-- Name: energy_consumption id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.energy_consumption ALTER COLUMN id SET DEFAULT nextval('public.energy_consumption_id_seq'::regclass);


--
-- Name: incident_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incident_logs ALTER COLUMN id SET DEFAULT nextval('public.incident_logs_id_seq'::regclass);


--
-- Name: report_dispatch_queue id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_dispatch_queue ALTER COLUMN id SET DEFAULT nextval('public.report_dispatch_queue_id_seq'::regclass);


--
-- Name: report_schedules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_schedules ALTER COLUMN id SET DEFAULT nextval('public.report_schedules_id_seq'::regclass);


--
-- Data for Name: admin_invite_codes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_invite_codes (id, code, created_by_user_id, used_by_user_id, created_at, used_at) FROM stdin;
\.


--
-- Data for Name: app_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.app_settings (key, value, updated_at) FROM stdin;
timezone_offset_hours	3	2026-05-10 00:55:22.499064
\.


--
-- Data for Name: app_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.app_users (id, username, password_hash, role, is_blocked, blocked_at, created_at) FROM stdin;
1	admin	cb17057669d2ddd2f501178511f2ad22$8ae2848add2b1fc2b339fe5e161fcf552c331cffb809f298114499a7dd7f57b2	admin	f	\N	2026-05-09 20:25:47.758435
2	test	c8fc40b37d6551c9c3a4f637181a6683$f0ed0f4f1392def2e3fcc0d295c534fe2e11a6f4f1529e0975b6d4a61c6d530a	operator	f	\N	2026-05-10 00:57:49.917279
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, actor_user_id, action, entity_type, entity_id, details_json, created_at) FROM stdin;
1	1	report_email_enqueued	activity_report	2025-04-01	{"group": "all", "email": "demo@example.com", "format": "pdf", "template": "brief"}	2026-05-09 21:12:34.242055
2	1	schedule_created	report_schedule	1	{"email": "demo@example.com", "group": "all", "format": "both", "time": "08:00", "template": "detailed"}	2026-05-09 21:12:34.259689
3	1	report_exported	activity_report	2025-04-01	{"group": "all", "format": "pdf", "template": "brief"}	2026-05-09 21:12:41.201987
4	1	report_exported	activity_report	2025-04-01	{"group": "all", "format": "pdf", "template": "detailed"}	2026-05-09 21:12:41.545504
5	1	report_sent	report_dispatch_queue	1	{"email": "demo@example.com", "format": "pdf"}	2026-05-09 21:12:52.11782
6	1	schedule_created	report_schedule	2	{"email": "demo@example.com", "group": "all", "format": "both", "time": "08:00", "template": "detailed"}	2026-05-09 21:15:17.562531
7	1	schedule_toggled	report_schedule	1	{"is_enabled": false}	2026-05-09 21:15:17.582122
8	1	report_email_enqueued	activity_report	2025-04-01	{"group": "all", "email": "retry@example.com", "format": "pdf", "template": "brief"}	2026-05-09 21:15:22.653942
9	1	queue_retry_now	report_dispatch_queue	2	{"recipient": "retry@example.com"}	2026-05-09 21:15:28.516898
10	1	report_sent	report_dispatch_queue	2	{"email": "retry@example.com", "format": "pdf"}	2026-05-09 21:15:34.307329
11	1	schedule_toggled	report_schedule	2	{"is_enabled": false}	2026-05-09 21:20:07.316262
12	1	schedule_created	report_schedule	3	{"email": "panel@example.com", "group": "all", "format": "both", "time": "08:00", "template": "detailed", "source": "admin_panel"}	2026-05-09 21:22:50.176853
13	1	report_exported	activity_report	2026-05-09	{"group": "all", "format": "pdf", "template": "brief"}	2026-05-09 21:23:50.899402
14	1	report_exported	activity_report	2026-05-09	{"group": "all", "format": "xlsx", "template": "detailed"}	2026-05-09 21:23:55.996172
15	1	report_exported	activity_report	2026-05-09	{"group": "CP-300", "format": "pdf", "template": "brief"}	2026-05-09 21:24:39.691195
16	1	report_exported	activity_report	2026-05-09	{"group": "CP-300", "format": "pdf", "template": "detailed"}	2026-05-09 21:25:01.207275
17	1	report_exported	activity_report	2026-05-09	{"group": "CP-300", "format": "pdf", "template": "detailed"}	2026-05-09 21:27:04.256307
18	1	schedule_toggled	report_schedule	3	{"is_enabled": false}	2026-05-10 00:36:01.425998
19	1	schedule_toggled	report_schedule	1	{"is_enabled": true}	2026-05-10 00:37:17.134332
20	1	schedule_toggled	report_schedule	3	{"is_enabled": true}	2026-05-10 00:37:40.858662
21	1	schedule_toggled	report_schedule	3	{"is_enabled": false}	2026-05-10 00:37:41.490154
22	1	schedule_toggled	report_schedule	2	{"is_enabled": true}	2026-05-10 00:37:42.599654
23	1	schedule_toggled	report_schedule	2	{"is_enabled": false}	2026-05-10 00:37:43.080833
24	1	timezone_updated	app_settings	timezone_offset_hours	{"timezone_offset_hours": 3}	2026-05-10 00:57:18.713482
\.


--
-- Data for Name: email_report_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.email_report_logs (id, queue_item_id, requested_by_user_id, recipient_email, report_date, group_id, export_format, template_mode, status, error_message, created_at, sent_at) FROM stdin;
1	1	1	demo@example.com	2025-04-01	all	pdf	brief	queued	\N	2026-05-09 21:12:34.243054	\N
2	1	1	demo@example.com	2025-04-01	all	pdf	brief	sent	\N	2026-05-09 21:12:52.118472	2026-05-09 21:12:52.115659
3	2	1	retry@example.com	2025-04-01	all	pdf	brief	queued	\N	2026-05-09 21:15:22.654554	\N
4	2	1	retry@example.com	2025-04-01	all	pdf	brief	retry_manual	\N	2026-05-09 21:15:28.518457	\N
5	2	1	retry@example.com	2025-04-01	all	pdf	brief	sent	\N	2026-05-09 21:15:34.308526	2026-05-09 21:15:34.305732
\.


--
-- Data for Name: energy_consumption; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.energy_consumption (id, device_class, device_type, device_name, id_in_group, save_time, energy_kwh) FROM stdin;
1	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 00:00:00	27.42
2	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 00:00:00	5.75
3	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 00:00:00	19.97
4	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 00:00:00	6.41
5	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 00:00:00	25.73
6	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 00:00:00	23.71
7	QF 1,20	ЗУ	China 1	044	2025-04-01 00:00:00	11.51
8	QF 1,21	ЗУ	China 2	045	2025-04-01 00:00:00	9.95
9	QF 1,22	ЗУ	China 3	046	2025-04-01 00:00:00	13.8
10	QF 2,20	ЗУ	China 4	047	2025-04-01 00:00:00	18.79
11	QF 2,21	ЗУ	China 5	048	2025-04-01 00:00:00	20.86
12	QF 2,22	ЗУ	China 6	049	2025-04-01 00:00:00	19.24
13	QF 2,23	ЗУ	China 7	050	2025-04-01 00:00:00	8.8
14	QF 2,19	ЗУ	China 8	051	2025-04-01 00:00:00	14.11
15	Q8	ЗУ	DIG	061	2025-04-01 00:00:00	64.51
16	Q4	ЗУ	BG 1	062	2025-04-01 00:00:00	0
17	Q9	ЗУ	BG 2	063	2025-04-01 00:00:00	20.29
18	Q10	ЗУ	SM 2	064	2025-04-01 00:00:00	32.55
19	Q11	ЗУ	SM 3	065	2025-04-01 00:00:00	18.56
20	Q12	ЗУ	SM 4	066	2025-04-01 00:00:00	21.03
21	Q13	ЗУ	SM 5	067	2025-04-01 00:00:00	0
22	Q14	ЗУ	SM 6	068	2025-04-01 00:00:00	0
23	Q15	ЗУ	SM 7	069	2025-04-01 00:00:00	0
24	Q16	ЗУ	SM 8	070	2025-04-01 00:00:00	0
25	Q17	ЗУ	MO 9	071	2025-04-01 00:00:00	2.08
26	Q20	ЗУ	MO 10	072	2025-04-01 00:00:00	0
27	Q21	ЗУ	MO 11	073	2025-04-01 00:00:00	13.04
28	Q22	ЗУ	MO 12	074	2025-04-01 00:00:00	0
29	Q23	ЗУ	MO 13	075	2025-04-01 00:00:00	0
30	Q24	ЗУ	MO 14	076	2025-04-01 00:00:00	0
31	Q25	ЗУ	MO 15	077	2025-04-01 00:00:00	0
32	TP3	ЗУ	CP-300 New	078	2025-04-01 00:00:00	0.2835
33	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 00:30:00	27.35
34	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 00:30:00	5.62
35	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 00:30:00	19.98
36	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 00:30:00	6.56
37	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 00:30:00	27.69
38	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 00:30:00	25.62
39	QF 1,20	ЗУ	China 1	044	2025-04-01 00:30:00	11.58
40	QF 1,21	ЗУ	China 2	045	2025-04-01 00:30:00	10.17
41	QF 1,22	ЗУ	China 3	046	2025-04-01 00:30:00	13.8
42	QF 2,20	ЗУ	China 4	047	2025-04-01 00:30:00	18.92
43	QF 2,21	ЗУ	China 5	048	2025-04-01 00:30:00	21.29
44	QF 2,22	ЗУ	China 6	049	2025-04-01 00:30:00	19.63
45	QF 2,23	ЗУ	China 7	050	2025-04-01 00:30:00	8.85
46	QF 2,19	ЗУ	China 8	051	2025-04-01 00:30:00	14.27
47	Q8	ЗУ	DIG	061	2025-04-01 00:30:00	59.69
48	Q4	ЗУ	BG 1	062	2025-04-01 00:30:00	0
49	Q9	ЗУ	BG 2	063	2025-04-01 00:30:00	20.28
50	Q10	ЗУ	SM 2	064	2025-04-01 00:30:00	32.55
51	Q11	ЗУ	SM 3	065	2025-04-01 00:30:00	18.51
52	Q12	ЗУ	SM 4	066	2025-04-01 00:30:00	21.14
53	Q13	ЗУ	SM 5	067	2025-04-01 00:30:00	0
54	Q14	ЗУ	SM 6	068	2025-04-01 00:30:00	0
55	Q15	ЗУ	SM 7	069	2025-04-01 00:30:00	0
56	Q16	ЗУ	SM 8	070	2025-04-01 00:30:00	0
57	Q17	ЗУ	MO 9	071	2025-04-01 00:30:00	2.09
58	Q20	ЗУ	MO 10	072	2025-04-01 00:30:00	0
59	Q21	ЗУ	MO 11	073	2025-04-01 00:30:00	13.06
60	Q22	ЗУ	MO 12	074	2025-04-01 00:30:00	0
61	Q23	ЗУ	MO 13	075	2025-04-01 00:30:00	0.0692
62	Q24	ЗУ	MO 14	076	2025-04-01 00:30:00	0
63	Q25	ЗУ	MO 15	077	2025-04-01 00:30:00	0
64	TP3	ЗУ	CP-300 New	078	2025-04-01 00:30:00	0.284
65	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 01:00:00	24.89
66	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 01:00:00	5.29
67	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 01:00:00	18.02
68	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 01:00:00	5.36
69	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 01:00:00	19.44
70	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 01:00:00	18.06
71	QF 1,20	ЗУ	China 1	044	2025-04-01 01:00:00	11.96
72	QF 1,21	ЗУ	China 2	045	2025-04-01 01:00:00	10.55
73	QF 1,22	ЗУ	China 3	046	2025-04-01 01:00:00	13.99
74	QF 2,20	ЗУ	China 4	047	2025-04-01 01:00:00	19.12
75	QF 2,21	ЗУ	China 5	048	2025-04-01 01:00:00	22.1
76	QF 2,22	ЗУ	China 6	049	2025-04-01 01:00:00	19.9
77	QF 2,23	ЗУ	China 7	050	2025-04-01 01:00:00	8.57
78	QF 2,19	ЗУ	China 8	051	2025-04-01 01:00:00	14.51
79	Q8	ЗУ	DIG	061	2025-04-01 01:00:00	49.49
80	Q4	ЗУ	BG 1	062	2025-04-01 01:00:00	0
81	Q9	ЗУ	BG 2	063	2025-04-01 01:00:00	20.3
82	Q10	ЗУ	SM 2	064	2025-04-01 01:00:00	32.54
83	Q11	ЗУ	SM 3	065	2025-04-01 01:00:00	18.54
84	Q12	ЗУ	SM 4	066	2025-04-01 01:00:00	21.17
85	Q13	ЗУ	SM 5	067	2025-04-01 01:00:00	0
86	Q14	ЗУ	SM 6	068	2025-04-01 01:00:00	0
87	Q15	ЗУ	SM 7	069	2025-04-01 01:00:00	0
88	Q16	ЗУ	SM 8	070	2025-04-01 01:00:00	0
89	Q17	ЗУ	MO 9	071	2025-04-01 01:00:00	2.09
90	Q20	ЗУ	MO 10	072	2025-04-01 01:00:00	0
91	Q21	ЗУ	MO 11	073	2025-04-01 01:00:00	13.06
92	Q22	ЗУ	MO 12	074	2025-04-01 01:00:00	0
93	Q23	ЗУ	MO 13	075	2025-04-01 01:00:00	0.3854
94	Q24	ЗУ	MO 14	076	2025-04-01 01:00:00	0
95	Q25	ЗУ	MO 15	077	2025-04-01 01:00:00	0
96	TP3	ЗУ	CP-300 New	078	2025-04-01 01:00:00	0.2849
97	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 01:30:00	1.32
98	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 01:30:00	1.12
99	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 01:30:00	0.2068
100	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 01:30:00	2.08
101	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 01:30:00	6.35
102	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 01:30:00	5.93
103	QF 1,20	ЗУ	China 1	044	2025-04-01 01:30:00	12.57
104	QF 1,21	ЗУ	China 2	045	2025-04-01 01:30:00	10.86
105	QF 1,22	ЗУ	China 3	046	2025-04-01 01:30:00	13.91
106	QF 2,20	ЗУ	China 4	047	2025-04-01 01:30:00	19.84
107	QF 2,21	ЗУ	China 5	048	2025-04-01 01:30:00	22.87
108	QF 2,22	ЗУ	China 6	049	2025-04-01 01:30:00	20.59
109	QF 2,23	ЗУ	China 7	050	2025-04-01 01:30:00	9.26
110	QF 2,19	ЗУ	China 8	051	2025-04-01 01:30:00	14.43
111	Q8	ЗУ	DIG	061	2025-04-01 01:30:00	48.45
112	Q4	ЗУ	BG 1	062	2025-04-01 01:30:00	0
113	Q9	ЗУ	BG 2	063	2025-04-01 01:30:00	20.3
114	Q10	ЗУ	SM 2	064	2025-04-01 01:30:00	32.56
115	Q11	ЗУ	SM 3	065	2025-04-01 01:30:00	18.58
116	Q12	ЗУ	SM 4	066	2025-04-01 01:30:00	21.15
117	Q13	ЗУ	SM 5	067	2025-04-01 01:30:00	0
118	Q14	ЗУ	SM 6	068	2025-04-01 01:30:00	0
119	Q15	ЗУ	SM 7	069	2025-04-01 01:30:00	0
120	Q16	ЗУ	SM 8	070	2025-04-01 01:30:00	0
121	Q17	ЗУ	MO 9	071	2025-04-01 01:30:00	2.1
122	Q20	ЗУ	MO 10	072	2025-04-01 01:30:00	0
123	Q21	ЗУ	MO 11	073	2025-04-01 01:30:00	13.07
124	Q22	ЗУ	MO 12	074	2025-04-01 01:30:00	0
125	Q23	ЗУ	MO 13	075	2025-04-01 01:30:00	1.5
126	Q24	ЗУ	MO 14	076	2025-04-01 01:30:00	0
127	Q25	ЗУ	MO 15	077	2025-04-01 01:30:00	0
128	TP3	ЗУ	CP-300 New	078	2025-04-01 01:30:00	0.2857
129	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 02:00:00	0
130	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 02:00:00	0
131	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 02:00:00	0.0023
132	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 02:00:00	0.0026
133	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 02:00:00	0
134	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 02:00:00	0
135	QF 1,20	ЗУ	China 1	044	2025-04-01 02:00:00	12.19
136	QF 1,21	ЗУ	China 2	045	2025-04-01 02:00:00	10.04
137	QF 1,22	ЗУ	China 3	046	2025-04-01 02:00:00	13.08
138	QF 2,20	ЗУ	China 4	047	2025-04-01 02:00:00	18.91
139	QF 2,21	ЗУ	China 5	048	2025-04-01 02:00:00	21.85
140	QF 2,22	ЗУ	China 6	049	2025-04-01 02:00:00	19.09
141	QF 2,23	ЗУ	China 7	050	2025-04-01 02:00:00	8.66
142	QF 2,19	ЗУ	China 8	051	2025-04-01 02:00:00	13.61
143	Q8	ЗУ	DIG	061	2025-04-01 02:00:00	48.46
144	Q4	ЗУ	BG 1	062	2025-04-01 02:00:00	0
145	Q9	ЗУ	BG 2	063	2025-04-01 02:00:00	20.3
146	Q10	ЗУ	SM 2	064	2025-04-01 02:00:00	32.53
147	Q11	ЗУ	SM 3	065	2025-04-01 02:00:00	18.62
148	Q12	ЗУ	SM 4	066	2025-04-01 02:00:00	21.17
149	Q13	ЗУ	SM 5	067	2025-04-01 02:00:00	0
150	Q14	ЗУ	SM 6	068	2025-04-01 02:00:00	0
151	Q15	ЗУ	SM 7	069	2025-04-01 02:00:00	0
152	Q16	ЗУ	SM 8	070	2025-04-01 02:00:00	0
153	Q17	ЗУ	MO 9	071	2025-04-01 02:00:00	2.11
154	Q20	ЗУ	MO 10	072	2025-04-01 02:00:00	0
155	Q21	ЗУ	MO 11	073	2025-04-01 02:00:00	13.06
156	Q22	ЗУ	MO 12	074	2025-04-01 02:00:00	0
157	Q23	ЗУ	MO 13	075	2025-04-01 02:00:00	0.3969
158	Q24	ЗУ	MO 14	076	2025-04-01 02:00:00	0
159	Q25	ЗУ	MO 15	077	2025-04-01 02:00:00	0
160	TP3	ЗУ	CP-300 New	078	2025-04-01 02:00:00	0.286
161	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 02:30:00	0
162	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 02:30:00	0.0013
163	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 02:30:00	0.0026
164	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 02:30:00	0.0029
165	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 02:30:00	0
166	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 02:30:00	0
167	QF 1,20	ЗУ	China 1	044	2025-04-01 02:30:00	14.71
168	QF 1,21	ЗУ	China 2	045	2025-04-01 02:30:00	12.3
169	QF 1,22	ЗУ	China 3	046	2025-04-01 02:30:00	14.77
170	QF 2,20	ЗУ	China 4	047	2025-04-01 02:30:00	21.11
171	QF 2,21	ЗУ	China 5	048	2025-04-01 02:30:00	24.03
172	QF 2,22	ЗУ	China 6	049	2025-04-01 02:30:00	21.92
173	QF 2,23	ЗУ	China 7	050	2025-04-01 02:30:00	9.97
174	QF 2,19	ЗУ	China 8	051	2025-04-01 02:30:00	15.81
175	Q8	ЗУ	DIG	061	2025-04-01 02:30:00	48.14
176	Q4	ЗУ	BG 1	062	2025-04-01 02:30:00	0
177	Q9	ЗУ	BG 2	063	2025-04-01 02:30:00	20.33
178	Q10	ЗУ	SM 2	064	2025-04-01 02:30:00	32.57
179	Q11	ЗУ	SM 3	065	2025-04-01 02:30:00	18.65
180	Q12	ЗУ	SM 4	066	2025-04-01 02:30:00	21.23
181	Q13	ЗУ	SM 5	067	2025-04-01 02:30:00	0
182	Q14	ЗУ	SM 6	068	2025-04-01 02:30:00	0
183	Q15	ЗУ	SM 7	069	2025-04-01 02:30:00	0
184	Q16	ЗУ	SM 8	070	2025-04-01 02:30:00	0
185	Q17	ЗУ	MO 9	071	2025-04-01 02:30:00	2.09
186	Q20	ЗУ	MO 10	072	2025-04-01 02:30:00	0
187	Q21	ЗУ	MO 11	073	2025-04-01 02:30:00	13.05
188	Q22	ЗУ	MO 12	074	2025-04-01 02:30:00	0
189	Q23	ЗУ	MO 13	075	2025-04-01 02:30:00	5.15
190	Q24	ЗУ	MO 14	076	2025-04-01 02:30:00	0
191	Q25	ЗУ	MO 15	077	2025-04-01 02:30:00	0
192	TP3	ЗУ	CP-300 New	078	2025-04-01 02:30:00	0.2857
193	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 03:00:00	0
194	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 03:00:00	0.0005
195	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 03:00:00	0.0025
196	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 03:00:00	0.003
197	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 03:00:00	0
198	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 03:00:00	0
199	QF 1,20	ЗУ	China 1	044	2025-04-01 03:00:00	15.12
200	QF 1,21	ЗУ	China 2	045	2025-04-01 03:00:00	12.63
201	QF 1,22	ЗУ	China 3	046	2025-04-01 03:00:00	15.24
202	QF 2,20	ЗУ	China 4	047	2025-04-01 03:00:00	21.27
203	QF 2,21	ЗУ	China 5	048	2025-04-01 03:00:00	23.92
204	QF 2,22	ЗУ	China 6	049	2025-04-01 03:00:00	22.02
205	QF 2,23	ЗУ	China 7	050	2025-04-01 03:00:00	9.95
206	QF 2,19	ЗУ	China 8	051	2025-04-01 03:00:00	15.83
207	Q8	ЗУ	DIG	061	2025-04-01 03:00:00	37.69
208	Q4	ЗУ	BG 1	062	2025-04-01 03:00:00	0
209	Q9	ЗУ	BG 2	063	2025-04-01 03:00:00	20.31
210	Q10	ЗУ	SM 2	064	2025-04-01 03:00:00	32.5
211	Q11	ЗУ	SM 3	065	2025-04-01 03:00:00	18.57
212	Q12	ЗУ	SM 4	066	2025-04-01 03:00:00	21.23
213	Q13	ЗУ	SM 5	067	2025-04-01 03:00:00	0
214	Q14	ЗУ	SM 6	068	2025-04-01 03:00:00	0
215	Q15	ЗУ	SM 7	069	2025-04-01 03:00:00	0
216	Q16	ЗУ	SM 8	070	2025-04-01 03:00:00	0
217	Q17	ЗУ	MO 9	071	2025-04-01 03:00:00	2.06
218	Q20	ЗУ	MO 10	072	2025-04-01 03:00:00	0
219	Q21	ЗУ	MO 11	073	2025-04-01 03:00:00	13.05
220	Q22	ЗУ	MO 12	074	2025-04-01 03:00:00	0
221	Q23	ЗУ	MO 13	075	2025-04-01 03:00:00	12.64
222	Q24	ЗУ	MO 14	076	2025-04-01 03:00:00	0
223	Q25	ЗУ	MO 15	077	2025-04-01 03:00:00	0
224	TP3	ЗУ	CP-300 New	078	2025-04-01 03:00:00	0.2825
225	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 03:30:00	0
226	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 03:30:00	0.0008
227	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 03:30:00	0.0025
228	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 03:30:00	0.0028
229	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 03:30:00	0
230	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 03:30:00	0
231	QF 1,20	ЗУ	China 1	044	2025-04-01 03:30:00	17
232	QF 1,21	ЗУ	China 2	045	2025-04-01 03:30:00	14.39
233	QF 1,22	ЗУ	China 3	046	2025-04-01 03:30:00	16.55
234	QF 2,20	ЗУ	China 4	047	2025-04-01 03:30:00	22.47
235	QF 2,21	ЗУ	China 5	048	2025-04-01 03:30:00	25.58
236	QF 2,22	ЗУ	China 6	049	2025-04-01 03:30:00	23.52
237	QF 2,23	ЗУ	China 7	050	2025-04-01 03:30:00	10.57
238	QF 2,19	ЗУ	China 8	051	2025-04-01 03:30:00	17.35
239	Q8	ЗУ	DIG	061	2025-04-01 03:30:00	31.28
240	Q4	ЗУ	BG 1	062	2025-04-01 03:30:00	0
241	Q9	ЗУ	BG 2	063	2025-04-01 03:30:00	20.28
242	Q10	ЗУ	SM 2	064	2025-04-01 03:30:00	32.46
243	Q11	ЗУ	SM 3	065	2025-04-01 03:30:00	18.49
244	Q12	ЗУ	SM 4	066	2025-04-01 03:30:00	21.14
245	Q13	ЗУ	SM 5	067	2025-04-01 03:30:00	0
246	Q14	ЗУ	SM 6	068	2025-04-01 03:30:00	0
247	Q15	ЗУ	SM 7	069	2025-04-01 03:30:00	0
248	Q16	ЗУ	SM 8	070	2025-04-01 03:30:00	0
249	Q17	ЗУ	MO 9	071	2025-04-01 03:30:00	1.98
250	Q20	ЗУ	MO 10	072	2025-04-01 03:30:00	0
251	Q21	ЗУ	MO 11	073	2025-04-01 03:30:00	13.03
252	Q22	ЗУ	MO 12	074	2025-04-01 03:30:00	0
253	Q23	ЗУ	MO 13	075	2025-04-01 03:30:00	12.52
254	Q24	ЗУ	MO 14	076	2025-04-01 03:30:00	0
255	Q25	ЗУ	MO 15	077	2025-04-01 03:30:00	3.27
256	TP3	ЗУ	CP-300 New	078	2025-04-01 03:30:00	0.277
257	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 04:00:00	0
258	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 04:00:00	0.0011
259	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 04:00:00	0.0028
260	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 04:00:00	0.0025
261	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 04:00:00	0
262	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 04:00:00	0
263	QF 1,20	ЗУ	China 1	044	2025-04-01 04:00:00	20.51
264	QF 1,21	ЗУ	China 2	045	2025-04-01 04:00:00	17.66
265	QF 1,22	ЗУ	China 3	046	2025-04-01 04:00:00	19.34
266	QF 2,20	ЗУ	China 4	047	2025-04-01 04:00:00	25.16
267	QF 2,21	ЗУ	China 5	048	2025-04-01 04:00:00	28.23
268	QF 2,22	ЗУ	China 6	049	2025-04-01 04:00:00	25.8
269	QF 2,23	ЗУ	China 7	050	2025-04-01 04:00:00	12.09
270	QF 2,19	ЗУ	China 8	051	2025-04-01 04:00:00	20.78
271	Q8	ЗУ	DIG	061	2025-04-01 04:00:00	31.42
272	Q4	ЗУ	BG 1	062	2025-04-01 04:00:00	0
273	Q9	ЗУ	BG 2	063	2025-04-01 04:00:00	20.28
274	Q10	ЗУ	SM 2	064	2025-04-01 04:00:00	32.48
275	Q11	ЗУ	SM 3	065	2025-04-01 04:00:00	18.38
276	Q12	ЗУ	SM 4	066	2025-04-01 04:00:00	21.08
277	Q13	ЗУ	SM 5	067	2025-04-01 04:00:00	0
278	Q14	ЗУ	SM 6	068	2025-04-01 04:00:00	0
279	Q15	ЗУ	SM 7	069	2025-04-01 04:00:00	0
280	Q16	ЗУ	SM 8	070	2025-04-01 04:00:00	0
281	Q17	ЗУ	MO 9	071	2025-04-01 04:00:00	1.95
282	Q20	ЗУ	MO 10	072	2025-04-01 04:00:00	0
283	Q21	ЗУ	MO 11	073	2025-04-01 04:00:00	13.04
284	Q22	ЗУ	MO 12	074	2025-04-01 04:00:00	0
285	Q23	ЗУ	MO 13	075	2025-04-01 04:00:00	12.55
286	Q24	ЗУ	MO 14	076	2025-04-01 04:00:00	0
287	Q25	ЗУ	MO 15	077	2025-04-01 04:00:00	6.55
288	TP3	ЗУ	CP-300 New	078	2025-04-01 04:00:00	0.2767
289	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 04:30:00	0
290	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 04:30:00	0.0002
291	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 04:30:00	0.0025
292	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 04:30:00	0.0028
293	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 04:30:00	0
294	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 04:30:00	0
295	QF 1,20	ЗУ	China 1	044	2025-04-01 04:30:00	22.71
296	QF 1,21	ЗУ	China 2	045	2025-04-01 04:30:00	19.93
297	QF 1,22	ЗУ	China 3	046	2025-04-01 04:30:00	21.77
298	QF 2,20	ЗУ	China 4	047	2025-04-01 04:30:00	27.05
299	QF 2,21	ЗУ	China 5	048	2025-04-01 04:30:00	30.02
300	QF 2,22	ЗУ	China 6	049	2025-04-01 04:30:00	27.81
301	QF 2,23	ЗУ	China 7	050	2025-04-01 04:30:00	12.99
302	QF 2,19	ЗУ	China 8	051	2025-04-01 04:30:00	22.6
303	Q8	ЗУ	DIG	061	2025-04-01 04:30:00	30.13
304	Q4	ЗУ	BG 1	062	2025-04-01 04:30:00	0
305	Q9	ЗУ	BG 2	063	2025-04-01 04:30:00	20.23
306	Q10	ЗУ	SM 2	064	2025-04-01 04:30:00	32.44
307	Q11	ЗУ	SM 3	065	2025-04-01 04:30:00	18.35
308	Q12	ЗУ	SM 4	066	2025-04-01 04:30:00	21.22
309	Q13	ЗУ	SM 5	067	2025-04-01 04:30:00	0
310	Q14	ЗУ	SM 6	068	2025-04-01 04:30:00	0
311	Q15	ЗУ	SM 7	069	2025-04-01 04:30:00	0
312	Q16	ЗУ	SM 8	070	2025-04-01 04:30:00	0
313	Q17	ЗУ	MO 9	071	2025-04-01 04:30:00	1.95
314	Q20	ЗУ	MO 10	072	2025-04-01 04:30:00	0
315	Q21	ЗУ	MO 11	073	2025-04-01 04:30:00	13.02
316	Q22	ЗУ	MO 12	074	2025-04-01 04:30:00	0
317	Q23	ЗУ	MO 13	075	2025-04-01 04:30:00	12.48
318	Q24	ЗУ	MO 14	076	2025-04-01 04:30:00	0
319	Q25	ЗУ	MO 15	077	2025-04-01 04:30:00	9.16
320	TP3	ЗУ	CP-300 New	078	2025-04-01 04:30:00	0.2756
321	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 05:00:00	0
322	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 05:00:00	0.0001
323	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 05:00:00	0.0027
324	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 05:00:00	0.0031
325	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 05:00:00	0
326	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 05:00:00	0
327	QF 1,20	ЗУ	China 1	044	2025-04-01 05:00:00	23.53
328	QF 1,21	ЗУ	China 2	045	2025-04-01 05:00:00	20.77
329	QF 1,22	ЗУ	China 3	046	2025-04-01 05:00:00	22.15
330	QF 2,20	ЗУ	China 4	047	2025-04-01 05:00:00	27.2
331	QF 2,21	ЗУ	China 5	048	2025-04-01 05:00:00	30.01
332	QF 2,22	ЗУ	China 6	049	2025-04-01 05:00:00	27.61
333	QF 2,23	ЗУ	China 7	050	2025-04-01 05:00:00	13.37
334	QF 2,19	ЗУ	China 8	051	2025-04-01 05:00:00	23.09
335	Q8	ЗУ	DIG	061	2025-04-01 05:00:00	29.86
336	Q4	ЗУ	BG 1	062	2025-04-01 05:00:00	0
337	Q9	ЗУ	BG 2	063	2025-04-01 05:00:00	20.22
338	Q10	ЗУ	SM 2	064	2025-04-01 05:00:00	32.43
339	Q11	ЗУ	SM 3	065	2025-04-01 05:00:00	18.28
340	Q12	ЗУ	SM 4	066	2025-04-01 05:00:00	21.08
341	Q13	ЗУ	SM 5	067	2025-04-01 05:00:00	0
342	Q14	ЗУ	SM 6	068	2025-04-01 05:00:00	0
343	Q15	ЗУ	SM 7	069	2025-04-01 05:00:00	0
344	Q16	ЗУ	SM 8	070	2025-04-01 05:00:00	0
345	Q17	ЗУ	MO 9	071	2025-04-01 05:00:00	1.96
346	Q20	ЗУ	MO 10	072	2025-04-01 05:00:00	0
347	Q21	ЗУ	MO 11	073	2025-04-01 05:00:00	13.03
348	Q22	ЗУ	MO 12	074	2025-04-01 05:00:00	0
349	Q23	ЗУ	MO 13	075	2025-04-01 05:00:00	12.48
350	Q24	ЗУ	MO 14	076	2025-04-01 05:00:00	0
351	Q25	ЗУ	MO 15	077	2025-04-01 05:00:00	9.42
352	TP3	ЗУ	CP-300 New	078	2025-04-01 05:00:00	0.2749
353	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 05:30:00	0
354	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 05:30:00	0.0012
355	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 05:30:00	0.003
356	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 05:30:00	0.0031
357	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 05:30:00	0
358	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 05:30:00	0
359	QF 1,20	ЗУ	China 1	044	2025-04-01 05:30:00	27.7
360	QF 1,21	ЗУ	China 2	045	2025-04-01 05:30:00	25.08
361	QF 1,22	ЗУ	China 3	046	2025-04-01 05:30:00	25.93
362	QF 2,20	ЗУ	China 4	047	2025-04-01 05:30:00	31.14
363	QF 2,21	ЗУ	China 5	048	2025-04-01 05:30:00	34.09
364	QF 2,22	ЗУ	China 6	049	2025-04-01 05:30:00	32.5
365	QF 2,23	ЗУ	China 7	050	2025-04-01 05:30:00	15.78
366	QF 2,19	ЗУ	China 8	051	2025-04-01 05:30:00	26.98
367	Q8	ЗУ	DIG	061	2025-04-01 05:30:00	32.12
368	Q4	ЗУ	BG 1	062	2025-04-01 05:30:00	0
369	Q9	ЗУ	BG 2	063	2025-04-01 05:30:00	20.27
370	Q10	ЗУ	SM 2	064	2025-04-01 05:30:00	32.44
371	Q11	ЗУ	SM 3	065	2025-04-01 05:30:00	18.22
372	Q12	ЗУ	SM 4	066	2025-04-01 05:30:00	21.08
373	Q13	ЗУ	SM 5	067	2025-04-01 05:30:00	0
374	Q14	ЗУ	SM 6	068	2025-04-01 05:30:00	0
375	Q15	ЗУ	SM 7	069	2025-04-01 05:30:00	0
376	Q16	ЗУ	SM 8	070	2025-04-01 05:30:00	0
377	Q17	ЗУ	MO 9	071	2025-04-01 05:30:00	1.96
378	Q20	ЗУ	MO 10	072	2025-04-01 05:30:00	0
379	Q21	ЗУ	MO 11	073	2025-04-01 05:30:00	13.08
380	Q22	ЗУ	MO 12	074	2025-04-01 05:30:00	0
381	Q23	ЗУ	MO 13	075	2025-04-01 05:30:00	12.52
382	Q24	ЗУ	MO 14	076	2025-04-01 05:30:00	0
383	Q25	ЗУ	MO 15	077	2025-04-01 05:30:00	9.4
384	TP3	ЗУ	CP-300 New	078	2025-04-01 05:30:00	0.7831
385	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 06:00:00	0
386	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 06:00:00	0.0002
387	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 06:00:00	0.0028
388	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 06:00:00	0.0031
389	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 06:00:00	0
390	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 06:00:00	0
391	QF 1,20	ЗУ	China 1	044	2025-04-01 06:00:00	27.97
392	QF 1,21	ЗУ	China 2	045	2025-04-01 06:00:00	25.68
393	QF 1,22	ЗУ	China 3	046	2025-04-01 06:00:00	26.55
394	QF 2,20	ЗУ	China 4	047	2025-04-01 06:00:00	31.56
395	QF 2,21	ЗУ	China 5	048	2025-04-01 06:00:00	35.87
396	QF 2,22	ЗУ	China 6	049	2025-04-01 06:00:00	33.36
397	QF 2,23	ЗУ	China 7	050	2025-04-01 06:00:00	16.52
398	QF 2,19	ЗУ	China 8	051	2025-04-01 06:00:00	27.23
399	Q8	ЗУ	DIG	061	2025-04-01 06:00:00	37.71
400	Q4	ЗУ	BG 1	062	2025-04-01 06:00:00	0
401	Q9	ЗУ	BG 2	063	2025-04-01 06:00:00	20.35
402	Q10	ЗУ	SM 2	064	2025-04-01 06:00:00	32.49
403	Q11	ЗУ	SM 3	065	2025-04-01 06:00:00	18.33
404	Q12	ЗУ	SM 4	066	2025-04-01 06:00:00	21.18
405	Q13	ЗУ	SM 5	067	2025-04-01 06:00:00	0
406	Q14	ЗУ	SM 6	068	2025-04-01 06:00:00	0
407	Q15	ЗУ	SM 7	069	2025-04-01 06:00:00	0
408	Q16	ЗУ	SM 8	070	2025-04-01 06:00:00	0
409	Q17	ЗУ	MO 9	071	2025-04-01 06:00:00	2.03
410	Q20	ЗУ	MO 10	072	2025-04-01 06:00:00	0
411	Q21	ЗУ	MO 11	073	2025-04-01 06:00:00	13.04
412	Q22	ЗУ	MO 12	074	2025-04-01 06:00:00	0
413	Q23	ЗУ	MO 13	075	2025-04-01 06:00:00	12.6
414	Q24	ЗУ	MO 14	076	2025-04-01 06:00:00	0
415	Q25	ЗУ	MO 15	077	2025-04-01 06:00:00	9.48
416	TP3	ЗУ	CP-300 New	078	2025-04-01 06:00:00	1.04
417	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 06:30:00	0
418	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 06:30:00	0.0011
419	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 06:30:00	0.0029
420	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 06:30:00	0.0033
421	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 06:30:00	0
422	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 06:30:00	0
423	QF 1,20	ЗУ	China 1	044	2025-04-01 06:30:00	27.16
424	QF 1,21	ЗУ	China 2	045	2025-04-01 06:30:00	24.79
425	QF 1,22	ЗУ	China 3	046	2025-04-01 06:30:00	25.98
426	QF 2,20	ЗУ	China 4	047	2025-04-01 06:30:00	31.84
427	QF 2,21	ЗУ	China 5	048	2025-04-01 06:30:00	35.35
428	QF 2,22	ЗУ	China 6	049	2025-04-01 06:30:00	33.05
429	QF 2,23	ЗУ	China 7	050	2025-04-01 06:30:00	16.5
430	QF 2,19	ЗУ	China 8	051	2025-04-01 06:30:00	26.33
431	Q8	ЗУ	DIG	061	2025-04-01 06:30:00	42.73
432	Q4	ЗУ	BG 1	062	2025-04-01 06:30:00	0
433	Q9	ЗУ	BG 2	063	2025-04-01 06:30:00	20.35
434	Q10	ЗУ	SM 2	064	2025-04-01 06:30:00	32.48
435	Q11	ЗУ	SM 3	065	2025-04-01 06:30:00	18.32
436	Q12	ЗУ	SM 4	066	2025-04-01 06:30:00	21.19
437	Q13	ЗУ	SM 5	067	2025-04-01 06:30:00	0
438	Q14	ЗУ	SM 6	068	2025-04-01 06:30:00	0
439	Q15	ЗУ	SM 7	069	2025-04-01 06:30:00	0
440	Q16	ЗУ	SM 8	070	2025-04-01 06:30:00	0
441	Q17	ЗУ	MO 9	071	2025-04-01 06:30:00	2.01
442	Q20	ЗУ	MO 10	072	2025-04-01 06:30:00	0
443	Q21	ЗУ	MO 11	073	2025-04-01 06:30:00	13.07
444	Q22	ЗУ	MO 12	074	2025-04-01 06:30:00	0
445	Q23	ЗУ	MO 13	075	2025-04-01 06:30:00	12.52
446	Q24	ЗУ	MO 14	076	2025-04-01 06:30:00	0
447	Q25	ЗУ	MO 15	077	2025-04-01 06:30:00	9.51
448	TP3	ЗУ	CP-300 New	078	2025-04-01 06:30:00	1.64
449	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 07:00:00	0.6067
450	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 07:00:00	0.5099
451	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 07:00:00	0.1057
452	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 07:00:00	0.0037
453	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 07:00:00	0
454	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 07:00:00	0
455	QF 1,20	ЗУ	China 1	044	2025-04-01 07:00:00	24.42
456	QF 1,21	ЗУ	China 2	045	2025-04-01 07:00:00	22.07
457	QF 1,22	ЗУ	China 3	046	2025-04-01 07:00:00	22.89
458	QF 2,20	ЗУ	China 4	047	2025-04-01 07:00:00	27.89
459	QF 2,21	ЗУ	China 5	048	2025-04-01 07:00:00	31.84
460	QF 2,22	ЗУ	China 6	049	2025-04-01 07:00:00	29.6
461	QF 2,23	ЗУ	China 7	050	2025-04-01 07:00:00	15.11
462	QF 2,19	ЗУ	China 8	051	2025-04-01 07:00:00	23.5
463	Q8	ЗУ	DIG	061	2025-04-01 07:00:00	46.47
464	Q4	ЗУ	BG 1	062	2025-04-01 07:00:00	0
465	Q9	ЗУ	BG 2	063	2025-04-01 07:00:00	20.34
466	Q10	ЗУ	SM 2	064	2025-04-01 07:00:00	32.39
467	Q11	ЗУ	SM 3	065	2025-04-01 07:00:00	18.26
468	Q12	ЗУ	SM 4	066	2025-04-01 07:00:00	21.21
469	Q13	ЗУ	SM 5	067	2025-04-01 07:00:00	0
470	Q14	ЗУ	SM 6	068	2025-04-01 07:00:00	0
471	Q15	ЗУ	SM 7	069	2025-04-01 07:00:00	0
472	Q16	ЗУ	SM 8	070	2025-04-01 07:00:00	0
473	Q17	ЗУ	MO 9	071	2025-04-01 07:00:00	1.97
474	Q20	ЗУ	MO 10	072	2025-04-01 07:00:00	0
475	Q21	ЗУ	MO 11	073	2025-04-01 07:00:00	13.02
476	Q22	ЗУ	MO 12	074	2025-04-01 07:00:00	0
477	Q23	ЗУ	MO 13	075	2025-04-01 07:00:00	12.49
478	Q24	ЗУ	MO 14	076	2025-04-01 07:00:00	0
479	Q25	ЗУ	MO 15	077	2025-04-01 07:00:00	9.4
480	TP3	ЗУ	CP-300 New	078	2025-04-01 07:00:00	2.07
481	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 07:30:00	2.21
482	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 07:30:00	1.85
483	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 07:30:00	0.3732
484	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 07:30:00	0.0033
485	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 07:30:00	0
486	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 07:30:00	0
487	QF 1,20	ЗУ	China 1	044	2025-04-01 07:30:00	23.22
488	QF 1,21	ЗУ	China 2	045	2025-04-01 07:30:00	20.64
489	QF 1,22	ЗУ	China 3	046	2025-04-01 07:30:00	22.47
490	QF 2,20	ЗУ	China 4	047	2025-04-01 07:30:00	26.28
491	QF 2,21	ЗУ	China 5	048	2025-04-01 07:30:00	30.68
492	QF 2,22	ЗУ	China 6	049	2025-04-01 07:30:00	28.42
493	QF 2,23	ЗУ	China 7	050	2025-04-01 07:30:00	14.38
494	QF 2,19	ЗУ	China 8	051	2025-04-01 07:30:00	21.94
495	Q8	ЗУ	DIG	061	2025-04-01 07:30:00	54.6
496	Q4	ЗУ	BG 1	062	2025-04-01 07:30:00	0
497	Q9	ЗУ	BG 2	063	2025-04-01 07:30:00	20.29
498	Q10	ЗУ	SM 2	064	2025-04-01 07:30:00	32.33
499	Q11	ЗУ	SM 3	065	2025-04-01 07:30:00	18.27
500	Q12	ЗУ	SM 4	066	2025-04-01 07:30:00	21.18
501	Q13	ЗУ	SM 5	067	2025-04-01 07:30:00	0
502	Q14	ЗУ	SM 6	068	2025-04-01 07:30:00	0
503	Q15	ЗУ	SM 7	069	2025-04-01 07:30:00	0
504	Q16	ЗУ	SM 8	070	2025-04-01 07:30:00	0
505	Q17	ЗУ	MO 9	071	2025-04-01 07:30:00	1.93
506	Q20	ЗУ	MO 10	072	2025-04-01 07:30:00	0
507	Q21	ЗУ	MO 11	073	2025-04-01 07:30:00	13
508	Q22	ЗУ	MO 12	074	2025-04-01 07:30:00	0
509	Q23	ЗУ	MO 13	075	2025-04-01 07:30:00	17.63
510	Q24	ЗУ	MO 14	076	2025-04-01 07:30:00	0
511	Q25	ЗУ	MO 15	077	2025-04-01 07:30:00	9.37
512	TP3	ЗУ	CP-300 New	078	2025-04-01 07:30:00	5.26
513	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 08:00:00	7.57
514	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 08:00:00	3.5
515	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 08:00:00	3.19
516	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 08:00:00	0.0034
517	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 08:00:00	0
518	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 08:00:00	0
519	QF 1,20	ЗУ	China 1	044	2025-04-01 08:00:00	21.64
520	QF 1,21	ЗУ	China 2	045	2025-04-01 08:00:00	19.09
521	QF 1,22	ЗУ	China 3	046	2025-04-01 08:00:00	21.4
522	QF 2,20	ЗУ	China 4	047	2025-04-01 08:00:00	25.36
523	QF 2,21	ЗУ	China 5	048	2025-04-01 08:00:00	29.41
524	QF 2,22	ЗУ	China 6	049	2025-04-01 08:00:00	27.58
525	QF 2,23	ЗУ	China 7	050	2025-04-01 08:00:00	14.01
526	QF 2,19	ЗУ	China 8	051	2025-04-01 08:00:00	20.54
527	Q8	ЗУ	DIG	061	2025-04-01 08:00:00	55.91
528	Q4	ЗУ	BG 1	062	2025-04-01 08:00:00	0
529	Q9	ЗУ	BG 2	063	2025-04-01 08:00:00	20.25
530	Q10	ЗУ	SM 2	064	2025-04-01 08:00:00	32.3
531	Q11	ЗУ	SM 3	065	2025-04-01 08:00:00	18.32
532	Q12	ЗУ	SM 4	066	2025-04-01 08:00:00	21.08
533	Q13	ЗУ	SM 5	067	2025-04-01 08:00:00	0
534	Q14	ЗУ	SM 6	068	2025-04-01 08:00:00	0
535	Q15	ЗУ	SM 7	069	2025-04-01 08:00:00	0
536	Q16	ЗУ	SM 8	070	2025-04-01 08:00:00	0
537	Q17	ЗУ	MO 9	071	2025-04-01 08:00:00	1.89
538	Q20	ЗУ	MO 10	072	2025-04-01 08:00:00	0
539	Q21	ЗУ	MO 11	073	2025-04-01 08:00:00	13.07
540	Q22	ЗУ	MO 12	074	2025-04-01 08:00:00	0
541	Q23	ЗУ	MO 13	075	2025-04-01 08:00:00	25.58
542	Q24	ЗУ	MO 14	076	2025-04-01 08:00:00	0
543	Q25	ЗУ	MO 15	077	2025-04-01 08:00:00	9.28
544	TP3	ЗУ	CP-300 New	078	2025-04-01 08:00:00	7.53
545	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 08:30:00	16.93
546	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 08:30:00	6.58
547	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 08:30:00	8.88
548	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 08:30:00	0.003
549	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 08:30:00	0
550	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 08:30:00	0
551	QF 1,20	ЗУ	China 1	044	2025-04-01 08:30:00	22.45
552	QF 1,21	ЗУ	China 2	045	2025-04-01 08:30:00	19.9
553	QF 1,22	ЗУ	China 3	046	2025-04-01 08:30:00	22.19
554	QF 2,20	ЗУ	China 4	047	2025-04-01 08:30:00	25.91
555	QF 2,21	ЗУ	China 5	048	2025-04-01 08:30:00	30.08
556	QF 2,22	ЗУ	China 6	049	2025-04-01 08:30:00	28.15
557	QF 2,23	ЗУ	China 7	050	2025-04-01 08:30:00	14.2
558	QF 2,19	ЗУ	China 8	051	2025-04-01 08:30:00	20.75
559	Q8	ЗУ	DIG	061	2025-04-01 08:30:00	55.58
560	Q4	ЗУ	BG 1	062	2025-04-01 08:30:00	0
561	Q9	ЗУ	BG 2	063	2025-04-01 08:30:00	20.21
562	Q10	ЗУ	SM 2	064	2025-04-01 08:30:00	32.26
563	Q11	ЗУ	SM 3	065	2025-04-01 08:30:00	18.29
564	Q12	ЗУ	SM 4	066	2025-04-01 08:30:00	21.03
565	Q13	ЗУ	SM 5	067	2025-04-01 08:30:00	0
566	Q14	ЗУ	SM 6	068	2025-04-01 08:30:00	0
567	Q15	ЗУ	SM 7	069	2025-04-01 08:30:00	0
568	Q16	ЗУ	SM 8	070	2025-04-01 08:30:00	0
569	Q17	ЗУ	MO 9	071	2025-04-01 08:30:00	1.86
570	Q20	ЗУ	MO 10	072	2025-04-01 08:30:00	0
571	Q21	ЗУ	MO 11	073	2025-04-01 08:30:00	13.1
572	Q22	ЗУ	MO 12	074	2025-04-01 08:30:00	0
573	Q23	ЗУ	MO 13	075	2025-04-01 08:30:00	25.48
574	Q24	ЗУ	MO 14	076	2025-04-01 08:30:00	0
575	Q25	ЗУ	MO 15	077	2025-04-01 08:30:00	9.2
576	TP3	ЗУ	CP-300 New	078	2025-04-01 08:30:00	9.21
577	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 09:00:00	20.72
578	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 09:00:00	7.82
579	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 09:00:00	11.4
580	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 09:00:00	0.0029
581	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 09:00:00	0
582	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 09:00:00	0
583	QF 1,20	ЗУ	China 1	044	2025-04-01 09:00:00	21.76
584	QF 1,21	ЗУ	China 2	045	2025-04-01 09:00:00	18.84
585	QF 1,22	ЗУ	China 3	046	2025-04-01 09:00:00	22.01
586	QF 2,20	ЗУ	China 4	047	2025-04-01 09:00:00	25.26
587	QF 2,21	ЗУ	China 5	048	2025-04-01 09:00:00	28.44
588	QF 2,22	ЗУ	China 6	049	2025-04-01 09:00:00	27.71
589	QF 2,23	ЗУ	China 7	050	2025-04-01 09:00:00	14.18
590	QF 2,19	ЗУ	China 8	051	2025-04-01 09:00:00	20.6
591	Q8	ЗУ	DIG	061	2025-04-01 09:00:00	43.47
592	Q4	ЗУ	BG 1	062	2025-04-01 09:00:00	0
593	Q9	ЗУ	BG 2	063	2025-04-01 09:00:00	20.24
594	Q10	ЗУ	SM 2	064	2025-04-01 09:00:00	32.26
595	Q11	ЗУ	SM 3	065	2025-04-01 09:00:00	18.24
596	Q12	ЗУ	SM 4	066	2025-04-01 09:00:00	21.05
597	Q13	ЗУ	SM 5	067	2025-04-01 09:00:00	0
598	Q14	ЗУ	SM 6	068	2025-04-01 09:00:00	0
599	Q15	ЗУ	SM 7	069	2025-04-01 09:00:00	0
600	Q16	ЗУ	SM 8	070	2025-04-01 09:00:00	0
601	Q17	ЗУ	MO 9	071	2025-04-01 09:00:00	1.88
602	Q20	ЗУ	MO 10	072	2025-04-01 09:00:00	0
603	Q21	ЗУ	MO 11	073	2025-04-01 09:00:00	13.1
604	Q22	ЗУ	MO 12	074	2025-04-01 09:00:00	0
605	Q23	ЗУ	MO 13	075	2025-04-01 09:00:00	25.46
606	Q24	ЗУ	MO 14	076	2025-04-01 09:00:00	0
607	Q25	ЗУ	MO 15	077	2025-04-01 09:00:00	9.16
608	TP3	ЗУ	CP-300 New	078	2025-04-01 09:00:00	11.87
609	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 09:30:00	27.14
610	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 09:30:00	9.18
611	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 09:30:00	16.69
612	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 09:30:00	0.0042
613	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 09:30:00	0
614	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 09:30:00	0
615	QF 1,20	ЗУ	China 1	044	2025-04-01 09:30:00	23.91
616	QF 1,21	ЗУ	China 2	045	2025-04-01 09:30:00	21.29
617	QF 1,22	ЗУ	China 3	046	2025-04-01 09:30:00	24.42
618	QF 2,20	ЗУ	China 4	047	2025-04-01 09:30:00	26.85
619	QF 2,21	ЗУ	China 5	048	2025-04-01 09:30:00	31.22
620	QF 2,22	ЗУ	China 6	049	2025-04-01 09:30:00	29.53
621	QF 2,23	ЗУ	China 7	050	2025-04-01 09:30:00	15.14
622	QF 2,19	ЗУ	China 8	051	2025-04-01 09:30:00	22.59
623	Q8	ЗУ	DIG	061	2025-04-01 09:30:00	40.3
624	Q4	ЗУ	BG 1	062	2025-04-01 09:30:00	0
625	Q9	ЗУ	BG 2	063	2025-04-01 09:30:00	20.23
626	Q10	ЗУ	SM 2	064	2025-04-01 09:30:00	32.29
627	Q11	ЗУ	SM 3	065	2025-04-01 09:30:00	18.22
628	Q12	ЗУ	SM 4	066	2025-04-01 09:30:00	21.02
629	Q13	ЗУ	SM 5	067	2025-04-01 09:30:00	0
630	Q14	ЗУ	SM 6	068	2025-04-01 09:30:00	0
631	Q15	ЗУ	SM 7	069	2025-04-01 09:30:00	0
632	Q16	ЗУ	SM 8	070	2025-04-01 09:30:00	0
633	Q17	ЗУ	MO 9	071	2025-04-01 09:30:00	1.91
634	Q20	ЗУ	MO 10	072	2025-04-01 09:30:00	0
635	Q21	ЗУ	MO 11	073	2025-04-01 09:30:00	13.11
636	Q22	ЗУ	MO 12	074	2025-04-01 09:30:00	0
637	Q23	ЗУ	MO 13	075	2025-04-01 09:30:00	25.43
638	Q24	ЗУ	MO 14	076	2025-04-01 09:30:00	0
639	Q25	ЗУ	MO 15	077	2025-04-01 09:30:00	15.45
640	TP3	ЗУ	CP-300 New	078	2025-04-01 09:30:00	13.33
641	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 10:00:00	31.41
642	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 10:00:00	10.17
643	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 10:00:00	20.19
644	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 10:00:00	0.0042
645	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 10:00:00	0
646	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 10:00:00	0
647	QF 1,20	ЗУ	China 1	044	2025-04-01 10:00:00	23.18
648	QF 1,21	ЗУ	China 2	045	2025-04-01 10:00:00	20.77
649	QF 1,22	ЗУ	China 3	046	2025-04-01 10:00:00	23.72
650	QF 2,20	ЗУ	China 4	047	2025-04-01 10:00:00	26.32
651	QF 2,21	ЗУ	China 5	048	2025-04-01 10:00:00	29.96
652	QF 2,22	ЗУ	China 6	049	2025-04-01 10:00:00	28.55
653	QF 2,23	ЗУ	China 7	050	2025-04-01 10:00:00	14.98
654	QF 2,19	ЗУ	China 8	051	2025-04-01 10:00:00	22.53
655	Q8	ЗУ	DIG	061	2025-04-01 10:00:00	40.37
656	Q4	ЗУ	BG 1	062	2025-04-01 10:00:00	0
657	Q9	ЗУ	BG 2	063	2025-04-01 10:00:00	20.24
658	Q10	ЗУ	SM 2	064	2025-04-01 10:00:00	32.33
659	Q11	ЗУ	SM 3	065	2025-04-01 10:00:00	18.23
660	Q12	ЗУ	SM 4	066	2025-04-01 10:00:00	21.03
661	Q13	ЗУ	SM 5	067	2025-04-01 10:00:00	0
662	Q14	ЗУ	SM 6	068	2025-04-01 10:00:00	0
663	Q15	ЗУ	SM 7	069	2025-04-01 10:00:00	0
664	Q16	ЗУ	SM 8	070	2025-04-01 10:00:00	0
665	Q17	ЗУ	MO 9	071	2025-04-01 10:00:00	1.93
666	Q20	ЗУ	MO 10	072	2025-04-01 10:00:00	0
667	Q21	ЗУ	MO 11	073	2025-04-01 10:00:00	13.11
668	Q22	ЗУ	MO 12	074	2025-04-01 10:00:00	0
669	Q23	ЗУ	MO 13	075	2025-04-01 10:00:00	25.47
670	Q24	ЗУ	MO 14	076	2025-04-01 10:00:00	0
671	Q25	ЗУ	MO 15	077	2025-04-01 10:00:00	16.16
672	TP3	ЗУ	CP-300 New	078	2025-04-01 10:00:00	14.89
673	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 10:30:00	31.27
674	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 10:30:00	9.72
675	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 10:30:00	20.44
676	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 10:30:00	0.0042
677	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 10:30:00	0
678	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 10:30:00	0
679	QF 1,20	ЗУ	China 1	044	2025-04-01 10:30:00	22.72
680	QF 1,21	ЗУ	China 2	045	2025-04-01 10:30:00	20.04
681	QF 1,22	ЗУ	China 3	046	2025-04-01 10:30:00	22.41
682	QF 2,20	ЗУ	China 4	047	2025-04-01 10:30:00	25.53
683	QF 2,21	ЗУ	China 5	048	2025-04-01 10:30:00	30
684	QF 2,22	ЗУ	China 6	049	2025-04-01 10:30:00	27.35
685	QF 2,23	ЗУ	China 7	050	2025-04-01 10:30:00	14.27
686	QF 2,19	ЗУ	China 8	051	2025-04-01 10:30:00	21.95
687	Q8	ЗУ	DIG	061	2025-04-01 10:30:00	41.74
688	Q4	ЗУ	BG 1	062	2025-04-01 10:30:00	0
689	Q9	ЗУ	BG 2	063	2025-04-01 10:30:00	20.19
690	Q10	ЗУ	SM 2	064	2025-04-01 10:30:00	32.27
691	Q11	ЗУ	SM 3	065	2025-04-01 10:30:00	18.18
692	Q12	ЗУ	SM 4	066	2025-04-01 10:30:00	21.03
693	Q13	ЗУ	SM 5	067	2025-04-01 10:30:00	0
694	Q14	ЗУ	SM 6	068	2025-04-01 10:30:00	0
695	Q15	ЗУ	SM 7	069	2025-04-01 10:30:00	0
696	Q16	ЗУ	SM 8	070	2025-04-01 10:30:00	0
697	Q17	ЗУ	MO 9	071	2025-04-01 10:30:00	2.01
698	Q20	ЗУ	MO 10	072	2025-04-01 10:30:00	0
699	Q21	ЗУ	MO 11	073	2025-04-01 10:30:00	13.07
700	Q22	ЗУ	MO 12	074	2025-04-01 10:30:00	0
701	Q23	ЗУ	MO 13	075	2025-04-01 10:30:00	25.39
702	Q24	ЗУ	MO 14	076	2025-04-01 10:30:00	0
703	Q25	ЗУ	MO 15	077	2025-04-01 10:30:00	16.01
704	TP3	ЗУ	CP-300 New	078	2025-04-01 10:30:00	20.02
705	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 11:00:00	31.17
706	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 11:00:00	8.89
707	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 11:00:00	20.96
708	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 11:00:00	0.0042
709	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 11:00:00	0
710	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 11:00:00	0
711	QF 1,20	ЗУ	China 1	044	2025-04-01 11:00:00	22
712	QF 1,21	ЗУ	China 2	045	2025-04-01 11:00:00	19.61
713	QF 1,22	ЗУ	China 3	046	2025-04-01 11:00:00	22.92
714	QF 2,20	ЗУ	China 4	047	2025-04-01 11:00:00	24.64
715	QF 2,21	ЗУ	China 5	048	2025-04-01 11:00:00	29.11
716	QF 2,22	ЗУ	China 6	049	2025-04-01 11:00:00	27.13
717	QF 2,23	ЗУ	China 7	050	2025-04-01 11:00:00	13.95
718	QF 2,19	ЗУ	China 8	051	2025-04-01 11:00:00	21.22
719	Q8	ЗУ	DIG	061	2025-04-01 11:00:00	42.89
720	Q4	ЗУ	BG 1	062	2025-04-01 11:00:00	0
721	Q9	ЗУ	BG 2	063	2025-04-01 11:00:00	20.2
722	Q10	ЗУ	SM 2	064	2025-04-01 11:00:00	32.27
723	Q11	ЗУ	SM 3	065	2025-04-01 11:00:00	18.2
724	Q12	ЗУ	SM 4	066	2025-04-01 11:00:00	21.03
725	Q13	ЗУ	SM 5	067	2025-04-01 11:00:00	0
726	Q14	ЗУ	SM 6	068	2025-04-01 11:00:00	0
727	Q15	ЗУ	SM 7	069	2025-04-01 11:00:00	0
728	Q16	ЗУ	SM 8	070	2025-04-01 11:00:00	0
729	Q17	ЗУ	MO 9	071	2025-04-01 11:00:00	1.99
730	Q20	ЗУ	MO 10	072	2025-04-01 11:00:00	0
731	Q21	ЗУ	MO 11	073	2025-04-01 11:00:00	13.1
732	Q22	ЗУ	MO 12	074	2025-04-01 11:00:00	0
733	Q23	ЗУ	MO 13	075	2025-04-01 11:00:00	25.4
734	Q24	ЗУ	MO 14	076	2025-04-01 11:00:00	0
735	Q25	ЗУ	MO 15	077	2025-04-01 11:00:00	16.08
736	TP3	ЗУ	CP-300 New	078	2025-04-01 11:00:00	21.92
737	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 11:30:00	22.68
738	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 11:30:00	5.36
739	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 11:30:00	15.85
740	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 11:30:00	0.004
741	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 11:30:00	0
742	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 11:30:00	0
743	QF 1,20	ЗУ	China 1	044	2025-04-01 11:30:00	20.35
744	QF 1,21	ЗУ	China 2	045	2025-04-01 11:30:00	17.51
745	QF 1,22	ЗУ	China 3	046	2025-04-01 11:30:00	21.28
746	QF 2,20	ЗУ	China 4	047	2025-04-01 11:30:00	23.35
747	QF 2,21	ЗУ	China 5	048	2025-04-01 11:30:00	27.23
748	QF 2,22	ЗУ	China 6	049	2025-04-01 11:30:00	24.38
749	QF 2,23	ЗУ	China 7	050	2025-04-01 11:30:00	12.93
750	QF 2,19	ЗУ	China 8	051	2025-04-01 11:30:00	19.72
751	Q8	ЗУ	DIG	061	2025-04-01 11:30:00	40.55
752	Q4	ЗУ	BG 1	062	2025-04-01 11:30:00	0
753	Q9	ЗУ	BG 2	063	2025-04-01 11:30:00	20.21
754	Q10	ЗУ	SM 2	064	2025-04-01 11:30:00	32.33
755	Q11	ЗУ	SM 3	065	2025-04-01 11:30:00	18.19
756	Q12	ЗУ	SM 4	066	2025-04-01 11:30:00	21.07
757	Q13	ЗУ	SM 5	067	2025-04-01 11:30:00	0
758	Q14	ЗУ	SM 6	068	2025-04-01 11:30:00	0
759	Q15	ЗУ	SM 7	069	2025-04-01 11:30:00	0
760	Q16	ЗУ	SM 8	070	2025-04-01 11:30:00	0
761	Q17	ЗУ	MO 9	071	2025-04-01 11:30:00	1.95
762	Q20	ЗУ	MO 10	072	2025-04-01 11:30:00	0
763	Q21	ЗУ	MO 11	073	2025-04-01 11:30:00	13.1
764	Q22	ЗУ	MO 12	074	2025-04-01 11:30:00	0
765	Q23	ЗУ	MO 13	075	2025-04-01 11:30:00	25.44
766	Q24	ЗУ	MO 14	076	2025-04-01 11:30:00	0
767	Q25	ЗУ	MO 15	077	2025-04-01 11:30:00	16.09
768	TP3	ЗУ	CP-300 New	078	2025-04-01 11:30:00	27.99
769	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 12:00:00	30.34
770	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 12:00:00	4.73
771	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 12:00:00	23.42
772	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 12:00:00	0.0736
773	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 12:00:00	0.0485
774	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 12:00:00	0.1072
775	QF 1,20	ЗУ	China 1	044	2025-04-01 12:00:00	17.04
776	QF 1,21	ЗУ	China 2	045	2025-04-01 12:00:00	14.41
777	QF 1,22	ЗУ	China 3	046	2025-04-01 12:00:00	17.42
778	QF 2,20	ЗУ	China 4	047	2025-04-01 12:00:00	20.13
779	QF 2,21	ЗУ	China 5	048	2025-04-01 12:00:00	23.65
780	QF 2,22	ЗУ	China 6	049	2025-04-01 12:00:00	20.48
781	QF 2,23	ЗУ	China 7	050	2025-04-01 12:00:00	10.56
782	QF 2,19	ЗУ	China 8	051	2025-04-01 12:00:00	16.5
783	Q8	ЗУ	DIG	061	2025-04-01 12:00:00	46.45
784	Q4	ЗУ	BG 1	062	2025-04-01 12:00:00	0
785	Q9	ЗУ	BG 2	063	2025-04-01 12:00:00	20.28
786	Q10	ЗУ	SM 2	064	2025-04-01 12:00:00	32.37
787	Q11	ЗУ	SM 3	065	2025-04-01 12:00:00	18.27
788	Q12	ЗУ	SM 4	066	2025-04-01 12:00:00	21
789	Q13	ЗУ	SM 5	067	2025-04-01 12:00:00	0
790	Q14	ЗУ	SM 6	068	2025-04-01 12:00:00	0
791	Q15	ЗУ	SM 7	069	2025-04-01 12:00:00	0
792	Q16	ЗУ	SM 8	070	2025-04-01 12:00:00	0
793	Q17	ЗУ	MO 9	071	2025-04-01 12:00:00	1.89
794	Q20	ЗУ	MO 10	072	2025-04-01 12:00:00	0
795	Q21	ЗУ	MO 11	073	2025-04-01 12:00:00	13.17
796	Q22	ЗУ	MO 12	074	2025-04-01 12:00:00	0
797	Q23	ЗУ	MO 13	075	2025-04-01 12:00:00	25.57
798	Q24	ЗУ	MO 14	076	2025-04-01 12:00:00	0
799	Q25	ЗУ	MO 15	077	2025-04-01 12:00:00	16.23
800	TP3	ЗУ	CP-300 New	078	2025-04-01 12:00:00	29.88
801	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 12:30:00	29.66
802	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 12:30:00	3.79
803	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 12:30:00	23.63
804	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 12:30:00	1.84
805	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 12:30:00	1.43
806	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 12:30:00	1.49
807	QF 1,20	ЗУ	China 1	044	2025-04-01 12:30:00	19.16
808	QF 1,21	ЗУ	China 2	045	2025-04-01 12:30:00	16.89
809	QF 1,22	ЗУ	China 3	046	2025-04-01 12:30:00	19.6
810	QF 2,20	ЗУ	China 4	047	2025-04-01 12:30:00	22.64
811	QF 2,21	ЗУ	China 5	048	2025-04-01 12:30:00	25.95
812	QF 2,22	ЗУ	China 6	049	2025-04-01 12:30:00	22.94
813	QF 2,23	ЗУ	China 7	050	2025-04-01 12:30:00	12.04
814	QF 2,19	ЗУ	China 8	051	2025-04-01 12:30:00	18.73
815	Q8	ЗУ	DIG	061	2025-04-01 12:30:00	55.59
816	Q4	ЗУ	BG 1	062	2025-04-01 12:30:00	0
817	Q9	ЗУ	BG 2	063	2025-04-01 12:30:00	20.18
818	Q10	ЗУ	SM 2	064	2025-04-01 12:30:00	32.27
819	Q11	ЗУ	SM 3	065	2025-04-01 12:30:00	18.14
820	Q12	ЗУ	SM 4	066	2025-04-01 12:30:00	21.02
821	Q13	ЗУ	SM 5	067	2025-04-01 12:30:00	0
822	Q14	ЗУ	SM 6	068	2025-04-01 12:30:00	0
823	Q15	ЗУ	SM 7	069	2025-04-01 12:30:00	0
824	Q16	ЗУ	SM 8	070	2025-04-01 12:30:00	0
825	Q17	ЗУ	MO 9	071	2025-04-01 12:30:00	1.92
826	Q20	ЗУ	MO 10	072	2025-04-01 12:30:00	0
827	Q21	ЗУ	MO 11	073	2025-04-01 12:30:00	13.14
828	Q22	ЗУ	MO 12	074	2025-04-01 12:30:00	0
829	Q23	ЗУ	MO 13	075	2025-04-01 12:30:00	25.45
830	Q24	ЗУ	MO 14	076	2025-04-01 12:30:00	0
831	Q25	ЗУ	MO 15	077	2025-04-01 12:30:00	16.16
832	TP3	ЗУ	CP-300 New	078	2025-04-01 12:30:00	32.07
833	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 13:00:00	30
834	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 13:00:00	3.79
835	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 13:00:00	23.9
836	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 13:00:00	4.2
837	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 13:00:00	8.36
838	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 13:00:00	8.17
839	QF 1,20	ЗУ	China 1	044	2025-04-01 13:00:00	17.51
840	QF 1,21	ЗУ	China 2	045	2025-04-01 13:00:00	15.58
841	QF 1,22	ЗУ	China 3	046	2025-04-01 13:00:00	18.47
842	QF 2,20	ЗУ	China 4	047	2025-04-01 13:00:00	21.2
843	QF 2,21	ЗУ	China 5	048	2025-04-01 13:00:00	23.35
844	QF 2,22	ЗУ	China 6	049	2025-04-01 13:00:00	21.15
845	QF 2,23	ЗУ	China 7	050	2025-04-01 13:00:00	11.3
846	QF 2,19	ЗУ	China 8	051	2025-04-01 13:00:00	17.41
847	Q8	ЗУ	DIG	061	2025-04-01 13:00:00	52.6
848	Q4	ЗУ	BG 1	062	2025-04-01 13:00:00	0
849	Q9	ЗУ	BG 2	063	2025-04-01 13:00:00	20.19
850	Q10	ЗУ	SM 2	064	2025-04-01 13:00:00	32.24
851	Q11	ЗУ	SM 3	065	2025-04-01 13:00:00	18.15
852	Q12	ЗУ	SM 4	066	2025-04-01 13:00:00	21.11
853	Q13	ЗУ	SM 5	067	2025-04-01 13:00:00	0
854	Q14	ЗУ	SM 6	068	2025-04-01 13:00:00	0
855	Q15	ЗУ	SM 7	069	2025-04-01 13:00:00	0
856	Q16	ЗУ	SM 8	070	2025-04-01 13:00:00	0
857	Q17	ЗУ	MO 9	071	2025-04-01 13:00:00	2
858	Q20	ЗУ	MO 10	072	2025-04-01 13:00:00	0
859	Q21	ЗУ	MO 11	073	2025-04-01 13:00:00	13.14
860	Q22	ЗУ	MO 12	074	2025-04-01 13:00:00	0
861	Q23	ЗУ	MO 13	075	2025-04-01 13:00:00	25.41
862	Q24	ЗУ	MO 14	076	2025-04-01 13:00:00	0
863	Q25	ЗУ	MO 15	077	2025-04-01 13:00:00	16.13
864	TP3	ЗУ	CP-300 New	078	2025-04-01 13:00:00	32.44
865	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 13:30:00	25.84
866	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 13:30:00	3.96
867	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 13:30:00	19.57
868	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 13:30:00	7.79
869	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 13:30:00	17.98
870	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 13:30:00	17.67
871	QF 1,20	ЗУ	China 1	044	2025-04-01 13:30:00	18.07
872	QF 1,21	ЗУ	China 2	045	2025-04-01 13:30:00	15.55
873	QF 1,22	ЗУ	China 3	046	2025-04-01 13:30:00	18.49
874	QF 2,20	ЗУ	China 4	047	2025-04-01 13:30:00	22.8
875	QF 2,21	ЗУ	China 5	048	2025-04-01 13:30:00	24.15
876	QF 2,22	ЗУ	China 6	049	2025-04-01 13:30:00	21.87
877	QF 2,23	ЗУ	China 7	050	2025-04-01 13:30:00	11.47
878	QF 2,19	ЗУ	China 8	051	2025-04-01 13:30:00	17.56
879	Q8	ЗУ	DIG	061	2025-04-01 13:30:00	54.25
880	Q4	ЗУ	BG 1	062	2025-04-01 13:30:00	0
881	Q9	ЗУ	BG 2	063	2025-04-01 13:30:00	20.16
882	Q10	ЗУ	SM 2	064	2025-04-01 13:30:00	32.32
883	Q11	ЗУ	SM 3	065	2025-04-01 13:30:00	18.21
884	Q12	ЗУ	SM 4	066	2025-04-01 13:30:00	21.06
885	Q13	ЗУ	SM 5	067	2025-04-01 13:30:00	0
886	Q14	ЗУ	SM 6	068	2025-04-01 13:30:00	0
887	Q15	ЗУ	SM 7	069	2025-04-01 13:30:00	0
888	Q16	ЗУ	SM 8	070	2025-04-01 13:30:00	0
889	Q17	ЗУ	MO 9	071	2025-04-01 13:30:00	1.99
890	Q20	ЗУ	MO 10	072	2025-04-01 13:30:00	0
891	Q21	ЗУ	MO 11	073	2025-04-01 13:30:00	13.15
892	Q22	ЗУ	MO 12	074	2025-04-01 13:30:00	0
893	Q23	ЗУ	MO 13	075	2025-04-01 13:30:00	25.38
894	Q24	ЗУ	MO 14	076	2025-04-01 13:30:00	0
895	Q25	ЗУ	MO 15	077	2025-04-01 13:30:00	16.13
896	TP3	ЗУ	CP-300 New	078	2025-04-01 13:30:00	29.86
897	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 14:00:00	14.89
898	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 14:00:00	3.45
899	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 14:00:00	10.05
900	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 14:00:00	8.69
901	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 14:00:00	20.48
902	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 14:00:00	20.12
903	QF 1,20	ЗУ	China 1	044	2025-04-01 14:00:00	18.64
904	QF 1,21	ЗУ	China 2	045	2025-04-01 14:00:00	16.39
905	QF 1,22	ЗУ	China 3	046	2025-04-01 14:00:00	19.61
906	QF 2,20	ЗУ	China 4	047	2025-04-01 14:00:00	23.89
907	QF 2,21	ЗУ	China 5	048	2025-04-01 14:00:00	24.92
908	QF 2,22	ЗУ	China 6	049	2025-04-01 14:00:00	22.71
909	QF 2,23	ЗУ	China 7	050	2025-04-01 14:00:00	12.08
910	QF 2,19	ЗУ	China 8	051	2025-04-01 14:00:00	18.09
911	Q8	ЗУ	DIG	061	2025-04-01 14:00:00	59.55
912	Q4	ЗУ	BG 1	062	2025-04-01 14:00:00	0
913	Q9	ЗУ	BG 2	063	2025-04-01 14:00:00	20.19
914	Q10	ЗУ	SM 2	064	2025-04-01 14:00:00	32.29
915	Q11	ЗУ	SM 3	065	2025-04-01 14:00:00	18.18
916	Q12	ЗУ	SM 4	066	2025-04-01 14:00:00	21.05
917	Q13	ЗУ	SM 5	067	2025-04-01 14:00:00	0
918	Q14	ЗУ	SM 6	068	2025-04-01 14:00:00	0
919	Q15	ЗУ	SM 7	069	2025-04-01 14:00:00	0
920	Q16	ЗУ	SM 8	070	2025-04-01 14:00:00	0
921	Q17	ЗУ	MO 9	071	2025-04-01 14:00:00	2
922	Q20	ЗУ	MO 10	072	2025-04-01 14:00:00	0
923	Q21	ЗУ	MO 11	073	2025-04-01 14:00:00	13.14
924	Q22	ЗУ	MO 12	074	2025-04-01 14:00:00	0
925	Q23	ЗУ	MO 13	075	2025-04-01 14:00:00	25.41
926	Q24	ЗУ	MO 14	076	2025-04-01 14:00:00	0
927	Q25	ЗУ	MO 15	077	2025-04-01 14:00:00	16.14
928	TP3	ЗУ	CP-300 New	078	2025-04-01 14:00:00	32.87
929	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 14:30:00	19.3
930	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 14:30:00	3.84
931	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 14:30:00	13.71
932	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 14:30:00	10.94
933	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 14:30:00	29.06
934	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 14:30:00	28.51
935	QF 1,20	ЗУ	China 1	044	2025-04-01 14:30:00	18.43
936	QF 1,21	ЗУ	China 2	045	2025-04-01 14:30:00	16.29
937	QF 1,22	ЗУ	China 3	046	2025-04-01 14:30:00	19.58
938	QF 2,20	ЗУ	China 4	047	2025-04-01 14:30:00	23.03
939	QF 2,21	ЗУ	China 5	048	2025-04-01 14:30:00	24.43
940	QF 2,22	ЗУ	China 6	049	2025-04-01 14:30:00	22.38
941	QF 2,23	ЗУ	China 7	050	2025-04-01 14:30:00	11.75
942	QF 2,19	ЗУ	China 8	051	2025-04-01 14:30:00	18.22
943	Q8	ЗУ	DIG	061	2025-04-01 14:30:00	63.59
944	Q4	ЗУ	BG 1	062	2025-04-01 14:30:00	0
945	Q9	ЗУ	BG 2	063	2025-04-01 14:30:00	20.24
946	Q10	ЗУ	SM 2	064	2025-04-01 14:30:00	32.28
947	Q11	ЗУ	SM 3	065	2025-04-01 14:30:00	18.17
948	Q12	ЗУ	SM 4	066	2025-04-01 14:30:00	21.09
949	Q13	ЗУ	SM 5	067	2025-04-01 14:30:00	0
950	Q14	ЗУ	SM 6	068	2025-04-01 14:30:00	0
951	Q15	ЗУ	SM 7	069	2025-04-01 14:30:00	0
952	Q16	ЗУ	SM 8	070	2025-04-01 14:30:00	0
953	Q17	ЗУ	MO 9	071	2025-04-01 14:30:00	1.95
954	Q20	ЗУ	MO 10	072	2025-04-01 14:30:00	0
955	Q21	ЗУ	MO 11	073	2025-04-01 14:30:00	13.15
956	Q22	ЗУ	MO 12	074	2025-04-01 14:30:00	0
957	Q23	ЗУ	MO 13	075	2025-04-01 14:30:00	25.44
958	Q24	ЗУ	MO 14	076	2025-04-01 14:30:00	0
959	Q25	ЗУ	MO 15	077	2025-04-01 14:30:00	16.13
960	TP3	ЗУ	CP-300 New	078	2025-04-01 14:30:00	32.85
961	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 15:00:00	19.74
962	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 15:00:00	4.06
963	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 15:00:00	14.06
964	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 15:00:00	11.53
965	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 15:00:00	31.95
966	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 15:00:00	31.28
967	QF 1,20	ЗУ	China 1	044	2025-04-01 15:00:00	18.23
968	QF 1,21	ЗУ	China 2	045	2025-04-01 15:00:00	16.05
969	QF 1,22	ЗУ	China 3	046	2025-04-01 15:00:00	19.1
970	QF 2,20	ЗУ	China 4	047	2025-04-01 15:00:00	23.01
971	QF 2,21	ЗУ	China 5	048	2025-04-01 15:00:00	24.07
972	QF 2,22	ЗУ	China 6	049	2025-04-01 15:00:00	22.11
973	QF 2,23	ЗУ	China 7	050	2025-04-01 15:00:00	11.65
974	QF 2,19	ЗУ	China 8	051	2025-04-01 15:00:00	17.96
975	Q8	ЗУ	DIG	061	2025-04-01 15:00:00	67.06
976	Q4	ЗУ	BG 1	062	2025-04-01 15:00:00	0
977	Q9	ЗУ	BG 2	063	2025-04-01 15:00:00	20.21
978	Q10	ЗУ	SM 2	064	2025-04-01 15:00:00	32.26
979	Q11	ЗУ	SM 3	065	2025-04-01 15:00:00	18.15
980	Q12	ЗУ	SM 4	066	2025-04-01 15:00:00	21.1
981	Q13	ЗУ	SM 5	067	2025-04-01 15:00:00	0
982	Q14	ЗУ	SM 6	068	2025-04-01 15:00:00	0
983	Q15	ЗУ	SM 7	069	2025-04-01 15:00:00	0
984	Q16	ЗУ	SM 8	070	2025-04-01 15:00:00	0
985	Q17	ЗУ	MO 9	071	2025-04-01 15:00:00	1.95
986	Q20	ЗУ	MO 10	072	2025-04-01 15:00:00	0
987	Q21	ЗУ	MO 11	073	2025-04-01 15:00:00	13.11
988	Q22	ЗУ	MO 12	074	2025-04-01 15:00:00	0
989	Q23	ЗУ	MO 13	075	2025-04-01 15:00:00	25.42
990	Q24	ЗУ	MO 14	076	2025-04-01 15:00:00	0
991	Q25	ЗУ	MO 15	077	2025-04-01 15:00:00	16.11
992	TP3	ЗУ	CP-300 New	078	2025-04-01 15:00:00	32.74
993	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 15:30:00	19.78
994	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 15:30:00	4.6
995	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 15:30:00	14.07
996	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 15:30:00	10.24
997	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 15:30:00	28.78
998	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 15:30:00	28.15
999	QF 1,20	ЗУ	China 1	044	2025-04-01 15:30:00	20.21
1000	QF 1,21	ЗУ	China 2	045	2025-04-01 15:30:00	17.84
1001	QF 1,22	ЗУ	China 3	046	2025-04-01 15:30:00	20.18
1002	QF 2,20	ЗУ	China 4	047	2025-04-01 15:30:00	24.58
1003	QF 2,21	ЗУ	China 5	048	2025-04-01 15:30:00	25.49
1004	QF 2,22	ЗУ	China 6	049	2025-04-01 15:30:00	23.52
1005	QF 2,23	ЗУ	China 7	050	2025-04-01 15:30:00	12.32
1006	QF 2,19	ЗУ	China 8	051	2025-04-01 15:30:00	19.85
1007	Q8	ЗУ	DIG	061	2025-04-01 15:30:00	67.74
1008	Q4	ЗУ	BG 1	062	2025-04-01 15:30:00	0
1009	Q9	ЗУ	BG 2	063	2025-04-01 15:30:00	20.21
1010	Q10	ЗУ	SM 2	064	2025-04-01 15:30:00	32.37
1011	Q11	ЗУ	SM 3	065	2025-04-01 15:30:00	18.23
1012	Q12	ЗУ	SM 4	066	2025-04-01 15:30:00	21.08
1013	Q13	ЗУ	SM 5	067	2025-04-01 15:30:00	0
1014	Q14	ЗУ	SM 6	068	2025-04-01 15:30:00	0
1015	Q15	ЗУ	SM 7	069	2025-04-01 15:30:00	0
1016	Q16	ЗУ	SM 8	070	2025-04-01 15:30:00	0
1017	Q17	ЗУ	MO 9	071	2025-04-01 15:30:00	1.89
1018	Q20	ЗУ	MO 10	072	2025-04-01 15:30:00	0
1019	Q21	ЗУ	MO 11	073	2025-04-01 15:30:00	13.19
1020	Q22	ЗУ	MO 12	074	2025-04-01 15:30:00	0
1021	Q23	ЗУ	MO 13	075	2025-04-01 15:30:00	25.53
1022	Q24	ЗУ	MO 14	076	2025-04-01 15:30:00	0
1023	Q25	ЗУ	MO 15	077	2025-04-01 15:30:00	16.18
1024	TP3	ЗУ	CP-300 New	078	2025-04-01 15:30:00	33.55
1025	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 16:00:00	19.78
1026	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 16:00:00	4.6
1027	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 16:00:00	14.14
1028	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 16:00:00	10.38
1029	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 16:00:00	31.93
1030	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 16:00:00	31.17
1031	QF 1,20	ЗУ	China 1	044	2025-04-01 16:00:00	18.87
1032	QF 1,21	ЗУ	China 2	045	2025-04-01 16:00:00	16.58
1033	QF 1,22	ЗУ	China 3	046	2025-04-01 16:00:00	19.71
1034	QF 2,20	ЗУ	China 4	047	2025-04-01 16:00:00	23.29
1035	QF 2,21	ЗУ	China 5	048	2025-04-01 16:00:00	24.31
1036	QF 2,22	ЗУ	China 6	049	2025-04-01 16:00:00	22.34
1037	QF 2,23	ЗУ	China 7	050	2025-04-01 16:00:00	11.85
1038	QF 2,19	ЗУ	China 8	051	2025-04-01 16:00:00	19
1039	Q8	ЗУ	DIG	061	2025-04-01 16:00:00	73.75
1040	Q4	ЗУ	BG 1	062	2025-04-01 16:00:00	0
1041	Q9	ЗУ	BG 2	063	2025-04-01 16:00:00	20.19
1042	Q10	ЗУ	SM 2	064	2025-04-01 16:00:00	32.39
1043	Q11	ЗУ	SM 3	065	2025-04-01 16:00:00	18.21
1044	Q12	ЗУ	SM 4	066	2025-04-01 16:00:00	21.13
1045	Q13	ЗУ	SM 5	067	2025-04-01 16:00:00	0
1046	Q14	ЗУ	SM 6	068	2025-04-01 16:00:00	0
1047	Q15	ЗУ	SM 7	069	2025-04-01 16:00:00	0
1048	Q16	ЗУ	SM 8	070	2025-04-01 16:00:00	0
1049	Q17	ЗУ	MO 9	071	2025-04-01 16:00:00	1.9
1050	Q20	ЗУ	MO 10	072	2025-04-01 16:00:00	0
1051	Q21	ЗУ	MO 11	073	2025-04-01 16:00:00	13.11
1052	Q22	ЗУ	MO 12	074	2025-04-01 16:00:00	0
1053	Q23	ЗУ	MO 13	075	2025-04-01 16:00:00	25.56
1054	Q24	ЗУ	MO 14	076	2025-04-01 16:00:00	0
1055	Q25	ЗУ	MO 15	077	2025-04-01 16:00:00	16.23
1056	TP3	ЗУ	CP-300 New	078	2025-04-01 16:00:00	33.23
1057	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 16:30:00	19.77
1058	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 16:30:00	4.61
1059	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 16:30:00	14.18
1060	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 16:30:00	6.66
1061	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 16:30:00	24.63
1062	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 16:30:00	24.2
1063	QF 1,20	ЗУ	China 1	044	2025-04-01 16:30:00	18.42
1064	QF 1,21	ЗУ	China 2	045	2025-04-01 16:30:00	16.42
1065	QF 1,22	ЗУ	China 3	046	2025-04-01 16:30:00	18.92
1066	QF 2,20	ЗУ	China 4	047	2025-04-01 16:30:00	22.4
1067	QF 2,21	ЗУ	China 5	048	2025-04-01 16:30:00	23.35
1068	QF 2,22	ЗУ	China 6	049	2025-04-01 16:30:00	21.84
1069	QF 2,23	ЗУ	China 7	050	2025-04-01 16:30:00	11.57
1070	QF 2,19	ЗУ	China 8	051	2025-04-01 16:30:00	19.21
1071	Q8	ЗУ	DIG	061	2025-04-01 16:30:00	68.3
1072	Q4	ЗУ	BG 1	062	2025-04-01 16:30:00	0
1073	Q9	ЗУ	BG 2	063	2025-04-01 16:30:00	20.17
1074	Q10	ЗУ	SM 2	064	2025-04-01 16:30:00	32.45
1075	Q11	ЗУ	SM 3	065	2025-04-01 16:30:00	18.32
1076	Q12	ЗУ	SM 4	066	2025-04-01 16:30:00	21.15
1077	Q13	ЗУ	SM 5	067	2025-04-01 16:30:00	0
1078	Q14	ЗУ	SM 6	068	2025-04-01 16:30:00	0
1079	Q15	ЗУ	SM 7	069	2025-04-01 16:30:00	0
1080	Q16	ЗУ	SM 8	070	2025-04-01 16:30:00	0
1081	Q17	ЗУ	MO 9	071	2025-04-01 16:30:00	1.93
1082	Q20	ЗУ	MO 10	072	2025-04-01 16:30:00	0
1083	Q21	ЗУ	MO 11	073	2025-04-01 16:30:00	13.13
1084	Q22	ЗУ	MO 12	074	2025-04-01 16:30:00	0
1085	Q23	ЗУ	MO 13	075	2025-04-01 16:30:00	25.63
1086	Q24	ЗУ	MO 14	076	2025-04-01 16:30:00	0
1087	Q25	ЗУ	MO 15	077	2025-04-01 16:30:00	16.29
1088	TP3	ЗУ	CP-300 New	078	2025-04-01 16:30:00	32.37
1089	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 17:00:00	12.71
1090	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 17:00:00	3.47
1091	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 17:00:00	8.62
1092	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 17:00:00	4.66
1093	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 17:00:00	19.8
1094	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 17:00:00	19.31
1095	QF 1,20	ЗУ	China 1	044	2025-04-01 17:00:00	19.12
1096	QF 1,21	ЗУ	China 2	045	2025-04-01 17:00:00	17.24
1097	QF 1,22	ЗУ	China 3	046	2025-04-01 17:00:00	19.92
1098	QF 2,20	ЗУ	China 4	047	2025-04-01 17:00:00	23
1099	QF 2,21	ЗУ	China 5	048	2025-04-01 17:00:00	24.37
1100	QF 2,22	ЗУ	China 6	049	2025-04-01 17:00:00	22.61
1101	QF 2,23	ЗУ	China 7	050	2025-04-01 17:00:00	11.89
1102	QF 2,19	ЗУ	China 8	051	2025-04-01 17:00:00	19.93
1103	Q8	ЗУ	DIG	061	2025-04-01 17:00:00	74.11
1104	Q4	ЗУ	BG 1	062	2025-04-01 17:00:00	0
1105	Q9	ЗУ	BG 2	063	2025-04-01 17:00:00	20.15
1106	Q10	ЗУ	SM 2	064	2025-04-01 17:00:00	32.44
1107	Q11	ЗУ	SM 3	065	2025-04-01 17:00:00	18.3
1108	Q12	ЗУ	SM 4	066	2025-04-01 17:00:00	21.15
1109	Q13	ЗУ	SM 5	067	2025-04-01 17:00:00	0
1110	Q14	ЗУ	SM 6	068	2025-04-01 17:00:00	0
1111	Q15	ЗУ	SM 7	069	2025-04-01 17:00:00	0
1112	Q16	ЗУ	SM 8	070	2025-04-01 17:00:00	0
1113	Q17	ЗУ	MO 9	071	2025-04-01 17:00:00	1.94
1114	Q20	ЗУ	MO 10	072	2025-04-01 17:00:00	0
1115	Q21	ЗУ	MO 11	073	2025-04-01 17:00:00	13.13
1116	Q22	ЗУ	MO 12	074	2025-04-01 17:00:00	0
1117	Q23	ЗУ	MO 13	075	2025-04-01 17:00:00	25.64
1118	Q24	ЗУ	MO 14	076	2025-04-01 17:00:00	0
1119	Q25	ЗУ	MO 15	077	2025-04-01 17:00:00	16.29
1120	TP3	ЗУ	CP-300 New	078	2025-04-01 17:00:00	33.18
1121	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 17:30:00	0.2983
1122	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 17:30:00	0.2079
1123	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 17:30:00	0.0461
1124	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 17:30:00	5.47
1125	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 17:30:00	30.33
1126	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 17:30:00	28.99
1127	QF 1,20	ЗУ	China 1	044	2025-04-01 17:30:00	19.17
1128	QF 1,21	ЗУ	China 2	045	2025-04-01 17:30:00	17.12
1129	QF 1,22	ЗУ	China 3	046	2025-04-01 17:30:00	20.46
1130	QF 2,20	ЗУ	China 4	047	2025-04-01 17:30:00	22.34
1131	QF 2,21	ЗУ	China 5	048	2025-04-01 17:30:00	23.71
1132	QF 2,22	ЗУ	China 6	049	2025-04-01 17:30:00	22.53
1133	QF 2,23	ЗУ	China 7	050	2025-04-01 17:30:00	11.73
1134	QF 2,19	ЗУ	China 8	051	2025-04-01 17:30:00	20.63
1135	Q8	ЗУ	DIG	061	2025-04-01 17:30:00	73.98
1136	Q4	ЗУ	BG 1	062	2025-04-01 17:30:00	0
1137	Q9	ЗУ	BG 2	063	2025-04-01 17:30:00	20.13
1138	Q10	ЗУ	SM 2	064	2025-04-01 17:30:00	32.41
1139	Q11	ЗУ	SM 3	065	2025-04-01 17:30:00	18.24
1140	Q12	ЗУ	SM 4	066	2025-04-01 17:30:00	21.18
1141	Q13	ЗУ	SM 5	067	2025-04-01 17:30:00	0
1142	Q14	ЗУ	SM 6	068	2025-04-01 17:30:00	0
1143	Q15	ЗУ	SM 7	069	2025-04-01 17:30:00	0
1144	Q16	ЗУ	SM 8	070	2025-04-01 17:30:00	0
1145	Q17	ЗУ	MO 9	071	2025-04-01 17:30:00	1.94
1146	Q20	ЗУ	MO 10	072	2025-04-01 17:30:00	0
1147	Q21	ЗУ	MO 11	073	2025-04-01 17:30:00	13.15
1148	Q22	ЗУ	MO 12	074	2025-04-01 17:30:00	0
1149	Q23	ЗУ	MO 13	075	2025-04-01 17:30:00	25.62
1150	Q24	ЗУ	MO 14	076	2025-04-01 17:30:00	0
1151	Q25	ЗУ	MO 15	077	2025-04-01 17:30:00	16.25
1152	TP3	ЗУ	CP-300 New	078	2025-04-01 17:30:00	33.86
1153	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 18:00:00	0
1154	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 18:00:00	0.0005
1155	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 18:00:00	0.0026
1156	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 18:00:00	4.41
1157	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 18:00:00	23.37
1158	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 18:00:00	22.34
1159	QF 1,20	ЗУ	China 1	044	2025-04-01 18:00:00	21.38
1160	QF 1,21	ЗУ	China 2	045	2025-04-01 18:00:00	19.35
1161	QF 1,22	ЗУ	China 3	046	2025-04-01 18:00:00	22.5
1162	QF 2,20	ЗУ	China 4	047	2025-04-01 18:00:00	25.03
1163	QF 2,21	ЗУ	China 5	048	2025-04-01 18:00:00	26.33
1164	QF 2,22	ЗУ	China 6	049	2025-04-01 18:00:00	25.35
1165	QF 2,23	ЗУ	China 7	050	2025-04-01 18:00:00	12.97
1166	QF 2,19	ЗУ	China 8	051	2025-04-01 18:00:00	22.87
1167	Q8	ЗУ	DIG	061	2025-04-01 18:00:00	76.65
1168	Q4	ЗУ	BG 1	062	2025-04-01 18:00:00	0
1169	Q9	ЗУ	BG 2	063	2025-04-01 18:00:00	20.09
1170	Q10	ЗУ	SM 2	064	2025-04-01 18:00:00	32.4
1171	Q11	ЗУ	SM 3	065	2025-04-01 18:00:00	18.2
1172	Q12	ЗУ	SM 4	066	2025-04-01 18:00:00	21.15
1173	Q13	ЗУ	SM 5	067	2025-04-01 18:00:00	0
1174	Q14	ЗУ	SM 6	068	2025-04-01 18:00:00	0
1175	Q15	ЗУ	SM 7	069	2025-04-01 18:00:00	0
1176	Q16	ЗУ	SM 8	070	2025-04-01 18:00:00	0
1177	Q17	ЗУ	MO 9	071	2025-04-01 18:00:00	1.92
1178	Q20	ЗУ	MO 10	072	2025-04-01 18:00:00	0
1179	Q21	ЗУ	MO 11	073	2025-04-01 18:00:00	13.15
1180	Q22	ЗУ	MO 12	074	2025-04-01 18:00:00	0
1181	Q23	ЗУ	MO 13	075	2025-04-01 18:00:00	25.59
1182	Q24	ЗУ	MO 14	076	2025-04-01 18:00:00	0
1183	Q25	ЗУ	MO 15	077	2025-04-01 18:00:00	16.24
1184	TP3	ЗУ	CP-300 New	078	2025-04-01 18:00:00	35.18
1185	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 18:30:00	0
1186	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 18:30:00	0
1187	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 18:30:00	0.0027
1188	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 18:30:00	5.04
1189	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 18:30:00	27.51
1190	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 18:30:00	26.4
1191	QF 1,20	ЗУ	China 1	044	2025-04-01 18:30:00	19.1
1192	QF 1,21	ЗУ	China 2	045	2025-04-01 18:30:00	16.96
1193	QF 1,22	ЗУ	China 3	046	2025-04-01 18:30:00	19.83
1194	QF 2,20	ЗУ	China 4	047	2025-04-01 18:30:00	22.85
1195	QF 2,21	ЗУ	China 5	048	2025-04-01 18:30:00	24.19
1196	QF 2,22	ЗУ	China 6	049	2025-04-01 18:30:00	22.92
1197	QF 2,23	ЗУ	China 7	050	2025-04-01 18:30:00	11.55
1198	QF 2,19	ЗУ	China 8	051	2025-04-01 18:30:00	20.5
1199	Q8	ЗУ	DIG	061	2025-04-01 18:30:00	77.33
1200	Q4	ЗУ	BG 1	062	2025-04-01 18:30:00	0
1201	Q9	ЗУ	BG 2	063	2025-04-01 18:30:00	20.09
1202	Q10	ЗУ	SM 2	064	2025-04-01 18:30:00	32.42
1203	Q11	ЗУ	SM 3	065	2025-04-01 18:30:00	18.17
1204	Q12	ЗУ	SM 4	066	2025-04-01 18:30:00	21.15
1205	Q13	ЗУ	SM 5	067	2025-04-01 18:30:00	0
1206	Q14	ЗУ	SM 6	068	2025-04-01 18:30:00	0
1207	Q15	ЗУ	SM 7	069	2025-04-01 18:30:00	0
1208	Q16	ЗУ	SM 8	070	2025-04-01 18:30:00	0
1209	Q17	ЗУ	MO 9	071	2025-04-01 18:30:00	1.92
1210	Q20	ЗУ	MO 10	072	2025-04-01 18:30:00	0
1211	Q21	ЗУ	MO 11	073	2025-04-01 18:30:00	13.14
1212	Q22	ЗУ	MO 12	074	2025-04-01 18:30:00	0
1213	Q23	ЗУ	MO 13	075	2025-04-01 18:30:00	25.6
1214	Q24	ЗУ	MO 14	076	2025-04-01 18:30:00	0
1215	Q25	ЗУ	MO 15	077	2025-04-01 18:30:00	16.23
1216	TP3	ЗУ	CP-300 New	078	2025-04-01 18:30:00	32.95
1217	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 19:00:00	0
1218	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 19:00:00	0.0012
1219	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 19:00:00	0.003
1220	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 19:00:00	4.6
1221	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 19:00:00	17.94
1222	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 19:00:00	17.54
1223	QF 1,20	ЗУ	China 1	044	2025-04-01 19:00:00	19.78
1224	QF 1,21	ЗУ	China 2	045	2025-04-01 19:00:00	17.95
1225	QF 1,22	ЗУ	China 3	046	2025-04-01 19:00:00	21.34
1226	QF 2,20	ЗУ	China 4	047	2025-04-01 19:00:00	23.41
1227	QF 2,21	ЗУ	China 5	048	2025-04-01 19:00:00	25.17
1228	QF 2,22	ЗУ	China 6	049	2025-04-01 19:00:00	23.75
1229	QF 2,23	ЗУ	China 7	050	2025-04-01 19:00:00	11.72
1230	QF 2,19	ЗУ	China 8	051	2025-04-01 19:00:00	21.37
1231	Q8	ЗУ	DIG	061	2025-04-01 19:00:00	77.58
1232	Q4	ЗУ	BG 1	062	2025-04-01 19:00:00	0
1233	Q9	ЗУ	BG 2	063	2025-04-01 19:00:00	20.11
1234	Q10	ЗУ	SM 2	064	2025-04-01 19:00:00	32.47
1235	Q11	ЗУ	SM 3	065	2025-04-01 19:00:00	18.15
1236	Q12	ЗУ	SM 4	066	2025-04-01 19:00:00	21.19
1237	Q13	ЗУ	SM 5	067	2025-04-01 19:00:00	0
1238	Q14	ЗУ	SM 6	068	2025-04-01 19:00:00	0
1239	Q15	ЗУ	SM 7	069	2025-04-01 19:00:00	0
1240	Q16	ЗУ	SM 8	070	2025-04-01 19:00:00	0
1241	Q17	ЗУ	MO 9	071	2025-04-01 19:00:00	1.94
1242	Q20	ЗУ	MO 10	072	2025-04-01 19:00:00	0
1243	Q21	ЗУ	MO 11	073	2025-04-01 19:00:00	13.18
1244	Q22	ЗУ	MO 12	074	2025-04-01 19:00:00	0
1245	Q23	ЗУ	MO 13	075	2025-04-01 19:00:00	25.62
1246	Q24	ЗУ	MO 14	076	2025-04-01 19:00:00	0
1247	Q25	ЗУ	MO 15	077	2025-04-01 19:00:00	16.26
1248	TP3	ЗУ	CP-300 New	078	2025-04-01 19:00:00	32.66
1249	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 19:30:00	0
1250	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 19:30:00	0.0003
1251	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 19:30:00	0.0027
1252	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 19:30:00	5.01
1253	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 19:30:00	19.94
1254	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 19:30:00	19.47
1255	QF 1,20	ЗУ	China 1	044	2025-04-01 19:30:00	17.69
1256	QF 1,21	ЗУ	China 2	045	2025-04-01 19:30:00	16.57
1257	QF 1,22	ЗУ	China 3	046	2025-04-01 19:30:00	19.3
1258	QF 2,20	ЗУ	China 4	047	2025-04-01 19:30:00	22.57
1259	QF 2,21	ЗУ	China 5	048	2025-04-01 19:30:00	24.48
1260	QF 2,22	ЗУ	China 6	049	2025-04-01 19:30:00	23.58
1261	QF 2,23	ЗУ	China 7	050	2025-04-01 19:30:00	11
1262	QF 2,19	ЗУ	China 8	051	2025-04-01 19:30:00	20.15
1263	Q8	ЗУ	DIG	061	2025-04-01 19:30:00	76.29
1264	Q4	ЗУ	BG 1	062	2025-04-01 19:30:00	0
1265	Q9	ЗУ	BG 2	063	2025-04-01 19:30:00	20.1
1266	Q10	ЗУ	SM 2	064	2025-04-01 19:30:00	32.51
1267	Q11	ЗУ	SM 3	065	2025-04-01 19:30:00	18.17
1268	Q12	ЗУ	SM 4	066	2025-04-01 19:30:00	21.27
1269	Q13	ЗУ	SM 5	067	2025-04-01 19:30:00	0
1270	Q14	ЗУ	SM 6	068	2025-04-01 19:30:00	0
1271	Q15	ЗУ	SM 7	069	2025-04-01 19:30:00	0
1272	Q16	ЗУ	SM 8	070	2025-04-01 19:30:00	0
1273	Q17	ЗУ	MO 9	071	2025-04-01 19:30:00	1.94
1274	Q20	ЗУ	MO 10	072	2025-04-01 19:30:00	0
1275	Q21	ЗУ	MO 11	073	2025-04-01 19:30:00	13.13
1276	Q22	ЗУ	MO 12	074	2025-04-01 19:30:00	0
1277	Q23	ЗУ	MO 13	075	2025-04-01 19:30:00	25.69
1278	Q24	ЗУ	MO 14	076	2025-04-01 19:30:00	0
1279	Q25	ЗУ	MO 15	077	2025-04-01 19:30:00	16.24
1280	TP3	ЗУ	CP-300 New	078	2025-04-01 19:30:00	29.78
1281	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 20:00:00	0
1282	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 20:00:00	0
1283	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 20:00:00	0.0025
1284	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 20:00:00	5.04
1285	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 20:00:00	20
1286	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 20:00:00	19.51
1287	QF 1,20	ЗУ	China 1	044	2025-04-01 20:00:00	17.36
1288	QF 1,21	ЗУ	China 2	045	2025-04-01 20:00:00	15.45
1289	QF 1,22	ЗУ	China 3	046	2025-04-01 20:00:00	18.93
1290	QF 2,20	ЗУ	China 4	047	2025-04-01 20:00:00	21.37
1291	QF 2,21	ЗУ	China 5	048	2025-04-01 20:00:00	23.95
1292	QF 2,22	ЗУ	China 6	049	2025-04-01 20:00:00	23.07
1293	QF 2,23	ЗУ	China 7	050	2025-04-01 20:00:00	10.57
1294	QF 2,19	ЗУ	China 8	051	2025-04-01 20:00:00	18.91
1295	Q8	ЗУ	DIG	061	2025-04-01 20:00:00	64.4
1296	Q4	ЗУ	BG 1	062	2025-04-01 20:00:00	0
1297	Q9	ЗУ	BG 2	063	2025-04-01 20:00:00	20.12
1298	Q10	ЗУ	SM 2	064	2025-04-01 20:00:00	32.52
1299	Q11	ЗУ	SM 3	065	2025-04-01 20:00:00	18.16
1300	Q12	ЗУ	SM 4	066	2025-04-01 20:00:00	21.35
1301	Q13	ЗУ	SM 5	067	2025-04-01 20:00:00	0
1302	Q14	ЗУ	SM 6	068	2025-04-01 20:00:00	0
1303	Q15	ЗУ	SM 7	069	2025-04-01 20:00:00	0
1304	Q16	ЗУ	SM 8	070	2025-04-01 20:00:00	0
1305	Q17	ЗУ	MO 9	071	2025-04-01 20:00:00	1.93
1306	Q20	ЗУ	MO 10	072	2025-04-01 20:00:00	0
1307	Q21	ЗУ	MO 11	073	2025-04-01 20:00:00	13.17
1308	Q22	ЗУ	MO 12	074	2025-04-01 20:00:00	0
1309	Q23	ЗУ	MO 13	075	2025-04-01 20:00:00	25.7
1310	Q24	ЗУ	MO 14	076	2025-04-01 20:00:00	0
1311	Q25	ЗУ	MO 15	077	2025-04-01 20:00:00	16.27
1312	TP3	ЗУ	CP-300 New	078	2025-04-01 20:00:00	30.24
1313	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 20:30:00	0
1314	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 20:30:00	0.0012
1315	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 20:30:00	0.0032
1316	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 20:30:00	4.96
1317	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 20:30:00	19.96
1318	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 20:30:00	19.48
1319	QF 1,20	ЗУ	China 1	044	2025-04-01 20:30:00	15.82
1320	QF 1,21	ЗУ	China 2	045	2025-04-01 20:30:00	14.27
1321	QF 1,22	ЗУ	China 3	046	2025-04-01 20:30:00	17.5
1322	QF 2,20	ЗУ	China 4	047	2025-04-01 20:30:00	20.78
1323	QF 2,21	ЗУ	China 5	048	2025-04-01 20:30:00	22.9
1324	QF 2,22	ЗУ	China 6	049	2025-04-01 20:30:00	21.7
1325	QF 2,23	ЗУ	China 7	050	2025-04-01 20:30:00	10.01
1326	QF 2,19	ЗУ	China 8	051	2025-04-01 20:30:00	17.96
1327	Q8	ЗУ	DIG	061	2025-04-01 20:30:00	53.94
1328	Q4	ЗУ	BG 1	062	2025-04-01 20:30:00	0
1329	Q9	ЗУ	BG 2	063	2025-04-01 20:30:00	20.18
1330	Q10	ЗУ	SM 2	064	2025-04-01 20:30:00	32.55
1331	Q11	ЗУ	SM 3	065	2025-04-01 20:30:00	18.19
1332	Q12	ЗУ	SM 4	066	2025-04-01 20:30:00	21.32
1333	Q13	ЗУ	SM 5	067	2025-04-01 20:30:00	0
1334	Q14	ЗУ	SM 6	068	2025-04-01 20:30:00	0
1335	Q15	ЗУ	SM 7	069	2025-04-01 20:30:00	0
1336	Q16	ЗУ	SM 8	070	2025-04-01 20:30:00	0
1337	Q17	ЗУ	MO 9	071	2025-04-01 20:30:00	1.93
1338	Q20	ЗУ	MO 10	072	2025-04-01 20:30:00	0
1339	Q21	ЗУ	MO 11	073	2025-04-01 20:30:00	13.15
1340	Q22	ЗУ	MO 12	074	2025-04-01 20:30:00	0
1341	Q23	ЗУ	MO 13	075	2025-04-01 20:30:00	25.68
1342	Q24	ЗУ	MO 14	076	2025-04-01 20:30:00	0
1343	Q25	ЗУ	MO 15	077	2025-04-01 20:30:00	16.28
1344	TP3	ЗУ	CP-300 New	078	2025-04-01 20:30:00	31.57
1345	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 21:00:00	0
1346	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 21:00:00	0.0004
1347	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 21:00:00	0.0027
1348	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 21:00:00	4.76
1349	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 21:00:00	19.83
1350	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 21:00:00	19.39
1351	QF 1,20	ЗУ	China 1	044	2025-04-01 21:00:00	13.09
1352	QF 1,21	ЗУ	China 2	045	2025-04-01 21:00:00	11.5
1353	QF 1,22	ЗУ	China 3	046	2025-04-01 21:00:00	14.26
1354	QF 2,20	ЗУ	China 4	047	2025-04-01 21:00:00	19.01
1355	QF 2,21	ЗУ	China 5	048	2025-04-01 21:00:00	21.83
1356	QF 2,22	ЗУ	China 6	049	2025-04-01 21:00:00	19.72
1357	QF 2,23	ЗУ	China 7	050	2025-04-01 21:00:00	8.99
1358	QF 2,19	ЗУ	China 8	051	2025-04-01 21:00:00	15.23
1359	Q8	ЗУ	DIG	061	2025-04-01 21:00:00	53.54
1360	Q4	ЗУ	BG 1	062	2025-04-01 21:00:00	0
1361	Q9	ЗУ	BG 2	063	2025-04-01 21:00:00	20.15
1362	Q10	ЗУ	SM 2	064	2025-04-01 21:00:00	32.48
1363	Q11	ЗУ	SM 3	065	2025-04-01 21:00:00	18.15
1364	Q12	ЗУ	SM 4	066	2025-04-01 21:00:00	21.27
1365	Q13	ЗУ	SM 5	067	2025-04-01 21:00:00	0
1366	Q14	ЗУ	SM 6	068	2025-04-01 21:00:00	0
1367	Q15	ЗУ	SM 7	069	2025-04-01 21:00:00	0
1368	Q16	ЗУ	SM 8	070	2025-04-01 21:00:00	0
1369	Q17	ЗУ	MO 9	071	2025-04-01 21:00:00	1.91
1370	Q20	ЗУ	MO 10	072	2025-04-01 21:00:00	0
1371	Q21	ЗУ	MO 11	073	2025-04-01 21:00:00	13.13
1372	Q22	ЗУ	MO 12	074	2025-04-01 21:00:00	0
1373	Q23	ЗУ	MO 13	075	2025-04-01 21:00:00	25.63
1374	Q24	ЗУ	MO 14	076	2025-04-01 21:00:00	0
1375	Q25	ЗУ	MO 15	077	2025-04-01 21:00:00	16.18
1376	TP3	ЗУ	CP-300 New	078	2025-04-01 21:00:00	31.19
1377	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 21:30:00	0
1378	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 21:30:00	0.0014
1379	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 21:30:00	0.0029
1380	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 21:30:00	4.55
1381	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 21:30:00	19.79
1382	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 21:30:00	19.37
1383	QF 1,20	ЗУ	China 1	044	2025-04-01 21:30:00	10.76
1384	QF 1,21	ЗУ	China 2	045	2025-04-01 21:30:00	8.97
1385	QF 1,22	ЗУ	China 3	046	2025-04-01 21:30:00	11.42
1386	QF 2,20	ЗУ	China 4	047	2025-04-01 21:30:00	17.24
1387	QF 2,21	ЗУ	China 5	048	2025-04-01 21:30:00	20.1
1388	QF 2,22	ЗУ	China 6	049	2025-04-01 21:30:00	17.91
1389	QF 2,23	ЗУ	China 7	050	2025-04-01 21:30:00	8.01
1390	QF 2,19	ЗУ	China 8	051	2025-04-01 21:30:00	12.42
1391	Q8	ЗУ	DIG	061	2025-04-01 21:30:00	53.33
1392	Q4	ЗУ	BG 1	062	2025-04-01 21:30:00	0
1393	Q9	ЗУ	BG 2	063	2025-04-01 21:30:00	20.12
1394	Q10	ЗУ	SM 2	064	2025-04-01 21:30:00	32.36
1395	Q11	ЗУ	SM 3	065	2025-04-01 21:30:00	18.16
1396	Q12	ЗУ	SM 4	066	2025-04-01 21:30:00	21.22
1397	Q13	ЗУ	SM 5	067	2025-04-01 21:30:00	0
1398	Q14	ЗУ	SM 6	068	2025-04-01 21:30:00	0
1399	Q15	ЗУ	SM 7	069	2025-04-01 21:30:00	0
1400	Q16	ЗУ	SM 8	070	2025-04-01 21:30:00	0
1401	Q17	ЗУ	MO 9	071	2025-04-01 21:30:00	1.87
1402	Q20	ЗУ	MO 10	072	2025-04-01 21:30:00	0
1403	Q21	ЗУ	MO 11	073	2025-04-01 21:30:00	13.18
1404	Q22	ЗУ	MO 12	074	2025-04-01 21:30:00	0
1405	Q23	ЗУ	MO 13	075	2025-04-01 21:30:00	25.53
1406	Q24	ЗУ	MO 14	076	2025-04-01 21:30:00	0
1407	Q25	ЗУ	MO 15	077	2025-04-01 21:30:00	16.1
1408	TP3	ЗУ	CP-300 New	078	2025-04-01 21:30:00	32.35
1409	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 22:00:00	0
1410	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 22:00:00	0.0009
1411	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 22:00:00	0.0027
1412	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 22:00:00	3.12
1413	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 22:00:00	9.76
1414	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 22:00:00	9.6
1415	QF 1,20	ЗУ	China 1	044	2025-04-01 22:00:00	10.94
1416	QF 1,21	ЗУ	China 2	045	2025-04-01 22:00:00	9.52
1417	QF 1,22	ЗУ	China 3	046	2025-04-01 22:00:00	11.95
1418	QF 2,20	ЗУ	China 4	047	2025-04-01 22:00:00	18.05
1419	QF 2,21	ЗУ	China 5	048	2025-04-01 22:00:00	20.87
1420	QF 2,22	ЗУ	China 6	049	2025-04-01 22:00:00	18.78
1421	QF 2,23	ЗУ	China 7	050	2025-04-01 22:00:00	8.48
1422	QF 2,19	ЗУ	China 8	051	2025-04-01 22:00:00	13.46
1423	Q8	ЗУ	DIG	061	2025-04-01 22:00:00	45.31
1424	Q4	ЗУ	BG 1	062	2025-04-01 22:00:00	0
1425	Q9	ЗУ	BG 2	063	2025-04-01 22:00:00	20.11
1426	Q10	ЗУ	SM 2	064	2025-04-01 22:00:00	32.38
1427	Q11	ЗУ	SM 3	065	2025-04-01 22:00:00	18.12
1428	Q12	ЗУ	SM 4	066	2025-04-01 22:00:00	21.24
1429	Q13	ЗУ	SM 5	067	2025-04-01 22:00:00	0
1430	Q14	ЗУ	SM 6	068	2025-04-01 22:00:00	0
1431	Q15	ЗУ	SM 7	069	2025-04-01 22:00:00	0
1432	Q16	ЗУ	SM 8	070	2025-04-01 22:00:00	0
1433	Q17	ЗУ	MO 9	071	2025-04-01 22:00:00	1.86
1434	Q20	ЗУ	MO 10	072	2025-04-01 22:00:00	0
1435	Q21	ЗУ	MO 11	073	2025-04-01 22:00:00	13.14
1436	Q22	ЗУ	MO 12	074	2025-04-01 22:00:00	0
1437	Q23	ЗУ	MO 13	075	2025-04-01 22:00:00	25.57
1438	Q24	ЗУ	MO 14	076	2025-04-01 22:00:00	0
1439	Q25	ЗУ	MO 15	077	2025-04-01 22:00:00	16.1
1440	TP3	ЗУ	CP-300 New	078	2025-04-01 22:00:00	34.5
1441	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 22:30:00	0
1442	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 22:30:00	0.0005
1443	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 22:30:00	0.0028
1444	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 22:30:00	0.0463
1445	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 22:30:00	0.0511
1446	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 22:30:00	0.0531
1447	QF 1,20	ЗУ	China 1	044	2025-04-01 22:30:00	10.27
1448	QF 1,21	ЗУ	China 2	045	2025-04-01 22:30:00	8.66
1449	QF 1,22	ЗУ	China 3	046	2025-04-01 22:30:00	11.65
1450	QF 2,20	ЗУ	China 4	047	2025-04-01 22:30:00	17.83
1451	QF 2,21	ЗУ	China 5	048	2025-04-01 22:30:00	20.6
1452	QF 2,22	ЗУ	China 6	049	2025-04-01 22:30:00	18.3
1453	QF 2,23	ЗУ	China 7	050	2025-04-01 22:30:00	8.42
1454	QF 2,19	ЗУ	China 8	051	2025-04-01 22:30:00	12.76
1455	Q8	ЗУ	DIG	061	2025-04-01 22:30:00	44.27
1456	Q4	ЗУ	BG 1	062	2025-04-01 22:30:00	0
1457	Q9	ЗУ	BG 2	063	2025-04-01 22:30:00	20.06
1458	Q10	ЗУ	SM 2	064	2025-04-01 22:30:00	31.41
1459	Q11	ЗУ	SM 3	065	2025-04-01 22:30:00	18.1
1460	Q12	ЗУ	SM 4	066	2025-04-01 22:30:00	21.45
1461	Q13	ЗУ	SM 5	067	2025-04-01 22:30:00	0
1462	Q14	ЗУ	SM 6	068	2025-04-01 22:30:00	0
1463	Q15	ЗУ	SM 7	069	2025-04-01 22:30:00	0
1464	Q16	ЗУ	SM 8	070	2025-04-01 22:30:00	0
1465	Q17	ЗУ	MO 9	071	2025-04-01 22:30:00	1.87
1466	Q20	ЗУ	MO 10	072	2025-04-01 22:30:00	0
1467	Q21	ЗУ	MO 11	073	2025-04-01 22:30:00	13.13
1468	Q22	ЗУ	MO 12	074	2025-04-01 22:30:00	0
1469	Q23	ЗУ	MO 13	075	2025-04-01 22:30:00	25.61
1470	Q24	ЗУ	MO 14	076	2025-04-01 22:30:00	0
1471	Q25	ЗУ	MO 15	077	2025-04-01 22:30:00	16.08
1472	TP3	ЗУ	CP-300 New	078	2025-04-01 22:30:00	37.3
1473	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 23:00:00	0
1474	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 23:00:00	0.0003
1475	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 23:00:00	0.0026
1476	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 23:00:00	0.0024
1477	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 23:00:00	0
1478	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 23:00:00	0
1479	QF 1,20	ЗУ	China 1	044	2025-04-01 23:00:00	11.1
1480	QF 1,21	ЗУ	China 2	045	2025-04-01 23:00:00	9.53
1481	QF 1,22	ЗУ	China 3	046	2025-04-01 23:00:00	12.16
1482	QF 2,20	ЗУ	China 4	047	2025-04-01 23:00:00	18.6
1483	QF 2,21	ЗУ	China 5	048	2025-04-01 23:00:00	21.73
1484	QF 2,22	ЗУ	China 6	049	2025-04-01 23:00:00	18.96
1485	QF 2,23	ЗУ	China 7	050	2025-04-01 23:00:00	9.06
1486	QF 2,19	ЗУ	China 8	051	2025-04-01 23:00:00	13.61
1487	Q8	ЗУ	DIG	061	2025-04-01 23:00:00	47.76
1488	Q4	ЗУ	BG 1	062	2025-04-01 23:00:00	0
1489	Q9	ЗУ	BG 2	063	2025-04-01 23:00:00	20.09
1490	Q10	ЗУ	SM 2	064	2025-04-01 23:00:00	30.81
1491	Q11	ЗУ	SM 3	065	2025-04-01 23:00:00	18.15
1492	Q12	ЗУ	SM 4	066	2025-04-01 23:00:00	21.44
1493	Q13	ЗУ	SM 5	067	2025-04-01 23:00:00	0
1494	Q14	ЗУ	SM 6	068	2025-04-01 23:00:00	0
1495	Q15	ЗУ	SM 7	069	2025-04-01 23:00:00	0
1496	Q16	ЗУ	SM 8	070	2025-04-01 23:00:00	0
1497	Q17	ЗУ	MO 9	071	2025-04-01 23:00:00	1.89
1498	Q20	ЗУ	MO 10	072	2025-04-01 23:00:00	0
1499	Q21	ЗУ	MO 11	073	2025-04-01 23:00:00	13.14
1500	Q22	ЗУ	MO 12	074	2025-04-01 23:00:00	0
1501	Q23	ЗУ	MO 13	075	2025-04-01 23:00:00	25.66
1502	Q24	ЗУ	MO 14	076	2025-04-01 23:00:00	0
1503	Q25	ЗУ	MO 15	077	2025-04-01 23:00:00	16.09
1504	TP3	ЗУ	CP-300 New	078	2025-04-01 23:00:00	37.74
1505	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-01 23:30:00	1.16
1506	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-01 23:30:00	0.9759
1507	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-01 23:30:00	0.1951
1508	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-01 23:30:00	0.0022
1509	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-01 23:30:00	0
1510	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-01 23:30:00	0
1511	QF 1,20	ЗУ	China 1	044	2025-04-01 23:30:00	9.78
1512	QF 1,21	ЗУ	China 2	045	2025-04-01 23:30:00	8.26
1513	QF 1,22	ЗУ	China 3	046	2025-04-01 23:30:00	10.69
1514	QF 2,20	ЗУ	China 4	047	2025-04-01 23:30:00	17.05
1515	QF 2,21	ЗУ	China 5	048	2025-04-01 23:30:00	19.86
1516	QF 2,22	ЗУ	China 6	049	2025-04-01 23:30:00	17.45
1517	QF 2,23	ЗУ	China 7	050	2025-04-01 23:30:00	8.41
1518	QF 2,19	ЗУ	China 8	051	2025-04-01 23:30:00	12.41
1519	Q8	ЗУ	DIG	061	2025-04-01 23:30:00	45.94
1520	Q4	ЗУ	BG 1	062	2025-04-01 23:30:00	0
1521	Q9	ЗУ	BG 2	063	2025-04-01 23:30:00	20.1
1522	Q10	ЗУ	SM 2	064	2025-04-01 23:30:00	24.06
1523	Q11	ЗУ	SM 3	065	2025-04-01 23:30:00	18.19
1524	Q12	ЗУ	SM 4	066	2025-04-01 23:30:00	21.46
1525	Q13	ЗУ	SM 5	067	2025-04-01 23:30:00	0
1526	Q14	ЗУ	SM 6	068	2025-04-01 23:30:00	0
1527	Q15	ЗУ	SM 7	069	2025-04-01 23:30:00	0
1528	Q16	ЗУ	SM 8	070	2025-04-01 23:30:00	0
1529	Q17	ЗУ	MO 9	071	2025-04-01 23:30:00	1.88
1530	Q20	ЗУ	MO 10	072	2025-04-01 23:30:00	0
1531	Q21	ЗУ	MO 11	073	2025-04-01 23:30:00	13.14
1532	Q22	ЗУ	MO 12	074	2025-04-01 23:30:00	0
1533	Q23	ЗУ	MO 13	075	2025-04-01 23:30:00	25.71
1534	Q24	ЗУ	MO 14	076	2025-04-01 23:30:00	0
1535	Q25	ЗУ	MO 15	077	2025-04-01 23:30:00	16.09
1536	TP3	ЗУ	CP-300 New	078	2025-04-01 23:30:00	37.47
1537	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 00:00:00	4.36
1538	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 00:00:00	2.47
1539	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 00:00:00	1.38
1540	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 00:00:00	0.0022
1541	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 00:00:00	0
1542	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 00:00:00	0
1543	QF 1,20	ЗУ	China 1	044	2025-04-02 00:00:00	11.49
1544	QF 1,21	ЗУ	China 2	045	2025-04-02 00:00:00	10.06
1545	QF 1,22	ЗУ	China 3	046	2025-04-02 00:00:00	12.62
1546	QF 2,20	ЗУ	China 4	047	2025-04-02 00:00:00	18.61
1547	QF 2,21	ЗУ	China 5	048	2025-04-02 00:00:00	21.6
1548	QF 2,22	ЗУ	China 6	049	2025-04-02 00:00:00	19.76
1549	QF 2,23	ЗУ	China 7	050	2025-04-02 00:00:00	9.57
1550	QF 2,19	ЗУ	China 8	051	2025-04-02 00:00:00	14.3
1551	Q8	ЗУ	DIG	061	2025-04-02 00:00:00	39.64
1552	Q4	ЗУ	BG 1	062	2025-04-02 00:00:00	0
1553	Q9	ЗУ	BG 2	063	2025-04-02 00:00:00	20.11
1554	Q10	ЗУ	SM 2	064	2025-04-02 00:00:00	19.52
1555	Q11	ЗУ	SM 3	065	2025-04-02 00:00:00	18.17
1556	Q12	ЗУ	SM 4	066	2025-04-02 00:00:00	21.47
1557	Q13	ЗУ	SM 5	067	2025-04-02 00:00:00	0
1558	Q14	ЗУ	SM 6	068	2025-04-02 00:00:00	0
1559	Q15	ЗУ	SM 7	069	2025-04-02 00:00:00	0
1560	Q16	ЗУ	SM 8	070	2025-04-02 00:00:00	0
1561	Q17	ЗУ	MO 9	071	2025-04-02 00:00:00	1.87
1562	Q20	ЗУ	MO 10	072	2025-04-02 00:00:00	0
1563	Q21	ЗУ	MO 11	073	2025-04-02 00:00:00	13.15
1564	Q22	ЗУ	MO 12	074	2025-04-02 00:00:00	0
1565	Q23	ЗУ	MO 13	075	2025-04-02 00:00:00	25.73
1566	Q24	ЗУ	MO 14	076	2025-04-02 00:00:00	0
1567	Q25	ЗУ	MO 15	077	2025-04-02 00:00:00	16.13
1568	TP3	ЗУ	CP-300 New	078	2025-04-02 00:00:00	37.38
1569	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 00:30:00	12.82
1570	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 00:30:00	5.05
1571	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 00:30:00	6.39
1572	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 00:30:00	0.0023
1573	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 00:30:00	0
1574	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 00:30:00	0
1575	QF 1,20	ЗУ	China 1	044	2025-04-02 00:30:00	12.61
1576	QF 1,21	ЗУ	China 2	045	2025-04-02 00:30:00	10.99
1577	QF 1,22	ЗУ	China 3	046	2025-04-02 00:30:00	13.74
1578	QF 2,20	ЗУ	China 4	047	2025-04-02 00:30:00	19.6
1579	QF 2,21	ЗУ	China 5	048	2025-04-02 00:30:00	22.9
1580	QF 2,22	ЗУ	China 6	049	2025-04-02 00:30:00	21.14
1581	QF 2,23	ЗУ	China 7	050	2025-04-02 00:30:00	10.49
1582	QF 2,19	ЗУ	China 8	051	2025-04-02 00:30:00	15.41
1583	Q8	ЗУ	DIG	061	2025-04-02 00:30:00	41.97
1584	Q4	ЗУ	BG 1	062	2025-04-02 00:30:00	0
1585	Q9	ЗУ	BG 2	063	2025-04-02 00:30:00	20.09
1586	Q10	ЗУ	SM 2	064	2025-04-02 00:30:00	8.22
1587	Q11	ЗУ	SM 3	065	2025-04-02 00:30:00	18.19
1588	Q12	ЗУ	SM 4	066	2025-04-02 00:30:00	21.61
1589	Q13	ЗУ	SM 5	067	2025-04-02 00:30:00	0
1590	Q14	ЗУ	SM 6	068	2025-04-02 00:30:00	0
1591	Q15	ЗУ	SM 7	069	2025-04-02 00:30:00	0
1592	Q16	ЗУ	SM 8	070	2025-04-02 00:30:00	0
1593	Q17	ЗУ	MO 9	071	2025-04-02 00:30:00	1.89
1594	Q20	ЗУ	MO 10	072	2025-04-02 00:30:00	0
1595	Q21	ЗУ	MO 11	073	2025-04-02 00:30:00	13.16
1596	Q22	ЗУ	MO 12	074	2025-04-02 00:30:00	0
1597	Q23	ЗУ	MO 13	075	2025-04-02 00:30:00	25.79
1598	Q24	ЗУ	MO 14	076	2025-04-02 00:30:00	0
1599	Q25	ЗУ	MO 15	077	2025-04-02 00:30:00	16.12
1600	TP3	ЗУ	CP-300 New	078	2025-04-02 00:30:00	37.12
1601	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 01:00:00	19.48
1602	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 01:00:00	7.35
1603	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 01:00:00	10.43
1604	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 01:00:00	0.0025
1605	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 01:00:00	0
1606	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 01:00:00	0
1607	QF 1,20	ЗУ	China 1	044	2025-04-02 01:00:00	9.77
1608	QF 1,21	ЗУ	China 2	045	2025-04-02 01:00:00	8.1
1609	QF 1,22	ЗУ	China 3	046	2025-04-02 01:00:00	10.88
1610	QF 2,20	ЗУ	China 4	047	2025-04-02 01:00:00	15.09
1611	QF 2,21	ЗУ	China 5	048	2025-04-02 01:00:00	17.77
1612	QF 2,22	ЗУ	China 6	049	2025-04-02 01:00:00	17
1613	QF 2,23	ЗУ	China 7	050	2025-04-02 01:00:00	8.44
1614	QF 2,19	ЗУ	China 8	051	2025-04-02 01:00:00	11.95
1615	Q8	ЗУ	DIG	061	2025-04-02 01:00:00	42.53
1616	Q4	ЗУ	BG 1	062	2025-04-02 01:00:00	0
1617	Q9	ЗУ	BG 2	063	2025-04-02 01:00:00	20.1
1618	Q10	ЗУ	SM 2	064	2025-04-02 01:00:00	1.38
1619	Q11	ЗУ	SM 3	065	2025-04-02 01:00:00	18.27
1620	Q12	ЗУ	SM 4	066	2025-04-02 01:00:00	21.7
1621	Q13	ЗУ	SM 5	067	2025-04-02 01:00:00	0
1622	Q14	ЗУ	SM 6	068	2025-04-02 01:00:00	0
1623	Q15	ЗУ	SM 7	069	2025-04-02 01:00:00	0
1624	Q16	ЗУ	SM 8	070	2025-04-02 01:00:00	0
1625	Q17	ЗУ	MO 9	071	2025-04-02 01:00:00	1.9
1626	Q20	ЗУ	MO 10	072	2025-04-02 01:00:00	0
1627	Q21	ЗУ	MO 11	073	2025-04-02 01:00:00	13.18
1628	Q22	ЗУ	MO 12	074	2025-04-02 01:00:00	0
1629	Q23	ЗУ	MO 13	075	2025-04-02 01:00:00	25.84
1630	Q24	ЗУ	MO 14	076	2025-04-02 01:00:00	0
1631	Q25	ЗУ	MO 15	077	2025-04-02 01:00:00	16.09
1632	TP3	ЗУ	CP-300 New	078	2025-04-02 01:00:00	36.94
1633	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 01:30:00	24.42
1634	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 01:30:00	8.41
1635	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 01:30:00	14.57
1636	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 01:30:00	0.0026
1637	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 01:30:00	0
1638	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 01:30:00	0
1639	QF 1,20	ЗУ	China 1	044	2025-04-02 01:30:00	11.28
1640	QF 1,21	ЗУ	China 2	045	2025-04-02 01:30:00	9.95
1641	QF 1,22	ЗУ	China 3	046	2025-04-02 01:30:00	13.08
1642	QF 2,20	ЗУ	China 4	047	2025-04-02 01:30:00	16.73
1643	QF 2,21	ЗУ	China 5	048	2025-04-02 01:30:00	20.26
1644	QF 2,22	ЗУ	China 6	049	2025-04-02 01:30:00	18.63
1645	QF 2,23	ЗУ	China 7	050	2025-04-02 01:30:00	9.47
1646	QF 2,19	ЗУ	China 8	051	2025-04-02 01:30:00	14.07
1647	Q8	ЗУ	DIG	061	2025-04-02 01:30:00	49.1
1648	Q4	ЗУ	BG 1	062	2025-04-02 01:30:00	0
1649	Q9	ЗУ	BG 2	063	2025-04-02 01:30:00	20.09
1650	Q10	ЗУ	SM 2	064	2025-04-02 01:30:00	1.36
1651	Q11	ЗУ	SM 3	065	2025-04-02 01:30:00	18.24
1652	Q12	ЗУ	SM 4	066	2025-04-02 01:30:00	21.75
1653	Q13	ЗУ	SM 5	067	2025-04-02 01:30:00	0
1654	Q14	ЗУ	SM 6	068	2025-04-02 01:30:00	0
1655	Q15	ЗУ	SM 7	069	2025-04-02 01:30:00	0
1656	Q16	ЗУ	SM 8	070	2025-04-02 01:30:00	0
1657	Q17	ЗУ	MO 9	071	2025-04-02 01:30:00	1.89
1658	Q20	ЗУ	MO 10	072	2025-04-02 01:30:00	0
1659	Q21	ЗУ	MO 11	073	2025-04-02 01:30:00	13.17
1660	Q22	ЗУ	MO 12	074	2025-04-02 01:30:00	0
1661	Q23	ЗУ	MO 13	075	2025-04-02 01:30:00	25.78
1662	Q24	ЗУ	MO 14	076	2025-04-02 01:30:00	0
1663	Q25	ЗУ	MO 15	077	2025-04-02 01:30:00	16.02
1664	TP3	ЗУ	CP-300 New	078	2025-04-02 01:30:00	37.12
1665	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 02:00:00	29.68
1666	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 02:00:00	9.12
1667	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 02:00:00	19.03
1668	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 02:00:00	0.0025
1669	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 02:00:00	0
1670	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 02:00:00	0
1671	QF 1,20	ЗУ	China 1	044	2025-04-02 02:00:00	12.01
1672	QF 1,21	ЗУ	China 2	045	2025-04-02 02:00:00	10.65
1673	QF 1,22	ЗУ	China 3	046	2025-04-02 02:00:00	14
1674	QF 2,20	ЗУ	China 4	047	2025-04-02 02:00:00	17.02
1675	QF 2,21	ЗУ	China 5	048	2025-04-02 02:00:00	20.71
1676	QF 2,22	ЗУ	China 6	049	2025-04-02 02:00:00	19.14
1677	QF 2,23	ЗУ	China 7	050	2025-04-02 02:00:00	9.66
1678	QF 2,19	ЗУ	China 8	051	2025-04-02 02:00:00	14.81
1679	Q8	ЗУ	DIG	061	2025-04-02 02:00:00	51.12
1680	Q4	ЗУ	BG 1	062	2025-04-02 02:00:00	0
1681	Q9	ЗУ	BG 2	063	2025-04-02 02:00:00	20.08
1682	Q10	ЗУ	SM 2	064	2025-04-02 02:00:00	1.3
1683	Q11	ЗУ	SM 3	065	2025-04-02 02:00:00	18.09
1684	Q12	ЗУ	SM 4	066	2025-04-02 02:00:00	21.83
1685	Q13	ЗУ	SM 5	067	2025-04-02 02:00:00	0
1686	Q14	ЗУ	SM 6	068	2025-04-02 02:00:00	0
1687	Q15	ЗУ	SM 7	069	2025-04-02 02:00:00	0
1688	Q16	ЗУ	SM 8	070	2025-04-02 02:00:00	0
1689	Q17	ЗУ	MO 9	071	2025-04-02 02:00:00	1.86
1690	Q20	ЗУ	MO 10	072	2025-04-02 02:00:00	0
1691	Q21	ЗУ	MO 11	073	2025-04-02 02:00:00	13.13
1692	Q22	ЗУ	MO 12	074	2025-04-02 02:00:00	0
1693	Q23	ЗУ	MO 13	075	2025-04-02 02:00:00	25.59
1694	Q24	ЗУ	MO 14	076	2025-04-02 02:00:00	0
1695	Q25	ЗУ	MO 15	077	2025-04-02 02:00:00	15.88
1696	TP3	ЗУ	CP-300 New	078	2025-04-02 02:00:00	35.99
1697	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 02:30:00	29.71
1698	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 02:30:00	9.02
1699	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 02:30:00	19.21
1700	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 02:30:00	0.0026
1701	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 02:30:00	0
1702	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 02:30:00	0
1703	QF 1,20	ЗУ	China 1	044	2025-04-02 02:30:00	13.05
1704	QF 1,21	ЗУ	China 2	045	2025-04-02 02:30:00	11.61
1705	QF 1,22	ЗУ	China 3	046	2025-04-02 02:30:00	15.24
1706	QF 2,20	ЗУ	China 4	047	2025-04-02 02:30:00	17.8
1707	QF 2,21	ЗУ	China 5	048	2025-04-02 02:30:00	21.05
1708	QF 2,22	ЗУ	China 6	049	2025-04-02 02:30:00	19.63
1709	QF 2,23	ЗУ	China 7	050	2025-04-02 02:30:00	10.01
1710	QF 2,19	ЗУ	China 8	051	2025-04-02 02:30:00	15.48
1711	Q8	ЗУ	DIG	061	2025-04-02 02:30:00	50.79
1712	Q4	ЗУ	BG 1	062	2025-04-02 02:30:00	0
1713	Q9	ЗУ	BG 2	063	2025-04-02 02:30:00	20.02
1714	Q10	ЗУ	SM 2	064	2025-04-02 02:30:00	1.3
1715	Q11	ЗУ	SM 3	065	2025-04-02 02:30:00	18.09
1716	Q12	ЗУ	SM 4	066	2025-04-02 02:30:00	21.84
1717	Q13	ЗУ	SM 5	067	2025-04-02 02:30:00	0
1718	Q14	ЗУ	SM 6	068	2025-04-02 02:30:00	0
1719	Q15	ЗУ	SM 7	069	2025-04-02 02:30:00	0
1720	Q16	ЗУ	SM 8	070	2025-04-02 02:30:00	0
1721	Q17	ЗУ	MO 9	071	2025-04-02 02:30:00	1.85
1722	Q20	ЗУ	MO 10	072	2025-04-02 02:30:00	0
1723	Q21	ЗУ	MO 11	073	2025-04-02 02:30:00	13.16
1724	Q22	ЗУ	MO 12	074	2025-04-02 02:30:00	0
1725	Q23	ЗУ	MO 13	075	2025-04-02 02:30:00	25.62
1726	Q24	ЗУ	MO 14	076	2025-04-02 02:30:00	0
1727	Q25	ЗУ	MO 15	077	2025-04-02 02:30:00	15.87
1728	TP3	ЗУ	CP-300 New	078	2025-04-02 02:30:00	37.06
1729	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 03:00:00	29.61
1730	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 03:00:00	8.4
1731	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 03:00:00	19.68
1732	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 03:00:00	0.0026
1733	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 03:00:00	0
1734	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 03:00:00	0
1735	QF 1,20	ЗУ	China 1	044	2025-04-02 03:00:00	14.73
1736	QF 1,21	ЗУ	China 2	045	2025-04-02 03:00:00	12.63
1737	QF 1,22	ЗУ	China 3	046	2025-04-02 03:00:00	16.25
1738	QF 2,20	ЗУ	China 4	047	2025-04-02 03:00:00	18.7
1739	QF 2,21	ЗУ	China 5	048	2025-04-02 03:00:00	22.4
1740	QF 2,22	ЗУ	China 6	049	2025-04-02 03:00:00	20.71
1741	QF 2,23	ЗУ	China 7	050	2025-04-02 03:00:00	10.38
1742	QF 2,19	ЗУ	China 8	051	2025-04-02 03:00:00	16.24
1743	Q8	ЗУ	DIG	061	2025-04-02 03:00:00	50.74
11553	Q8	ЗУ	DIG	061	2026-05-09 20:31:32.807267	46.3441
1744	Q4	ЗУ	BG 1	062	2025-04-02 03:00:00	0
1745	Q9	ЗУ	BG 2	063	2025-04-02 03:00:00	20
1746	Q10	ЗУ	SM 2	064	2025-04-02 03:00:00	1.31
1747	Q11	ЗУ	SM 3	065	2025-04-02 03:00:00	18.11
1748	Q12	ЗУ	SM 4	066	2025-04-02 03:00:00	21.67
1749	Q13	ЗУ	SM 5	067	2025-04-02 03:00:00	0
1750	Q14	ЗУ	SM 6	068	2025-04-02 03:00:00	0
1751	Q15	ЗУ	SM 7	069	2025-04-02 03:00:00	0
1752	Q16	ЗУ	SM 8	070	2025-04-02 03:00:00	0
1753	Q17	ЗУ	MO 9	071	2025-04-02 03:00:00	1.86
1754	Q20	ЗУ	MO 10	072	2025-04-02 03:00:00	0
1755	Q21	ЗУ	MO 11	073	2025-04-02 03:00:00	13.14
1756	Q22	ЗУ	MO 12	074	2025-04-02 03:00:00	0
1757	Q23	ЗУ	MO 13	075	2025-04-02 03:00:00	25.64
1758	Q24	ЗУ	MO 14	076	2025-04-02 03:00:00	0
1759	Q25	ЗУ	MO 15	077	2025-04-02 03:00:00	15.87
1760	TP3	ЗУ	CP-300 New	078	2025-04-02 03:00:00	37.07
1761	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 03:30:00	23.57
1762	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 03:30:00	6.07
1763	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 03:30:00	16.3
1764	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 03:30:00	0.0027
1765	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 03:30:00	0
1766	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 03:30:00	0
1767	QF 1,20	ЗУ	China 1	044	2025-04-02 03:30:00	16.2
1768	QF 1,21	ЗУ	China 2	045	2025-04-02 03:30:00	14.19
1769	QF 1,22	ЗУ	China 3	046	2025-04-02 03:30:00	17.99
1770	QF 2,20	ЗУ	China 4	047	2025-04-02 03:30:00	19.69
1771	QF 2,21	ЗУ	China 5	048	2025-04-02 03:30:00	22.89
1772	QF 2,22	ЗУ	China 6	049	2025-04-02 03:30:00	21.66
1773	QF 2,23	ЗУ	China 7	050	2025-04-02 03:30:00	10.83
1774	QF 2,19	ЗУ	China 8	051	2025-04-02 03:30:00	17.65
1775	Q8	ЗУ	DIG	061	2025-04-02 03:30:00	50.81
1776	Q4	ЗУ	BG 1	062	2025-04-02 03:30:00	0
1777	Q9	ЗУ	BG 2	063	2025-04-02 03:30:00	19.99
1778	Q10	ЗУ	SM 2	064	2025-04-02 03:30:00	1.31
1779	Q11	ЗУ	SM 3	065	2025-04-02 03:30:00	18.12
1780	Q12	ЗУ	SM 4	066	2025-04-02 03:30:00	21.7
1781	Q13	ЗУ	SM 5	067	2025-04-02 03:30:00	0
1782	Q14	ЗУ	SM 6	068	2025-04-02 03:30:00	0
1783	Q15	ЗУ	SM 7	069	2025-04-02 03:30:00	0
1784	Q16	ЗУ	SM 8	070	2025-04-02 03:30:00	0
1785	Q17	ЗУ	MO 9	071	2025-04-02 03:30:00	1.85
1786	Q20	ЗУ	MO 10	072	2025-04-02 03:30:00	0
1787	Q21	ЗУ	MO 11	073	2025-04-02 03:30:00	13.14
1788	Q22	ЗУ	MO 12	074	2025-04-02 03:30:00	0
1789	Q23	ЗУ	MO 13	075	2025-04-02 03:30:00	25.65
1790	Q24	ЗУ	MO 14	076	2025-04-02 03:30:00	0
1791	Q25	ЗУ	MO 15	077	2025-04-02 03:30:00	15.85
1792	TP3	ЗУ	CP-300 New	078	2025-04-02 03:30:00	37.6
1793	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 04:00:00	28.01
1794	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 04:00:00	4.36
1795	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 04:00:00	21.75
1796	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 04:00:00	0.0026
1797	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 04:00:00	0
1798	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 04:00:00	0
1799	QF 1,20	ЗУ	China 1	044	2025-04-02 04:00:00	17.4
1800	QF 1,21	ЗУ	China 2	045	2025-04-02 04:00:00	15.55
1801	QF 1,22	ЗУ	China 3	046	2025-04-02 04:00:00	18.95
1802	QF 2,20	ЗУ	China 4	047	2025-04-02 04:00:00	20.26
1803	QF 2,21	ЗУ	China 5	048	2025-04-02 04:00:00	23.56
1804	QF 2,22	ЗУ	China 6	049	2025-04-02 04:00:00	22.23
1805	QF 2,23	ЗУ	China 7	050	2025-04-02 04:00:00	11.12
1806	QF 2,19	ЗУ	China 8	051	2025-04-02 04:00:00	18.67
1807	Q8	ЗУ	DIG	061	2025-04-02 04:00:00	50.33
1808	Q4	ЗУ	BG 1	062	2025-04-02 04:00:00	0
1809	Q9	ЗУ	BG 2	063	2025-04-02 04:00:00	20.04
1810	Q10	ЗУ	SM 2	064	2025-04-02 04:00:00	1.3
1811	Q11	ЗУ	SM 3	065	2025-04-02 04:00:00	18.08
1812	Q12	ЗУ	SM 4	066	2025-04-02 04:00:00	21.79
1813	Q13	ЗУ	SM 5	067	2025-04-02 04:00:00	0
1814	Q14	ЗУ	SM 6	068	2025-04-02 04:00:00	0
1815	Q15	ЗУ	SM 7	069	2025-04-02 04:00:00	0
1816	Q16	ЗУ	SM 8	070	2025-04-02 04:00:00	0
1817	Q17	ЗУ	MO 9	071	2025-04-02 04:00:00	1.88
1818	Q20	ЗУ	MO 10	072	2025-04-02 04:00:00	0
1819	Q21	ЗУ	MO 11	073	2025-04-02 04:00:00	13.14
1820	Q22	ЗУ	MO 12	074	2025-04-02 04:00:00	0
1821	Q23	ЗУ	MO 13	075	2025-04-02 04:00:00	25.61
1822	Q24	ЗУ	MO 14	076	2025-04-02 04:00:00	0
1823	Q25	ЗУ	MO 15	077	2025-04-02 04:00:00	15.77
1824	TP3	ЗУ	CP-300 New	078	2025-04-02 04:00:00	37.23
1825	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 04:30:00	27.89
1826	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 04:30:00	3.3
1827	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 04:30:00	22.12
1828	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 04:30:00	0.0026
1829	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 04:30:00	0
1830	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 04:30:00	0
1831	QF 1,20	ЗУ	China 1	044	2025-04-02 04:30:00	18.22
1832	QF 1,21	ЗУ	China 2	045	2025-04-02 04:30:00	16.06
1833	QF 1,22	ЗУ	China 3	046	2025-04-02 04:30:00	19.06
1834	QF 2,20	ЗУ	China 4	047	2025-04-02 04:30:00	19.87
1835	QF 2,21	ЗУ	China 5	048	2025-04-02 04:30:00	23.53
1836	QF 2,22	ЗУ	China 6	049	2025-04-02 04:30:00	21.56
1837	QF 2,23	ЗУ	China 7	050	2025-04-02 04:30:00	10.63
1838	QF 2,19	ЗУ	China 8	051	2025-04-02 04:30:00	18.96
1839	Q8	ЗУ	DIG	061	2025-04-02 04:30:00	42.37
1840	Q4	ЗУ	BG 1	062	2025-04-02 04:30:00	0
1841	Q9	ЗУ	BG 2	063	2025-04-02 04:30:00	20.05
1842	Q10	ЗУ	SM 2	064	2025-04-02 04:30:00	1.3
1843	Q11	ЗУ	SM 3	065	2025-04-02 04:30:00	18.11
1844	Q12	ЗУ	SM 4	066	2025-04-02 04:30:00	21.77
1845	Q13	ЗУ	SM 5	067	2025-04-02 04:30:00	0
1846	Q14	ЗУ	SM 6	068	2025-04-02 04:30:00	0
1847	Q15	ЗУ	SM 7	069	2025-04-02 04:30:00	0
1848	Q16	ЗУ	SM 8	070	2025-04-02 04:30:00	0
1849	Q17	ЗУ	MO 9	071	2025-04-02 04:30:00	1.88
1850	Q20	ЗУ	MO 10	072	2025-04-02 04:30:00	0
1851	Q21	ЗУ	MO 11	073	2025-04-02 04:30:00	13.1
1852	Q22	ЗУ	MO 12	074	2025-04-02 04:30:00	0
1853	Q23	ЗУ	MO 13	075	2025-04-02 04:30:00	25.57
1854	Q24	ЗУ	MO 14	076	2025-04-02 04:30:00	0
1855	Q25	ЗУ	MO 15	077	2025-04-02 04:30:00	15.8
1856	TP3	ЗУ	CP-300 New	078	2025-04-02 04:30:00	37.09
1857	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 05:00:00	27.88
1858	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 05:00:00	3.19
1859	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 05:00:00	22.12
1860	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 05:00:00	0.0026
1861	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 05:00:00	0
1862	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 05:00:00	0
1863	QF 1,20	ЗУ	China 1	044	2025-04-02 05:00:00	20.43
1864	QF 1,21	ЗУ	China 2	045	2025-04-02 05:00:00	17.84
1865	QF 1,22	ЗУ	China 3	046	2025-04-02 05:00:00	19.96
1866	QF 2,20	ЗУ	China 4	047	2025-04-02 05:00:00	21.57
1867	QF 2,21	ЗУ	China 5	048	2025-04-02 05:00:00	25.25
1868	QF 2,22	ЗУ	China 6	049	2025-04-02 05:00:00	23.63
1869	QF 2,23	ЗУ	China 7	050	2025-04-02 05:00:00	11.86
1870	QF 2,19	ЗУ	China 8	051	2025-04-02 05:00:00	20.24
1871	Q8	ЗУ	DIG	061	2025-04-02 05:00:00	39.81
1872	Q4	ЗУ	BG 1	062	2025-04-02 05:00:00	0
1873	Q9	ЗУ	BG 2	063	2025-04-02 05:00:00	20.06
1874	Q10	ЗУ	SM 2	064	2025-04-02 05:00:00	1.3
1875	Q11	ЗУ	SM 3	065	2025-04-02 05:00:00	18.09
1876	Q12	ЗУ	SM 4	066	2025-04-02 05:00:00	21.68
1877	Q13	ЗУ	SM 5	067	2025-04-02 05:00:00	0
1878	Q14	ЗУ	SM 6	068	2025-04-02 05:00:00	0
1879	Q15	ЗУ	SM 7	069	2025-04-02 05:00:00	0
1880	Q16	ЗУ	SM 8	070	2025-04-02 05:00:00	0
1881	Q17	ЗУ	MO 9	071	2025-04-02 05:00:00	1.85
1882	Q20	ЗУ	MO 10	072	2025-04-02 05:00:00	0
1883	Q21	ЗУ	MO 11	073	2025-04-02 05:00:00	13.15
1884	Q22	ЗУ	MO 12	074	2025-04-02 05:00:00	0
1885	Q23	ЗУ	MO 13	075	2025-04-02 05:00:00	25.51
1886	Q24	ЗУ	MO 14	076	2025-04-02 05:00:00	0
1887	Q25	ЗУ	MO 15	077	2025-04-02 05:00:00	15.79
1888	TP3	ЗУ	CP-300 New	078	2025-04-02 05:00:00	36.96
1889	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 05:30:00	25.33
1890	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 05:30:00	3.23
1891	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 05:30:00	19.52
1892	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 05:30:00	1.19
1893	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 05:30:00	0.9577
1894	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 05:30:00	0.999
1895	QF 1,20	ЗУ	China 1	044	2025-04-02 05:30:00	21.48
1896	QF 1,21	ЗУ	China 2	045	2025-04-02 05:30:00	19.14
1897	QF 1,22	ЗУ	China 3	046	2025-04-02 05:30:00	21.59
1898	QF 2,20	ЗУ	China 4	047	2025-04-02 05:30:00	22.5
1899	QF 2,21	ЗУ	China 5	048	2025-04-02 05:30:00	26.02
1900	QF 2,22	ЗУ	China 6	049	2025-04-02 05:30:00	24.57
1901	QF 2,23	ЗУ	China 7	050	2025-04-02 05:30:00	12.29
1902	QF 2,19	ЗУ	China 8	051	2025-04-02 05:30:00	20.5
1903	Q8	ЗУ	DIG	061	2025-04-02 05:30:00	34.36
1904	Q4	ЗУ	BG 1	062	2025-04-02 05:30:00	0
1905	Q9	ЗУ	BG 2	063	2025-04-02 05:30:00	20.05
1906	Q10	ЗУ	SM 2	064	2025-04-02 05:30:00	1.3
1907	Q11	ЗУ	SM 3	065	2025-04-02 05:30:00	18.05
1908	Q12	ЗУ	SM 4	066	2025-04-02 05:30:00	21.64
1909	Q13	ЗУ	SM 5	067	2025-04-02 05:30:00	0
1910	Q14	ЗУ	SM 6	068	2025-04-02 05:30:00	0
1911	Q15	ЗУ	SM 7	069	2025-04-02 05:30:00	0
1912	Q16	ЗУ	SM 8	070	2025-04-02 05:30:00	0
1913	Q17	ЗУ	MO 9	071	2025-04-02 05:30:00	1.86
1914	Q20	ЗУ	MO 10	072	2025-04-02 05:30:00	0
1915	Q21	ЗУ	MO 11	073	2025-04-02 05:30:00	13.11
1916	Q22	ЗУ	MO 12	074	2025-04-02 05:30:00	0
1917	Q23	ЗУ	MO 13	075	2025-04-02 05:30:00	25.49
1918	Q24	ЗУ	MO 14	076	2025-04-02 05:30:00	0
1919	Q25	ЗУ	MO 15	077	2025-04-02 05:30:00	15.79
1920	TP3	ЗУ	CP-300 New	078	2025-04-02 05:30:00	36.98
1921	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 06:00:00	18.46
1922	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 06:00:00	3.63
1923	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 06:00:00	12.79
1924	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 06:00:00	2.73
1925	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 06:00:00	4.35
1926	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 06:00:00	4.27
1927	QF 1,20	ЗУ	China 1	044	2025-04-02 06:00:00	20.41
1928	QF 1,21	ЗУ	China 2	045	2025-04-02 06:00:00	18.56
1929	QF 1,22	ЗУ	China 3	046	2025-04-02 06:00:00	20.48
1930	QF 2,20	ЗУ	China 4	047	2025-04-02 06:00:00	22.82
1931	QF 2,21	ЗУ	China 5	048	2025-04-02 06:00:00	25.82
1932	QF 2,22	ЗУ	China 6	049	2025-04-02 06:00:00	24.41
1933	QF 2,23	ЗУ	China 7	050	2025-04-02 06:00:00	12.27
1934	QF 2,19	ЗУ	China 8	051	2025-04-02 06:00:00	19.9
1935	Q8	ЗУ	DIG	061	2025-04-02 06:00:00	36.34
1936	Q4	ЗУ	BG 1	062	2025-04-02 06:00:00	0
1937	Q9	ЗУ	BG 2	063	2025-04-02 06:00:00	20.13
1938	Q10	ЗУ	SM 2	064	2025-04-02 06:00:00	1.34
1939	Q11	ЗУ	SM 3	065	2025-04-02 06:00:00	18.12
1940	Q12	ЗУ	SM 4	066	2025-04-02 06:00:00	21.77
1941	Q13	ЗУ	SM 5	067	2025-04-02 06:00:00	0
1942	Q14	ЗУ	SM 6	068	2025-04-02 06:00:00	0
1943	Q15	ЗУ	SM 7	069	2025-04-02 06:00:00	0
1944	Q16	ЗУ	SM 8	070	2025-04-02 06:00:00	0
1945	Q17	ЗУ	MO 9	071	2025-04-02 06:00:00	1.91
1946	Q20	ЗУ	MO 10	072	2025-04-02 06:00:00	0
1947	Q21	ЗУ	MO 11	073	2025-04-02 06:00:00	13.12
1948	Q22	ЗУ	MO 12	074	2025-04-02 06:00:00	0
1949	Q23	ЗУ	MO 13	075	2025-04-02 06:00:00	25.67
1950	Q24	ЗУ	MO 14	076	2025-04-02 06:00:00	0
1951	Q25	ЗУ	MO 15	077	2025-04-02 06:00:00	15.87
1952	TP3	ЗУ	CP-300 New	078	2025-04-02 06:00:00	34.65
1953	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 06:30:00	18.6
1954	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 06:30:00	3.83
1955	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 06:30:00	12.78
1956	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 06:30:00	6.2
1957	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 06:30:00	13.85
1958	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 06:30:00	13.52
1959	QF 1,20	ЗУ	China 1	044	2025-04-02 06:30:00	20.49
1960	QF 1,21	ЗУ	China 2	045	2025-04-02 06:30:00	18.03
1961	QF 1,22	ЗУ	China 3	046	2025-04-02 06:30:00	20.78
1962	QF 2,20	ЗУ	China 4	047	2025-04-02 06:30:00	22.49
1963	QF 2,21	ЗУ	China 5	048	2025-04-02 06:30:00	25.79
1964	QF 2,22	ЗУ	China 6	049	2025-04-02 06:30:00	24.02
1965	QF 2,23	ЗУ	China 7	050	2025-04-02 06:30:00	12.17
1966	QF 2,19	ЗУ	China 8	051	2025-04-02 06:30:00	19.82
1967	Q8	ЗУ	DIG	061	2025-04-02 06:30:00	44.4
1968	Q4	ЗУ	BG 1	062	2025-04-02 06:30:00	0
1969	Q9	ЗУ	BG 2	063	2025-04-02 06:30:00	20.16
1970	Q10	ЗУ	SM 2	064	2025-04-02 06:30:00	1.37
1971	Q11	ЗУ	SM 3	065	2025-04-02 06:30:00	18.17
1972	Q12	ЗУ	SM 4	066	2025-04-02 06:30:00	21.78
1973	Q13	ЗУ	SM 5	067	2025-04-02 06:30:00	0
1974	Q14	ЗУ	SM 6	068	2025-04-02 06:30:00	0
1975	Q15	ЗУ	SM 7	069	2025-04-02 06:30:00	0
1976	Q16	ЗУ	SM 8	070	2025-04-02 06:30:00	0
1977	Q17	ЗУ	MO 9	071	2025-04-02 06:30:00	1.92
1978	Q20	ЗУ	MO 10	072	2025-04-02 06:30:00	0
1979	Q21	ЗУ	MO 11	073	2025-04-02 06:30:00	13.11
1980	Q22	ЗУ	MO 12	074	2025-04-02 06:30:00	0
1981	Q23	ЗУ	MO 13	075	2025-04-02 06:30:00	25.76
1982	Q24	ЗУ	MO 14	076	2025-04-02 06:30:00	0
1983	Q25	ЗУ	MO 15	077	2025-04-02 06:30:00	15.97
1984	TP3	ЗУ	CP-300 New	078	2025-04-02 06:30:00	33.04
1985	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 07:00:00	18.5
1986	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 07:00:00	3.67
1987	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 07:00:00	12.77
1988	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 07:00:00	8.56
1989	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 07:00:00	20.66
1990	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 07:00:00	20.32
1991	QF 1,20	ЗУ	China 1	044	2025-04-02 07:00:00	19
1992	QF 1,21	ЗУ	China 2	045	2025-04-02 07:00:00	16.46
1993	QF 1,22	ЗУ	China 3	046	2025-04-02 07:00:00	18.92
1994	QF 2,20	ЗУ	China 4	047	2025-04-02 07:00:00	21.42
1995	QF 2,21	ЗУ	China 5	048	2025-04-02 07:00:00	24.11
1996	QF 2,22	ЗУ	China 6	049	2025-04-02 07:00:00	21.48
1997	QF 2,23	ЗУ	China 7	050	2025-04-02 07:00:00	11.19
1998	QF 2,19	ЗУ	China 8	051	2025-04-02 07:00:00	17.97
1999	Q8	ЗУ	DIG	061	2025-04-02 07:00:00	53.2
2000	Q4	ЗУ	BG 1	062	2025-04-02 07:00:00	0
2001	Q9	ЗУ	BG 2	063	2025-04-02 07:00:00	20.11
2002	Q10	ЗУ	SM 2	064	2025-04-02 07:00:00	10.71
2003	Q11	ЗУ	SM 3	065	2025-04-02 07:00:00	17.97
2004	Q12	ЗУ	SM 4	066	2025-04-02 07:00:00	21.62
2005	Q13	ЗУ	SM 5	067	2025-04-02 07:00:00	0
2006	Q14	ЗУ	SM 6	068	2025-04-02 07:00:00	0
2007	Q15	ЗУ	SM 7	069	2025-04-02 07:00:00	0
2008	Q16	ЗУ	SM 8	070	2025-04-02 07:00:00	0
2009	Q17	ЗУ	MO 9	071	2025-04-02 07:00:00	1.92
2010	Q20	ЗУ	MO 10	072	2025-04-02 07:00:00	0
2011	Q21	ЗУ	MO 11	073	2025-04-02 07:00:00	13.12
2012	Q22	ЗУ	MO 12	074	2025-04-02 07:00:00	0
2013	Q23	ЗУ	MO 13	075	2025-04-02 07:00:00	25.57
2014	Q24	ЗУ	MO 14	076	2025-04-02 07:00:00	0
2015	Q25	ЗУ	MO 15	077	2025-04-02 07:00:00	15.81
2016	TP3	ЗУ	CP-300 New	078	2025-04-02 07:00:00	32.44
2017	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 07:30:00	18.41
2018	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 07:30:00	3.57
2019	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 07:30:00	12.78
2020	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 07:30:00	9.5
2021	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 07:30:00	24.27
2022	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 07:30:00	23.8
2023	QF 1,20	ЗУ	China 1	044	2025-04-02 07:30:00	18.95
2024	QF 1,21	ЗУ	China 2	045	2025-04-02 07:30:00	16.29
2025	QF 1,22	ЗУ	China 3	046	2025-04-02 07:30:00	19.32
2026	QF 2,20	ЗУ	China 4	047	2025-04-02 07:30:00	22.64
2027	QF 2,21	ЗУ	China 5	048	2025-04-02 07:30:00	24.79
2028	QF 2,22	ЗУ	China 6	049	2025-04-02 07:30:00	22
2029	QF 2,23	ЗУ	China 7	050	2025-04-02 07:30:00	11.37
2030	QF 2,19	ЗУ	China 8	051	2025-04-02 07:30:00	18.34
2031	Q8	ЗУ	DIG	061	2025-04-02 07:30:00	56.04
2032	Q4	ЗУ	BG 1	062	2025-04-02 07:30:00	0
2033	Q9	ЗУ	BG 2	063	2025-04-02 07:30:00	20.09
2034	Q10	ЗУ	SM 2	064	2025-04-02 07:30:00	21.49
2035	Q11	ЗУ	SM 3	065	2025-04-02 07:30:00	17.88
2036	Q12	ЗУ	SM 4	066	2025-04-02 07:30:00	21.59
2037	Q13	ЗУ	SM 5	067	2025-04-02 07:30:00	0
2038	Q14	ЗУ	SM 6	068	2025-04-02 07:30:00	0
2039	Q15	ЗУ	SM 7	069	2025-04-02 07:30:00	0
2040	Q16	ЗУ	SM 8	070	2025-04-02 07:30:00	0
2041	Q17	ЗУ	MO 9	071	2025-04-02 07:30:00	1.96
2042	Q20	ЗУ	MO 10	072	2025-04-02 07:30:00	0
2043	Q21	ЗУ	MO 11	073	2025-04-02 07:30:00	13.06
2044	Q22	ЗУ	MO 12	074	2025-04-02 07:30:00	0
2045	Q23	ЗУ	MO 13	075	2025-04-02 07:30:00	25.54
2046	Q24	ЗУ	MO 14	076	2025-04-02 07:30:00	0
2047	Q25	ЗУ	MO 15	077	2025-04-02 07:30:00	15.77
2048	TP3	ЗУ	CP-300 New	078	2025-04-02 07:30:00	33.04
2049	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 08:00:00	18.19
2050	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 08:00:00	3.35
2051	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 08:00:00	12.82
11941	Q8	ЗУ	DIG	061	2026-05-09 20:39:43.161383	48.1925
2052	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 08:00:00	11.4
2053	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 08:00:00	32.02
2054	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 08:00:00	31.29
2055	QF 1,20	ЗУ	China 1	044	2025-04-02 08:00:00	20.39
2056	QF 1,21	ЗУ	China 2	045	2025-04-02 08:00:00	18.41
2057	QF 1,22	ЗУ	China 3	046	2025-04-02 08:00:00	20.84
2058	QF 2,20	ЗУ	China 4	047	2025-04-02 08:00:00	25.13
2059	QF 2,21	ЗУ	China 5	048	2025-04-02 08:00:00	26.61
2060	QF 2,22	ЗУ	China 6	049	2025-04-02 08:00:00	23.8
2061	QF 2,23	ЗУ	China 7	050	2025-04-02 08:00:00	12.16
2062	QF 2,19	ЗУ	China 8	051	2025-04-02 08:00:00	19.97
2063	Q8	ЗУ	DIG	061	2025-04-02 08:00:00	57.83
2064	Q4	ЗУ	BG 1	062	2025-04-02 08:00:00	0
2065	Q9	ЗУ	BG 2	063	2025-04-02 08:00:00	19.77
2066	Q10	ЗУ	SM 2	064	2025-04-02 08:00:00	18.73
2067	Q11	ЗУ	SM 3	065	2025-04-02 08:00:00	17.98
2068	Q12	ЗУ	SM 4	066	2025-04-02 08:00:00	16.38
2069	Q13	ЗУ	SM 5	067	2025-04-02 08:00:00	0
2070	Q14	ЗУ	SM 6	068	2025-04-02 08:00:00	0
2071	Q15	ЗУ	SM 7	069	2025-04-02 08:00:00	0
2072	Q16	ЗУ	SM 8	070	2025-04-02 08:00:00	0
2073	Q17	ЗУ	MO 9	071	2025-04-02 08:00:00	2.03
2074	Q20	ЗУ	MO 10	072	2025-04-02 08:00:00	0
2075	Q21	ЗУ	MO 11	073	2025-04-02 08:00:00	13.11
2076	Q22	ЗУ	MO 12	074	2025-04-02 08:00:00	0
2077	Q23	ЗУ	MO 13	075	2025-04-02 08:00:00	25.43
2078	Q24	ЗУ	MO 14	076	2025-04-02 08:00:00	0
2079	Q25	ЗУ	MO 15	077	2025-04-02 08:00:00	15.66
2080	TP3	ЗУ	CP-300 New	078	2025-04-02 08:00:00	34.78
2081	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 08:30:00	18.08
2082	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 08:30:00	3.1
2083	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 08:30:00	12.86
2084	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 08:30:00	10.87
2085	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 08:30:00	31.98
2086	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 08:30:00	31.19
2087	QF 1,20	ЗУ	China 1	044	2025-04-02 08:30:00	18.1
2088	QF 1,21	ЗУ	China 2	045	2025-04-02 08:30:00	16.11
2089	QF 1,22	ЗУ	China 3	046	2025-04-02 08:30:00	18.94
2090	QF 2,20	ЗУ	China 4	047	2025-04-02 08:30:00	22.55
2091	QF 2,21	ЗУ	China 5	048	2025-04-02 08:30:00	22.6
2092	QF 2,22	ЗУ	China 6	049	2025-04-02 08:30:00	21.19
2093	QF 2,23	ЗУ	China 7	050	2025-04-02 08:30:00	10.84
2094	QF 2,19	ЗУ	China 8	051	2025-04-02 08:30:00	18.23
2095	Q8	ЗУ	DIG	061	2025-04-02 08:30:00	58.24
2096	Q4	ЗУ	BG 1	062	2025-04-02 08:30:00	0
2097	Q9	ЗУ	BG 2	063	2025-04-02 08:30:00	13.71
2098	Q10	ЗУ	SM 2	064	2025-04-02 08:30:00	18.64
2099	Q11	ЗУ	SM 3	065	2025-04-02 08:30:00	17.93
2100	Q12	ЗУ	SM 4	066	2025-04-02 08:30:00	14.66
2101	Q13	ЗУ	SM 5	067	2025-04-02 08:30:00	0
2102	Q14	ЗУ	SM 6	068	2025-04-02 08:30:00	0
2103	Q15	ЗУ	SM 7	069	2025-04-02 08:30:00	0
2104	Q16	ЗУ	SM 8	070	2025-04-02 08:30:00	0
2105	Q17	ЗУ	MO 9	071	2025-04-02 08:30:00	2.07
2106	Q20	ЗУ	MO 10	072	2025-04-02 08:30:00	0
2107	Q21	ЗУ	MO 11	073	2025-04-02 08:30:00	13.1
2108	Q22	ЗУ	MO 12	074	2025-04-02 08:30:00	0
2109	Q23	ЗУ	MO 13	075	2025-04-02 08:30:00	25.32
2110	Q24	ЗУ	MO 14	076	2025-04-02 08:30:00	0
2111	Q25	ЗУ	MO 15	077	2025-04-02 08:30:00	15.59
2112	TP3	ЗУ	CP-300 New	078	2025-04-02 08:30:00	34.57
2113	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 09:00:00	13.07
2114	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 09:00:00	2.32
2115	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 09:00:00	9.1
2116	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 09:00:00	9.95
2117	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 09:00:00	31.7
2118	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 09:00:00	30.76
2119	QF 1,20	ЗУ	China 1	044	2025-04-02 09:00:00	16.79
2120	QF 1,21	ЗУ	China 2	045	2025-04-02 09:00:00	15.53
2121	QF 1,22	ЗУ	China 3	046	2025-04-02 09:00:00	18.28
2122	QF 2,20	ЗУ	China 4	047	2025-04-02 09:00:00	22.25
2123	QF 2,21	ЗУ	China 5	048	2025-04-02 09:00:00	22.9
2124	QF 2,22	ЗУ	China 6	049	2025-04-02 09:00:00	20.19
2125	QF 2,23	ЗУ	China 7	050	2025-04-02 09:00:00	10.7
2126	QF 2,19	ЗУ	China 8	051	2025-04-02 09:00:00	18.16
2127	Q8	ЗУ	DIG	061	2025-04-02 09:00:00	54.6
2128	Q4	ЗУ	BG 1	062	2025-04-02 09:00:00	0
2129	Q9	ЗУ	BG 2	063	2025-04-02 09:00:00	13.42
2130	Q10	ЗУ	SM 2	064	2025-04-02 09:00:00	19.63
2131	Q11	ЗУ	SM 3	065	2025-04-02 09:00:00	17.92
2132	Q12	ЗУ	SM 4	066	2025-04-02 09:00:00	14.62
2133	Q13	ЗУ	SM 5	067	2025-04-02 09:00:00	0
2134	Q14	ЗУ	SM 6	068	2025-04-02 09:00:00	0
2135	Q15	ЗУ	SM 7	069	2025-04-02 09:00:00	0
2136	Q16	ЗУ	SM 8	070	2025-04-02 09:00:00	0
2137	Q17	ЗУ	MO 9	071	2025-04-02 09:00:00	2.08
2138	Q20	ЗУ	MO 10	072	2025-04-02 09:00:00	0
2139	Q21	ЗУ	MO 11	073	2025-04-02 09:00:00	9.9
2140	Q22	ЗУ	MO 12	074	2025-04-02 09:00:00	0
2141	Q23	ЗУ	MO 13	075	2025-04-02 09:00:00	25.28
2142	Q24	ЗУ	MO 14	076	2025-04-02 09:00:00	0
2143	Q25	ЗУ	MO 15	077	2025-04-02 09:00:00	15.56
2144	TP3	ЗУ	CP-300 New	078	2025-04-02 09:00:00	34.88
2145	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 09:30:00	0
2146	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 09:30:00	0.0003
2147	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 09:30:00	0.0026
2148	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 09:30:00	6.91
2149	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 09:30:00	25.41
2150	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 09:30:00	24.53
2151	QF 1,20	ЗУ	China 1	044	2025-04-02 09:30:00	16.54
2152	QF 1,21	ЗУ	China 2	045	2025-04-02 09:30:00	14.26
2153	QF 1,22	ЗУ	China 3	046	2025-04-02 09:30:00	17.56
2154	QF 2,20	ЗУ	China 4	047	2025-04-02 09:30:00	21.46
2155	QF 2,21	ЗУ	China 5	048	2025-04-02 09:30:00	21.88
2156	QF 2,22	ЗУ	China 6	049	2025-04-02 09:30:00	19.98
2157	QF 2,23	ЗУ	China 7	050	2025-04-02 09:30:00	10.34
2158	QF 2,19	ЗУ	China 8	051	2025-04-02 09:30:00	17.24
2159	Q8	ЗУ	DIG	061	2025-04-02 09:30:00	51.45
2160	Q4	ЗУ	BG 1	062	2025-04-02 09:30:00	0
2161	Q9	ЗУ	BG 2	063	2025-04-02 09:30:00	13.42
2162	Q10	ЗУ	SM 2	064	2025-04-02 09:30:00	19.61
2163	Q11	ЗУ	SM 3	065	2025-04-02 09:30:00	17.91
2164	Q12	ЗУ	SM 4	066	2025-04-02 09:30:00	14.67
2165	Q13	ЗУ	SM 5	067	2025-04-02 09:30:00	0
2166	Q14	ЗУ	SM 6	068	2025-04-02 09:30:00	0
2167	Q15	ЗУ	SM 7	069	2025-04-02 09:30:00	0
2168	Q16	ЗУ	SM 8	070	2025-04-02 09:30:00	0
2169	Q17	ЗУ	MO 9	071	2025-04-02 09:30:00	2.07
2170	Q20	ЗУ	MO 10	072	2025-04-02 09:30:00	0
2171	Q21	ЗУ	MO 11	073	2025-04-02 09:30:00	8.1
2172	Q22	ЗУ	MO 12	074	2025-04-02 09:30:00	0
2173	Q23	ЗУ	MO 13	075	2025-04-02 09:30:00	25.34
2174	Q24	ЗУ	MO 14	076	2025-04-02 09:30:00	0
2175	Q25	ЗУ	MO 15	077	2025-04-02 09:30:00	15.61
2176	TP3	ЗУ	CP-300 New	078	2025-04-02 09:30:00	35.57
2177	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 10:00:00	0
2178	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 10:00:00	0.0011
2179	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 10:00:00	0.0029
2180	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 10:00:00	5.24
2181	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 10:00:00	30.83
2182	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 10:00:00	29.55
2183	QF 1,20	ЗУ	China 1	044	2025-04-02 10:00:00	17.98
2184	QF 1,21	ЗУ	China 2	045	2025-04-02 10:00:00	16.13
2185	QF 1,22	ЗУ	China 3	046	2025-04-02 10:00:00	18.69
2186	QF 2,20	ЗУ	China 4	047	2025-04-02 10:00:00	22.74
2187	QF 2,21	ЗУ	China 5	048	2025-04-02 10:00:00	23.47
2188	QF 2,22	ЗУ	China 6	049	2025-04-02 10:00:00	21.6
2189	QF 2,23	ЗУ	China 7	050	2025-04-02 10:00:00	11.08
2190	QF 2,19	ЗУ	China 8	051	2025-04-02 10:00:00	18.93
2191	Q8	ЗУ	DIG	061	2025-04-02 10:00:00	46.66
2192	Q4	ЗУ	BG 1	062	2025-04-02 10:00:00	0
2193	Q9	ЗУ	BG 2	063	2025-04-02 10:00:00	12.86
2194	Q10	ЗУ	SM 2	064	2025-04-02 10:00:00	20.03
2195	Q11	ЗУ	SM 3	065	2025-04-02 10:00:00	16.01
2196	Q12	ЗУ	SM 4	066	2025-04-02 10:00:00	5.06
2197	Q13	ЗУ	SM 5	067	2025-04-02 10:00:00	0
2198	Q14	ЗУ	SM 6	068	2025-04-02 10:00:00	0
2199	Q15	ЗУ	SM 7	069	2025-04-02 10:00:00	0
2200	Q16	ЗУ	SM 8	070	2025-04-02 10:00:00	0
2201	Q17	ЗУ	MO 9	071	2025-04-02 10:00:00	1.96
2202	Q20	ЗУ	MO 10	072	2025-04-02 10:00:00	0
2203	Q21	ЗУ	MO 11	073	2025-04-02 10:00:00	8.11
2204	Q22	ЗУ	MO 12	074	2025-04-02 10:00:00	0
2205	Q23	ЗУ	MO 13	075	2025-04-02 10:00:00	25.45
2206	Q24	ЗУ	MO 14	076	2025-04-02 10:00:00	0
2207	Q25	ЗУ	MO 15	077	2025-04-02 10:00:00	15.65
2208	TP3	ЗУ	CP-300 New	078	2025-04-02 10:00:00	36.21
2209	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 10:30:00	0
2210	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 10:30:00	0.0014
2211	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 10:30:00	0.0033
2212	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 10:30:00	4.5
2213	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 10:30:00	30.89
2214	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 10:30:00	29.36
2215	QF 1,20	ЗУ	China 1	044	2025-04-02 10:30:00	19.78
2216	QF 1,21	ЗУ	China 2	045	2025-04-02 10:30:00	17.84
2217	QF 1,22	ЗУ	China 3	046	2025-04-02 10:30:00	20.37
2218	QF 2,20	ЗУ	China 4	047	2025-04-02 10:30:00	23.91
2219	QF 2,21	ЗУ	China 5	048	2025-04-02 10:30:00	24.74
2220	QF 2,22	ЗУ	China 6	049	2025-04-02 10:30:00	22.94
2221	QF 2,23	ЗУ	China 7	050	2025-04-02 10:30:00	11.68
2222	QF 2,19	ЗУ	China 8	051	2025-04-02 10:30:00	20.42
2223	Q8	ЗУ	DIG	061	2025-04-02 10:30:00	46.74
2224	Q4	ЗУ	BG 1	062	2025-04-02 10:30:00	0
2225	Q9	ЗУ	BG 2	063	2025-04-02 10:30:00	1.2
2226	Q10	ЗУ	SM 2	064	2025-04-02 10:30:00	22.93
2227	Q11	ЗУ	SM 3	065	2025-04-02 10:30:00	12.42
2228	Q12	ЗУ	SM 4	066	2025-04-02 10:30:00	1.88
2229	Q13	ЗУ	SM 5	067	2025-04-02 10:30:00	0
2230	Q14	ЗУ	SM 6	068	2025-04-02 10:30:00	0
2231	Q15	ЗУ	SM 7	069	2025-04-02 10:30:00	0
2232	Q16	ЗУ	SM 8	070	2025-04-02 10:30:00	0
2233	Q17	ЗУ	MO 9	071	2025-04-02 10:30:00	1.96
2234	Q20	ЗУ	MO 10	072	2025-04-02 10:30:00	0
2235	Q21	ЗУ	MO 11	073	2025-04-02 10:30:00	8.11
2236	Q22	ЗУ	MO 12	074	2025-04-02 10:30:00	0
2237	Q23	ЗУ	MO 13	075	2025-04-02 10:30:00	25.37
2238	Q24	ЗУ	MO 14	076	2025-04-02 10:30:00	0
2239	Q25	ЗУ	MO 15	077	2025-04-02 10:30:00	15.64
2240	TP3	ЗУ	CP-300 New	078	2025-04-02 10:30:00	34.55
2241	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 11:00:00	0
2242	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 11:00:00	0.0009
2243	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 11:00:00	0.0029
2244	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 11:00:00	4.58
2245	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 11:00:00	30.96
2246	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 11:00:00	29.41
2247	QF 1,20	ЗУ	China 1	044	2025-04-02 11:00:00	21.8
2248	QF 1,21	ЗУ	China 2	045	2025-04-02 11:00:00	19.5
2249	QF 1,22	ЗУ	China 3	046	2025-04-02 11:00:00	22.29
2250	QF 2,20	ЗУ	China 4	047	2025-04-02 11:00:00	25.85
2251	QF 2,21	ЗУ	China 5	048	2025-04-02 11:00:00	26.96
2252	QF 2,22	ЗУ	China 6	049	2025-04-02 11:00:00	25.54
2253	QF 2,23	ЗУ	China 7	050	2025-04-02 11:00:00	12.73
2254	QF 2,19	ЗУ	China 8	051	2025-04-02 11:00:00	22.7
2255	Q8	ЗУ	DIG	061	2025-04-02 11:00:00	35.79
12045	Q8	ЗУ	DIG	061	2026-05-09 20:42:03.2961	47.9235
2256	Q4	ЗУ	BG 1	062	2025-04-02 11:00:00	0
2257	Q9	ЗУ	BG 2	063	2025-04-02 11:00:00	0.6081
2258	Q10	ЗУ	SM 2	064	2025-04-02 11:00:00	27.29
2259	Q11	ЗУ	SM 3	065	2025-04-02 11:00:00	12.43
2260	Q12	ЗУ	SM 4	066	2025-04-02 11:00:00	1.9
2261	Q13	ЗУ	SM 5	067	2025-04-02 11:00:00	0
2262	Q14	ЗУ	SM 6	068	2025-04-02 11:00:00	0
2263	Q15	ЗУ	SM 7	069	2025-04-02 11:00:00	0
2264	Q16	ЗУ	SM 8	070	2025-04-02 11:00:00	0
2265	Q17	ЗУ	MO 9	071	2025-04-02 11:00:00	1.99
2266	Q20	ЗУ	MO 10	072	2025-04-02 11:00:00	0
2267	Q21	ЗУ	MO 11	073	2025-04-02 11:00:00	2.98
2268	Q22	ЗУ	MO 12	074	2025-04-02 11:00:00	0
2269	Q23	ЗУ	MO 13	075	2025-04-02 11:00:00	25.41
2270	Q24	ЗУ	MO 14	076	2025-04-02 11:00:00	0
2271	Q25	ЗУ	MO 15	077	2025-04-02 11:00:00	15.61
2272	TP3	ЗУ	CP-300 New	078	2025-04-02 11:00:00	35.33
2273	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 11:30:00	0
2274	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 11:30:00	0.0012
2275	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 11:30:00	0.003
2276	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 11:30:00	4.72
2277	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 11:30:00	29.76
2278	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 11:30:00	28.42
2279	QF 1,20	ЗУ	China 1	044	2025-04-02 11:30:00	21.76
2280	QF 1,21	ЗУ	China 2	045	2025-04-02 11:30:00	19.22
2281	QF 1,22	ЗУ	China 3	046	2025-04-02 11:30:00	22.26
2282	QF 2,20	ЗУ	China 4	047	2025-04-02 11:30:00	25.46
2283	QF 2,21	ЗУ	China 5	048	2025-04-02 11:30:00	26.71
2284	QF 2,22	ЗУ	China 6	049	2025-04-02 11:30:00	25.73
2285	QF 2,23	ЗУ	China 7	050	2025-04-02 11:30:00	12.54
2286	QF 2,19	ЗУ	China 8	051	2025-04-02 11:30:00	22.55
2287	Q8	ЗУ	DIG	061	2025-04-02 11:30:00	41.72
2288	Q4	ЗУ	BG 1	062	2025-04-02 11:30:00	0
2289	Q9	ЗУ	BG 2	063	2025-04-02 11:30:00	0.604
2290	Q10	ЗУ	SM 2	064	2025-04-02 11:30:00	30.55
2291	Q11	ЗУ	SM 3	065	2025-04-02 11:30:00	12.41
2292	Q12	ЗУ	SM 4	066	2025-04-02 11:30:00	1.89
2293	Q13	ЗУ	SM 5	067	2025-04-02 11:30:00	0
2294	Q14	ЗУ	SM 6	068	2025-04-02 11:30:00	0
2295	Q15	ЗУ	SM 7	069	2025-04-02 11:30:00	0
2296	Q16	ЗУ	SM 8	070	2025-04-02 11:30:00	0
2297	Q17	ЗУ	MO 9	071	2025-04-02 11:30:00	1.98
2298	Q20	ЗУ	MO 10	072	2025-04-02 11:30:00	0
2299	Q21	ЗУ	MO 11	073	2025-04-02 11:30:00	0
2300	Q22	ЗУ	MO 12	074	2025-04-02 11:30:00	0
2301	Q23	ЗУ	MO 13	075	2025-04-02 11:30:00	25.41
2302	Q24	ЗУ	MO 14	076	2025-04-02 11:30:00	0
2303	Q25	ЗУ	MO 15	077	2025-04-02 11:30:00	15.64
2304	TP3	ЗУ	CP-300 New	078	2025-04-02 11:30:00	33.53
2305	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 12:00:00	0
2306	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 12:00:00	0.0011
2307	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 12:00:00	0.0029
2308	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 12:00:00	4.62
2309	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 12:00:00	19.83
2310	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 12:00:00	19.39
2311	QF 1,20	ЗУ	China 1	044	2025-04-02 12:00:00	18.77
2312	QF 1,21	ЗУ	China 2	045	2025-04-02 12:00:00	16.78
2313	QF 1,22	ЗУ	China 3	046	2025-04-02 12:00:00	19.58
2314	QF 2,20	ЗУ	China 4	047	2025-04-02 12:00:00	22.25
2315	QF 2,21	ЗУ	China 5	048	2025-04-02 12:00:00	24.08
2316	QF 2,22	ЗУ	China 6	049	2025-04-02 12:00:00	23.04
2317	QF 2,23	ЗУ	China 7	050	2025-04-02 12:00:00	10.75
2318	QF 2,19	ЗУ	China 8	051	2025-04-02 12:00:00	19.59
2319	Q8	ЗУ	DIG	061	2025-04-02 12:00:00	42.47
2320	Q4	ЗУ	BG 1	062	2025-04-02 12:00:00	0
2321	Q9	ЗУ	BG 2	063	2025-04-02 12:00:00	0.6199
2322	Q10	ЗУ	SM 2	064	2025-04-02 12:00:00	32.33
2323	Q11	ЗУ	SM 3	065	2025-04-02 12:00:00	8.63
2324	Q12	ЗУ	SM 4	066	2025-04-02 12:00:00	1.96
2325	Q13	ЗУ	SM 5	067	2025-04-02 12:00:00	0
2326	Q14	ЗУ	SM 6	068	2025-04-02 12:00:00	0
2327	Q15	ЗУ	SM 7	069	2025-04-02 12:00:00	0
2328	Q16	ЗУ	SM 8	070	2025-04-02 12:00:00	0
2329	Q17	ЗУ	MO 9	071	2025-04-02 12:00:00	1.83
2330	Q20	ЗУ	MO 10	072	2025-04-02 12:00:00	0
2331	Q21	ЗУ	MO 11	073	2025-04-02 12:00:00	0
2332	Q22	ЗУ	MO 12	074	2025-04-02 12:00:00	0
2333	Q23	ЗУ	MO 13	075	2025-04-02 12:00:00	25.57
2334	Q24	ЗУ	MO 14	076	2025-04-02 12:00:00	0
2335	Q25	ЗУ	MO 15	077	2025-04-02 12:00:00	15.78
2336	TP3	ЗУ	CP-300 New	078	2025-04-02 12:00:00	29.56
2337	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 12:30:00	0
2338	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 12:30:00	0.0014
2339	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 12:30:00	0.0031
2340	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 12:30:00	4.59
2341	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 12:30:00	19.82
2342	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 12:30:00	19.36
2343	QF 1,20	ЗУ	China 1	044	2025-04-02 12:30:00	20.52
2344	QF 1,21	ЗУ	China 2	045	2025-04-02 12:30:00	18.49
2345	QF 1,22	ЗУ	China 3	046	2025-04-02 12:30:00	21.4
2346	QF 2,20	ЗУ	China 4	047	2025-04-02 12:30:00	24.89
2347	QF 2,21	ЗУ	China 5	048	2025-04-02 12:30:00	26.68
2348	QF 2,22	ЗУ	China 6	049	2025-04-02 12:30:00	25.6
2349	QF 2,23	ЗУ	China 7	050	2025-04-02 12:30:00	11.95
2350	QF 2,19	ЗУ	China 8	051	2025-04-02 12:30:00	22.01
2351	Q8	ЗУ	DIG	061	2025-04-02 12:30:00	39.07
2352	Q4	ЗУ	BG 1	062	2025-04-02 12:30:00	0
2353	Q9	ЗУ	BG 2	063	2025-04-02 12:30:00	0.6087
2354	Q10	ЗУ	SM 2	064	2025-04-02 12:30:00	32.32
2355	Q11	ЗУ	SM 3	065	2025-04-02 12:30:00	1.83
2356	Q12	ЗУ	SM 4	066	2025-04-02 12:30:00	1.92
2357	Q13	ЗУ	SM 5	067	2025-04-02 12:30:00	0
2358	Q14	ЗУ	SM 6	068	2025-04-02 12:30:00	0
2359	Q15	ЗУ	SM 7	069	2025-04-02 12:30:00	0
2360	Q16	ЗУ	SM 8	070	2025-04-02 12:30:00	0
2361	Q17	ЗУ	MO 9	071	2025-04-02 12:30:00	1.97
2362	Q20	ЗУ	MO 10	072	2025-04-02 12:30:00	0
2363	Q21	ЗУ	MO 11	073	2025-04-02 12:30:00	0
2364	Q22	ЗУ	MO 12	074	2025-04-02 12:30:00	0
2365	Q23	ЗУ	MO 13	075	2025-04-02 12:30:00	25.47
2366	Q24	ЗУ	MO 14	076	2025-04-02 12:30:00	0
2367	Q25	ЗУ	MO 15	077	2025-04-02 12:30:00	15.67
2368	TP3	ЗУ	CP-300 New	078	2025-04-02 12:30:00	27.01
2369	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 13:00:00	0
2370	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 13:00:00	0.0013
2371	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 13:00:00	0.003
2372	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 13:00:00	4.57
2373	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 13:00:00	19.8
2374	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 13:00:00	19.36
2375	QF 1,20	ЗУ	China 1	044	2025-04-02 13:00:00	21.17
2376	QF 1,21	ЗУ	China 2	045	2025-04-02 13:00:00	19.09
2377	QF 1,22	ЗУ	China 3	046	2025-04-02 13:00:00	22.4
2378	QF 2,20	ЗУ	China 4	047	2025-04-02 13:00:00	25.59
2379	QF 2,21	ЗУ	China 5	048	2025-04-02 13:00:00	27.83
2380	QF 2,22	ЗУ	China 6	049	2025-04-02 13:00:00	26.08
2381	QF 2,23	ЗУ	China 7	050	2025-04-02 13:00:00	12.2
2382	QF 2,19	ЗУ	China 8	051	2025-04-02 13:00:00	22.7
2383	Q8	ЗУ	DIG	061	2025-04-02 13:00:00	30.58
2384	Q4	ЗУ	BG 1	062	2025-04-02 13:00:00	0
2385	Q9	ЗУ	BG 2	063	2025-04-02 13:00:00	0.6106
2386	Q10	ЗУ	SM 2	064	2025-04-02 13:00:00	32.3
2387	Q11	ЗУ	SM 3	065	2025-04-02 13:00:00	1.81
2388	Q12	ЗУ	SM 4	066	2025-04-02 13:00:00	1.92
2389	Q13	ЗУ	SM 5	067	2025-04-02 13:00:00	0
2390	Q14	ЗУ	SM 6	068	2025-04-02 13:00:00	0
2391	Q15	ЗУ	SM 7	069	2025-04-02 13:00:00	0
2392	Q16	ЗУ	SM 8	070	2025-04-02 13:00:00	0
2393	Q17	ЗУ	MO 9	071	2025-04-02 13:00:00	1.99
2394	Q20	ЗУ	MO 10	072	2025-04-02 13:00:00	0
2395	Q21	ЗУ	MO 11	073	2025-04-02 13:00:00	0
2396	Q22	ЗУ	MO 12	074	2025-04-02 13:00:00	0
2397	Q23	ЗУ	MO 13	075	2025-04-02 13:00:00	25.45
2398	Q24	ЗУ	MO 14	076	2025-04-02 13:00:00	0
2399	Q25	ЗУ	MO 15	077	2025-04-02 13:00:00	15.64
2400	TP3	ЗУ	CP-300 New	078	2025-04-02 13:00:00	24.5
2401	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 13:30:00	1.6
2402	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 13:30:00	1.28
2403	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 13:30:00	0.2767
2404	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 13:30:00	4.58
2405	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 13:30:00	19.81
2406	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 13:30:00	19.36
2407	QF 1,20	ЗУ	China 1	044	2025-04-02 13:30:00	21.21
2408	QF 1,21	ЗУ	China 2	045	2025-04-02 13:30:00	19.7
2409	QF 1,22	ЗУ	China 3	046	2025-04-02 13:30:00	22.92
2410	QF 2,20	ЗУ	China 4	047	2025-04-02 13:30:00	26.04
2411	QF 2,21	ЗУ	China 5	048	2025-04-02 13:30:00	28.47
2412	QF 2,22	ЗУ	China 6	049	2025-04-02 13:30:00	27.17
2413	QF 2,23	ЗУ	China 7	050	2025-04-02 13:30:00	12.63
2414	QF 2,19	ЗУ	China 8	051	2025-04-02 13:30:00	22.79
2415	Q8	ЗУ	DIG	061	2025-04-02 13:30:00	28.95
2416	Q4	ЗУ	BG 1	062	2025-04-02 13:30:00	0
2417	Q9	ЗУ	BG 2	063	2025-04-02 13:30:00	0.6116
2418	Q10	ЗУ	SM 2	064	2025-04-02 13:30:00	32.28
2419	Q11	ЗУ	SM 3	065	2025-04-02 13:30:00	1.81
2420	Q12	ЗУ	SM 4	066	2025-04-02 13:30:00	1.93
2421	Q13	ЗУ	SM 5	067	2025-04-02 13:30:00	0
2422	Q14	ЗУ	SM 6	068	2025-04-02 13:30:00	0
2423	Q15	ЗУ	SM 7	069	2025-04-02 13:30:00	0
2424	Q16	ЗУ	SM 8	070	2025-04-02 13:30:00	0
2425	Q17	ЗУ	MO 9	071	2025-04-02 13:30:00	1.99
2426	Q20	ЗУ	MO 10	072	2025-04-02 13:30:00	0
2427	Q21	ЗУ	MO 11	073	2025-04-02 13:30:00	0
2428	Q22	ЗУ	MO 12	074	2025-04-02 13:30:00	0
2429	Q23	ЗУ	MO 13	075	2025-04-02 13:30:00	25.47
2430	Q24	ЗУ	MO 14	076	2025-04-02 13:30:00	0
2431	Q25	ЗУ	MO 15	077	2025-04-02 13:30:00	15.67
2432	TP3	ЗУ	CP-300 New	078	2025-04-02 13:30:00	21.51
2433	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 14:00:00	5.85
2434	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 14:00:00	2.84
2435	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 14:00:00	2.08
2436	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 14:00:00	4.47
2437	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 14:00:00	19.58
2438	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 14:00:00	19.14
2439	QF 1,20	ЗУ	China 1	044	2025-04-02 14:00:00	21.05
2440	QF 1,21	ЗУ	China 2	045	2025-04-02 14:00:00	19.35
2441	QF 1,22	ЗУ	China 3	046	2025-04-02 14:00:00	22.68
2442	QF 2,20	ЗУ	China 4	047	2025-04-02 14:00:00	26.39
2443	QF 2,21	ЗУ	China 5	048	2025-04-02 14:00:00	29.1
2444	QF 2,22	ЗУ	China 6	049	2025-04-02 14:00:00	27.29
2445	QF 2,23	ЗУ	China 7	050	2025-04-02 14:00:00	12.85
2446	QF 2,19	ЗУ	China 8	051	2025-04-02 14:00:00	23.05
2447	Q8	ЗУ	DIG	061	2025-04-02 14:00:00	30.86
2448	Q4	ЗУ	BG 1	062	2025-04-02 14:00:00	0
2449	Q9	ЗУ	BG 2	063	2025-04-02 14:00:00	0.6068
2450	Q10	ЗУ	SM 2	064	2025-04-02 14:00:00	32.34
2451	Q11	ЗУ	SM 3	065	2025-04-02 14:00:00	1.81
2452	Q12	ЗУ	SM 4	066	2025-04-02 14:00:00	1.93
2453	Q13	ЗУ	SM 5	067	2025-04-02 14:00:00	0
2454	Q14	ЗУ	SM 6	068	2025-04-02 14:00:00	0
2455	Q15	ЗУ	SM 7	069	2025-04-02 14:00:00	0
2456	Q16	ЗУ	SM 8	070	2025-04-02 14:00:00	0
2457	Q17	ЗУ	MO 9	071	2025-04-02 14:00:00	1.98
2458	Q20	ЗУ	MO 10	072	2025-04-02 14:00:00	0
2459	Q21	ЗУ	MO 11	073	2025-04-02 14:00:00	0
2460	Q22	ЗУ	MO 12	074	2025-04-02 14:00:00	0
2461	Q23	ЗУ	MO 13	075	2025-04-02 14:00:00	25.46
2462	Q24	ЗУ	MO 14	076	2025-04-02 14:00:00	0
2463	Q25	ЗУ	MO 15	077	2025-04-02 14:00:00	15.67
2464	TP3	ЗУ	CP-300 New	078	2025-04-02 14:00:00	18.31
2465	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 14:30:00	17.11
2466	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 14:30:00	6.16
2467	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 14:30:00	9.43
2468	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 14:30:00	4.33
2469	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 14:30:00	19.69
2470	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 14:30:00	19.26
2471	QF 1,20	ЗУ	China 1	044	2025-04-02 14:30:00	19.23
2472	QF 1,21	ЗУ	China 2	045	2025-04-02 14:30:00	17.84
2473	QF 1,22	ЗУ	China 3	046	2025-04-02 14:30:00	20.73
2474	QF 2,20	ЗУ	China 4	047	2025-04-02 14:30:00	25.05
2475	QF 2,21	ЗУ	China 5	048	2025-04-02 14:30:00	27.58
2476	QF 2,22	ЗУ	China 6	049	2025-04-02 14:30:00	25.5
2477	QF 2,23	ЗУ	China 7	050	2025-04-02 14:30:00	11.77
2478	QF 2,19	ЗУ	China 8	051	2025-04-02 14:30:00	21.17
2479	Q8	ЗУ	DIG	061	2025-04-02 14:30:00	36.91
2480	Q4	ЗУ	BG 1	062	2025-04-02 14:30:00	0
2481	Q9	ЗУ	BG 2	063	2025-04-02 14:30:00	0.6026
2482	Q10	ЗУ	SM 2	064	2025-04-02 14:30:00	32.35
2483	Q11	ЗУ	SM 3	065	2025-04-02 14:30:00	1.81
2484	Q12	ЗУ	SM 4	066	2025-04-02 14:30:00	1.93
2485	Q13	ЗУ	SM 5	067	2025-04-02 14:30:00	0
2486	Q14	ЗУ	SM 6	068	2025-04-02 14:30:00	0
2487	Q15	ЗУ	SM 7	069	2025-04-02 14:30:00	0
2488	Q16	ЗУ	SM 8	070	2025-04-02 14:30:00	0
2489	Q17	ЗУ	MO 9	071	2025-04-02 14:30:00	1.98
2490	Q20	ЗУ	MO 10	072	2025-04-02 14:30:00	0
2491	Q21	ЗУ	MO 11	073	2025-04-02 14:30:00	0
2492	Q22	ЗУ	MO 12	074	2025-04-02 14:30:00	0
2493	Q23	ЗУ	MO 13	075	2025-04-02 14:30:00	25.47
2494	Q24	ЗУ	MO 14	076	2025-04-02 14:30:00	0
2495	Q25	ЗУ	MO 15	077	2025-04-02 14:30:00	15.7
2496	TP3	ЗУ	CP-300 New	078	2025-04-02 14:30:00	17.36
2497	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 15:00:00	19.09
2498	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 15:00:00	6.92
2499	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 15:00:00	10.48
2500	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 15:00:00	3.95
2501	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 15:00:00	17.22
2502	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 15:00:00	16.91
2503	QF 1,20	ЗУ	China 1	044	2025-04-02 15:00:00	17.26
2504	QF 1,21	ЗУ	China 2	045	2025-04-02 15:00:00	15.47
2505	QF 1,22	ЗУ	China 3	046	2025-04-02 15:00:00	18.09
2506	QF 2,20	ЗУ	China 4	047	2025-04-02 15:00:00	22.77
2507	QF 2,21	ЗУ	China 5	048	2025-04-02 15:00:00	25.57
2508	QF 2,22	ЗУ	China 6	049	2025-04-02 15:00:00	23.09
2509	QF 2,23	ЗУ	China 7	050	2025-04-02 15:00:00	10.64
2510	QF 2,19	ЗУ	China 8	051	2025-04-02 15:00:00	18.95
2511	Q8	ЗУ	DIG	061	2025-04-02 15:00:00	42.99
2512	Q4	ЗУ	BG 1	062	2025-04-02 15:00:00	0
2513	Q9	ЗУ	BG 2	063	2025-04-02 15:00:00	0.5994
2514	Q10	ЗУ	SM 2	064	2025-04-02 15:00:00	32.35
2515	Q11	ЗУ	SM 3	065	2025-04-02 15:00:00	1.83
2516	Q12	ЗУ	SM 4	066	2025-04-02 15:00:00	1.94
2517	Q13	ЗУ	SM 5	067	2025-04-02 15:00:00	0
2518	Q14	ЗУ	SM 6	068	2025-04-02 15:00:00	0
2519	Q15	ЗУ	SM 7	069	2025-04-02 15:00:00	0
2520	Q16	ЗУ	SM 8	070	2025-04-02 15:00:00	0
2521	Q17	ЗУ	MO 9	071	2025-04-02 15:00:00	1.94
2522	Q20	ЗУ	MO 10	072	2025-04-02 15:00:00	0
2523	Q21	ЗУ	MO 11	073	2025-04-02 15:00:00	0
2524	Q22	ЗУ	MO 12	074	2025-04-02 15:00:00	0
2525	Q23	ЗУ	MO 13	075	2025-04-02 15:00:00	25.5
2526	Q24	ЗУ	MO 14	076	2025-04-02 15:00:00	0
2527	Q25	ЗУ	MO 15	077	2025-04-02 15:00:00	15.72
2528	TP3	ЗУ	CP-300 New	078	2025-04-02 15:00:00	12.59
2529	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 15:30:00	27.97
2530	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 15:30:00	8.73
2531	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 15:30:00	17.96
2532	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 15:30:00	0.193
2533	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 15:30:00	0.1455
2534	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 15:30:00	0.1521
2535	QF 1,20	ЗУ	China 1	044	2025-04-02 15:30:00	15.64
2536	QF 1,21	ЗУ	China 2	045	2025-04-02 15:30:00	14.03
2537	QF 1,22	ЗУ	China 3	046	2025-04-02 15:30:00	16.36
2538	QF 2,20	ЗУ	China 4	047	2025-04-02 15:30:00	21.43
2539	QF 2,21	ЗУ	China 5	048	2025-04-02 15:30:00	24.04
2540	QF 2,22	ЗУ	China 6	049	2025-04-02 15:30:00	21.17
2541	QF 2,23	ЗУ	China 7	050	2025-04-02 15:30:00	9.88
2542	QF 2,19	ЗУ	China 8	051	2025-04-02 15:30:00	17.49
2543	Q8	ЗУ	DIG	061	2025-04-02 15:30:00	49.5
2544	Q4	ЗУ	BG 1	062	2025-04-02 15:30:00	0
2545	Q9	ЗУ	BG 2	063	2025-04-02 15:30:00	0.6061
2546	Q10	ЗУ	SM 2	064	2025-04-02 15:30:00	32.39
2547	Q11	ЗУ	SM 3	065	2025-04-02 15:30:00	1.85
2548	Q12	ЗУ	SM 4	066	2025-04-02 15:30:00	1.97
2549	Q13	ЗУ	SM 5	067	2025-04-02 15:30:00	0
2550	Q14	ЗУ	SM 6	068	2025-04-02 15:30:00	0
2551	Q15	ЗУ	SM 7	069	2025-04-02 15:30:00	0
2552	Q16	ЗУ	SM 8	070	2025-04-02 15:30:00	0
2553	Q17	ЗУ	MO 9	071	2025-04-02 15:30:00	1.86
2554	Q20	ЗУ	MO 10	072	2025-04-02 15:30:00	0
2555	Q21	ЗУ	MO 11	073	2025-04-02 15:30:00	0
2556	Q22	ЗУ	MO 12	074	2025-04-02 15:30:00	0
2557	Q23	ЗУ	MO 13	075	2025-04-02 15:30:00	25.56
2558	Q24	ЗУ	MO 14	076	2025-04-02 15:30:00	0
2559	Q25	ЗУ	MO 15	077	2025-04-02 15:30:00	15.76
2560	TP3	ЗУ	CP-300 New	078	2025-04-02 15:30:00	11.17
2561	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 16:00:00	29.34
2562	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 16:00:00	8.86
2563	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 16:00:00	19.08
12974	Q8	ЗУ	DIG	061	2026-05-09 21:01:54.27748	46.1824
2564	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 16:00:00	0.0036
2565	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 16:00:00	0
2566	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 16:00:00	0
2567	QF 1,20	ЗУ	China 1	044	2025-04-02 16:00:00	16.46
2568	QF 1,21	ЗУ	China 2	045	2025-04-02 16:00:00	14.91
2569	QF 1,22	ЗУ	China 3	046	2025-04-02 16:00:00	16.9
2570	QF 2,20	ЗУ	China 4	047	2025-04-02 16:00:00	22.65
2571	QF 2,21	ЗУ	China 5	048	2025-04-02 16:00:00	25.54
2572	QF 2,22	ЗУ	China 6	049	2025-04-02 16:00:00	22.74
2573	QF 2,23	ЗУ	China 7	050	2025-04-02 16:00:00	10.64
2574	QF 2,19	ЗУ	China 8	051	2025-04-02 16:00:00	18.46
2575	Q8	ЗУ	DIG	061	2025-04-02 16:00:00	50.79
2576	Q4	ЗУ	BG 1	062	2025-04-02 16:00:00	0
2577	Q9	ЗУ	BG 2	063	2025-04-02 16:00:00	0.6049
2578	Q10	ЗУ	SM 2	064	2025-04-02 16:00:00	32.35
2579	Q11	ЗУ	SM 3	065	2025-04-02 16:00:00	1.87
2580	Q12	ЗУ	SM 4	066	2025-04-02 16:00:00	1.99
2581	Q13	ЗУ	SM 5	067	2025-04-02 16:00:00	0
2582	Q14	ЗУ	SM 6	068	2025-04-02 16:00:00	0
2583	Q15	ЗУ	SM 7	069	2025-04-02 16:00:00	0
2584	Q16	ЗУ	SM 8	070	2025-04-02 16:00:00	0
2585	Q17	ЗУ	MO 9	071	2025-04-02 16:00:00	1.87
2586	Q20	ЗУ	MO 10	072	2025-04-02 16:00:00	0
2587	Q21	ЗУ	MO 11	073	2025-04-02 16:00:00	0
2588	Q22	ЗУ	MO 12	074	2025-04-02 16:00:00	0
2589	Q23	ЗУ	MO 13	075	2025-04-02 16:00:00	25.6
2590	Q24	ЗУ	MO 14	076	2025-04-02 16:00:00	0
2591	Q25	ЗУ	MO 15	077	2025-04-02 16:00:00	15.76
2592	TP3	ЗУ	CP-300 New	078	2025-04-02 16:00:00	10.19
2593	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 16:30:00	29.37
2594	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 16:30:00	8.65
2595	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 16:30:00	19.54
2596	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 16:30:00	0.0016
2597	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 16:30:00	0
2598	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 16:30:00	0
2599	QF 1,20	ЗУ	China 1	044	2025-04-02 16:30:00	13.19
2600	QF 1,21	ЗУ	China 2	045	2025-04-02 16:30:00	12.53
2601	QF 1,22	ЗУ	China 3	046	2025-04-02 16:30:00	14.74
2602	QF 2,20	ЗУ	China 4	047	2025-04-02 16:30:00	20.75
2603	QF 2,21	ЗУ	China 5	048	2025-04-02 16:30:00	23
2604	QF 2,22	ЗУ	China 6	049	2025-04-02 16:30:00	20.59
2605	QF 2,23	ЗУ	China 7	050	2025-04-02 16:30:00	9.78
2606	QF 2,19	ЗУ	China 8	051	2025-04-02 16:30:00	16.48
2607	Q8	ЗУ	DIG	061	2025-04-02 16:30:00	54.17
2608	Q4	ЗУ	BG 1	062	2025-04-02 16:30:00	0
2609	Q9	ЗУ	BG 2	063	2025-04-02 16:30:00	0.6078
2610	Q10	ЗУ	SM 2	064	2025-04-02 16:30:00	32.52
2611	Q11	ЗУ	SM 3	065	2025-04-02 16:30:00	1.9
2612	Q12	ЗУ	SM 4	066	2025-04-02 16:30:00	2.03
2613	Q13	ЗУ	SM 5	067	2025-04-02 16:30:00	0
2614	Q14	ЗУ	SM 6	068	2025-04-02 16:30:00	0
2615	Q15	ЗУ	SM 7	069	2025-04-02 16:30:00	0
2616	Q16	ЗУ	SM 8	070	2025-04-02 16:30:00	0
2617	Q17	ЗУ	MO 9	071	2025-04-02 16:30:00	1.87
2618	Q20	ЗУ	MO 10	072	2025-04-02 16:30:00	0
2619	Q21	ЗУ	MO 11	073	2025-04-02 16:30:00	0
2620	Q22	ЗУ	MO 12	074	2025-04-02 16:30:00	0
2621	Q23	ЗУ	MO 13	075	2025-04-02 16:30:00	25.66
2622	Q24	ЗУ	MO 14	076	2025-04-02 16:30:00	0
2623	Q25	ЗУ	MO 15	077	2025-04-02 16:30:00	15.89
2624	TP3	ЗУ	CP-300 New	078	2025-04-02 16:30:00	9.68
2625	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 17:00:00	29.33
2626	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 17:00:00	7.94
2627	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 17:00:00	20.06
2628	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 17:00:00	0.0028
2629	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 17:00:00	0
2630	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 17:00:00	0
2631	QF 1,20	ЗУ	China 1	044	2025-04-02 17:00:00	10.36
2632	QF 1,21	ЗУ	China 2	045	2025-04-02 17:00:00	9.66
2633	QF 1,22	ЗУ	China 3	046	2025-04-02 17:00:00	12.55
2634	QF 2,20	ЗУ	China 4	047	2025-04-02 17:00:00	18.6
2635	QF 2,21	ЗУ	China 5	048	2025-04-02 17:00:00	21.3
2636	QF 2,22	ЗУ	China 6	049	2025-04-02 17:00:00	17.63
2637	QF 2,23	ЗУ	China 7	050	2025-04-02 17:00:00	8.82
2638	QF 2,19	ЗУ	China 8	051	2025-04-02 17:00:00	14.13
2639	Q8	ЗУ	DIG	061	2025-04-02 17:00:00	54.81
2640	Q4	ЗУ	BG 1	062	2025-04-02 17:00:00	0
2641	Q9	ЗУ	BG 2	063	2025-04-02 17:00:00	0.4787
2642	Q10	ЗУ	SM 2	064	2025-04-02 17:00:00	32.46
2643	Q11	ЗУ	SM 3	065	2025-04-02 17:00:00	1.91
2644	Q12	ЗУ	SM 4	066	2025-04-02 17:00:00	2.04
2645	Q13	ЗУ	SM 5	067	2025-04-02 17:00:00	0
2646	Q14	ЗУ	SM 6	068	2025-04-02 17:00:00	0
2647	Q15	ЗУ	SM 7	069	2025-04-02 17:00:00	0
2648	Q16	ЗУ	SM 8	070	2025-04-02 17:00:00	0
2649	Q17	ЗУ	MO 9	071	2025-04-02 17:00:00	1.88
2650	Q20	ЗУ	MO 10	072	2025-04-02 17:00:00	0
2651	Q21	ЗУ	MO 11	073	2025-04-02 17:00:00	0
2652	Q22	ЗУ	MO 12	074	2025-04-02 17:00:00	0
2653	Q23	ЗУ	MO 13	075	2025-04-02 17:00:00	25.7
2654	Q24	ЗУ	MO 14	076	2025-04-02 17:00:00	0
2655	Q25	ЗУ	MO 15	077	2025-04-02 17:00:00	15.87
2656	TP3	ЗУ	CP-300 New	078	2025-04-02 17:00:00	9.28
2657	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 17:30:00	23.11
2658	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 17:30:00	4.56
2659	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 17:30:00	17
2660	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 17:30:00	0.0035
2661	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 17:30:00	0
2662	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 17:30:00	0
2663	QF 1,20	ЗУ	China 1	044	2025-04-02 17:30:00	9.19
2664	QF 1,21	ЗУ	China 2	045	2025-04-02 17:30:00	8.23
2665	QF 1,22	ЗУ	China 3	046	2025-04-02 17:30:00	10.86
2666	QF 2,20	ЗУ	China 4	047	2025-04-02 17:30:00	17.1
2667	QF 2,21	ЗУ	China 5	048	2025-04-02 17:30:00	18.78
2668	QF 2,22	ЗУ	China 6	049	2025-04-02 17:30:00	16.38
2669	QF 2,23	ЗУ	China 7	050	2025-04-02 17:30:00	8.15
2670	QF 2,19	ЗУ	China 8	051	2025-04-02 17:30:00	12.72
2671	Q8	ЗУ	DIG	061	2025-04-02 17:30:00	56.6
2672	Q4	ЗУ	BG 1	062	2025-04-02 17:30:00	0
2673	Q9	ЗУ	BG 2	063	2025-04-02 17:30:00	1.57
2674	Q10	ЗУ	SM 2	064	2025-04-02 17:30:00	32.44
2675	Q11	ЗУ	SM 3	065	2025-04-02 17:30:00	1.93
2676	Q12	ЗУ	SM 4	066	2025-04-02 17:30:00	2.05
2677	Q13	ЗУ	SM 5	067	2025-04-02 17:30:00	0
2678	Q14	ЗУ	SM 6	068	2025-04-02 17:30:00	0
2679	Q15	ЗУ	SM 7	069	2025-04-02 17:30:00	0
2680	Q16	ЗУ	SM 8	070	2025-04-02 17:30:00	0
2681	Q17	ЗУ	MO 9	071	2025-04-02 17:30:00	1.88
2682	Q20	ЗУ	MO 10	072	2025-04-02 17:30:00	0
2683	Q21	ЗУ	MO 11	073	2025-04-02 17:30:00	0
2684	Q22	ЗУ	MO 12	074	2025-04-02 17:30:00	0
2685	Q23	ЗУ	MO 13	075	2025-04-02 17:30:00	25.7
2686	Q24	ЗУ	MO 14	076	2025-04-02 17:30:00	0
2687	Q25	ЗУ	MO 15	077	2025-04-02 17:30:00	15.86
2688	TP3	ЗУ	CP-300 New	078	2025-04-02 17:30:00	8.96
2689	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 18:00:00	27.79
2690	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 18:00:00	3.56
2691	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 18:00:00	22.11
2692	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 18:00:00	0.0038
2693	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 18:00:00	0
2694	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 18:00:00	0
2695	QF 1,20	ЗУ	China 1	044	2025-04-02 18:00:00	10.71
2696	QF 1,21	ЗУ	China 2	045	2025-04-02 18:00:00	9.61
2697	QF 1,22	ЗУ	China 3	046	2025-04-02 18:00:00	12.2
2698	QF 2,20	ЗУ	China 4	047	2025-04-02 18:00:00	18.81
2699	QF 2,21	ЗУ	China 5	048	2025-04-02 18:00:00	21.01
2700	QF 2,22	ЗУ	China 6	049	2025-04-02 18:00:00	18.21
2701	QF 2,23	ЗУ	China 7	050	2025-04-02 18:00:00	9.38
2702	QF 2,19	ЗУ	China 8	051	2025-04-02 18:00:00	13.77
2703	Q8	ЗУ	DIG	061	2025-04-02 18:00:00	58.24
2704	Q4	ЗУ	BG 1	062	2025-04-02 18:00:00	0
2705	Q9	ЗУ	BG 2	063	2025-04-02 18:00:00	10.6
2706	Q10	ЗУ	SM 2	064	2025-04-02 18:00:00	32.42
2707	Q11	ЗУ	SM 3	065	2025-04-02 18:00:00	2.05
2708	Q12	ЗУ	SM 4	066	2025-04-02 18:00:00	2.1
2709	Q13	ЗУ	SM 5	067	2025-04-02 18:00:00	0
2710	Q14	ЗУ	SM 6	068	2025-04-02 18:00:00	0
2711	Q15	ЗУ	SM 7	069	2025-04-02 18:00:00	0
2712	Q16	ЗУ	SM 8	070	2025-04-02 18:00:00	0
2713	Q17	ЗУ	MO 9	071	2025-04-02 18:00:00	1.88
2714	Q20	ЗУ	MO 10	072	2025-04-02 18:00:00	0
2715	Q21	ЗУ	MO 11	073	2025-04-02 18:00:00	0
2716	Q22	ЗУ	MO 12	074	2025-04-02 18:00:00	0
2717	Q23	ЗУ	MO 13	075	2025-04-02 18:00:00	25.7
2718	Q24	ЗУ	MO 14	076	2025-04-02 18:00:00	0
2719	Q25	ЗУ	MO 15	077	2025-04-02 18:00:00	15.86
2720	TP3	ЗУ	CP-300 New	078	2025-04-02 18:00:00	8.56
2721	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 18:30:00	27.34
2722	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 18:30:00	3.06
2723	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 18:30:00	21.74
2724	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 18:30:00	0.0035
2725	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 18:30:00	0
2726	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 18:30:00	0
2727	QF 1,20	ЗУ	China 1	044	2025-04-02 18:30:00	12.69
2728	QF 1,21	ЗУ	China 2	045	2025-04-02 18:30:00	11.06
2729	QF 1,22	ЗУ	China 3	046	2025-04-02 18:30:00	14.17
2730	QF 2,20	ЗУ	China 4	047	2025-04-02 18:30:00	20.78
2731	QF 2,21	ЗУ	China 5	048	2025-04-02 18:30:00	23.16
2732	QF 2,22	ЗУ	China 6	049	2025-04-02 18:30:00	20.54
2733	QF 2,23	ЗУ	China 7	050	2025-04-02 18:30:00	10.5
2734	QF 2,19	ЗУ	China 8	051	2025-04-02 18:30:00	15.72
2735	Q8	ЗУ	DIG	061	2025-04-02 18:30:00	50.86
2736	Q4	ЗУ	BG 1	062	2025-04-02 18:30:00	0
2737	Q9	ЗУ	BG 2	063	2025-04-02 18:30:00	10.56
2738	Q10	ЗУ	SM 2	064	2025-04-02 18:30:00	32.39
2739	Q11	ЗУ	SM 3	065	2025-04-02 18:30:00	5.04
2740	Q12	ЗУ	SM 4	066	2025-04-02 18:30:00	2.1
2741	Q13	ЗУ	SM 5	067	2025-04-02 18:30:00	0
2742	Q14	ЗУ	SM 6	068	2025-04-02 18:30:00	0
2743	Q15	ЗУ	SM 7	069	2025-04-02 18:30:00	0
2744	Q16	ЗУ	SM 8	070	2025-04-02 18:30:00	0
2745	Q17	ЗУ	MO 9	071	2025-04-02 18:30:00	1.88
2746	Q20	ЗУ	MO 10	072	2025-04-02 18:30:00	0
2747	Q21	ЗУ	MO 11	073	2025-04-02 18:30:00	0
2748	Q22	ЗУ	MO 12	074	2025-04-02 18:30:00	0
2749	Q23	ЗУ	MO 13	075	2025-04-02 18:30:00	25.7
2750	Q24	ЗУ	MO 14	076	2025-04-02 18:30:00	0
2751	Q25	ЗУ	MO 15	077	2025-04-02 18:30:00	15.86
2752	TP3	ЗУ	CP-300 New	078	2025-04-02 18:30:00	9.01
2753	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 19:00:00	26.05
2754	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 19:00:00	2.85
2755	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 19:00:00	18.71
2756	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 19:00:00	0.0033
2757	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 19:00:00	0
2758	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 19:00:00	0
2759	QF 1,20	ЗУ	China 1	044	2025-04-02 19:00:00	10.6
2760	QF 1,21	ЗУ	China 2	045	2025-04-02 19:00:00	9.14
2761	QF 1,22	ЗУ	China 3	046	2025-04-02 19:00:00	12.36
2762	QF 2,20	ЗУ	China 4	047	2025-04-02 19:00:00	18.31
2763	QF 2,21	ЗУ	China 5	048	2025-04-02 19:00:00	20.53
2764	QF 2,22	ЗУ	China 6	049	2025-04-02 19:00:00	18.01
2765	QF 2,23	ЗУ	China 7	050	2025-04-02 19:00:00	9.38
2766	QF 2,19	ЗУ	China 8	051	2025-04-02 19:00:00	13.74
2767	Q8	ЗУ	DIG	061	2025-04-02 19:00:00	54.01
12999	Q8	ЗУ	DIG	061	2026-05-09 21:02:29.326471	47.7133
2768	Q4	ЗУ	BG 1	062	2025-04-02 19:00:00	0
2769	Q9	ЗУ	BG 2	063	2025-04-02 19:00:00	10.55
2770	Q10	ЗУ	SM 2	064	2025-04-02 19:00:00	32.33
2771	Q11	ЗУ	SM 3	065	2025-04-02 19:00:00	10.32
2772	Q12	ЗУ	SM 4	066	2025-04-02 19:00:00	2.06
2773	Q13	ЗУ	SM 5	067	2025-04-02 19:00:00	0
2774	Q14	ЗУ	SM 6	068	2025-04-02 19:00:00	0
2775	Q15	ЗУ	SM 7	069	2025-04-02 19:00:00	0
2776	Q16	ЗУ	SM 8	070	2025-04-02 19:00:00	0
2777	Q17	ЗУ	MO 9	071	2025-04-02 19:00:00	1.86
2778	Q20	ЗУ	MO 10	072	2025-04-02 19:00:00	0
2779	Q21	ЗУ	MO 11	073	2025-04-02 19:00:00	0
2780	Q22	ЗУ	MO 12	074	2025-04-02 19:00:00	0
2781	Q23	ЗУ	MO 13	075	2025-04-02 19:00:00	25.65
2782	Q24	ЗУ	MO 14	076	2025-04-02 19:00:00	0
2783	Q25	ЗУ	MO 15	077	2025-04-02 19:00:00	15.81
2784	TP3	ЗУ	CP-300 New	078	2025-04-02 19:00:00	9.01
2785	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 19:30:00	21.2
2786	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 19:30:00	3.15
2787	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 19:30:00	16.92
2788	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 19:30:00	0.0034
2789	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 19:30:00	0
2790	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 19:30:00	0
2791	QF 1,20	ЗУ	China 1	044	2025-04-02 19:30:00	10.5
2792	QF 1,21	ЗУ	China 2	045	2025-04-02 19:30:00	9.17
2793	QF 1,22	ЗУ	China 3	046	2025-04-02 19:30:00	12.49
2794	QF 2,20	ЗУ	China 4	047	2025-04-02 19:30:00	17.55
2795	QF 2,21	ЗУ	China 5	048	2025-04-02 19:30:00	20.67
2796	QF 2,22	ЗУ	China 6	049	2025-04-02 19:30:00	17.82
2797	QF 2,23	ЗУ	China 7	050	2025-04-02 19:30:00	9.26
2798	QF 2,19	ЗУ	China 8	051	2025-04-02 19:30:00	13.53
2799	Q8	ЗУ	DIG	061	2025-04-02 19:30:00	60.44
2800	Q4	ЗУ	BG 1	062	2025-04-02 19:30:00	0
2801	Q9	ЗУ	BG 2	063	2025-04-02 19:30:00	10.55
2802	Q10	ЗУ	SM 2	064	2025-04-02 19:30:00	32.35
2803	Q11	ЗУ	SM 3	065	2025-04-02 19:30:00	10.24
2804	Q12	ЗУ	SM 4	066	2025-04-02 19:30:00	7.13
2805	Q13	ЗУ	SM 5	067	2025-04-02 19:30:00	0
2806	Q14	ЗУ	SM 6	068	2025-04-02 19:30:00	0
2807	Q15	ЗУ	SM 7	069	2025-04-02 19:30:00	0
2808	Q16	ЗУ	SM 8	070	2025-04-02 19:30:00	0
2809	Q17	ЗУ	MO 9	071	2025-04-02 19:30:00	1.87
2810	Q20	ЗУ	MO 10	072	2025-04-02 19:30:00	0
2811	Q21	ЗУ	MO 11	073	2025-04-02 19:30:00	0
2812	Q22	ЗУ	MO 12	074	2025-04-02 19:30:00	0
2813	Q23	ЗУ	MO 13	075	2025-04-02 19:30:00	25.64
2814	Q24	ЗУ	MO 14	076	2025-04-02 19:30:00	0
2815	Q25	ЗУ	MO 15	077	2025-04-02 19:30:00	15.81
2816	TP3	ЗУ	CP-300 New	078	2025-04-02 19:30:00	8.99
2817	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 20:00:00	18.27
2818	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 20:00:00	3.48
2819	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 20:00:00	12.86
2820	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 20:00:00	0.0038
2821	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 20:00:00	0
2822	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 20:00:00	0
2823	QF 1,20	ЗУ	China 1	044	2025-04-02 20:00:00	10.66
2824	QF 1,21	ЗУ	China 2	045	2025-04-02 20:00:00	9.58
2825	QF 1,22	ЗУ	China 3	046	2025-04-02 20:00:00	13.08
2826	QF 2,20	ЗУ	China 4	047	2025-04-02 20:00:00	17.3
2827	QF 2,21	ЗУ	China 5	048	2025-04-02 20:00:00	20.49
2828	QF 2,22	ЗУ	China 6	049	2025-04-02 20:00:00	18.06
2829	QF 2,23	ЗУ	China 7	050	2025-04-02 20:00:00	9.41
2830	QF 2,19	ЗУ	China 8	051	2025-04-02 20:00:00	13.6
2831	Q8	ЗУ	DIG	061	2025-04-02 20:00:00	59.94
2832	Q4	ЗУ	BG 1	062	2025-04-02 20:00:00	0
2833	Q9	ЗУ	BG 2	063	2025-04-02 20:00:00	10.51
2834	Q10	ЗУ	SM 2	064	2025-04-02 20:00:00	32.36
2835	Q11	ЗУ	SM 3	065	2025-04-02 20:00:00	10.19
2836	Q12	ЗУ	SM 4	066	2025-04-02 20:00:00	11.49
2837	Q13	ЗУ	SM 5	067	2025-04-02 20:00:00	0
2838	Q14	ЗУ	SM 6	068	2025-04-02 20:00:00	0
2839	Q15	ЗУ	SM 7	069	2025-04-02 20:00:00	0
2840	Q16	ЗУ	SM 8	070	2025-04-02 20:00:00	0
2841	Q17	ЗУ	MO 9	071	2025-04-02 20:00:00	1.88
2842	Q20	ЗУ	MO 10	072	2025-04-02 20:00:00	0
2843	Q21	ЗУ	MO 11	073	2025-04-02 20:00:00	0
2844	Q22	ЗУ	MO 12	074	2025-04-02 20:00:00	0
2845	Q23	ЗУ	MO 13	075	2025-04-02 20:00:00	25.63
2846	Q24	ЗУ	MO 14	076	2025-04-02 20:00:00	0
2847	Q25	ЗУ	MO 15	077	2025-04-02 20:00:00	15.81
2848	TP3	ЗУ	CP-300 New	078	2025-04-02 20:00:00	8.97
2849	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 20:30:00	18.25
2850	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 20:30:00	3.43
2851	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 20:30:00	12.85
2852	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 20:30:00	0.0032
2853	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 20:30:00	0
2854	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 20:30:00	0
2855	QF 1,20	ЗУ	China 1	044	2025-04-02 20:30:00	10.74
2856	QF 1,21	ЗУ	China 2	045	2025-04-02 20:30:00	9.74
2857	QF 1,22	ЗУ	China 3	046	2025-04-02 20:30:00	13.24
2858	QF 2,20	ЗУ	China 4	047	2025-04-02 20:30:00	17.18
2859	QF 2,21	ЗУ	China 5	048	2025-04-02 20:30:00	20.39
2860	QF 2,22	ЗУ	China 6	049	2025-04-02 20:30:00	17.61
2861	QF 2,23	ЗУ	China 7	050	2025-04-02 20:30:00	9.32
2862	QF 2,19	ЗУ	China 8	051	2025-04-02 20:30:00	14.16
2863	Q8	ЗУ	DIG	061	2025-04-02 20:30:00	59.53
2864	Q4	ЗУ	BG 1	062	2025-04-02 20:30:00	0
2865	Q9	ЗУ	BG 2	063	2025-04-02 20:30:00	10.57
2866	Q10	ЗУ	SM 2	064	2025-04-02 20:30:00	32.34
2867	Q11	ЗУ	SM 3	065	2025-04-02 20:30:00	10.17
2868	Q12	ЗУ	SM 4	066	2025-04-02 20:30:00	11.48
2869	Q13	ЗУ	SM 5	067	2025-04-02 20:30:00	0
2870	Q14	ЗУ	SM 6	068	2025-04-02 20:30:00	0
2871	Q15	ЗУ	SM 7	069	2025-04-02 20:30:00	0
2872	Q16	ЗУ	SM 8	070	2025-04-02 20:30:00	0
2873	Q17	ЗУ	MO 9	071	2025-04-02 20:30:00	1.88
2874	Q20	ЗУ	MO 10	072	2025-04-02 20:30:00	0
2875	Q21	ЗУ	MO 11	073	2025-04-02 20:30:00	0
2876	Q22	ЗУ	MO 12	074	2025-04-02 20:30:00	0
2877	Q23	ЗУ	MO 13	075	2025-04-02 20:30:00	25.61
2878	Q24	ЗУ	MO 14	076	2025-04-02 20:30:00	0
2879	Q25	ЗУ	MO 15	077	2025-04-02 20:30:00	15.81
2880	TP3	ЗУ	CP-300 New	078	2025-04-02 20:30:00	7.88
2881	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 21:00:00	18.16
2882	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 21:00:00	3.35
2883	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 21:00:00	12.84
2884	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 21:00:00	0.0025
2885	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 21:00:00	0
2886	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 21:00:00	0
2887	QF 1,20	ЗУ	China 1	044	2025-04-02 21:00:00	11.03
2888	QF 1,21	ЗУ	China 2	045	2025-04-02 21:00:00	10.17
2889	QF 1,22	ЗУ	China 3	046	2025-04-02 21:00:00	13.74
2890	QF 2,20	ЗУ	China 4	047	2025-04-02 21:00:00	17.97
2891	QF 2,21	ЗУ	China 5	048	2025-04-02 21:00:00	21.33
2892	QF 2,22	ЗУ	China 6	049	2025-04-02 21:00:00	18.71
2893	QF 2,23	ЗУ	China 7	050	2025-04-02 21:00:00	9.5
2894	QF 2,19	ЗУ	China 8	051	2025-04-02 21:00:00	14.48
2895	Q8	ЗУ	DIG	061	2025-04-02 21:00:00	58.87
2896	Q4	ЗУ	BG 1	062	2025-04-02 21:00:00	0
2897	Q9	ЗУ	BG 2	063	2025-04-02 21:00:00	10.59
2898	Q10	ЗУ	SM 2	064	2025-04-02 21:00:00	32.32
2899	Q11	ЗУ	SM 3	065	2025-04-02 21:00:00	10.17
2900	Q12	ЗУ	SM 4	066	2025-04-02 21:00:00	11.45
2901	Q13	ЗУ	SM 5	067	2025-04-02 21:00:00	0
2902	Q14	ЗУ	SM 6	068	2025-04-02 21:00:00	0
2903	Q15	ЗУ	SM 7	069	2025-04-02 21:00:00	0
2904	Q16	ЗУ	SM 8	070	2025-04-02 21:00:00	0
2905	Q17	ЗУ	MO 9	071	2025-04-02 21:00:00	1.87
2906	Q20	ЗУ	MO 10	072	2025-04-02 21:00:00	0
2907	Q21	ЗУ	MO 11	073	2025-04-02 21:00:00	0
2908	Q22	ЗУ	MO 12	074	2025-04-02 21:00:00	0
2909	Q23	ЗУ	MO 13	075	2025-04-02 21:00:00	25.59
2910	Q24	ЗУ	MO 14	076	2025-04-02 21:00:00	0
2911	Q25	ЗУ	MO 15	077	2025-04-02 21:00:00	15.76
2912	TP3	ЗУ	CP-300 New	078	2025-04-02 21:00:00	7.99
2913	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 21:30:00	18.22
2914	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 21:30:00	3.41
2915	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 21:30:00	12.87
2916	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 21:30:00	0.0027
2917	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 21:30:00	0
2918	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 21:30:00	0
2919	QF 1,20	ЗУ	China 1	044	2025-04-02 21:30:00	12.88
2920	QF 1,21	ЗУ	China 2	045	2025-04-02 21:30:00	11.97
2921	QF 1,22	ЗУ	China 3	046	2025-04-02 21:30:00	15.36
2922	QF 2,20	ЗУ	China 4	047	2025-04-02 21:30:00	19.45
2923	QF 2,21	ЗУ	China 5	048	2025-04-02 21:30:00	22.76
2924	QF 2,22	ЗУ	China 6	049	2025-04-02 21:30:00	20.56
2925	QF 2,23	ЗУ	China 7	050	2025-04-02 21:30:00	10.21
2926	QF 2,19	ЗУ	China 8	051	2025-04-02 21:30:00	16.03
2927	Q8	ЗУ	DIG	061	2025-04-02 21:30:00	57.12
2928	Q4	ЗУ	BG 1	062	2025-04-02 21:30:00	0
2929	Q9	ЗУ	BG 2	063	2025-04-02 21:30:00	10.59
2930	Q10	ЗУ	SM 2	064	2025-04-02 21:30:00	32.33
2931	Q11	ЗУ	SM 3	065	2025-04-02 21:30:00	10.09
2932	Q12	ЗУ	SM 4	066	2025-04-02 21:30:00	11.51
2933	Q13	ЗУ	SM 5	067	2025-04-02 21:30:00	0
2934	Q14	ЗУ	SM 6	068	2025-04-02 21:30:00	0
2935	Q15	ЗУ	SM 7	069	2025-04-02 21:30:00	0
2936	Q16	ЗУ	SM 8	070	2025-04-02 21:30:00	0
2937	Q17	ЗУ	MO 9	071	2025-04-02 21:30:00	1.87
2938	Q20	ЗУ	MO 10	072	2025-04-02 21:30:00	0
2939	Q21	ЗУ	MO 11	073	2025-04-02 21:30:00	1.52
2940	Q22	ЗУ	MO 12	074	2025-04-02 21:30:00	0
2941	Q23	ЗУ	MO 13	075	2025-04-02 21:30:00	25.65
2942	Q24	ЗУ	MO 14	076	2025-04-02 21:30:00	0
2943	Q25	ЗУ	MO 15	077	2025-04-02 21:30:00	15.83
2944	TP3	ЗУ	CP-300 New	078	2025-04-02 21:30:00	7.8
2945	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 22:00:00	18.3
2946	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 22:00:00	3.42
2947	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 22:00:00	12.89
2948	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 22:00:00	0.0027
2949	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 22:00:00	0
2950	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 22:00:00	0
2951	QF 1,20	ЗУ	China 1	044	2025-04-02 22:00:00	13.71
2952	QF 1,21	ЗУ	China 2	045	2025-04-02 22:00:00	12.19
2953	QF 1,22	ЗУ	China 3	046	2025-04-02 22:00:00	15.66
2954	QF 2,20	ЗУ	China 4	047	2025-04-02 22:00:00	19.52
2955	QF 2,21	ЗУ	China 5	048	2025-04-02 22:00:00	23.03
2956	QF 2,22	ЗУ	China 6	049	2025-04-02 22:00:00	20.93
2957	QF 2,23	ЗУ	China 7	050	2025-04-02 22:00:00	10.14
2958	QF 2,19	ЗУ	China 8	051	2025-04-02 22:00:00	16.03
2959	Q8	ЗУ	DIG	061	2025-04-02 22:00:00	45.15
2960	Q4	ЗУ	BG 1	062	2025-04-02 22:00:00	0
2961	Q9	ЗУ	BG 2	063	2025-04-02 22:00:00	10.61
2962	Q10	ЗУ	SM 2	064	2025-04-02 22:00:00	32.33
2963	Q11	ЗУ	SM 3	065	2025-04-02 22:00:00	10.13
2964	Q12	ЗУ	SM 4	066	2025-04-02 22:00:00	11.32
2965	Q13	ЗУ	SM 5	067	2025-04-02 22:00:00	0
2966	Q14	ЗУ	SM 6	068	2025-04-02 22:00:00	0
2967	Q15	ЗУ	SM 7	069	2025-04-02 22:00:00	0
2968	Q16	ЗУ	SM 8	070	2025-04-02 22:00:00	0
2969	Q17	ЗУ	MO 9	071	2025-04-02 22:00:00	1.86
2970	Q20	ЗУ	MO 10	072	2025-04-02 22:00:00	0
2971	Q21	ЗУ	MO 11	073	2025-04-02 22:00:00	7.04
2972	Q22	ЗУ	MO 12	074	2025-04-02 22:00:00	0
2973	Q23	ЗУ	MO 13	075	2025-04-02 22:00:00	25.65
2974	Q24	ЗУ	MO 14	076	2025-04-02 22:00:00	0
2975	Q25	ЗУ	MO 15	077	2025-04-02 22:00:00	15.83
2976	TP3	ЗУ	CP-300 New	078	2025-04-02 22:00:00	7.02
2977	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 22:30:00	18.37
2978	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 22:30:00	3.56
2979	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 22:30:00	12.91
2980	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 22:30:00	0.0027
2981	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 22:30:00	0
2982	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 22:30:00	0
2983	QF 1,20	ЗУ	China 1	044	2025-04-02 22:30:00	13.46
2984	QF 1,21	ЗУ	China 2	045	2025-04-02 22:30:00	11.64
2985	QF 1,22	ЗУ	China 3	046	2025-04-02 22:30:00	15.48
2986	QF 2,20	ЗУ	China 4	047	2025-04-02 22:30:00	18.84
2987	QF 2,21	ЗУ	China 5	048	2025-04-02 22:30:00	22.37
2988	QF 2,22	ЗУ	China 6	049	2025-04-02 22:30:00	19.97
2989	QF 2,23	ЗУ	China 7	050	2025-04-02 22:30:00	9.73
2990	QF 2,19	ЗУ	China 8	051	2025-04-02 22:30:00	15.27
2991	Q8	ЗУ	DIG	061	2025-04-02 22:30:00	51.18
2992	Q4	ЗУ	BG 1	062	2025-04-02 22:30:00	0
2993	Q9	ЗУ	BG 2	063	2025-04-02 22:30:00	11.73
2994	Q10	ЗУ	SM 2	064	2025-04-02 22:30:00	32.4
2995	Q11	ЗУ	SM 3	065	2025-04-02 22:30:00	10.15
2996	Q12	ЗУ	SM 4	066	2025-04-02 22:30:00	11.32
2997	Q13	ЗУ	SM 5	067	2025-04-02 22:30:00	0
2998	Q14	ЗУ	SM 6	068	2025-04-02 22:30:00	0
2999	Q15	ЗУ	SM 7	069	2025-04-02 22:30:00	0
3000	Q16	ЗУ	SM 8	070	2025-04-02 22:30:00	0
3001	Q17	ЗУ	MO 9	071	2025-04-02 22:30:00	1.87
3002	Q20	ЗУ	MO 10	072	2025-04-02 22:30:00	0
3003	Q21	ЗУ	MO 11	073	2025-04-02 22:30:00	7.03
3004	Q22	ЗУ	MO 12	074	2025-04-02 22:30:00	0
3005	Q23	ЗУ	MO 13	075	2025-04-02 22:30:00	25.69
3006	Q24	ЗУ	MO 14	076	2025-04-02 22:30:00	0
3007	Q25	ЗУ	MO 15	077	2025-04-02 22:30:00	15.85
3008	TP3	ЗУ	CP-300 New	078	2025-04-02 22:30:00	7.37
3009	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 23:00:00	6.66
3010	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 23:00:00	1.55
3011	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 23:00:00	4.38
3012	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 23:00:00	1.34
3013	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 23:00:00	0.9964
3014	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 23:00:00	1.1
3015	QF 1,20	ЗУ	China 1	044	2025-04-02 23:00:00	14.01
3016	QF 1,21	ЗУ	China 2	045	2025-04-02 23:00:00	11.97
3017	QF 1,22	ЗУ	China 3	046	2025-04-02 23:00:00	15.61
3018	QF 2,20	ЗУ	China 4	047	2025-04-02 23:00:00	19.31
3019	QF 2,21	ЗУ	China 5	048	2025-04-02 23:00:00	22.7
3020	QF 2,22	ЗУ	China 6	049	2025-04-02 23:00:00	21
3021	QF 2,23	ЗУ	China 7	050	2025-04-02 23:00:00	10.2
3022	QF 2,19	ЗУ	China 8	051	2025-04-02 23:00:00	15.68
3023	Q8	ЗУ	DIG	061	2025-04-02 23:00:00	50.86
3024	Q4	ЗУ	BG 1	062	2025-04-02 23:00:00	0
3025	Q9	ЗУ	BG 2	063	2025-04-02 23:00:00	20.18
3026	Q10	ЗУ	SM 2	064	2025-04-02 23:00:00	32.37
3027	Q11	ЗУ	SM 3	065	2025-04-02 23:00:00	10.18
3028	Q12	ЗУ	SM 4	066	2025-04-02 23:00:00	11.33
3029	Q13	ЗУ	SM 5	067	2025-04-02 23:00:00	0
3030	Q14	ЗУ	SM 6	068	2025-04-02 23:00:00	0
3031	Q15	ЗУ	SM 7	069	2025-04-02 23:00:00	0
3032	Q16	ЗУ	SM 8	070	2025-04-02 23:00:00	0
3033	Q17	ЗУ	MO 9	071	2025-04-02 23:00:00	1.89
3034	Q20	ЗУ	MO 10	072	2025-04-02 23:00:00	0
3035	Q21	ЗУ	MO 11	073	2025-04-02 23:00:00	7.02
3036	Q22	ЗУ	MO 12	074	2025-04-02 23:00:00	0
3037	Q23	ЗУ	MO 13	075	2025-04-02 23:00:00	25.74
3038	Q24	ЗУ	MO 14	076	2025-04-02 23:00:00	0
3039	Q25	ЗУ	MO 15	077	2025-04-02 23:00:00	15.85
3040	TP3	ЗУ	CP-300 New	078	2025-04-02 23:00:00	7.35
3041	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-02 23:30:00	0
3042	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-02 23:30:00	0.0009
3043	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-02 23:30:00	0.0029
3044	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-02 23:30:00	2.87
3045	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-02 23:30:00	4.26
3046	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-02 23:30:00	5.61
3047	QF 1,20	ЗУ	China 1	044	2025-04-02 23:30:00	16.71
3048	QF 1,21	ЗУ	China 2	045	2025-04-02 23:30:00	14.96
3049	QF 1,22	ЗУ	China 3	046	2025-04-02 23:30:00	17.99
3050	QF 2,20	ЗУ	China 4	047	2025-04-02 23:30:00	21.52
3051	QF 2,21	ЗУ	China 5	048	2025-04-02 23:30:00	24.86
3052	QF 2,22	ЗУ	China 6	049	2025-04-02 23:30:00	22.77
3053	QF 2,23	ЗУ	China 7	050	2025-04-02 23:30:00	11.39
3054	QF 2,19	ЗУ	China 8	051	2025-04-02 23:30:00	17.96
3055	Q8	ЗУ	DIG	061	2025-04-02 23:30:00	42.48
3056	Q4	ЗУ	BG 1	062	2025-04-02 23:30:00	0
3057	Q9	ЗУ	BG 2	063	2025-04-02 23:30:00	20.22
3058	Q10	ЗУ	SM 2	064	2025-04-02 23:30:00	32.38
3059	Q11	ЗУ	SM 3	065	2025-04-02 23:30:00	10.85
3060	Q12	ЗУ	SM 4	066	2025-04-02 23:30:00	11.25
3061	Q13	ЗУ	SM 5	067	2025-04-02 23:30:00	0
3062	Q14	ЗУ	SM 6	068	2025-04-02 23:30:00	0
3063	Q15	ЗУ	SM 7	069	2025-04-02 23:30:00	0
3064	Q16	ЗУ	SM 8	070	2025-04-02 23:30:00	0
3065	Q17	ЗУ	MO 9	071	2025-04-02 23:30:00	1.89
3066	Q20	ЗУ	MO 10	072	2025-04-02 23:30:00	0
3067	Q21	ЗУ	MO 11	073	2025-04-02 23:30:00	7.04
3068	Q22	ЗУ	MO 12	074	2025-04-02 23:30:00	0
3069	Q23	ЗУ	MO 13	075	2025-04-02 23:30:00	25.78
3070	Q24	ЗУ	MO 14	076	2025-04-02 23:30:00	0
3071	Q25	ЗУ	MO 15	077	2025-04-02 23:30:00	15.91
3072	TP3	ЗУ	CP-300 New	078	2025-04-02 23:30:00	7.47
3073	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 00:00:00	0
3074	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 00:00:00	0.0016
3075	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 00:00:00	0.0031
13589	Q8	ЗУ	DIG	061	2026-05-09 21:15:19.8227	47.1854
3076	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 00:00:00	5.96
3077	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 00:00:00	14
3078	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 00:00:00	15.22
3079	QF 1,20	ЗУ	China 1	044	2025-04-03 00:00:00	17.85
3080	QF 1,21	ЗУ	China 2	045	2025-04-03 00:00:00	15.34
3081	QF 1,22	ЗУ	China 3	046	2025-04-03 00:00:00	18.82
3082	QF 2,20	ЗУ	China 4	047	2025-04-03 00:00:00	21.87
3083	QF 2,21	ЗУ	China 5	048	2025-04-03 00:00:00	25.84
3084	QF 2,22	ЗУ	China 6	049	2025-04-03 00:00:00	23.43
3085	QF 2,23	ЗУ	China 7	050	2025-04-03 00:00:00	11.68
3086	QF 2,19	ЗУ	China 8	051	2025-04-03 00:00:00	18.53
3087	Q8	ЗУ	DIG	061	2025-04-03 00:00:00	49.68
3088	Q4	ЗУ	BG 1	062	2025-04-03 00:00:00	0
3089	Q9	ЗУ	BG 2	063	2025-04-03 00:00:00	20.16
3090	Q10	ЗУ	SM 2	064	2025-04-03 00:00:00	32.37
3091	Q11	ЗУ	SM 3	065	2025-04-03 00:00:00	18.55
3092	Q12	ЗУ	SM 4	066	2025-04-03 00:00:00	11.21
3093	Q13	ЗУ	SM 5	067	2025-04-03 00:00:00	0
3094	Q14	ЗУ	SM 6	068	2025-04-03 00:00:00	0
3095	Q15	ЗУ	SM 7	069	2025-04-03 00:00:00	0
3096	Q16	ЗУ	SM 8	070	2025-04-03 00:00:00	0
3097	Q17	ЗУ	MO 9	071	2025-04-03 00:00:00	1.87
3098	Q20	ЗУ	MO 10	072	2025-04-03 00:00:00	0
3099	Q21	ЗУ	MO 11	073	2025-04-03 00:00:00	7.04
3100	Q22	ЗУ	MO 12	074	2025-04-03 00:00:00	0
3101	Q23	ЗУ	MO 13	075	2025-04-03 00:00:00	25.74
3102	Q24	ЗУ	MO 14	076	2025-04-03 00:00:00	0
3103	Q25	ЗУ	MO 15	077	2025-04-03 00:00:00	15.9
3104	TP3	ЗУ	CP-300 New	078	2025-04-03 00:00:00	7.52
3105	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 00:30:00	0
3106	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 00:30:00	0.0012
3107	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 00:30:00	0.0032
3108	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 00:30:00	7.8
3109	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 00:30:00	18.96
3110	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 00:30:00	19.49
3111	QF 1,20	ЗУ	China 1	044	2025-04-03 00:30:00	19.26
3112	QF 1,21	ЗУ	China 2	045	2025-04-03 00:30:00	16.59
3113	QF 1,22	ЗУ	China 3	046	2025-04-03 00:30:00	19.56
3114	QF 2,20	ЗУ	China 4	047	2025-04-03 00:30:00	22.63
3115	QF 2,21	ЗУ	China 5	048	2025-04-03 00:30:00	26.2
3116	QF 2,22	ЗУ	China 6	049	2025-04-03 00:30:00	23.44
3117	QF 2,23	ЗУ	China 7	050	2025-04-03 00:30:00	12.09
3118	QF 2,19	ЗУ	China 8	051	2025-04-03 00:30:00	19.5
3119	Q8	ЗУ	DIG	061	2025-04-03 00:30:00	48.96
3120	Q4	ЗУ	BG 1	062	2025-04-03 00:30:00	0
3121	Q9	ЗУ	BG 2	063	2025-04-03 00:30:00	20.07
3122	Q10	ЗУ	SM 2	064	2025-04-03 00:30:00	32.47
3123	Q11	ЗУ	SM 3	065	2025-04-03 00:30:00	18.49
3124	Q12	ЗУ	SM 4	066	2025-04-03 00:30:00	12.71
3125	Q13	ЗУ	SM 5	067	2025-04-03 00:30:00	0
3126	Q14	ЗУ	SM 6	068	2025-04-03 00:30:00	0
3127	Q15	ЗУ	SM 7	069	2025-04-03 00:30:00	0
3128	Q16	ЗУ	SM 8	070	2025-04-03 00:30:00	0
3129	Q17	ЗУ	MO 9	071	2025-04-03 00:30:00	1.87
3130	Q20	ЗУ	MO 10	072	2025-04-03 00:30:00	0
3131	Q21	ЗУ	MO 11	073	2025-04-03 00:30:00	7.02
3132	Q22	ЗУ	MO 12	074	2025-04-03 00:30:00	0
3133	Q23	ЗУ	MO 13	075	2025-04-03 00:30:00	25.67
3134	Q24	ЗУ	MO 14	076	2025-04-03 00:30:00	0
3135	Q25	ЗУ	MO 15	077	2025-04-03 00:30:00	15.86
3136	TP3	ЗУ	CP-300 New	078	2025-04-03 00:30:00	7.63
3137	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 01:00:00	0
3138	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 01:00:00	0.0015
3139	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 01:00:00	0.0031
3140	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 01:00:00	9.33
3141	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 01:00:00	25.56
3142	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 01:00:00	26.16
3143	QF 1,20	ЗУ	China 1	044	2025-04-03 01:00:00	15.84
3144	QF 1,21	ЗУ	China 2	045	2025-04-03 01:00:00	14.26
3145	QF 1,22	ЗУ	China 3	046	2025-04-03 01:00:00	17.66
3146	QF 2,20	ЗУ	China 4	047	2025-04-03 01:00:00	20.43
3147	QF 2,21	ЗУ	China 5	048	2025-04-03 01:00:00	23.95
3148	QF 2,22	ЗУ	China 6	049	2025-04-03 01:00:00	22.09
3149	QF 2,23	ЗУ	China 7	050	2025-04-03 01:00:00	10.81
3150	QF 2,19	ЗУ	China 8	051	2025-04-03 01:00:00	17.16
3151	Q8	ЗУ	DIG	061	2025-04-03 01:00:00	42.91
3152	Q4	ЗУ	BG 1	062	2025-04-03 01:00:00	0
3153	Q9	ЗУ	BG 2	063	2025-04-03 01:00:00	20.08
3154	Q10	ЗУ	SM 2	064	2025-04-03 01:00:00	32.35
3155	Q11	ЗУ	SM 3	065	2025-04-03 01:00:00	18.34
3156	Q12	ЗУ	SM 4	066	2025-04-03 01:00:00	20.99
3157	Q13	ЗУ	SM 5	067	2025-04-03 01:00:00	0
3158	Q14	ЗУ	SM 6	068	2025-04-03 01:00:00	0
3159	Q15	ЗУ	SM 7	069	2025-04-03 01:00:00	0
3160	Q16	ЗУ	SM 8	070	2025-04-03 01:00:00	0
3161	Q17	ЗУ	MO 9	071	2025-04-03 01:00:00	1.91
3162	Q20	ЗУ	MO 10	072	2025-04-03 01:00:00	0
3163	Q21	ЗУ	MO 11	073	2025-04-03 01:00:00	7.04
3164	Q22	ЗУ	MO 12	074	2025-04-03 01:00:00	0
3165	Q23	ЗУ	MO 13	075	2025-04-03 01:00:00	25.52
3166	Q24	ЗУ	MO 14	076	2025-04-03 01:00:00	0
3167	Q25	ЗУ	MO 15	077	2025-04-03 01:00:00	15.73
3168	TP3	ЗУ	CP-300 New	078	2025-04-03 01:00:00	7.58
3169	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 01:30:00	0
3170	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 01:30:00	0.0012
3171	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 01:30:00	0.0029
3172	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 01:30:00	10.33
3173	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 01:30:00	29.83
3174	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 01:30:00	30.41
3175	QF 1,20	ЗУ	China 1	044	2025-04-03 01:30:00	16.33
3176	QF 1,21	ЗУ	China 2	045	2025-04-03 01:30:00	15.19
3177	QF 1,22	ЗУ	China 3	046	2025-04-03 01:30:00	17.86
3178	QF 2,20	ЗУ	China 4	047	2025-04-03 01:30:00	20.89
3179	QF 2,21	ЗУ	China 5	048	2025-04-03 01:30:00	24.14
3180	QF 2,22	ЗУ	China 6	049	2025-04-03 01:30:00	21.91
3181	QF 2,23	ЗУ	China 7	050	2025-04-03 01:30:00	11.04
3182	QF 2,19	ЗУ	China 8	051	2025-04-03 01:30:00	17.75
3183	Q8	ЗУ	DIG	061	2025-04-03 01:30:00	37.37
3184	Q4	ЗУ	BG 1	062	2025-04-03 01:30:00	0
3185	Q9	ЗУ	BG 2	063	2025-04-03 01:30:00	20.11
3186	Q10	ЗУ	SM 2	064	2025-04-03 01:30:00	32.33
3187	Q11	ЗУ	SM 3	065	2025-04-03 01:30:00	18.64
3188	Q12	ЗУ	SM 4	066	2025-04-03 01:30:00	20.98
3189	Q13	ЗУ	SM 5	067	2025-04-03 01:30:00	0
3190	Q14	ЗУ	SM 6	068	2025-04-03 01:30:00	0
3191	Q15	ЗУ	SM 7	069	2025-04-03 01:30:00	0
3192	Q16	ЗУ	SM 8	070	2025-04-03 01:30:00	0
3193	Q17	ЗУ	MO 9	071	2025-04-03 01:30:00	1.91
3194	Q20	ЗУ	MO 10	072	2025-04-03 01:30:00	0
3195	Q21	ЗУ	MO 11	073	2025-04-03 01:30:00	7.04
3196	Q22	ЗУ	MO 12	074	2025-04-03 01:30:00	0
3197	Q23	ЗУ	MO 13	075	2025-04-03 01:30:00	25.54
3198	Q24	ЗУ	MO 14	076	2025-04-03 01:30:00	0
3199	Q25	ЗУ	MO 15	077	2025-04-03 01:30:00	15.77
3200	TP3	ЗУ	CP-300 New	078	2025-04-03 01:30:00	6.36
3201	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 02:00:00	0
3202	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 02:00:00	0.001
3203	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 02:00:00	0.003
3204	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 02:00:00	9.85
3205	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 02:00:00	29.92
3206	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 02:00:00	30.35
3207	QF 1,20	ЗУ	China 1	044	2025-04-03 02:00:00	21.04
3208	QF 1,21	ЗУ	China 2	045	2025-04-03 02:00:00	17.2
3209	QF 1,22	ЗУ	China 3	046	2025-04-03 02:00:00	20.72
3210	QF 2,20	ЗУ	China 4	047	2025-04-03 02:00:00	22.45
3211	QF 2,21	ЗУ	China 5	048	2025-04-03 02:00:00	26.43
3212	QF 2,22	ЗУ	China 6	049	2025-04-03 02:00:00	23.38
3213	QF 2,23	ЗУ	China 7	050	2025-04-03 02:00:00	11.81
3214	QF 2,19	ЗУ	China 8	051	2025-04-03 02:00:00	20.03
3215	Q8	ЗУ	DIG	061	2025-04-03 02:00:00	39.93
3216	Q4	ЗУ	BG 1	062	2025-04-03 02:00:00	0
3217	Q9	ЗУ	BG 2	063	2025-04-03 02:00:00	20.14
3218	Q10	ЗУ	SM 2	064	2025-04-03 02:00:00	32.34
3219	Q11	ЗУ	SM 3	065	2025-04-03 02:00:00	19.69
3220	Q12	ЗУ	SM 4	066	2025-04-03 02:00:00	20.93
3221	Q13	ЗУ	SM 5	067	2025-04-03 02:00:00	0
3222	Q14	ЗУ	SM 6	068	2025-04-03 02:00:00	0
3223	Q15	ЗУ	SM 7	069	2025-04-03 02:00:00	0
3224	Q16	ЗУ	SM 8	070	2025-04-03 02:00:00	0
3225	Q17	ЗУ	MO 9	071	2025-04-03 02:00:00	1.87
3226	Q20	ЗУ	MO 10	072	2025-04-03 02:00:00	0
3227	Q21	ЗУ	MO 11	073	2025-04-03 02:00:00	7.03
3228	Q22	ЗУ	MO 12	074	2025-04-03 02:00:00	0
3229	Q23	ЗУ	MO 13	075	2025-04-03 02:00:00	25.44
3230	Q24	ЗУ	MO 14	076	2025-04-03 02:00:00	0
3231	Q25	ЗУ	MO 15	077	2025-04-03 02:00:00	15.77
3232	TP3	ЗУ	CP-300 New	078	2025-04-03 02:00:00	6.08
3233	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 02:30:00	0
3234	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 02:30:00	0.0011
3235	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 02:30:00	0.0031
3236	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 02:30:00	8.8
3237	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 02:30:00	29.95
3238	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 02:30:00	30.09
3239	QF 1,20	ЗУ	China 1	044	2025-04-03 02:30:00	22.03
3240	QF 1,21	ЗУ	China 2	045	2025-04-03 02:30:00	18.56
3241	QF 1,22	ЗУ	China 3	046	2025-04-03 02:30:00	21.32
3242	QF 2,20	ЗУ	China 4	047	2025-04-03 02:30:00	22.55
3243	QF 2,21	ЗУ	China 5	048	2025-04-03 02:30:00	26.16
3244	QF 2,22	ЗУ	China 6	049	2025-04-03 02:30:00	22.93
3245	QF 2,23	ЗУ	China 7	050	2025-04-03 02:30:00	11.78
3246	QF 2,19	ЗУ	China 8	051	2025-04-03 02:30:00	20.43
3247	Q8	ЗУ	DIG	061	2025-04-03 02:30:00	42.26
3248	Q4	ЗУ	BG 1	062	2025-04-03 02:30:00	0
3249	Q9	ЗУ	BG 2	063	2025-04-03 02:30:00	20.06
3250	Q10	ЗУ	SM 2	064	2025-04-03 02:30:00	32.36
3251	Q11	ЗУ	SM 3	065	2025-04-03 02:30:00	19.68
3252	Q12	ЗУ	SM 4	066	2025-04-03 02:30:00	20.92
3253	Q13	ЗУ	SM 5	067	2025-04-03 02:30:00	0
3254	Q14	ЗУ	SM 6	068	2025-04-03 02:30:00	0
3255	Q15	ЗУ	SM 7	069	2025-04-03 02:30:00	0
3256	Q16	ЗУ	SM 8	070	2025-04-03 02:30:00	0
3257	Q17	ЗУ	MO 9	071	2025-04-03 02:30:00	1.89
3258	Q20	ЗУ	MO 10	072	2025-04-03 02:30:00	0
3259	Q21	ЗУ	MO 11	073	2025-04-03 02:30:00	8.65
3260	Q22	ЗУ	MO 12	074	2025-04-03 02:30:00	0
3261	Q23	ЗУ	MO 13	075	2025-04-03 02:30:00	24.7
3262	Q24	ЗУ	MO 14	076	2025-04-03 02:30:00	0
3263	Q25	ЗУ	MO 15	077	2025-04-03 02:30:00	15.77
3264	TP3	ЗУ	CP-300 New	078	2025-04-03 02:30:00	5.83
3265	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 03:00:00	0
3266	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 03:00:00	0.0011
3267	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 03:00:00	0.003
3268	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 03:00:00	5.58
3269	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 03:00:00	23.79
3270	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 03:00:00	23.77
3271	QF 1,20	ЗУ	China 1	044	2025-04-03 03:00:00	22.39
3272	QF 1,21	ЗУ	China 2	045	2025-04-03 03:00:00	19.38
3273	QF 1,22	ЗУ	China 3	046	2025-04-03 03:00:00	22.26
3274	QF 2,20	ЗУ	China 4	047	2025-04-03 03:00:00	23.3
3275	QF 2,21	ЗУ	China 5	048	2025-04-03 03:00:00	26.35
3276	QF 2,22	ЗУ	China 6	049	2025-04-03 03:00:00	23.17
3277	QF 2,23	ЗУ	China 7	050	2025-04-03 03:00:00	11.98
3278	QF 2,19	ЗУ	China 8	051	2025-04-03 03:00:00	20.96
3279	Q8	ЗУ	DIG	061	2025-04-03 03:00:00	53.34
13742	Q8	ЗУ	DIG	061	2026-05-09 21:18:50.004792	46.7347
3280	Q4	ЗУ	BG 1	062	2025-04-03 03:00:00	0
3281	Q9	ЗУ	BG 2	063	2025-04-03 03:00:00	20.01
3282	Q10	ЗУ	SM 2	064	2025-04-03 03:00:00	32.35
3283	Q11	ЗУ	SM 3	065	2025-04-03 03:00:00	19.68
3284	Q12	ЗУ	SM 4	066	2025-04-03 03:00:00	20.9
3285	Q13	ЗУ	SM 5	067	2025-04-03 03:00:00	0
3286	Q14	ЗУ	SM 6	068	2025-04-03 03:00:00	0
3287	Q15	ЗУ	SM 7	069	2025-04-03 03:00:00	0
3288	Q16	ЗУ	SM 8	070	2025-04-03 03:00:00	0
3289	Q17	ЗУ	MO 9	071	2025-04-03 03:00:00	1.89
3290	Q20	ЗУ	MO 10	072	2025-04-03 03:00:00	0
3291	Q21	ЗУ	MO 11	073	2025-04-03 03:00:00	13.83
3292	Q22	ЗУ	MO 12	074	2025-04-03 03:00:00	0
3293	Q23	ЗУ	MO 13	075	2025-04-03 03:00:00	24.67
3294	Q24	ЗУ	MO 14	076	2025-04-03 03:00:00	0
3295	Q25	ЗУ	MO 15	077	2025-04-03 03:00:00	15.76
3296	TP3	ЗУ	CP-300 New	078	2025-04-03 03:00:00	5.96
3297	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 03:30:00	0
3298	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 03:30:00	0.0012
3299	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 03:30:00	0.003
3300	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 03:30:00	4.67
3301	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 03:30:00	28.65
3302	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 03:30:00	28.72
3303	QF 1,20	ЗУ	China 1	044	2025-04-03 03:30:00	21.4
3304	QF 1,21	ЗУ	China 2	045	2025-04-03 03:30:00	18.21
3305	QF 1,22	ЗУ	China 3	046	2025-04-03 03:30:00	20.21
3306	QF 2,20	ЗУ	China 4	047	2025-04-03 03:30:00	21.85
3307	QF 2,21	ЗУ	China 5	048	2025-04-03 03:30:00	23.85
3308	QF 2,22	ЗУ	China 6	049	2025-04-03 03:30:00	21.29
3309	QF 2,23	ЗУ	China 7	050	2025-04-03 03:30:00	11.1
3310	QF 2,19	ЗУ	China 8	051	2025-04-03 03:30:00	19.68
3311	Q8	ЗУ	DIG	061	2025-04-03 03:30:00	58.56
3312	Q4	ЗУ	BG 1	062	2025-04-03 03:30:00	0
3313	Q9	ЗУ	BG 2	063	2025-04-03 03:30:00	19.98
3314	Q10	ЗУ	SM 2	064	2025-04-03 03:30:00	32.34
3315	Q11	ЗУ	SM 3	065	2025-04-03 03:30:00	19.67
3316	Q12	ЗУ	SM 4	066	2025-04-03 03:30:00	20.86
3317	Q13	ЗУ	SM 5	067	2025-04-03 03:30:00	0
3318	Q14	ЗУ	SM 6	068	2025-04-03 03:30:00	0
3319	Q15	ЗУ	SM 7	069	2025-04-03 03:30:00	0
3320	Q16	ЗУ	SM 8	070	2025-04-03 03:30:00	0
3321	Q17	ЗУ	MO 9	071	2025-04-03 03:30:00	1.88
3322	Q20	ЗУ	MO 10	072	2025-04-03 03:30:00	0
3323	Q21	ЗУ	MO 11	073	2025-04-03 03:30:00	13.83
3324	Q22	ЗУ	MO 12	074	2025-04-03 03:30:00	0
3325	Q23	ЗУ	MO 13	075	2025-04-03 03:30:00	24.66
3326	Q24	ЗУ	MO 14	076	2025-04-03 03:30:00	0
3327	Q25	ЗУ	MO 15	077	2025-04-03 03:30:00	15.79
3328	TP3	ЗУ	CP-300 New	078	2025-04-03 03:30:00	5.8
3329	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 04:00:00	0
3330	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 04:00:00	0.001
3331	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 04:00:00	0.0029
3332	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 04:00:00	4.36
3333	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 04:00:00	28.56
3334	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 04:00:00	28.58
3335	QF 1,20	ЗУ	China 1	044	2025-04-03 04:00:00	20.68
3336	QF 1,21	ЗУ	China 2	045	2025-04-03 04:00:00	17.39
3337	QF 1,22	ЗУ	China 3	046	2025-04-03 04:00:00	19.91
3338	QF 2,20	ЗУ	China 4	047	2025-04-03 04:00:00	21.36
3339	QF 2,21	ЗУ	China 5	048	2025-04-03 04:00:00	23.18
3340	QF 2,22	ЗУ	China 6	049	2025-04-03 04:00:00	21.14
3341	QF 2,23	ЗУ	China 7	050	2025-04-03 04:00:00	10.7
3342	QF 2,19	ЗУ	China 8	051	2025-04-03 04:00:00	18.22
3343	Q8	ЗУ	DIG	061	2025-04-03 04:00:00	65.01
3344	Q4	ЗУ	BG 1	062	2025-04-03 04:00:00	0
3345	Q9	ЗУ	BG 2	063	2025-04-03 04:00:00	20.04
3346	Q10	ЗУ	SM 2	064	2025-04-03 04:00:00	32.35
3347	Q11	ЗУ	SM 3	065	2025-04-03 04:00:00	18.48
3348	Q12	ЗУ	SM 4	066	2025-04-03 04:00:00	20.88
3349	Q13	ЗУ	SM 5	067	2025-04-03 04:00:00	0
3350	Q14	ЗУ	SM 6	068	2025-04-03 04:00:00	0
3351	Q15	ЗУ	SM 7	069	2025-04-03 04:00:00	0
3352	Q16	ЗУ	SM 8	070	2025-04-03 04:00:00	0
3353	Q17	ЗУ	MO 9	071	2025-04-03 04:00:00	1.89
3354	Q20	ЗУ	MO 10	072	2025-04-03 04:00:00	0
3355	Q21	ЗУ	MO 11	073	2025-04-03 04:00:00	13.86
3356	Q22	ЗУ	MO 12	074	2025-04-03 04:00:00	0
3357	Q23	ЗУ	MO 13	075	2025-04-03 04:00:00	24.65
3358	Q24	ЗУ	MO 14	076	2025-04-03 04:00:00	0
3359	Q25	ЗУ	MO 15	077	2025-04-03 04:00:00	15.76
3360	TP3	ЗУ	CP-300 New	078	2025-04-03 04:00:00	5.4
3361	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 04:30:00	0
3362	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 04:30:00	0.0012
3363	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 04:30:00	0.0029
3364	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 04:30:00	4.34
3365	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 04:30:00	28.58
3366	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 04:30:00	28.61
3367	QF 1,20	ЗУ	China 1	044	2025-04-03 04:30:00	20.44
3368	QF 1,21	ЗУ	China 2	045	2025-04-03 04:30:00	17.87
3369	QF 1,22	ЗУ	China 3	046	2025-04-03 04:30:00	18.98
3370	QF 2,20	ЗУ	China 4	047	2025-04-03 04:30:00	21.87
3371	QF 2,21	ЗУ	China 5	048	2025-04-03 04:30:00	23.45
3372	QF 2,22	ЗУ	China 6	049	2025-04-03 04:30:00	21.14
3373	QF 2,23	ЗУ	China 7	050	2025-04-03 04:30:00	10.83
3374	QF 2,19	ЗУ	China 8	051	2025-04-03 04:30:00	17.96
3375	Q8	ЗУ	DIG	061	2025-04-03 04:30:00	66.3
3376	Q4	ЗУ	BG 1	062	2025-04-03 04:30:00	0
3377	Q9	ЗУ	BG 2	063	2025-04-03 04:30:00	20.01
3378	Q10	ЗУ	SM 2	064	2025-04-03 04:30:00	32.37
3379	Q11	ЗУ	SM 3	065	2025-04-03 04:30:00	18.46
3380	Q12	ЗУ	SM 4	066	2025-04-03 04:30:00	20.8
3381	Q13	ЗУ	SM 5	067	2025-04-03 04:30:00	0
3382	Q14	ЗУ	SM 6	068	2025-04-03 04:30:00	0
3383	Q15	ЗУ	SM 7	069	2025-04-03 04:30:00	0
3384	Q16	ЗУ	SM 8	070	2025-04-03 04:30:00	0
3385	Q17	ЗУ	MO 9	071	2025-04-03 04:30:00	1.93
3386	Q20	ЗУ	MO 10	072	2025-04-03 04:30:00	0
3387	Q21	ЗУ	MO 11	073	2025-04-03 04:30:00	13.85
3388	Q22	ЗУ	MO 12	074	2025-04-03 04:30:00	0
3389	Q23	ЗУ	MO 13	075	2025-04-03 04:30:00	24.63
3390	Q24	ЗУ	MO 14	076	2025-04-03 04:30:00	0
3391	Q25	ЗУ	MO 15	077	2025-04-03 04:30:00	15.75
3392	TP3	ЗУ	CP-300 New	078	2025-04-03 04:30:00	5
3393	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 05:00:00	0
3394	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 05:00:00	0.0013
3395	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 05:00:00	0.0028
3396	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 05:00:00	4.1
3397	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 05:00:00	24.22
3398	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 05:00:00	24.44
3399	QF 1,20	ЗУ	China 1	044	2025-04-03 05:00:00	20.7
3400	QF 1,21	ЗУ	China 2	045	2025-04-03 05:00:00	17.98
3401	QF 1,22	ЗУ	China 3	046	2025-04-03 05:00:00	19.97
3402	QF 2,20	ЗУ	China 4	047	2025-04-03 05:00:00	22.97
3403	QF 2,21	ЗУ	China 5	048	2025-04-03 05:00:00	23.65
3404	QF 2,22	ЗУ	China 6	049	2025-04-03 05:00:00	21.47
3405	QF 2,23	ЗУ	China 7	050	2025-04-03 05:00:00	11.16
3406	QF 2,19	ЗУ	China 8	051	2025-04-03 05:00:00	18.04
3407	Q8	ЗУ	DIG	061	2025-04-03 05:00:00	67.48
3408	Q4	ЗУ	BG 1	062	2025-04-03 05:00:00	0
3409	Q9	ЗУ	BG 2	063	2025-04-03 05:00:00	19.96
3410	Q10	ЗУ	SM 2	064	2025-04-03 05:00:00	32.33
3411	Q11	ЗУ	SM 3	065	2025-04-03 05:00:00	18.37
3412	Q12	ЗУ	SM 4	066	2025-04-03 05:00:00	20.73
3413	Q13	ЗУ	SM 5	067	2025-04-03 05:00:00	0
3414	Q14	ЗУ	SM 6	068	2025-04-03 05:00:00	0
3415	Q15	ЗУ	SM 7	069	2025-04-03 05:00:00	0
3416	Q16	ЗУ	SM 8	070	2025-04-03 05:00:00	0
3417	Q17	ЗУ	MO 9	071	2025-04-03 05:00:00	2.03
3418	Q20	ЗУ	MO 10	072	2025-04-03 05:00:00	0
3419	Q21	ЗУ	MO 11	073	2025-04-03 05:00:00	13.86
3420	Q22	ЗУ	MO 12	074	2025-04-03 05:00:00	0
3421	Q23	ЗУ	MO 13	075	2025-04-03 05:00:00	24.59
3422	Q24	ЗУ	MO 14	076	2025-04-03 05:00:00	0
3423	Q25	ЗУ	MO 15	077	2025-04-03 05:00:00	15.74
3424	TP3	ЗУ	CP-300 New	078	2025-04-03 05:00:00	4.68
3425	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 05:30:00	0
3426	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 05:30:00	0.0012
3427	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 05:30:00	0.0028
3428	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 05:30:00	4.63
3429	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 05:30:00	18.27
3430	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 05:30:00	18.74
3431	QF 1,20	ЗУ	China 1	044	2025-04-03 05:30:00	19.29
3432	QF 1,21	ЗУ	China 2	045	2025-04-03 05:30:00	16.64
3433	QF 1,22	ЗУ	China 3	046	2025-04-03 05:30:00	18.67
3434	QF 2,20	ЗУ	China 4	047	2025-04-03 05:30:00	21.89
3435	QF 2,21	ЗУ	China 5	048	2025-04-03 05:30:00	22.93
3436	QF 2,22	ЗУ	China 6	049	2025-04-03 05:30:00	20.4
3437	QF 2,23	ЗУ	China 7	050	2025-04-03 05:30:00	10.39
3438	QF 2,19	ЗУ	China 8	051	2025-04-03 05:30:00	17.26
3439	Q8	ЗУ	DIG	061	2025-04-03 05:30:00	54.76
3440	Q4	ЗУ	BG 1	062	2025-04-03 05:30:00	0
3441	Q9	ЗУ	BG 2	063	2025-04-03 05:30:00	20.11
3442	Q10	ЗУ	SM 2	064	2025-04-03 05:30:00	32.4
3443	Q11	ЗУ	SM 3	065	2025-04-03 05:30:00	18.43
3444	Q12	ЗУ	SM 4	066	2025-04-03 05:30:00	20.87
3445	Q13	ЗУ	SM 5	067	2025-04-03 05:30:00	0
3446	Q14	ЗУ	SM 6	068	2025-04-03 05:30:00	0
3447	Q15	ЗУ	SM 7	069	2025-04-03 05:30:00	0
3448	Q16	ЗУ	SM 8	070	2025-04-03 05:30:00	0
3449	Q17	ЗУ	MO 9	071	2025-04-03 05:30:00	1.92
3450	Q20	ЗУ	MO 10	072	2025-04-03 05:30:00	0
3451	Q21	ЗУ	MO 11	073	2025-04-03 05:30:00	13.9
3452	Q22	ЗУ	MO 12	074	2025-04-03 05:30:00	0
3453	Q23	ЗУ	MO 13	075	2025-04-03 05:30:00	24.88
3454	Q24	ЗУ	MO 14	076	2025-04-03 05:30:00	0
3455	Q25	ЗУ	MO 15	077	2025-04-03 05:30:00	15.89
3456	TP3	ЗУ	CP-300 New	078	2025-04-03 05:30:00	2.7
3457	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 06:00:00	0
3458	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 06:00:00	0.0013
3459	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 06:00:00	0.0032
3460	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 06:00:00	4.92
3461	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 06:00:00	18.31
3462	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 06:00:00	18.81
3463	QF 1,20	ЗУ	China 1	044	2025-04-03 06:00:00	16.97
3464	QF 1,21	ЗУ	China 2	045	2025-04-03 06:00:00	14.53
3465	QF 1,22	ЗУ	China 3	046	2025-04-03 06:00:00	16.82
3466	QF 2,20	ЗУ	China 4	047	2025-04-03 06:00:00	19.91
3467	QF 2,21	ЗУ	China 5	048	2025-04-03 06:00:00	20.93
3468	QF 2,22	ЗУ	China 6	049	2025-04-03 06:00:00	18.15
3469	QF 2,23	ЗУ	China 7	050	2025-04-03 06:00:00	9.15
3470	QF 2,19	ЗУ	China 8	051	2025-04-03 06:00:00	15.53
3471	Q8	ЗУ	DIG	061	2025-04-03 06:00:00	52.13
3472	Q4	ЗУ	BG 1	062	2025-04-03 06:00:00	0
3473	Q9	ЗУ	BG 2	063	2025-04-03 06:00:00	20.15
3474	Q10	ЗУ	SM 2	064	2025-04-03 06:00:00	32.38
3475	Q11	ЗУ	SM 3	065	2025-04-03 06:00:00	18.48
3476	Q12	ЗУ	SM 4	066	2025-04-03 06:00:00	20.93
3477	Q13	ЗУ	SM 5	067	2025-04-03 06:00:00	0
3478	Q14	ЗУ	SM 6	068	2025-04-03 06:00:00	0
3479	Q15	ЗУ	SM 7	069	2025-04-03 06:00:00	0
3480	Q16	ЗУ	SM 8	070	2025-04-03 06:00:00	0
3481	Q17	ЗУ	MO 9	071	2025-04-03 06:00:00	1.95
3482	Q20	ЗУ	MO 10	072	2025-04-03 06:00:00	0
3483	Q21	ЗУ	MO 11	073	2025-04-03 06:00:00	13.85
3484	Q22	ЗУ	MO 12	074	2025-04-03 06:00:00	0
3485	Q23	ЗУ	MO 13	075	2025-04-03 06:00:00	24.91
3486	Q24	ЗУ	MO 14	076	2025-04-03 06:00:00	0
3487	Q25	ЗУ	MO 15	077	2025-04-03 06:00:00	15.88
3488	TP3	ЗУ	CP-300 New	078	2025-04-03 06:00:00	2.04
3489	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 06:30:00	0
3490	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 06:30:00	0.0008
3491	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 06:30:00	0.0028
3492	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 06:30:00	5
3493	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 06:30:00	18.36
3494	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 06:30:00	18.88
3495	QF 1,20	ЗУ	China 1	044	2025-04-03 06:30:00	16.32
3496	QF 1,21	ЗУ	China 2	045	2025-04-03 06:30:00	14.14
3497	QF 1,22	ЗУ	China 3	046	2025-04-03 06:30:00	16.6
3498	QF 2,20	ЗУ	China 4	047	2025-04-03 06:30:00	19.89
3499	QF 2,21	ЗУ	China 5	048	2025-04-03 06:30:00	20.97
3500	QF 2,22	ЗУ	China 6	049	2025-04-03 06:30:00	18.14
3501	QF 2,23	ЗУ	China 7	050	2025-04-03 06:30:00	9.02
3502	QF 2,19	ЗУ	China 8	051	2025-04-03 06:30:00	15.25
3503	Q8	ЗУ	DIG	061	2025-04-03 06:30:00	49.27
3504	Q4	ЗУ	BG 1	062	2025-04-03 06:30:00	0
3505	Q9	ЗУ	BG 2	063	2025-04-03 06:30:00	20.17
3506	Q10	ЗУ	SM 2	064	2025-04-03 06:30:00	32.43
3507	Q11	ЗУ	SM 3	065	2025-04-03 06:30:00	19.27
3508	Q12	ЗУ	SM 4	066	2025-04-03 06:30:00	20.93
3509	Q13	ЗУ	SM 5	067	2025-04-03 06:30:00	0
3510	Q14	ЗУ	SM 6	068	2025-04-03 06:30:00	0
3511	Q15	ЗУ	SM 7	069	2025-04-03 06:30:00	0
3512	Q16	ЗУ	SM 8	070	2025-04-03 06:30:00	0
3513	Q17	ЗУ	MO 9	071	2025-04-03 06:30:00	1.92
3514	Q20	ЗУ	MO 10	072	2025-04-03 06:30:00	0
3515	Q21	ЗУ	MO 11	073	2025-04-03 06:30:00	13.96
3516	Q22	ЗУ	MO 12	074	2025-04-03 06:30:00	0
3517	Q23	ЗУ	MO 13	075	2025-04-03 06:30:00	24.91
3518	Q24	ЗУ	MO 14	076	2025-04-03 06:30:00	0
3519	Q25	ЗУ	MO 15	077	2025-04-03 06:30:00	15.9
3520	TP3	ЗУ	CP-300 New	078	2025-04-03 06:30:00	1.95
3521	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 07:00:00	0.4982
3522	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 07:00:00	0.4158
3523	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 07:00:00	0.0883
3524	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 07:00:00	4.85
3525	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 07:00:00	18.33
3526	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 07:00:00	18.81
3527	QF 1,20	ЗУ	China 1	044	2025-04-03 07:00:00	15.31
3528	QF 1,21	ЗУ	China 2	045	2025-04-03 07:00:00	13.05
3529	QF 1,22	ЗУ	China 3	046	2025-04-03 07:00:00	16.02
3530	QF 2,20	ЗУ	China 4	047	2025-04-03 07:00:00	19.66
3531	QF 2,21	ЗУ	China 5	048	2025-04-03 07:00:00	21.18
3532	QF 2,22	ЗУ	China 6	049	2025-04-03 07:00:00	17.96
3533	QF 2,23	ЗУ	China 7	050	2025-04-03 07:00:00	8.89
3534	QF 2,19	ЗУ	China 8	051	2025-04-03 07:00:00	14.73
3535	Q8	ЗУ	DIG	061	2025-04-03 07:00:00	45.35
3536	Q4	ЗУ	BG 1	062	2025-04-03 07:00:00	0
3537	Q9	ЗУ	BG 2	063	2025-04-03 07:00:00	20.13
3538	Q10	ЗУ	SM 2	064	2025-04-03 07:00:00	32.29
3539	Q11	ЗУ	SM 3	065	2025-04-03 07:00:00	21.13
3540	Q12	ЗУ	SM 4	066	2025-04-03 07:00:00	20.87
3541	Q13	ЗУ	SM 5	067	2025-04-03 07:00:00	0
3542	Q14	ЗУ	SM 6	068	2025-04-03 07:00:00	0
3543	Q15	ЗУ	SM 7	069	2025-04-03 07:00:00	0
3544	Q16	ЗУ	SM 8	070	2025-04-03 07:00:00	0
3545	Q17	ЗУ	MO 9	071	2025-04-03 07:00:00	1.93
3546	Q20	ЗУ	MO 10	072	2025-04-03 07:00:00	0
3547	Q21	ЗУ	MO 11	073	2025-04-03 07:00:00	13.91
3548	Q22	ЗУ	MO 12	074	2025-04-03 07:00:00	0
3549	Q23	ЗУ	MO 13	075	2025-04-03 07:00:00	24.76
3550	Q24	ЗУ	MO 14	076	2025-04-03 07:00:00	0
3551	Q25	ЗУ	MO 15	077	2025-04-03 07:00:00	15.78
3552	TP3	ЗУ	CP-300 New	078	2025-04-03 07:00:00	1.1
3553	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 07:30:00	2.13
3554	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 07:30:00	1.76
3555	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 07:30:00	0.3592
3556	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 07:30:00	4.61
3557	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 07:30:00	18.32
3558	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 07:30:00	18.83
3559	QF 1,20	ЗУ	China 1	044	2025-04-03 07:30:00	14.72
3560	QF 1,21	ЗУ	China 2	045	2025-04-03 07:30:00	12.97
3561	QF 1,22	ЗУ	China 3	046	2025-04-03 07:30:00	15.59
3562	QF 2,20	ЗУ	China 4	047	2025-04-03 07:30:00	19.86
3563	QF 2,21	ЗУ	China 5	048	2025-04-03 07:30:00	21.69
3564	QF 2,22	ЗУ	China 6	049	2025-04-03 07:30:00	18.68
3565	QF 2,23	ЗУ	China 7	050	2025-04-03 07:30:00	8.98
3566	QF 2,19	ЗУ	China 8	051	2025-04-03 07:30:00	14.47
3567	Q8	ЗУ	DIG	061	2025-04-03 07:30:00	40.66
3568	Q4	ЗУ	BG 1	062	2025-04-03 07:30:00	0
3569	Q9	ЗУ	BG 2	063	2025-04-03 07:30:00	20.12
3570	Q10	ЗУ	SM 2	064	2025-04-03 07:30:00	32.19
3571	Q11	ЗУ	SM 3	065	2025-04-03 07:30:00	21.1
3572	Q12	ЗУ	SM 4	066	2025-04-03 07:30:00	20.97
3573	Q13	ЗУ	SM 5	067	2025-04-03 07:30:00	0
3574	Q14	ЗУ	SM 6	068	2025-04-03 07:30:00	0
3575	Q15	ЗУ	SM 7	069	2025-04-03 07:30:00	0
3576	Q16	ЗУ	SM 8	070	2025-04-03 07:30:00	0
3577	Q17	ЗУ	MO 9	071	2025-04-03 07:30:00	1.9
3578	Q20	ЗУ	MO 10	072	2025-04-03 07:30:00	0
3579	Q21	ЗУ	MO 11	073	2025-04-03 07:30:00	13.95
3580	Q22	ЗУ	MO 12	074	2025-04-03 07:30:00	0
3581	Q23	ЗУ	MO 13	075	2025-04-03 07:30:00	24.7
3582	Q24	ЗУ	MO 14	076	2025-04-03 07:30:00	0
3583	Q25	ЗУ	MO 15	077	2025-04-03 07:30:00	15.72
3584	TP3	ЗУ	CP-300 New	078	2025-04-03 07:30:00	1.14
3585	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 08:00:00	10
3586	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 08:00:00	4.12
3587	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 08:00:00	4.53
13936	Q8	ЗУ	DIG	061	2026-05-09 21:22:55.19853	45.5969
3588	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 08:00:00	4.47
3589	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 08:00:00	18.18
3590	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 08:00:00	18.7
3591	QF 1,20	ЗУ	China 1	044	2025-04-03 08:00:00	16.21
3592	QF 1,21	ЗУ	China 2	045	2025-04-03 08:00:00	13.88
3593	QF 1,22	ЗУ	China 3	046	2025-04-03 08:00:00	17
3594	QF 2,20	ЗУ	China 4	047	2025-04-03 08:00:00	20.95
3595	QF 2,21	ЗУ	China 5	048	2025-04-03 08:00:00	22.87
3596	QF 2,22	ЗУ	China 6	049	2025-04-03 08:00:00	20.55
3597	QF 2,23	ЗУ	China 7	050	2025-04-03 08:00:00	9.72
3598	QF 2,19	ЗУ	China 8	051	2025-04-03 08:00:00	15.5
3599	Q8	ЗУ	DIG	061	2025-04-03 08:00:00	23.83
3600	Q4	ЗУ	BG 1	062	2025-04-03 08:00:00	0
3601	Q9	ЗУ	BG 2	063	2025-04-03 08:00:00	20.19
3602	Q10	ЗУ	SM 2	064	2025-04-03 08:00:00	32.18
3603	Q11	ЗУ	SM 3	065	2025-04-03 08:00:00	21.17
3604	Q12	ЗУ	SM 4	066	2025-04-03 08:00:00	20.86
3605	Q13	ЗУ	SM 5	067	2025-04-03 08:00:00	0
3606	Q14	ЗУ	SM 6	068	2025-04-03 08:00:00	0
3607	Q15	ЗУ	SM 7	069	2025-04-03 08:00:00	0
3608	Q16	ЗУ	SM 8	070	2025-04-03 08:00:00	0
3609	Q17	ЗУ	MO 9	071	2025-04-03 08:00:00	1.93
3610	Q20	ЗУ	MO 10	072	2025-04-03 08:00:00	0
3611	Q21	ЗУ	MO 11	073	2025-04-03 08:00:00	13.93
3612	Q22	ЗУ	MO 12	074	2025-04-03 08:00:00	0
3613	Q23	ЗУ	MO 13	075	2025-04-03 08:00:00	24.65
3614	Q24	ЗУ	MO 14	076	2025-04-03 08:00:00	0
3615	Q25	ЗУ	MO 15	077	2025-04-03 08:00:00	15.8
3616	TP3	ЗУ	CP-300 New	078	2025-04-03 08:00:00	1.17
3617	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 08:30:00	18.82
3618	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 08:30:00	6.93
3619	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 08:30:00	10.42
3620	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 08:30:00	2.65
3621	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 08:30:00	10.81
3622	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 08:30:00	11.15
3623	QF 1,20	ЗУ	China 1	044	2025-04-03 08:30:00	17.47
3624	QF 1,21	ЗУ	China 2	045	2025-04-03 08:30:00	15.31
3625	QF 1,22	ЗУ	China 3	046	2025-04-03 08:30:00	18.24
3626	QF 2,20	ЗУ	China 4	047	2025-04-03 08:30:00	22.23
3627	QF 2,21	ЗУ	China 5	048	2025-04-03 08:30:00	25.03
3628	QF 2,22	ЗУ	China 6	049	2025-04-03 08:30:00	22.36
3629	QF 2,23	ЗУ	China 7	050	2025-04-03 08:30:00	10.43
3630	QF 2,19	ЗУ	China 8	051	2025-04-03 08:30:00	16.76
3631	Q8	ЗУ	DIG	061	2025-04-03 08:30:00	29.31
3632	Q4	ЗУ	BG 1	062	2025-04-03 08:30:00	0
3633	Q9	ЗУ	BG 2	063	2025-04-03 08:30:00	20.08
3634	Q10	ЗУ	SM 2	064	2025-04-03 08:30:00	32.14
3635	Q11	ЗУ	SM 3	065	2025-04-03 08:30:00	21.1
3636	Q12	ЗУ	SM 4	066	2025-04-03 08:30:00	20.78
3637	Q13	ЗУ	SM 5	067	2025-04-03 08:30:00	0
3638	Q14	ЗУ	SM 6	068	2025-04-03 08:30:00	0
3639	Q15	ЗУ	SM 7	069	2025-04-03 08:30:00	0
3640	Q16	ЗУ	SM 8	070	2025-04-03 08:30:00	0
3641	Q17	ЗУ	MO 9	071	2025-04-03 08:30:00	2.08
3642	Q20	ЗУ	MO 10	072	2025-04-03 08:30:00	0
3643	Q21	ЗУ	MO 11	073	2025-04-03 08:30:00	13.9
3644	Q22	ЗУ	MO 12	074	2025-04-03 08:30:00	0
3645	Q23	ЗУ	MO 13	075	2025-04-03 08:30:00	24.5
3646	Q24	ЗУ	MO 14	076	2025-04-03 08:30:00	0
3647	Q25	ЗУ	MO 15	077	2025-04-03 08:30:00	15.71
3648	TP3	ЗУ	CP-300 New	078	2025-04-03 08:30:00	1.14
3649	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 09:00:00	19.98
3650	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 09:00:00	7.3
3651	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 09:00:00	11.15
3652	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 09:00:00	0.0031
3653	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 09:00:00	0
3654	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 09:00:00	0
3655	QF 1,20	ЗУ	China 1	044	2025-04-03 09:00:00	17.45
3656	QF 1,21	ЗУ	China 2	045	2025-04-03 09:00:00	15.83
3657	QF 1,22	ЗУ	China 3	046	2025-04-03 09:00:00	18.31
3658	QF 2,20	ЗУ	China 4	047	2025-04-03 09:00:00	22.42
3659	QF 2,21	ЗУ	China 5	048	2025-04-03 09:00:00	25.51
3660	QF 2,22	ЗУ	China 6	049	2025-04-03 09:00:00	22.73
3661	QF 2,23	ЗУ	China 7	050	2025-04-03 09:00:00	10.69
3662	QF 2,19	ЗУ	China 8	051	2025-04-03 09:00:00	17.25
3663	Q8	ЗУ	DIG	061	2025-04-03 09:00:00	29.1
3664	Q4	ЗУ	BG 1	062	2025-04-03 09:00:00	0
3665	Q9	ЗУ	BG 2	063	2025-04-03 09:00:00	20.09
3666	Q10	ЗУ	SM 2	064	2025-04-03 09:00:00	32.1
3667	Q11	ЗУ	SM 3	065	2025-04-03 09:00:00	21
3668	Q12	ЗУ	SM 4	066	2025-04-03 09:00:00	20.98
3669	Q13	ЗУ	SM 5	067	2025-04-03 09:00:00	0
3670	Q14	ЗУ	SM 6	068	2025-04-03 09:00:00	0
3671	Q15	ЗУ	SM 7	069	2025-04-03 09:00:00	0
3672	Q16	ЗУ	SM 8	070	2025-04-03 09:00:00	0
3673	Q17	ЗУ	MO 9	071	2025-04-03 09:00:00	2.08
3674	Q20	ЗУ	MO 10	072	2025-04-03 09:00:00	0
3675	Q21	ЗУ	MO 11	073	2025-04-03 09:00:00	13.91
3676	Q22	ЗУ	MO 12	074	2025-04-03 09:00:00	0
3677	Q23	ЗУ	MO 13	075	2025-04-03 09:00:00	24.49
3678	Q24	ЗУ	MO 14	076	2025-04-03 09:00:00	0
3679	Q25	ЗУ	MO 15	077	2025-04-03 09:00:00	15.64
3680	TP3	ЗУ	CP-300 New	078	2025-04-03 09:00:00	1.09
3681	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 09:30:00	29.2
3682	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 09:30:00	9.12
3683	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 09:30:00	18.76
3684	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 09:30:00	0.0032
3685	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 09:30:00	0
3686	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 09:30:00	0
3687	QF 1,20	ЗУ	China 1	044	2025-04-03 09:30:00	19.51
3688	QF 1,21	ЗУ	China 2	045	2025-04-03 09:30:00	17.4
3689	QF 1,22	ЗУ	China 3	046	2025-04-03 09:30:00	19.94
3690	QF 2,20	ЗУ	China 4	047	2025-04-03 09:30:00	24.68
3691	QF 2,21	ЗУ	China 5	048	2025-04-03 09:30:00	27.67
3692	QF 2,22	ЗУ	China 6	049	2025-04-03 09:30:00	25.46
3693	QF 2,23	ЗУ	China 7	050	2025-04-03 09:30:00	11.94
3694	QF 2,19	ЗУ	China 8	051	2025-04-03 09:30:00	19.05
3695	Q8	ЗУ	DIG	061	2025-04-03 09:30:00	26.46
3696	Q4	ЗУ	BG 1	062	2025-04-03 09:30:00	0
3697	Q9	ЗУ	BG 2	063	2025-04-03 09:30:00	20.08
3698	Q10	ЗУ	SM 2	064	2025-04-03 09:30:00	32.17
3699	Q11	ЗУ	SM 3	065	2025-04-03 09:30:00	20.99
3700	Q12	ЗУ	SM 4	066	2025-04-03 09:30:00	20.95
3701	Q13	ЗУ	SM 5	067	2025-04-03 09:30:00	0
3702	Q14	ЗУ	SM 6	068	2025-04-03 09:30:00	0
3703	Q15	ЗУ	SM 7	069	2025-04-03 09:30:00	0
3704	Q16	ЗУ	SM 8	070	2025-04-03 09:30:00	0
3705	Q17	ЗУ	MO 9	071	2025-04-03 09:30:00	2.06
3706	Q20	ЗУ	MO 10	072	2025-04-03 09:30:00	0
3707	Q21	ЗУ	MO 11	073	2025-04-03 09:30:00	13.94
3708	Q22	ЗУ	MO 12	074	2025-04-03 09:30:00	0
3709	Q23	ЗУ	MO 13	075	2025-04-03 09:30:00	24.52
3710	Q24	ЗУ	MO 14	076	2025-04-03 09:30:00	0
3711	Q25	ЗУ	MO 15	077	2025-04-03 09:30:00	15.72
3712	TP3	ЗУ	CP-300 New	078	2025-04-03 09:30:00	1.03
3713	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 10:00:00	30.36
3714	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 10:00:00	9.17
3715	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 10:00:00	19.8
3716	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 10:00:00	0.0032
3717	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 10:00:00	0
3718	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 10:00:00	0
3719	QF 1,20	ЗУ	China 1	044	2025-04-03 10:00:00	21.27
3720	QF 1,21	ЗУ	China 2	045	2025-04-03 10:00:00	19.33
3721	QF 1,22	ЗУ	China 3	046	2025-04-03 10:00:00	22.16
3722	QF 2,20	ЗУ	China 4	047	2025-04-03 10:00:00	26.4
3723	QF 2,21	ЗУ	China 5	048	2025-04-03 10:00:00	29.48
3724	QF 2,22	ЗУ	China 6	049	2025-04-03 10:00:00	27.59
3725	QF 2,23	ЗУ	China 7	050	2025-04-03 10:00:00	12.88
3726	QF 2,19	ЗУ	China 8	051	2025-04-03 10:00:00	21.14
3727	Q8	ЗУ	DIG	061	2025-04-03 10:00:00	28.5
3728	Q4	ЗУ	BG 1	062	2025-04-03 10:00:00	0
3729	Q9	ЗУ	BG 2	063	2025-04-03 10:00:00	20.1
3730	Q10	ЗУ	SM 2	064	2025-04-03 10:00:00	32.19
3731	Q11	ЗУ	SM 3	065	2025-04-03 10:00:00	20.95
3732	Q12	ЗУ	SM 4	066	2025-04-03 10:00:00	21.03
3733	Q13	ЗУ	SM 5	067	2025-04-03 10:00:00	0
3734	Q14	ЗУ	SM 6	068	2025-04-03 10:00:00	0
3735	Q15	ЗУ	SM 7	069	2025-04-03 10:00:00	0
3736	Q16	ЗУ	SM 8	070	2025-04-03 10:00:00	0
3737	Q17	ЗУ	MO 9	071	2025-04-03 10:00:00	2.06
3738	Q20	ЗУ	MO 10	072	2025-04-03 10:00:00	0
3739	Q21	ЗУ	MO 11	073	2025-04-03 10:00:00	13.92
3740	Q22	ЗУ	MO 12	074	2025-04-03 10:00:00	0
3741	Q23	ЗУ	MO 13	075	2025-04-03 10:00:00	24.47
3742	Q24	ЗУ	MO 14	076	2025-04-03 10:00:00	0
3743	Q25	ЗУ	MO 15	077	2025-04-03 10:00:00	15.67
3744	TP3	ЗУ	CP-300 New	078	2025-04-03 10:00:00	0.9886
3745	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 10:30:00	30.3
3746	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 10:30:00	8.69
3747	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 10:30:00	20.19
3748	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 10:30:00	0.0032
3749	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 10:30:00	0
3750	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 10:30:00	0
3751	QF 1,20	ЗУ	China 1	044	2025-04-03 10:30:00	21.91
3752	QF 1,21	ЗУ	China 2	045	2025-04-03 10:30:00	20.32
3753	QF 1,22	ЗУ	China 3	046	2025-04-03 10:30:00	22.58
3754	QF 2,20	ЗУ	China 4	047	2025-04-03 10:30:00	27.7
3755	QF 2,21	ЗУ	China 5	048	2025-04-03 10:30:00	30.3
3756	QF 2,22	ЗУ	China 6	049	2025-04-03 10:30:00	28.31
3757	QF 2,23	ЗУ	China 7	050	2025-04-03 10:30:00	13.62
3758	QF 2,19	ЗУ	China 8	051	2025-04-03 10:30:00	22.13
3759	Q8	ЗУ	DIG	061	2025-04-03 10:30:00	28.15
3760	Q4	ЗУ	BG 1	062	2025-04-03 10:30:00	0
3761	Q9	ЗУ	BG 2	063	2025-04-03 10:30:00	20.09
3762	Q10	ЗУ	SM 2	064	2025-04-03 10:30:00	32.18
3763	Q11	ЗУ	SM 3	065	2025-04-03 10:30:00	20.88
3764	Q12	ЗУ	SM 4	066	2025-04-03 10:30:00	21.06
3765	Q13	ЗУ	SM 5	067	2025-04-03 10:30:00	0
3766	Q14	ЗУ	SM 6	068	2025-04-03 10:30:00	0
3767	Q15	ЗУ	SM 7	069	2025-04-03 10:30:00	0
3768	Q16	ЗУ	SM 8	070	2025-04-03 10:30:00	0
3769	Q17	ЗУ	MO 9	071	2025-04-03 10:30:00	2.07
3770	Q20	ЗУ	MO 10	072	2025-04-03 10:30:00	0
3771	Q21	ЗУ	MO 11	073	2025-04-03 10:30:00	13.91
3772	Q22	ЗУ	MO 12	074	2025-04-03 10:30:00	0
3773	Q23	ЗУ	MO 13	075	2025-04-03 10:30:00	24.48
3774	Q24	ЗУ	MO 14	076	2025-04-03 10:30:00	0
3775	Q25	ЗУ	MO 15	077	2025-04-03 10:30:00	15.63
3776	TP3	ЗУ	CP-300 New	078	2025-04-03 10:30:00	2.2
3777	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 11:00:00	30.06
3778	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 11:00:00	7.59
3779	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 11:00:00	21
3780	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 11:00:00	0.0033
3781	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 11:00:00	0
3782	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 11:00:00	0
3783	QF 1,20	ЗУ	China 1	044	2025-04-03 11:00:00	23.16
3784	QF 1,21	ЗУ	China 2	045	2025-04-03 11:00:00	21.06
3785	QF 1,22	ЗУ	China 3	046	2025-04-03 11:00:00	23.63
3786	QF 2,20	ЗУ	China 4	047	2025-04-03 11:00:00	28.54
3787	QF 2,21	ЗУ	China 5	048	2025-04-03 11:00:00	31.82
3788	QF 2,22	ЗУ	China 6	049	2025-04-03 11:00:00	29.92
3789	QF 2,23	ЗУ	China 7	050	2025-04-03 11:00:00	14.47
3790	QF 2,19	ЗУ	China 8	051	2025-04-03 11:00:00	23.62
3791	Q8	ЗУ	DIG	061	2025-04-03 11:00:00	26.95
14097	Q8	ЗУ	DIG	061	2026-05-09 21:26:25.706713	47.5065
3792	Q4	ЗУ	BG 1	062	2025-04-03 11:00:00	0
3793	Q9	ЗУ	BG 2	063	2025-04-03 11:00:00	20.11
3794	Q10	ЗУ	SM 2	064	2025-04-03 11:00:00	32.17
3795	Q11	ЗУ	SM 3	065	2025-04-03 11:00:00	20.8
3796	Q12	ЗУ	SM 4	066	2025-04-03 11:00:00	21.18
3797	Q13	ЗУ	SM 5	067	2025-04-03 11:00:00	0
3798	Q14	ЗУ	SM 6	068	2025-04-03 11:00:00	0
3799	Q15	ЗУ	SM 7	069	2025-04-03 11:00:00	0
3800	Q16	ЗУ	SM 8	070	2025-04-03 11:00:00	0
3801	Q17	ЗУ	MO 9	071	2025-04-03 11:00:00	2.08
3802	Q20	ЗУ	MO 10	072	2025-04-03 11:00:00	0
3803	Q21	ЗУ	MO 11	073	2025-04-03 11:00:00	13.89
3804	Q22	ЗУ	MO 12	074	2025-04-03 11:00:00	0
3805	Q23	ЗУ	MO 13	075	2025-04-03 11:00:00	24.52
3806	Q24	ЗУ	MO 14	076	2025-04-03 11:00:00	0
3807	Q25	ЗУ	MO 15	077	2025-04-03 11:00:00	15.65
3808	TP3	ЗУ	CP-300 New	078	2025-04-03 11:00:00	2.79
3809	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 11:30:00	23.8
3810	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 11:30:00	4.01
3811	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 11:30:00	18.06
3812	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 11:30:00	0.0036
3813	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 11:30:00	0
3814	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 11:30:00	0
3815	QF 1,20	ЗУ	China 1	044	2025-04-03 11:30:00	25.41
3816	QF 1,21	ЗУ	China 2	045	2025-04-03 11:30:00	23.13
3817	QF 1,22	ЗУ	China 3	046	2025-04-03 11:30:00	26.53
3818	QF 2,20	ЗУ	China 4	047	2025-04-03 11:30:00	30.38
3819	QF 2,21	ЗУ	China 5	048	2025-04-03 11:30:00	34.04
3820	QF 2,22	ЗУ	China 6	049	2025-04-03 11:30:00	31.56
3821	QF 2,23	ЗУ	China 7	050	2025-04-03 11:30:00	15.8
3822	QF 2,19	ЗУ	China 8	051	2025-04-03 11:30:00	25.4
3823	Q8	ЗУ	DIG	061	2025-04-03 11:30:00	28
3824	Q4	ЗУ	BG 1	062	2025-04-03 11:30:00	0
3825	Q9	ЗУ	BG 2	063	2025-04-03 11:30:00	20.11
3826	Q10	ЗУ	SM 2	064	2025-04-03 11:30:00	32.18
3827	Q11	ЗУ	SM 3	065	2025-04-03 11:30:00	20.74
3828	Q12	ЗУ	SM 4	066	2025-04-03 11:30:00	21.23
3829	Q13	ЗУ	SM 5	067	2025-04-03 11:30:00	0
3830	Q14	ЗУ	SM 6	068	2025-04-03 11:30:00	0
3831	Q15	ЗУ	SM 7	069	2025-04-03 11:30:00	0
3832	Q16	ЗУ	SM 8	070	2025-04-03 11:30:00	0
3833	Q17	ЗУ	MO 9	071	2025-04-03 11:30:00	2.1
3834	Q20	ЗУ	MO 10	072	2025-04-03 11:30:00	0
3835	Q21	ЗУ	MO 11	073	2025-04-03 11:30:00	13.91
3836	Q22	ЗУ	MO 12	074	2025-04-03 11:30:00	0
3837	Q23	ЗУ	MO 13	075	2025-04-03 11:30:00	24.52
3838	Q24	ЗУ	MO 14	076	2025-04-03 11:30:00	0
3839	Q25	ЗУ	MO 15	077	2025-04-03 11:30:00	15.63
3840	TP3	ЗУ	CP-300 New	078	2025-04-03 11:30:00	5.08
3841	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 12:00:00	28.87
3842	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 12:00:00	3.45
3843	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 12:00:00	23.16
3844	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 12:00:00	0.0035
3845	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 12:00:00	0
3846	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 12:00:00	0
3847	QF 1,20	ЗУ	China 1	044	2025-04-03 12:00:00	24.8
3848	QF 1,21	ЗУ	China 2	045	2025-04-03 12:00:00	22.78
3849	QF 1,22	ЗУ	China 3	046	2025-04-03 12:00:00	25.63
3850	QF 2,20	ЗУ	China 4	047	2025-04-03 12:00:00	29.12
3851	QF 2,21	ЗУ	China 5	048	2025-04-03 12:00:00	32.59
3852	QF 2,22	ЗУ	China 6	049	2025-04-03 12:00:00	30.25
3853	QF 2,23	ЗУ	China 7	050	2025-04-03 12:00:00	14.99
3854	QF 2,19	ЗУ	China 8	051	2025-04-03 12:00:00	25.56
3855	Q8	ЗУ	DIG	061	2025-04-03 12:00:00	30.64
3856	Q4	ЗУ	BG 1	062	2025-04-03 12:00:00	0
3857	Q9	ЗУ	BG 2	063	2025-04-03 12:00:00	20.13
3858	Q10	ЗУ	SM 2	064	2025-04-03 12:00:00	32.24
3859	Q11	ЗУ	SM 3	065	2025-04-03 12:00:00	20.81
3860	Q12	ЗУ	SM 4	066	2025-04-03 12:00:00	21.35
3861	Q13	ЗУ	SM 5	067	2025-04-03 12:00:00	0
3862	Q14	ЗУ	SM 6	068	2025-04-03 12:00:00	0
3863	Q15	ЗУ	SM 7	069	2025-04-03 12:00:00	0
3864	Q16	ЗУ	SM 8	070	2025-04-03 12:00:00	0
3865	Q17	ЗУ	MO 9	071	2025-04-03 12:00:00	2.02
3866	Q20	ЗУ	MO 10	072	2025-04-03 12:00:00	0
3867	Q21	ЗУ	MO 11	073	2025-04-03 12:00:00	13.92
3868	Q22	ЗУ	MO 12	074	2025-04-03 12:00:00	0
3869	Q23	ЗУ	MO 13	075	2025-04-03 12:00:00	24.6
3870	Q24	ЗУ	MO 14	076	2025-04-03 12:00:00	0
3871	Q25	ЗУ	MO 15	077	2025-04-03 12:00:00	15.77
3872	TP3	ЗУ	CP-300 New	078	2025-04-03 12:00:00	5.74
3873	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 12:30:00	28.96
3874	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 12:30:00	3.35
3875	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 12:30:00	23.24
3876	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 12:30:00	0.0036
3877	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 12:30:00	0
3878	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 12:30:00	0
3879	QF 1,20	ЗУ	China 1	044	2025-04-03 12:30:00	23.75
3880	QF 1,21	ЗУ	China 2	045	2025-04-03 12:30:00	22.32
3881	QF 1,22	ЗУ	China 3	046	2025-04-03 12:30:00	24.65
3882	QF 2,20	ЗУ	China 4	047	2025-04-03 12:30:00	29.21
3883	QF 2,21	ЗУ	China 5	048	2025-04-03 12:30:00	31.45
3884	QF 2,22	ЗУ	China 6	049	2025-04-03 12:30:00	29.22
3885	QF 2,23	ЗУ	China 7	050	2025-04-03 12:30:00	14.83
3886	QF 2,19	ЗУ	China 8	051	2025-04-03 12:30:00	25.16
3887	Q8	ЗУ	DIG	061	2025-04-03 12:30:00	33.18
3888	Q4	ЗУ	BG 1	062	2025-04-03 12:30:00	0
3889	Q9	ЗУ	BG 2	063	2025-04-03 12:30:00	20.08
3890	Q10	ЗУ	SM 2	064	2025-04-03 12:30:00	32.18
3891	Q11	ЗУ	SM 3	065	2025-04-03 12:30:00	20.68
3892	Q12	ЗУ	SM 4	066	2025-04-03 12:30:00	21.41
3893	Q13	ЗУ	SM 5	067	2025-04-03 12:30:00	0
3894	Q14	ЗУ	SM 6	068	2025-04-03 12:30:00	0
3895	Q15	ЗУ	SM 7	069	2025-04-03 12:30:00	0
3896	Q16	ЗУ	SM 8	070	2025-04-03 12:30:00	0
3897	Q17	ЗУ	MO 9	071	2025-04-03 12:30:00	2.11
3898	Q20	ЗУ	MO 10	072	2025-04-03 12:30:00	0
3899	Q21	ЗУ	MO 11	073	2025-04-03 12:30:00	13.93
3900	Q22	ЗУ	MO 12	074	2025-04-03 12:30:00	0
3901	Q23	ЗУ	MO 13	075	2025-04-03 12:30:00	24.53
3902	Q24	ЗУ	MO 14	076	2025-04-03 12:30:00	0
3903	Q25	ЗУ	MO 15	077	2025-04-03 12:30:00	15.69
3904	TP3	ЗУ	CP-300 New	078	2025-04-03 12:30:00	7.55
3905	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 13:00:00	28.84
3906	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 13:00:00	3.19
3907	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 13:00:00	23.17
3908	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 13:00:00	0.0036
3909	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 13:00:00	0
3910	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 13:00:00	0
3911	QF 1,20	ЗУ	China 1	044	2025-04-03 13:00:00	22.72
3912	QF 1,21	ЗУ	China 2	045	2025-04-03 13:00:00	22.16
3913	QF 1,22	ЗУ	China 3	046	2025-04-03 13:00:00	24.75
3914	QF 2,20	ЗУ	China 4	047	2025-04-03 13:00:00	28.61
3915	QF 2,21	ЗУ	China 5	048	2025-04-03 13:00:00	31.65
3916	QF 2,22	ЗУ	China 6	049	2025-04-03 13:00:00	28.99
3917	QF 2,23	ЗУ	China 7	050	2025-04-03 13:00:00	14.9
3918	QF 2,19	ЗУ	China 8	051	2025-04-03 13:00:00	25.59
3919	Q8	ЗУ	DIG	061	2025-04-03 13:00:00	36.77
3920	Q4	ЗУ	BG 1	062	2025-04-03 13:00:00	0
3921	Q9	ЗУ	BG 2	063	2025-04-03 13:00:00	19.99
3922	Q10	ЗУ	SM 2	064	2025-04-03 13:00:00	32.16
3923	Q11	ЗУ	SM 3	065	2025-04-03 13:00:00	20.54
3924	Q12	ЗУ	SM 4	066	2025-04-03 13:00:00	21.82
3925	Q13	ЗУ	SM 5	067	2025-04-03 13:00:00	0
3926	Q14	ЗУ	SM 6	068	2025-04-03 13:00:00	0
3927	Q15	ЗУ	SM 7	069	2025-04-03 13:00:00	0
3928	Q16	ЗУ	SM 8	070	2025-04-03 13:00:00	0
3929	Q17	ЗУ	MO 9	071	2025-04-03 13:00:00	2.14
3930	Q20	ЗУ	MO 10	072	2025-04-03 13:00:00	0
3931	Q21	ЗУ	MO 11	073	2025-04-03 13:00:00	13.86
3932	Q22	ЗУ	MO 12	074	2025-04-03 13:00:00	0
3933	Q23	ЗУ	MO 13	075	2025-04-03 13:00:00	24.45
3934	Q24	ЗУ	MO 14	076	2025-04-03 13:00:00	0
3935	Q25	ЗУ	MO 15	077	2025-04-03 13:00:00	15.66
3936	TP3	ЗУ	CP-300 New	078	2025-04-03 13:00:00	9.32
3937	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 13:30:00	22.26
3938	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 13:30:00	3.53
3939	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 13:30:00	16.47
3940	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 13:30:00	0.0034
3941	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 13:30:00	0
3942	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 13:30:00	0
3943	QF 1,20	ЗУ	China 1	044	2025-04-03 13:30:00	22.44
3944	QF 1,21	ЗУ	China 2	045	2025-04-03 13:30:00	21.44
3945	QF 1,22	ЗУ	China 3	046	2025-04-03 13:30:00	23.45
3946	QF 2,20	ЗУ	China 4	047	2025-04-03 13:30:00	27.51
3947	QF 2,21	ЗУ	China 5	048	2025-04-03 13:30:00	30.94
3948	QF 2,22	ЗУ	China 6	049	2025-04-03 13:30:00	28.36
3949	QF 2,23	ЗУ	China 7	050	2025-04-03 13:30:00	14.66
3950	QF 2,19	ЗУ	China 8	051	2025-04-03 13:30:00	24.79
3951	Q8	ЗУ	DIG	061	2025-04-03 13:30:00	42.15
3952	Q4	ЗУ	BG 1	062	2025-04-03 13:30:00	0
3953	Q9	ЗУ	BG 2	063	2025-04-03 13:30:00	19.99
3954	Q10	ЗУ	SM 2	064	2025-04-03 13:30:00	32.11
3955	Q11	ЗУ	SM 3	065	2025-04-03 13:30:00	20.57
3956	Q12	ЗУ	SM 4	066	2025-04-03 13:30:00	21.78
3957	Q13	ЗУ	SM 5	067	2025-04-03 13:30:00	0
3958	Q14	ЗУ	SM 6	068	2025-04-03 13:30:00	0
3959	Q15	ЗУ	SM 7	069	2025-04-03 13:30:00	0
3960	Q16	ЗУ	SM 8	070	2025-04-03 13:30:00	0
3961	Q17	ЗУ	MO 9	071	2025-04-03 13:30:00	2.16
3962	Q20	ЗУ	MO 10	072	2025-04-03 13:30:00	0
3963	Q21	ЗУ	MO 11	073	2025-04-03 13:30:00	13.91
3964	Q22	ЗУ	MO 12	074	2025-04-03 13:30:00	0
3965	Q23	ЗУ	MO 13	075	2025-04-03 13:30:00	24.44
3966	Q24	ЗУ	MO 14	076	2025-04-03 13:30:00	0
3967	Q25	ЗУ	MO 15	077	2025-04-03 13:30:00	15.67
3968	TP3	ЗУ	CP-300 New	078	2025-04-03 13:30:00	13.62
3969	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 14:00:00	19.13
3970	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 14:00:00	3.58
3971	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 14:00:00	13.49
3972	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 14:00:00	0.0035
3973	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 14:00:00	0
3974	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 14:00:00	0
3975	QF 1,20	ЗУ	China 1	044	2025-04-03 14:00:00	22.82
3976	QF 1,21	ЗУ	China 2	045	2025-04-03 14:00:00	21.41
3977	QF 1,22	ЗУ	China 3	046	2025-04-03 14:00:00	23.88
3978	QF 2,20	ЗУ	China 4	047	2025-04-03 14:00:00	28.28
3979	QF 2,21	ЗУ	China 5	048	2025-04-03 14:00:00	31.32
3980	QF 2,22	ЗУ	China 6	049	2025-04-03 14:00:00	28.61
3981	QF 2,23	ЗУ	China 7	050	2025-04-03 14:00:00	14.75
3982	QF 2,19	ЗУ	China 8	051	2025-04-03 14:00:00	25.05
3983	Q8	ЗУ	DIG	061	2025-04-03 14:00:00	47.35
3984	Q4	ЗУ	BG 1	062	2025-04-03 14:00:00	0
3985	Q9	ЗУ	BG 2	063	2025-04-03 14:00:00	19.98
3986	Q10	ЗУ	SM 2	064	2025-04-03 14:00:00	32.13
3987	Q11	ЗУ	SM 3	065	2025-04-03 14:00:00	20.52
3988	Q12	ЗУ	SM 4	066	2025-04-03 14:00:00	21.85
3989	Q13	ЗУ	SM 5	067	2025-04-03 14:00:00	0
3990	Q14	ЗУ	SM 6	068	2025-04-03 14:00:00	0
3991	Q15	ЗУ	SM 7	069	2025-04-03 14:00:00	0
3992	Q16	ЗУ	SM 8	070	2025-04-03 14:00:00	0
3993	Q17	ЗУ	MO 9	071	2025-04-03 14:00:00	2.17
3994	Q20	ЗУ	MO 10	072	2025-04-03 14:00:00	0
3995	Q21	ЗУ	MO 11	073	2025-04-03 14:00:00	13.92
3996	Q22	ЗУ	MO 12	074	2025-04-03 14:00:00	0
3997	Q23	ЗУ	MO 13	075	2025-04-03 14:00:00	24.44
3998	Q24	ЗУ	MO 14	076	2025-04-03 14:00:00	0
3999	Q25	ЗУ	MO 15	077	2025-04-03 14:00:00	15.68
4000	TP3	ЗУ	CP-300 New	078	2025-04-03 14:00:00	15.09
4001	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 14:30:00	19.19
4002	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 14:30:00	3.7
4003	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 14:30:00	13.49
4004	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 14:30:00	0.946
4005	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 14:30:00	0.7564
4006	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 14:30:00	0.7932
4007	QF 1,20	ЗУ	China 1	044	2025-04-03 14:30:00	22
4008	QF 1,21	ЗУ	China 2	045	2025-04-03 14:30:00	20.4
4009	QF 1,22	ЗУ	China 3	046	2025-04-03 14:30:00	23.06
4010	QF 2,20	ЗУ	China 4	047	2025-04-03 14:30:00	27.04
4011	QF 2,21	ЗУ	China 5	048	2025-04-03 14:30:00	30.6
4012	QF 2,22	ЗУ	China 6	049	2025-04-03 14:30:00	28.48
4013	QF 2,23	ЗУ	China 7	050	2025-04-03 14:30:00	14.31
4014	QF 2,19	ЗУ	China 8	051	2025-04-03 14:30:00	23.93
4015	Q8	ЗУ	DIG	061	2025-04-03 14:30:00	47.55
4016	Q4	ЗУ	BG 1	062	2025-04-03 14:30:00	0
4017	Q9	ЗУ	BG 2	063	2025-04-03 14:30:00	18.81
4018	Q10	ЗУ	SM 2	064	2025-04-03 14:30:00	32.18
4019	Q11	ЗУ	SM 3	065	2025-04-03 14:30:00	20.48
4020	Q12	ЗУ	SM 4	066	2025-04-03 14:30:00	21.9
4021	Q13	ЗУ	SM 5	067	2025-04-03 14:30:00	0
4022	Q14	ЗУ	SM 6	068	2025-04-03 14:30:00	0
4023	Q15	ЗУ	SM 7	069	2025-04-03 14:30:00	0
4024	Q16	ЗУ	SM 8	070	2025-04-03 14:30:00	0
4025	Q17	ЗУ	MO 9	071	2025-04-03 14:30:00	2.16
4026	Q20	ЗУ	MO 10	072	2025-04-03 14:30:00	0
4027	Q21	ЗУ	MO 11	073	2025-04-03 14:30:00	13.93
4028	Q22	ЗУ	MO 12	074	2025-04-03 14:30:00	0
4029	Q23	ЗУ	MO 13	075	2025-04-03 14:30:00	24.49
4030	Q24	ЗУ	MO 14	076	2025-04-03 14:30:00	0
4031	Q25	ЗУ	MO 15	077	2025-04-03 14:30:00	15.72
4032	TP3	ЗУ	CP-300 New	078	2025-04-03 14:30:00	17.58
4033	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 15:00:00	19.23
4034	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 15:00:00	3.79
4035	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 15:00:00	13.49
4036	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 15:00:00	2.94
4037	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 15:00:00	4.57
4038	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 15:00:00	5
4039	QF 1,20	ЗУ	China 1	044	2025-04-03 15:00:00	20.68
4040	QF 1,21	ЗУ	China 2	045	2025-04-03 15:00:00	20.27
4041	QF 1,22	ЗУ	China 3	046	2025-04-03 15:00:00	21.89
4042	QF 2,20	ЗУ	China 4	047	2025-04-03 15:00:00	26.54
4043	QF 2,21	ЗУ	China 5	048	2025-04-03 15:00:00	29.6
4044	QF 2,22	ЗУ	China 6	049	2025-04-03 15:00:00	27.23
4045	QF 2,23	ЗУ	China 7	050	2025-04-03 15:00:00	13.85
4046	QF 2,19	ЗУ	China 8	051	2025-04-03 15:00:00	23.2
4047	Q8	ЗУ	DIG	061	2025-04-03 15:00:00	43.34
4048	Q4	ЗУ	BG 1	062	2025-04-03 15:00:00	0
4049	Q9	ЗУ	BG 2	063	2025-04-03 15:00:00	19.92
4050	Q10	ЗУ	SM 2	064	2025-04-03 15:00:00	32.2
4051	Q11	ЗУ	SM 3	065	2025-04-03 15:00:00	20.43
4052	Q12	ЗУ	SM 4	066	2025-04-03 15:00:00	21.93
4053	Q13	ЗУ	SM 5	067	2025-04-03 15:00:00	0
4054	Q14	ЗУ	SM 6	068	2025-04-03 15:00:00	0
4055	Q15	ЗУ	SM 7	069	2025-04-03 15:00:00	0
4056	Q16	ЗУ	SM 8	070	2025-04-03 15:00:00	0
4057	Q17	ЗУ	MO 9	071	2025-04-03 15:00:00	2.19
4058	Q20	ЗУ	MO 10	072	2025-04-03 15:00:00	0
4059	Q21	ЗУ	MO 11	073	2025-04-03 15:00:00	13.95
4060	Q22	ЗУ	MO 12	074	2025-04-03 15:00:00	0
4061	Q23	ЗУ	MO 13	075	2025-04-03 15:00:00	24.5
4062	Q24	ЗУ	MO 14	076	2025-04-03 15:00:00	0
4063	Q25	ЗУ	MO 15	077	2025-04-03 15:00:00	15.73
4064	TP3	ЗУ	CP-300 New	078	2025-04-03 15:00:00	20.71
4065	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 15:30:00	19.24
4066	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 15:30:00	3.79
4067	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 15:30:00	13.52
4068	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 15:30:00	6.3
4069	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 15:30:00	13.17
4070	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 15:30:00	14.36
4071	QF 1,20	ЗУ	China 1	044	2025-04-03 15:30:00	19.18
4072	QF 1,21	ЗУ	China 2	045	2025-04-03 15:30:00	18.32
4073	QF 1,22	ЗУ	China 3	046	2025-04-03 15:30:00	20.51
4074	QF 2,20	ЗУ	China 4	047	2025-04-03 15:30:00	24.73
4075	QF 2,21	ЗУ	China 5	048	2025-04-03 15:30:00	27.32
4076	QF 2,22	ЗУ	China 6	049	2025-04-03 15:30:00	25.32
4077	QF 2,23	ЗУ	China 7	050	2025-04-03 15:30:00	12.57
4078	QF 2,19	ЗУ	China 8	051	2025-04-03 15:30:00	21.22
4079	Q8	ЗУ	DIG	061	2025-04-03 15:30:00	36.87
4080	Q4	ЗУ	BG 1	062	2025-04-03 15:30:00	0
4081	Q9	ЗУ	BG 2	063	2025-04-03 15:30:00	19.96
4082	Q10	ЗУ	SM 2	064	2025-04-03 15:30:00	32.32
4083	Q11	ЗУ	SM 3	065	2025-04-03 15:30:00	20.51
4084	Q12	ЗУ	SM 4	066	2025-04-03 15:30:00	22.05
4085	Q13	ЗУ	SM 5	067	2025-04-03 15:30:00	0
4086	Q14	ЗУ	SM 6	068	2025-04-03 15:30:00	0
4087	Q15	ЗУ	SM 7	069	2025-04-03 15:30:00	0
4088	Q16	ЗУ	SM 8	070	2025-04-03 15:30:00	0
4089	Q17	ЗУ	MO 9	071	2025-04-03 15:30:00	2.12
4090	Q20	ЗУ	MO 10	072	2025-04-03 15:30:00	0
4091	Q21	ЗУ	MO 11	073	2025-04-03 15:30:00	13.97
4092	Q22	ЗУ	MO 12	074	2025-04-03 15:30:00	0
4093	Q23	ЗУ	MO 13	075	2025-04-03 15:30:00	24.59
4094	Q24	ЗУ	MO 14	076	2025-04-03 15:30:00	0
4095	Q25	ЗУ	MO 15	077	2025-04-03 15:30:00	15.8
4096	TP3	ЗУ	CP-300 New	078	2025-04-03 15:30:00	23.55
4097	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 16:00:00	18.98
4098	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 16:00:00	3.65
4099	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 16:00:00	13.34
17375	Q8	ЗУ	DIG	061	2026-05-10 01:38:48.910128	46.37
4100	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 16:00:00	8.35
4101	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 16:00:00	18.91
4102	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 16:00:00	20.45
4103	QF 1,20	ЗУ	China 1	044	2025-04-03 16:00:00	18.29
4104	QF 1,21	ЗУ	China 2	045	2025-04-03 16:00:00	17.58
4105	QF 1,22	ЗУ	China 3	046	2025-04-03 16:00:00	19.94
4106	QF 2,20	ЗУ	China 4	047	2025-04-03 16:00:00	24.21
4107	QF 2,21	ЗУ	China 5	048	2025-04-03 16:00:00	27.07
4108	QF 2,22	ЗУ	China 6	049	2025-04-03 16:00:00	25.16
4109	QF 2,23	ЗУ	China 7	050	2025-04-03 16:00:00	12.62
4110	QF 2,19	ЗУ	China 8	051	2025-04-03 16:00:00	20.44
4111	Q8	ЗУ	DIG	061	2025-04-03 16:00:00	42.02
4112	Q4	ЗУ	BG 1	062	2025-04-03 16:00:00	0
4113	Q9	ЗУ	BG 2	063	2025-04-03 16:00:00	19.9
4114	Q10	ЗУ	SM 2	064	2025-04-03 16:00:00	32.3
4115	Q11	ЗУ	SM 3	065	2025-04-03 16:00:00	20.35
4116	Q12	ЗУ	SM 4	066	2025-04-03 16:00:00	22.12
4117	Q13	ЗУ	SM 5	067	2025-04-03 16:00:00	0
4118	Q14	ЗУ	SM 6	068	2025-04-03 16:00:00	0
4119	Q15	ЗУ	SM 7	069	2025-04-03 16:00:00	0
4120	Q16	ЗУ	SM 8	070	2025-04-03 16:00:00	0
4121	Q17	ЗУ	MO 9	071	2025-04-03 16:00:00	2.1
4122	Q20	ЗУ	MO 10	072	2025-04-03 16:00:00	0
4123	Q21	ЗУ	MO 11	073	2025-04-03 16:00:00	13.94
4124	Q22	ЗУ	MO 12	074	2025-04-03 16:00:00	0
4125	Q23	ЗУ	MO 13	075	2025-04-03 16:00:00	24.63
4126	Q24	ЗУ	MO 14	076	2025-04-03 16:00:00	0
4127	Q25	ЗУ	MO 15	077	2025-04-03 16:00:00	15.76
4128	TP3	ЗУ	CP-300 New	078	2025-04-03 16:00:00	25.75
4129	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 16:30:00	17.62
4130	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 16:30:00	3.44
4131	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 16:30:00	12.41
4132	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 16:30:00	9.44
4133	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 16:30:00	23.18
4134	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 16:30:00	25.02
4135	QF 1,20	ЗУ	China 1	044	2025-04-03 16:30:00	18.4
4136	QF 1,21	ЗУ	China 2	045	2025-04-03 16:30:00	17.5
4137	QF 1,22	ЗУ	China 3	046	2025-04-03 16:30:00	19.53
4138	QF 2,20	ЗУ	China 4	047	2025-04-03 16:30:00	23.32
4139	QF 2,21	ЗУ	China 5	048	2025-04-03 16:30:00	26.55
4140	QF 2,22	ЗУ	China 6	049	2025-04-03 16:30:00	24.34
4141	QF 2,23	ЗУ	China 7	050	2025-04-03 16:30:00	12.2
4142	QF 2,19	ЗУ	China 8	051	2025-04-03 16:30:00	20.47
4143	Q8	ЗУ	DIG	061	2025-04-03 16:30:00	50.54
4144	Q4	ЗУ	BG 1	062	2025-04-03 16:30:00	0
4145	Q9	ЗУ	BG 2	063	2025-04-03 16:30:00	19.85
4146	Q10	ЗУ	SM 2	064	2025-04-03 16:30:00	32.4
4147	Q11	ЗУ	SM 3	065	2025-04-03 16:30:00	20.24
4148	Q12	ЗУ	SM 4	066	2025-04-03 16:30:00	22.15
4149	Q13	ЗУ	SM 5	067	2025-04-03 16:30:00	0
4150	Q14	ЗУ	SM 6	068	2025-04-03 16:30:00	0
4151	Q15	ЗУ	SM 7	069	2025-04-03 16:30:00	0
4152	Q16	ЗУ	SM 8	070	2025-04-03 16:30:00	0
4153	Q17	ЗУ	MO 9	071	2025-04-03 16:30:00	1.99
4154	Q20	ЗУ	MO 10	072	2025-04-03 16:30:00	0
4155	Q21	ЗУ	MO 11	073	2025-04-03 16:30:00	13.95
4156	Q22	ЗУ	MO 12	074	2025-04-03 16:30:00	0
4157	Q23	ЗУ	MO 13	075	2025-04-03 16:30:00	21.13
4158	Q24	ЗУ	MO 14	076	2025-04-03 16:30:00	0
4159	Q25	ЗУ	MO 15	077	2025-04-03 16:30:00	15.83
4160	TP3	ЗУ	CP-300 New	078	2025-04-03 16:30:00	26.88
4161	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 17:00:00	6.53
4162	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 17:00:00	1.59
4163	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 17:00:00	4.26
4164	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 17:00:00	11.15
4165	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 17:00:00	29.81
4166	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 17:00:00	31.96
4167	QF 1,20	ЗУ	China 1	044	2025-04-03 17:00:00	18.02
4168	QF 1,21	ЗУ	China 2	045	2025-04-03 17:00:00	16.84
4169	QF 1,22	ЗУ	China 3	046	2025-04-03 17:00:00	18.79
4170	QF 2,20	ЗУ	China 4	047	2025-04-03 17:00:00	22.04
4171	QF 2,21	ЗУ	China 5	048	2025-04-03 17:00:00	25.39
4172	QF 2,22	ЗУ	China 6	049	2025-04-03 17:00:00	23.42
4173	QF 2,23	ЗУ	China 7	050	2025-04-03 17:00:00	11.7
4174	QF 2,19	ЗУ	China 8	051	2025-04-03 17:00:00	19.93
4175	Q8	ЗУ	DIG	061	2025-04-03 17:00:00	54.86
4176	Q4	ЗУ	BG 1	062	2025-04-03 17:00:00	0
4177	Q9	ЗУ	BG 2	063	2025-04-03 17:00:00	19.86
4178	Q10	ЗУ	SM 2	064	2025-04-03 17:00:00	32.05
4179	Q11	ЗУ	SM 3	065	2025-04-03 17:00:00	20.1
4180	Q12	ЗУ	SM 4	066	2025-04-03 17:00:00	22.25
4181	Q13	ЗУ	SM 5	067	2025-04-03 17:00:00	0
4182	Q14	ЗУ	SM 6	068	2025-04-03 17:00:00	0
4183	Q15	ЗУ	SM 7	069	2025-04-03 17:00:00	0
4184	Q16	ЗУ	SM 8	070	2025-04-03 17:00:00	0
4185	Q17	ЗУ	MO 9	071	2025-04-03 17:00:00	2
4186	Q20	ЗУ	MO 10	072	2025-04-03 17:00:00	0
4187	Q21	ЗУ	MO 11	073	2025-04-03 17:00:00	13.92
4188	Q22	ЗУ	MO 12	074	2025-04-03 17:00:00	0
4189	Q23	ЗУ	MO 13	075	2025-04-03 17:00:00	15.59
4190	Q24	ЗУ	MO 14	076	2025-04-03 17:00:00	0
4191	Q25	ЗУ	MO 15	077	2025-04-03 17:00:00	15.87
4192	TP3	ЗУ	CP-300 New	078	2025-04-03 17:00:00	30.41
4193	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 17:30:00	0
4194	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 17:30:00	0.0007
4195	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 17:30:00	0.0029
4196	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 17:30:00	10.87
4197	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 17:30:00	29.74
4198	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 17:30:00	31.86
4199	QF 1,20	ЗУ	China 1	044	2025-04-03 17:30:00	17.57
4200	QF 1,21	ЗУ	China 2	045	2025-04-03 17:30:00	16.43
4201	QF 1,22	ЗУ	China 3	046	2025-04-03 17:30:00	18.25
4202	QF 2,20	ЗУ	China 4	047	2025-04-03 17:30:00	21.38
4203	QF 2,21	ЗУ	China 5	048	2025-04-03 17:30:00	24.96
4204	QF 2,22	ЗУ	China 6	049	2025-04-03 17:30:00	22.65
4205	QF 2,23	ЗУ	China 7	050	2025-04-03 17:30:00	11.48
4206	QF 2,19	ЗУ	China 8	051	2025-04-03 17:30:00	19.39
4207	Q8	ЗУ	DIG	061	2025-04-03 17:30:00	54.83
4208	Q4	ЗУ	BG 1	062	2025-04-03 17:30:00	0
4209	Q9	ЗУ	BG 2	063	2025-04-03 17:30:00	19.87
4210	Q10	ЗУ	SM 2	064	2025-04-03 17:30:00	30.95
4211	Q11	ЗУ	SM 3	065	2025-04-03 17:30:00	19.87
4212	Q12	ЗУ	SM 4	066	2025-04-03 17:30:00	22.3
4213	Q13	ЗУ	SM 5	067	2025-04-03 17:30:00	0
4214	Q14	ЗУ	SM 6	068	2025-04-03 17:30:00	0
4215	Q15	ЗУ	SM 7	069	2025-04-03 17:30:00	0
4216	Q16	ЗУ	SM 8	070	2025-04-03 17:30:00	0
4217	Q17	ЗУ	MO 9	071	2025-04-03 17:30:00	2
4218	Q20	ЗУ	MO 10	072	2025-04-03 17:30:00	0
4219	Q21	ЗУ	MO 11	073	2025-04-03 17:30:00	13.92
4220	Q22	ЗУ	MO 12	074	2025-04-03 17:30:00	0
4221	Q23	ЗУ	MO 13	075	2025-04-03 17:30:00	15.59
4222	Q24	ЗУ	MO 14	076	2025-04-03 17:30:00	0
4223	Q25	ЗУ	MO 15	077	2025-04-03 17:30:00	15.76
4224	TP3	ЗУ	CP-300 New	078	2025-04-03 17:30:00	31
4225	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 18:00:00	0
4226	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 18:00:00	0.0014
4227	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 18:00:00	0.0034
4228	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 18:00:00	10.22
4229	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 18:00:00	29.72
4230	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 18:00:00	31.47
4231	QF 1,20	ЗУ	China 1	044	2025-04-03 18:00:00	17.06
4232	QF 1,21	ЗУ	China 2	045	2025-04-03 18:00:00	15.77
4233	QF 1,22	ЗУ	China 3	046	2025-04-03 18:00:00	17.98
4234	QF 2,20	ЗУ	China 4	047	2025-04-03 18:00:00	20.9
4235	QF 2,21	ЗУ	China 5	048	2025-04-03 18:00:00	24.35
4236	QF 2,22	ЗУ	China 6	049	2025-04-03 18:00:00	22.09
4237	QF 2,23	ЗУ	China 7	050	2025-04-03 18:00:00	11.1
4238	QF 2,19	ЗУ	China 8	051	2025-04-03 18:00:00	19.09
4239	Q8	ЗУ	DIG	061	2025-04-03 18:00:00	53.2
4240	Q4	ЗУ	BG 1	062	2025-04-03 18:00:00	0
4241	Q9	ЗУ	BG 2	063	2025-04-03 18:00:00	19.92
4242	Q10	ЗУ	SM 2	064	2025-04-03 18:00:00	30.93
4243	Q11	ЗУ	SM 3	065	2025-04-03 18:00:00	19.79
4244	Q12	ЗУ	SM 4	066	2025-04-03 18:00:00	22.27
4245	Q13	ЗУ	SM 5	067	2025-04-03 18:00:00	0
4246	Q14	ЗУ	SM 6	068	2025-04-03 18:00:00	0
4247	Q15	ЗУ	SM 7	069	2025-04-03 18:00:00	0
4248	Q16	ЗУ	SM 8	070	2025-04-03 18:00:00	0
4249	Q17	ЗУ	MO 9	071	2025-04-03 18:00:00	2.01
4250	Q20	ЗУ	MO 10	072	2025-04-03 18:00:00	0
4251	Q21	ЗУ	MO 11	073	2025-04-03 18:00:00	13.92
4252	Q22	ЗУ	MO 12	074	2025-04-03 18:00:00	0
4253	Q23	ЗУ	MO 13	075	2025-04-03 18:00:00	15.55
4254	Q24	ЗУ	MO 14	076	2025-04-03 18:00:00	0
4255	Q25	ЗУ	MO 15	077	2025-04-03 18:00:00	15.81
4256	TP3	ЗУ	CP-300 New	078	2025-04-03 18:00:00	33.68
4257	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 18:30:00	0
4258	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 18:30:00	0.0013
4259	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 18:30:00	0.0036
4260	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 18:30:00	7.65
4261	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 18:30:00	23.61
4262	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 18:30:00	24.9
4263	QF 1,20	ЗУ	China 1	044	2025-04-03 18:30:00	16.77
4264	QF 1,21	ЗУ	China 2	045	2025-04-03 18:30:00	14.98
4265	QF 1,22	ЗУ	China 3	046	2025-04-03 18:30:00	17.25
4266	QF 2,20	ЗУ	China 4	047	2025-04-03 18:30:00	19.95
4267	QF 2,21	ЗУ	China 5	048	2025-04-03 18:30:00	23.43
4268	QF 2,22	ЗУ	China 6	049	2025-04-03 18:30:00	20.89
4269	QF 2,23	ЗУ	China 7	050	2025-04-03 18:30:00	10.73
4270	QF 2,19	ЗУ	China 8	051	2025-04-03 18:30:00	18.15
4271	Q8	ЗУ	DIG	061	2025-04-03 18:30:00	62.72
4272	Q4	ЗУ	BG 1	062	2025-04-03 18:30:00	0
4273	Q9	ЗУ	BG 2	063	2025-04-03 18:30:00	19.87
4274	Q10	ЗУ	SM 2	064	2025-04-03 18:30:00	31.43
4275	Q11	ЗУ	SM 3	065	2025-04-03 18:30:00	19.8
4276	Q12	ЗУ	SM 4	066	2025-04-03 18:30:00	22.22
4277	Q13	ЗУ	SM 5	067	2025-04-03 18:30:00	0
4278	Q14	ЗУ	SM 6	068	2025-04-03 18:30:00	0
4279	Q15	ЗУ	SM 7	069	2025-04-03 18:30:00	0
4280	Q16	ЗУ	SM 8	070	2025-04-03 18:30:00	0
4281	Q17	ЗУ	MO 9	071	2025-04-03 18:30:00	1.99
4282	Q20	ЗУ	MO 10	072	2025-04-03 18:30:00	0
4283	Q21	ЗУ	MO 11	073	2025-04-03 18:30:00	13.91
4284	Q22	ЗУ	MO 12	074	2025-04-03 18:30:00	0
4285	Q23	ЗУ	MO 13	075	2025-04-03 18:30:00	9.49
4286	Q24	ЗУ	MO 14	076	2025-04-03 18:30:00	0
4287	Q25	ЗУ	MO 15	077	2025-04-03 18:30:00	15.86
4288	TP3	ЗУ	CP-300 New	078	2025-04-03 18:30:00	37.15
4289	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 19:00:00	0
4290	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 19:00:00	0.0014
4291	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 19:00:00	0.0035
4292	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 19:00:00	5.88
4293	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 19:00:00	28.56
4294	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 19:00:00	30
4295	QF 1,20	ЗУ	China 1	044	2025-04-03 19:00:00	16.56
4296	QF 1,21	ЗУ	China 2	045	2025-04-03 19:00:00	15.11
4297	QF 1,22	ЗУ	China 3	046	2025-04-03 19:00:00	17.05
4298	QF 2,20	ЗУ	China 4	047	2025-04-03 19:00:00	20.17
4299	QF 2,21	ЗУ	China 5	048	2025-04-03 19:00:00	23.06
4300	QF 2,22	ЗУ	China 6	049	2025-04-03 19:00:00	21.17
4301	QF 2,23	ЗУ	China 7	050	2025-04-03 19:00:00	10.72
4302	QF 2,19	ЗУ	China 8	051	2025-04-03 19:00:00	18.46
4303	Q8	ЗУ	DIG	061	2025-04-03 19:00:00	68.98
4304	Q4	ЗУ	BG 1	062	2025-04-03 19:00:00	0
4305	Q9	ЗУ	BG 2	063	2025-04-03 19:00:00	19.8
4306	Q10	ЗУ	SM 2	064	2025-04-03 19:00:00	32.38
4307	Q11	ЗУ	SM 3	065	2025-04-03 19:00:00	19.82
4308	Q12	ЗУ	SM 4	066	2025-04-03 19:00:00	22.2
4309	Q13	ЗУ	SM 5	067	2025-04-03 19:00:00	0
4310	Q14	ЗУ	SM 6	068	2025-04-03 19:00:00	0
4311	Q15	ЗУ	SM 7	069	2025-04-03 19:00:00	0
4312	Q16	ЗУ	SM 8	070	2025-04-03 19:00:00	0
4313	Q17	ЗУ	MO 9	071	2025-04-03 19:00:00	1.97
4314	Q20	ЗУ	MO 10	072	2025-04-03 19:00:00	0
4315	Q21	ЗУ	MO 11	073	2025-04-03 19:00:00	13.94
4316	Q22	ЗУ	MO 12	074	2025-04-03 19:00:00	0
4317	Q23	ЗУ	MO 13	075	2025-04-03 19:00:00	0
4318	Q24	ЗУ	MO 14	076	2025-04-03 19:00:00	0
4319	Q25	ЗУ	MO 15	077	2025-04-03 19:00:00	15.91
4320	TP3	ЗУ	CP-300 New	078	2025-04-03 19:00:00	41.81
4321	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 19:30:00	0
4322	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 19:30:00	0.0013
4323	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 19:30:00	0.0032
4324	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 19:30:00	5
4325	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 19:30:00	28.51
4326	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 19:30:00	29.85
4327	QF 1,20	ЗУ	China 1	044	2025-04-03 19:30:00	14.03
4328	QF 1,21	ЗУ	China 2	045	2025-04-03 19:30:00	12.98
4329	QF 1,22	ЗУ	China 3	046	2025-04-03 19:30:00	15.21
4330	QF 2,20	ЗУ	China 4	047	2025-04-03 19:30:00	18.14
4331	QF 2,21	ЗУ	China 5	048	2025-04-03 19:30:00	21.02
4332	QF 2,22	ЗУ	China 6	049	2025-04-03 19:30:00	19.47
4333	QF 2,23	ЗУ	China 7	050	2025-04-03 19:30:00	9.73
4334	QF 2,19	ЗУ	China 8	051	2025-04-03 19:30:00	16.69
4335	Q8	ЗУ	DIG	061	2025-04-03 19:30:00	77.3
4336	Q4	ЗУ	BG 1	062	2025-04-03 19:30:00	0
4337	Q9	ЗУ	BG 2	063	2025-04-03 19:30:00	19.88
4338	Q10	ЗУ	SM 2	064	2025-04-03 19:30:00	32.39
4339	Q11	ЗУ	SM 3	065	2025-04-03 19:30:00	19.87
4340	Q12	ЗУ	SM 4	066	2025-04-03 19:30:00	22.33
4341	Q13	ЗУ	SM 5	067	2025-04-03 19:30:00	0
4342	Q14	ЗУ	SM 6	068	2025-04-03 19:30:00	0
4343	Q15	ЗУ	SM 7	069	2025-04-03 19:30:00	0
4344	Q16	ЗУ	SM 8	070	2025-04-03 19:30:00	0
4345	Q17	ЗУ	MO 9	071	2025-04-03 19:30:00	1.98
4346	Q20	ЗУ	MO 10	072	2025-04-03 19:30:00	0
4347	Q21	ЗУ	MO 11	073	2025-04-03 19:30:00	13.92
4348	Q22	ЗУ	MO 12	074	2025-04-03 19:30:00	0
4349	Q23	ЗУ	MO 13	075	2025-04-03 19:30:00	0
4350	Q24	ЗУ	MO 14	076	2025-04-03 19:30:00	0
4351	Q25	ЗУ	MO 15	077	2025-04-03 19:30:00	15.91
4352	TP3	ЗУ	CP-300 New	078	2025-04-03 19:30:00	41.44
4353	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 20:00:00	0
4354	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 20:00:00	0.0014
4355	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 20:00:00	0.0032
4356	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 20:00:00	4.99
4357	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 20:00:00	28.49
4358	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 20:00:00	29.79
4359	QF 1,20	ЗУ	China 1	044	2025-04-03 20:00:00	12.86
4360	QF 1,21	ЗУ	China 2	045	2025-04-03 20:00:00	11.8
4361	QF 1,22	ЗУ	China 3	046	2025-04-03 20:00:00	14.03
4362	QF 2,20	ЗУ	China 4	047	2025-04-03 20:00:00	16.39
4363	QF 2,21	ЗУ	China 5	048	2025-04-03 20:00:00	19.01
4364	QF 2,22	ЗУ	China 6	049	2025-04-03 20:00:00	17.72
4365	QF 2,23	ЗУ	China 7	050	2025-04-03 20:00:00	8.89
4366	QF 2,19	ЗУ	China 8	051	2025-04-03 20:00:00	15.2
4367	Q8	ЗУ	DIG	061	2025-04-03 20:00:00	82.56
4368	Q4	ЗУ	BG 1	062	2025-04-03 20:00:00	0
4369	Q9	ЗУ	BG 2	063	2025-04-03 20:00:00	19.95
4370	Q10	ЗУ	SM 2	064	2025-04-03 20:00:00	32.29
4371	Q11	ЗУ	SM 3	065	2025-04-03 20:00:00	19.88
4372	Q12	ЗУ	SM 4	066	2025-04-03 20:00:00	22.57
4373	Q13	ЗУ	SM 5	067	2025-04-03 20:00:00	0
4374	Q14	ЗУ	SM 6	068	2025-04-03 20:00:00	0
4375	Q15	ЗУ	SM 7	069	2025-04-03 20:00:00	0
4376	Q16	ЗУ	SM 8	070	2025-04-03 20:00:00	0
4377	Q17	ЗУ	MO 9	071	2025-04-03 20:00:00	2.03
4378	Q20	ЗУ	MO 10	072	2025-04-03 20:00:00	0
4379	Q21	ЗУ	MO 11	073	2025-04-03 20:00:00	13.94
4380	Q22	ЗУ	MO 12	074	2025-04-03 20:00:00	0
4381	Q23	ЗУ	MO 13	075	2025-04-03 20:00:00	0
4382	Q24	ЗУ	MO 14	076	2025-04-03 20:00:00	0
4383	Q25	ЗУ	MO 15	077	2025-04-03 20:00:00	15.86
4384	TP3	ЗУ	CP-300 New	078	2025-04-03 20:00:00	41.38
4385	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 20:30:00	0
4386	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 20:30:00	0.0008
4387	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 20:30:00	0.003
4388	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 20:30:00	4.7
4389	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 20:30:00	25.97
4390	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 20:30:00	27.25
4391	QF 1,20	ЗУ	China 1	044	2025-04-03 20:30:00	11.2
4392	QF 1,21	ЗУ	China 2	045	2025-04-03 20:30:00	10.26
4393	QF 1,22	ЗУ	China 3	046	2025-04-03 20:30:00	12.59
4394	QF 2,20	ЗУ	China 4	047	2025-04-03 20:30:00	14.84
4395	QF 2,21	ЗУ	China 5	048	2025-04-03 20:30:00	17
4396	QF 2,22	ЗУ	China 6	049	2025-04-03 20:30:00	15.54
4397	QF 2,23	ЗУ	China 7	050	2025-04-03 20:30:00	7.99
4398	QF 2,19	ЗУ	China 8	051	2025-04-03 20:30:00	13.71
4399	Q8	ЗУ	DIG	061	2025-04-03 20:30:00	87.84
4400	Q4	ЗУ	BG 1	062	2025-04-03 20:30:00	0
4401	Q9	ЗУ	BG 2	063	2025-04-03 20:30:00	19.96
4402	Q10	ЗУ	SM 2	064	2025-04-03 20:30:00	32.29
4403	Q11	ЗУ	SM 3	065	2025-04-03 20:30:00	19.88
4404	Q12	ЗУ	SM 4	066	2025-04-03 20:30:00	22.65
4405	Q13	ЗУ	SM 5	067	2025-04-03 20:30:00	0
4406	Q14	ЗУ	SM 6	068	2025-04-03 20:30:00	0
4407	Q15	ЗУ	SM 7	069	2025-04-03 20:30:00	0
4408	Q16	ЗУ	SM 8	070	2025-04-03 20:30:00	0
4409	Q17	ЗУ	MO 9	071	2025-04-03 20:30:00	2.04
4410	Q20	ЗУ	MO 10	072	2025-04-03 20:30:00	0
4411	Q21	ЗУ	MO 11	073	2025-04-03 20:30:00	13.9
4412	Q22	ЗУ	MO 12	074	2025-04-03 20:30:00	0
4413	Q23	ЗУ	MO 13	075	2025-04-03 20:30:00	0
4414	Q24	ЗУ	MO 14	076	2025-04-03 20:30:00	0
4415	Q25	ЗУ	MO 15	077	2025-04-03 20:30:00	15.85
4416	TP3	ЗУ	CP-300 New	078	2025-04-03 20:30:00	44.14
4417	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 21:00:00	0
4418	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 21:00:00	0.0012
4419	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 21:00:00	0.003
4420	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 21:00:00	4.65
4421	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 21:00:00	18.07
4422	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 21:00:00	19.51
4423	QF 1,20	ЗУ	China 1	044	2025-04-03 21:00:00	9.5
4424	QF 1,21	ЗУ	China 2	045	2025-04-03 21:00:00	8.42
4425	QF 1,22	ЗУ	China 3	046	2025-04-03 21:00:00	10.64
4426	QF 2,20	ЗУ	China 4	047	2025-04-03 21:00:00	13.16
4427	QF 2,21	ЗУ	China 5	048	2025-04-03 21:00:00	14.96
4428	QF 2,22	ЗУ	China 6	049	2025-04-03 21:00:00	13.25
4429	QF 2,23	ЗУ	China 7	050	2025-04-03 21:00:00	6.97
4430	QF 2,19	ЗУ	China 8	051	2025-04-03 21:00:00	12.27
4431	Q8	ЗУ	DIG	061	2025-04-03 21:00:00	91.48
4432	Q4	ЗУ	BG 1	062	2025-04-03 21:00:00	0
4433	Q9	ЗУ	BG 2	063	2025-04-03 21:00:00	19.93
4434	Q10	ЗУ	SM 2	064	2025-04-03 21:00:00	31.96
4435	Q11	ЗУ	SM 3	065	2025-04-03 21:00:00	19.99
4436	Q12	ЗУ	SM 4	066	2025-04-03 21:00:00	22.72
4437	Q13	ЗУ	SM 5	067	2025-04-03 21:00:00	0
4438	Q14	ЗУ	SM 6	068	2025-04-03 21:00:00	0
4439	Q15	ЗУ	SM 7	069	2025-04-03 21:00:00	0
4440	Q16	ЗУ	SM 8	070	2025-04-03 21:00:00	0
4441	Q17	ЗУ	MO 9	071	2025-04-03 21:00:00	2
4442	Q20	ЗУ	MO 10	072	2025-04-03 21:00:00	0
4443	Q21	ЗУ	MO 11	073	2025-04-03 21:00:00	13.86
4444	Q22	ЗУ	MO 12	074	2025-04-03 21:00:00	0
4445	Q23	ЗУ	MO 13	075	2025-04-03 21:00:00	0
4446	Q24	ЗУ	MO 14	076	2025-04-03 21:00:00	0
4447	Q25	ЗУ	MO 15	077	2025-04-03 21:00:00	15.95
4448	TP3	ЗУ	CP-300 New	078	2025-04-03 21:00:00	49.71
4449	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 21:30:00	0
4450	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 21:30:00	0.0005
4451	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 21:30:00	0.0027
4452	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 21:30:00	4.88
4453	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 21:30:00	18.21
4454	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 21:30:00	19.62
4455	QF 1,20	ЗУ	China 1	044	2025-04-03 21:30:00	7.83
4456	QF 1,21	ЗУ	China 2	045	2025-04-03 21:30:00	6.73
4457	QF 1,22	ЗУ	China 3	046	2025-04-03 21:30:00	8.5
4458	QF 2,20	ЗУ	China 4	047	2025-04-03 21:30:00	11.64
4459	QF 2,21	ЗУ	China 5	048	2025-04-03 21:30:00	13.52
4460	QF 2,22	ЗУ	China 6	049	2025-04-03 21:30:00	11.63
4461	QF 2,23	ЗУ	China 7	050	2025-04-03 21:30:00	6.16
4462	QF 2,19	ЗУ	China 8	051	2025-04-03 21:30:00	10.01
4463	Q8	ЗУ	DIG	061	2025-04-03 21:30:00	92.55
4464	Q4	ЗУ	BG 1	062	2025-04-03 21:30:00	0
4465	Q9	ЗУ	BG 2	063	2025-04-03 21:30:00	19.9
4466	Q10	ЗУ	SM 2	064	2025-04-03 21:30:00	31.43
4467	Q11	ЗУ	SM 3	065	2025-04-03 21:30:00	20.02
4468	Q12	ЗУ	SM 4	066	2025-04-03 21:30:00	22.84
4469	Q13	ЗУ	SM 5	067	2025-04-03 21:30:00	0
4470	Q14	ЗУ	SM 6	068	2025-04-03 21:30:00	0
4471	Q15	ЗУ	SM 7	069	2025-04-03 21:30:00	0
4472	Q16	ЗУ	SM 8	070	2025-04-03 21:30:00	0
4473	Q17	ЗУ	MO 9	071	2025-04-03 21:30:00	1.98
4474	Q20	ЗУ	MO 10	072	2025-04-03 21:30:00	0
4475	Q21	ЗУ	MO 11	073	2025-04-03 21:30:00	13.82
4476	Q22	ЗУ	MO 12	074	2025-04-03 21:30:00	0
4477	Q23	ЗУ	MO 13	075	2025-04-03 21:30:00	0
4478	Q24	ЗУ	MO 14	076	2025-04-03 21:30:00	0
4479	Q25	ЗУ	MO 15	077	2025-04-03 21:30:00	15.94
4480	TP3	ЗУ	CP-300 New	078	2025-04-03 21:30:00	51.82
4481	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 22:00:00	0
4482	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 22:00:00	0.0011
4483	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 22:00:00	0.003
4484	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 22:00:00	4.78
4485	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 22:00:00	18.14
4486	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 22:00:00	19.63
4487	QF 1,20	ЗУ	China 1	044	2025-04-03 22:00:00	6.77
4488	QF 1,21	ЗУ	China 2	045	2025-04-03 22:00:00	5.45
4489	QF 1,22	ЗУ	China 3	046	2025-04-03 22:00:00	7.83
4490	QF 2,20	ЗУ	China 4	047	2025-04-03 22:00:00	10.94
4491	QF 2,21	ЗУ	China 5	048	2025-04-03 22:00:00	13.08
4492	QF 2,22	ЗУ	China 6	049	2025-04-03 22:00:00	10.94
4493	QF 2,23	ЗУ	China 7	050	2025-04-03 22:00:00	5.91
4494	QF 2,19	ЗУ	China 8	051	2025-04-03 22:00:00	9.4
4495	Q8	ЗУ	DIG	061	2025-04-03 22:00:00	95.28
4496	Q4	ЗУ	BG 1	062	2025-04-03 22:00:00	0
4497	Q9	ЗУ	BG 2	063	2025-04-03 22:00:00	19.89
4498	Q10	ЗУ	SM 2	064	2025-04-03 22:00:00	29.58
4499	Q11	ЗУ	SM 3	065	2025-04-03 22:00:00	19.96
4500	Q12	ЗУ	SM 4	066	2025-04-03 22:00:00	23.03
4501	Q13	ЗУ	SM 5	067	2025-04-03 22:00:00	0
4502	Q14	ЗУ	SM 6	068	2025-04-03 22:00:00	0
4503	Q15	ЗУ	SM 7	069	2025-04-03 22:00:00	0
4504	Q16	ЗУ	SM 8	070	2025-04-03 22:00:00	0
4505	Q17	ЗУ	MO 9	071	2025-04-03 22:00:00	1.98
4506	Q20	ЗУ	MO 10	072	2025-04-03 22:00:00	0
4507	Q21	ЗУ	MO 11	073	2025-04-03 22:00:00	13.79
4508	Q22	ЗУ	MO 12	074	2025-04-03 22:00:00	0
4509	Q23	ЗУ	MO 13	075	2025-04-03 22:00:00	0
4510	Q24	ЗУ	MO 14	076	2025-04-03 22:00:00	0
4511	Q25	ЗУ	MO 15	077	2025-04-03 22:00:00	15.85
4512	TP3	ЗУ	CP-300 New	078	2025-04-03 22:00:00	52.89
4513	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 22:30:00	0
4514	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 22:30:00	0.0006
4515	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 22:30:00	0.0027
4516	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 22:30:00	4.91
4517	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 22:30:00	18.16
4518	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 22:30:00	19.6
4519	QF 1,20	ЗУ	China 1	044	2025-04-03 22:30:00	5.4
4520	QF 1,21	ЗУ	China 2	045	2025-04-03 22:30:00	4.07
4521	QF 1,22	ЗУ	China 3	046	2025-04-03 22:30:00	6.59
4522	QF 2,20	ЗУ	China 4	047	2025-04-03 22:30:00	9.28
4523	QF 2,21	ЗУ	China 5	048	2025-04-03 22:30:00	11.99
4524	QF 2,22	ЗУ	China 6	049	2025-04-03 22:30:00	9.86
4525	QF 2,23	ЗУ	China 7	050	2025-04-03 22:30:00	5.16
4526	QF 2,19	ЗУ	China 8	051	2025-04-03 22:30:00	8.53
4527	Q8	ЗУ	DIG	061	2025-04-03 22:30:00	95.96
4528	Q4	ЗУ	BG 1	062	2025-04-03 22:30:00	0
4529	Q9	ЗУ	BG 2	063	2025-04-03 22:30:00	19.92
4530	Q10	ЗУ	SM 2	064	2025-04-03 22:30:00	23.6
4531	Q11	ЗУ	SM 3	065	2025-04-03 22:30:00	20.2
4532	Q12	ЗУ	SM 4	066	2025-04-03 22:30:00	23.04
4533	Q13	ЗУ	SM 5	067	2025-04-03 22:30:00	0
4534	Q14	ЗУ	SM 6	068	2025-04-03 22:30:00	0
4535	Q15	ЗУ	SM 7	069	2025-04-03 22:30:00	0
4536	Q16	ЗУ	SM 8	070	2025-04-03 22:30:00	0
4537	Q17	ЗУ	MO 9	071	2025-04-03 22:30:00	1.95
4538	Q20	ЗУ	MO 10	072	2025-04-03 22:30:00	0
4539	Q21	ЗУ	MO 11	073	2025-04-03 22:30:00	13.86
4540	Q22	ЗУ	MO 12	074	2025-04-03 22:30:00	0
4541	Q23	ЗУ	MO 13	075	2025-04-03 22:30:00	0
4542	Q24	ЗУ	MO 14	076	2025-04-03 22:30:00	0
4543	Q25	ЗУ	MO 15	077	2025-04-03 22:30:00	15.92
4544	TP3	ЗУ	CP-300 New	078	2025-04-03 22:30:00	54.99
4545	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 23:00:00	0.7833
4546	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 23:00:00	0.6508
4547	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 23:00:00	0.1339
4548	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 23:00:00	4.9
4549	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 23:00:00	17.95
4550	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 23:00:00	19.5
4551	QF 1,20	ЗУ	China 1	044	2025-04-03 23:00:00	4.49
4552	QF 1,21	ЗУ	China 2	045	2025-04-03 23:00:00	3.11
4553	QF 1,22	ЗУ	China 3	046	2025-04-03 23:00:00	5.25
4554	QF 2,20	ЗУ	China 4	047	2025-04-03 23:00:00	8.34
4555	QF 2,21	ЗУ	China 5	048	2025-04-03 23:00:00	11.54
4556	QF 2,22	ЗУ	China 6	049	2025-04-03 23:00:00	8.31
4557	QF 2,23	ЗУ	China 7	050	2025-04-03 23:00:00	4.3
4558	QF 2,19	ЗУ	China 8	051	2025-04-03 23:00:00	7.81
4559	Q8	ЗУ	DIG	061	2025-04-03 23:00:00	95.07
4560	Q4	ЗУ	BG 1	062	2025-04-03 23:00:00	0
4561	Q9	ЗУ	BG 2	063	2025-04-03 23:00:00	19.9
4562	Q10	ЗУ	SM 2	064	2025-04-03 23:00:00	20.32
4563	Q11	ЗУ	SM 3	065	2025-04-03 23:00:00	20.18
4564	Q12	ЗУ	SM 4	066	2025-04-03 23:00:00	23.09
4565	Q13	ЗУ	SM 5	067	2025-04-03 23:00:00	0
4566	Q14	ЗУ	SM 6	068	2025-04-03 23:00:00	0
4567	Q15	ЗУ	SM 7	069	2025-04-03 23:00:00	0
4568	Q16	ЗУ	SM 8	070	2025-04-03 23:00:00	0
4569	Q17	ЗУ	MO 9	071	2025-04-03 23:00:00	1.98
4570	Q20	ЗУ	MO 10	072	2025-04-03 23:00:00	0
4571	Q21	ЗУ	MO 11	073	2025-04-03 23:00:00	13.87
4572	Q22	ЗУ	MO 12	074	2025-04-03 23:00:00	0
4573	Q23	ЗУ	MO 13	075	2025-04-03 23:00:00	0
4574	Q24	ЗУ	MO 14	076	2025-04-03 23:00:00	0
4575	Q25	ЗУ	MO 15	077	2025-04-03 23:00:00	15.9
4576	TP3	ЗУ	CP-300 New	078	2025-04-03 23:00:00	57.36
4577	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-03 23:30:00	5.72
4578	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-03 23:30:00	2.81
4579	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-03 23:30:00	2.42
4580	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-03 23:30:00	4.91
4581	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-03 23:30:00	18.06
4582	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-03 23:30:00	19.73
4583	QF 1,20	ЗУ	China 1	044	2025-04-03 23:30:00	3.78
4584	QF 1,21	ЗУ	China 2	045	2025-04-03 23:30:00	2.23
4585	QF 1,22	ЗУ	China 3	046	2025-04-03 23:30:00	2.91
4586	QF 2,20	ЗУ	China 4	047	2025-04-03 23:30:00	8.45
4587	QF 2,21	ЗУ	China 5	048	2025-04-03 23:30:00	11.94
4588	QF 2,22	ЗУ	China 6	049	2025-04-03 23:30:00	8.28
4589	QF 2,23	ЗУ	China 7	050	2025-04-03 23:30:00	4.24
4590	QF 2,19	ЗУ	China 8	051	2025-04-03 23:30:00	7.12
4591	Q8	ЗУ	DIG	061	2025-04-03 23:30:00	94.52
4592	Q4	ЗУ	BG 1	062	2025-04-03 23:30:00	0
4593	Q9	ЗУ	BG 2	063	2025-04-03 23:30:00	19.85
4594	Q10	ЗУ	SM 2	064	2025-04-03 23:30:00	11.9
4595	Q11	ЗУ	SM 3	065	2025-04-03 23:30:00	20.27
4596	Q12	ЗУ	SM 4	066	2025-04-03 23:30:00	23.1
4597	Q13	ЗУ	SM 5	067	2025-04-03 23:30:00	0
4598	Q14	ЗУ	SM 6	068	2025-04-03 23:30:00	0
4599	Q15	ЗУ	SM 7	069	2025-04-03 23:30:00	0
4600	Q16	ЗУ	SM 8	070	2025-04-03 23:30:00	0
4601	Q17	ЗУ	MO 9	071	2025-04-03 23:30:00	1.95
4602	Q20	ЗУ	MO 10	072	2025-04-03 23:30:00	0
4603	Q21	ЗУ	MO 11	073	2025-04-03 23:30:00	13.96
4604	Q22	ЗУ	MO 12	074	2025-04-03 23:30:00	0
4605	Q23	ЗУ	MO 13	075	2025-04-03 23:30:00	0
4606	Q24	ЗУ	MO 14	076	2025-04-03 23:30:00	0
4607	Q25	ЗУ	MO 15	077	2025-04-03 23:30:00	15.91
4608	TP3	ЗУ	CP-300 New	078	2025-04-03 23:30:00	56.47
4609	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 00:00:00	16.47
4610	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 00:00:00	6.25
4611	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 00:00:00	8.63
4612	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 00:00:00	4.08
4613	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 00:00:00	14.62
4614	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 00:00:00	15.94
4615	QF 1,20	ЗУ	China 1	044	2025-04-04 00:00:00	3.36
4616	QF 1,21	ЗУ	China 2	045	2025-04-04 00:00:00	1.84
4617	QF 1,22	ЗУ	China 3	046	2025-04-04 00:00:00	0.3061
4618	QF 2,20	ЗУ	China 4	047	2025-04-04 00:00:00	8.7
4619	QF 2,21	ЗУ	China 5	048	2025-04-04 00:00:00	12.5
4620	QF 2,22	ЗУ	China 6	049	2025-04-04 00:00:00	8.74
4621	QF 2,23	ЗУ	China 7	050	2025-04-04 00:00:00	4.27
4622	QF 2,19	ЗУ	China 8	051	2025-04-04 00:00:00	6.22
4623	Q8	ЗУ	DIG	061	2025-04-04 00:00:00	93.77
4624	Q4	ЗУ	BG 1	062	2025-04-04 00:00:00	0
4625	Q9	ЗУ	BG 2	063	2025-04-04 00:00:00	19.8
4626	Q10	ЗУ	SM 2	064	2025-04-04 00:00:00	5.48
4627	Q11	ЗУ	SM 3	065	2025-04-04 00:00:00	20.26
4628	Q12	ЗУ	SM 4	066	2025-04-04 00:00:00	23.02
4629	Q13	ЗУ	SM 5	067	2025-04-04 00:00:00	0
4630	Q14	ЗУ	SM 6	068	2025-04-04 00:00:00	0
4631	Q15	ЗУ	SM 7	069	2025-04-04 00:00:00	0
4632	Q16	ЗУ	SM 8	070	2025-04-04 00:00:00	0
4633	Q17	ЗУ	MO 9	071	2025-04-04 00:00:00	1.99
4634	Q20	ЗУ	MO 10	072	2025-04-04 00:00:00	0
4635	Q21	ЗУ	MO 11	073	2025-04-04 00:00:00	13.92
4636	Q22	ЗУ	MO 12	074	2025-04-04 00:00:00	0
4637	Q23	ЗУ	MO 13	075	2025-04-04 00:00:00	0
4638	Q24	ЗУ	MO 14	076	2025-04-04 00:00:00	0
4639	Q25	ЗУ	MO 15	077	2025-04-04 00:00:00	15.87
4640	TP3	ЗУ	CP-300 New	078	2025-04-04 00:00:00	62.76
4641	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 00:30:00	23.76
4642	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 00:30:00	8.5
4643	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 00:30:00	13.62
4644	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 00:30:00	1.29
4645	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 00:30:00	0.8715
4646	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 00:30:00	0.9197
4647	QF 1,20	ЗУ	China 1	044	2025-04-04 00:30:00	3.67
4648	QF 1,21	ЗУ	China 2	045	2025-04-04 00:30:00	2.2
4649	QF 1,22	ЗУ	China 3	046	2025-04-04 00:30:00	1.16
4650	QF 2,20	ЗУ	China 4	047	2025-04-04 00:30:00	9.79
4651	QF 2,21	ЗУ	China 5	048	2025-04-04 00:30:00	13.32
4652	QF 2,22	ЗУ	China 6	049	2025-04-04 00:30:00	9.51
4653	QF 2,23	ЗУ	China 7	050	2025-04-04 00:30:00	4.57
4654	QF 2,19	ЗУ	China 8	051	2025-04-04 00:30:00	6.4
4655	Q8	ЗУ	DIG	061	2025-04-04 00:30:00	93.22
4656	Q4	ЗУ	BG 1	062	2025-04-04 00:30:00	0
4657	Q9	ЗУ	BG 2	063	2025-04-04 00:30:00	19.81
4658	Q10	ЗУ	SM 2	064	2025-04-04 00:30:00	3.45
4659	Q11	ЗУ	SM 3	065	2025-04-04 00:30:00	20.24
4660	Q12	ЗУ	SM 4	066	2025-04-04 00:30:00	22.94
4661	Q13	ЗУ	SM 5	067	2025-04-04 00:30:00	0
4662	Q14	ЗУ	SM 6	068	2025-04-04 00:30:00	0
4663	Q15	ЗУ	SM 7	069	2025-04-04 00:30:00	0
4664	Q16	ЗУ	SM 8	070	2025-04-04 00:30:00	0
4665	Q17	ЗУ	MO 9	071	2025-04-04 00:30:00	2
4666	Q20	ЗУ	MO 10	072	2025-04-04 00:30:00	0
4667	Q21	ЗУ	MO 11	073	2025-04-04 00:30:00	13.91
4668	Q22	ЗУ	MO 12	074	2025-04-04 00:30:00	0
4669	Q23	ЗУ	MO 13	075	2025-04-04 00:30:00	0
4670	Q24	ЗУ	MO 14	076	2025-04-04 00:30:00	0
4671	Q25	ЗУ	MO 15	077	2025-04-04 00:30:00	15.78
4672	TP3	ЗУ	CP-300 New	078	2025-04-04 00:30:00	65.99
4673	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 01:00:00	28.31
4674	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 01:00:00	9.33
4675	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 01:00:00	17.4
4676	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 01:00:00	0.0019
4677	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 01:00:00	0
4678	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 01:00:00	0
4679	QF 1,20	ЗУ	China 1	044	2025-04-04 01:00:00	3.93
4680	QF 1,21	ЗУ	China 2	045	2025-04-04 01:00:00	2.6
4681	QF 1,22	ЗУ	China 3	046	2025-04-04 01:00:00	3.01
4682	QF 2,20	ЗУ	China 4	047	2025-04-04 01:00:00	10.79
4683	QF 2,21	ЗУ	China 5	048	2025-04-04 01:00:00	13.68
4684	QF 2,22	ЗУ	China 6	049	2025-04-04 01:00:00	10.3
4685	QF 2,23	ЗУ	China 7	050	2025-04-04 01:00:00	4.91
4686	QF 2,19	ЗУ	China 8	051	2025-04-04 01:00:00	6.62
4687	Q8	ЗУ	DIG	061	2025-04-04 01:00:00	86.67
4688	Q4	ЗУ	BG 1	062	2025-04-04 01:00:00	0
4689	Q9	ЗУ	BG 2	063	2025-04-04 01:00:00	19.88
4690	Q10	ЗУ	SM 2	064	2025-04-04 01:00:00	3.39
4691	Q11	ЗУ	SM 3	065	2025-04-04 01:00:00	20.25
4692	Q12	ЗУ	SM 4	066	2025-04-04 01:00:00	22.96
4693	Q13	ЗУ	SM 5	067	2025-04-04 01:00:00	0
4694	Q14	ЗУ	SM 6	068	2025-04-04 01:00:00	0
4695	Q15	ЗУ	SM 7	069	2025-04-04 01:00:00	0
4696	Q16	ЗУ	SM 8	070	2025-04-04 01:00:00	0
4697	Q17	ЗУ	MO 9	071	2025-04-04 01:00:00	1.91
4698	Q20	ЗУ	MO 10	072	2025-04-04 01:00:00	0
4699	Q21	ЗУ	MO 11	073	2025-04-04 01:00:00	13.9
4700	Q22	ЗУ	MO 12	074	2025-04-04 01:00:00	0
4701	Q23	ЗУ	MO 13	075	2025-04-04 01:00:00	0
4702	Q24	ЗУ	MO 14	076	2025-04-04 01:00:00	0
4703	Q25	ЗУ	MO 15	077	2025-04-04 01:00:00	15.79
4704	TP3	ЗУ	CP-300 New	078	2025-04-04 01:00:00	66.47
4705	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 01:30:00	37.19
4706	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 01:30:00	10.81
4707	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 01:30:00	24.7
4708	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 01:30:00	0.0021
4709	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 01:30:00	0
4710	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 01:30:00	0
4711	QF 1,20	ЗУ	China 1	044	2025-04-04 01:30:00	5.68
4712	QF 1,21	ЗУ	China 2	045	2025-04-04 01:30:00	4.43
4713	QF 1,22	ЗУ	China 3	046	2025-04-04 01:30:00	7.37
4714	QF 2,20	ЗУ	China 4	047	2025-04-04 01:30:00	14.32
4715	QF 2,21	ЗУ	China 5	048	2025-04-04 01:30:00	16.47
4716	QF 2,22	ЗУ	China 6	049	2025-04-04 01:30:00	13.01
4717	QF 2,23	ЗУ	China 7	050	2025-04-04 01:30:00	6.2
4718	QF 2,19	ЗУ	China 8	051	2025-04-04 01:30:00	8.24
4719	Q8	ЗУ	DIG	061	2025-04-04 01:30:00	81.18
4720	Q4	ЗУ	BG 1	062	2025-04-04 01:30:00	0
4721	Q9	ЗУ	BG 2	063	2025-04-04 01:30:00	19.93
4722	Q10	ЗУ	SM 2	064	2025-04-04 01:30:00	1.43
4723	Q11	ЗУ	SM 3	065	2025-04-04 01:30:00	20.28
4724	Q12	ЗУ	SM 4	066	2025-04-04 01:30:00	22.98
4725	Q13	ЗУ	SM 5	067	2025-04-04 01:30:00	0
4726	Q14	ЗУ	SM 6	068	2025-04-04 01:30:00	0
4727	Q15	ЗУ	SM 7	069	2025-04-04 01:30:00	0
4728	Q16	ЗУ	SM 8	070	2025-04-04 01:30:00	0
4729	Q17	ЗУ	MO 9	071	2025-04-04 01:30:00	1.91
4730	Q20	ЗУ	MO 10	072	2025-04-04 01:30:00	0
4731	Q21	ЗУ	MO 11	073	2025-04-04 01:30:00	13.94
4732	Q22	ЗУ	MO 12	074	2025-04-04 01:30:00	0
4733	Q23	ЗУ	MO 13	075	2025-04-04 01:30:00	0
4734	Q24	ЗУ	MO 14	076	2025-04-04 01:30:00	0
4735	Q25	ЗУ	MO 15	077	2025-04-04 01:30:00	15.83
4736	TP3	ЗУ	CP-300 New	078	2025-04-04 01:30:00	74.19
4737	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 02:00:00	37.07
4738	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 02:00:00	10.39
4739	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 02:00:00	25.07
4740	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 02:00:00	0.002
4741	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 02:00:00	0
4742	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 02:00:00	0
4743	QF 1,20	ЗУ	China 1	044	2025-04-04 02:00:00	6.42
4744	QF 1,21	ЗУ	China 2	045	2025-04-04 02:00:00	5.17
4745	QF 1,22	ЗУ	China 3	046	2025-04-04 02:00:00	8.09
4746	QF 2,20	ЗУ	China 4	047	2025-04-04 02:00:00	15.29
4747	QF 2,21	ЗУ	China 5	048	2025-04-04 02:00:00	17.51
4748	QF 2,22	ЗУ	China 6	049	2025-04-04 02:00:00	14.08
4749	QF 2,23	ЗУ	China 7	050	2025-04-04 02:00:00	6.65
4750	QF 2,19	ЗУ	China 8	051	2025-04-04 02:00:00	8.74
4751	Q8	ЗУ	DIG	061	2025-04-04 02:00:00	69.02
4752	Q4	ЗУ	BG 1	062	2025-04-04 02:00:00	0
4753	Q9	ЗУ	BG 2	063	2025-04-04 02:00:00	19.99
4754	Q10	ЗУ	SM 2	064	2025-04-04 02:00:00	1.3
4755	Q11	ЗУ	SM 3	065	2025-04-04 02:00:00	20.28
4756	Q12	ЗУ	SM 4	066	2025-04-04 02:00:00	23.01
4757	Q13	ЗУ	SM 5	067	2025-04-04 02:00:00	0
4758	Q14	ЗУ	SM 6	068	2025-04-04 02:00:00	0
4759	Q15	ЗУ	SM 7	069	2025-04-04 02:00:00	0
4760	Q16	ЗУ	SM 8	070	2025-04-04 02:00:00	0
4761	Q17	ЗУ	MO 9	071	2025-04-04 02:00:00	1.92
4762	Q20	ЗУ	MO 10	072	2025-04-04 02:00:00	0
4763	Q21	ЗУ	MO 11	073	2025-04-04 02:00:00	13.89
4764	Q22	ЗУ	MO 12	074	2025-04-04 02:00:00	0
4765	Q23	ЗУ	MO 13	075	2025-04-04 02:00:00	0
4766	Q24	ЗУ	MO 14	076	2025-04-04 02:00:00	0
4767	Q25	ЗУ	MO 15	077	2025-04-04 02:00:00	15.85
4768	TP3	ЗУ	CP-300 New	078	2025-04-04 02:00:00	73.01
4769	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 02:30:00	36.86
4770	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 02:30:00	9.76
4771	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 02:30:00	25.49
4772	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 02:30:00	0.002
4773	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 02:30:00	0
4774	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 02:30:00	0
4775	QF 1,20	ЗУ	China 1	044	2025-04-04 02:30:00	7.9
4776	QF 1,21	ЗУ	China 2	045	2025-04-04 02:30:00	6.25
4777	QF 1,22	ЗУ	China 3	046	2025-04-04 02:30:00	9.14
4778	QF 2,20	ЗУ	China 4	047	2025-04-04 02:30:00	16.34
4779	QF 2,21	ЗУ	China 5	048	2025-04-04 02:30:00	19.2
4780	QF 2,22	ЗУ	China 6	049	2025-04-04 02:30:00	15.89
4781	QF 2,23	ЗУ	China 7	050	2025-04-04 02:30:00	7.41
4782	QF 2,19	ЗУ	China 8	051	2025-04-04 02:30:00	9.54
4783	Q8	ЗУ	DIG	061	2025-04-04 02:30:00	77.67
4784	Q4	ЗУ	BG 1	062	2025-04-04 02:30:00	0
4785	Q9	ЗУ	BG 2	063	2025-04-04 02:30:00	19.94
4786	Q10	ЗУ	SM 2	064	2025-04-04 02:30:00	1.3
4787	Q11	ЗУ	SM 3	065	2025-04-04 02:30:00	20.23
4788	Q12	ЗУ	SM 4	066	2025-04-04 02:30:00	23.02
4789	Q13	ЗУ	SM 5	067	2025-04-04 02:30:00	0
4790	Q14	ЗУ	SM 6	068	2025-04-04 02:30:00	0
4791	Q15	ЗУ	SM 7	069	2025-04-04 02:30:00	0
4792	Q16	ЗУ	SM 8	070	2025-04-04 02:30:00	0
4793	Q17	ЗУ	MO 9	071	2025-04-04 02:30:00	1.92
4794	Q20	ЗУ	MO 10	072	2025-04-04 02:30:00	0
4795	Q21	ЗУ	MO 11	073	2025-04-04 02:30:00	13.86
4796	Q22	ЗУ	MO 12	074	2025-04-04 02:30:00	0
4797	Q23	ЗУ	MO 13	075	2025-04-04 02:30:00	0
4798	Q24	ЗУ	MO 14	076	2025-04-04 02:30:00	0
4799	Q25	ЗУ	MO 15	077	2025-04-04 02:30:00	15.82
4800	TP3	ЗУ	CP-300 New	078	2025-04-04 02:30:00	74.4
4801	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 03:00:00	24.45
4802	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 03:00:00	6.44
4803	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 03:00:00	17.42
4804	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 03:00:00	0.002
4805	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 03:00:00	0
4806	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 03:00:00	0
4807	QF 1,20	ЗУ	China 1	044	2025-04-04 03:00:00	8.46
4808	QF 1,21	ЗУ	China 2	045	2025-04-04 03:00:00	7.34
4809	QF 1,22	ЗУ	China 3	046	2025-04-04 03:00:00	9.77
4810	QF 2,20	ЗУ	China 4	047	2025-04-04 03:00:00	17.14
4811	QF 2,21	ЗУ	China 5	048	2025-04-04 03:00:00	19.53
4812	QF 2,22	ЗУ	China 6	049	2025-04-04 03:00:00	17.08
4813	QF 2,23	ЗУ	China 7	050	2025-04-04 03:00:00	7.86
4814	QF 2,19	ЗУ	China 8	051	2025-04-04 03:00:00	9.98
4815	Q8	ЗУ	DIG	061	2025-04-04 03:00:00	72.61
4816	Q4	ЗУ	BG 1	062	2025-04-04 03:00:00	0
4817	Q9	ЗУ	BG 2	063	2025-04-04 03:00:00	19.96
4818	Q10	ЗУ	SM 2	064	2025-04-04 03:00:00	1.31
4819	Q11	ЗУ	SM 3	065	2025-04-04 03:00:00	20.29
4820	Q12	ЗУ	SM 4	066	2025-04-04 03:00:00	23.02
4821	Q13	ЗУ	SM 5	067	2025-04-04 03:00:00	0
4822	Q14	ЗУ	SM 6	068	2025-04-04 03:00:00	0
4823	Q15	ЗУ	SM 7	069	2025-04-04 03:00:00	0
4824	Q16	ЗУ	SM 8	070	2025-04-04 03:00:00	0
4825	Q17	ЗУ	MO 9	071	2025-04-04 03:00:00	1.93
4826	Q20	ЗУ	MO 10	072	2025-04-04 03:00:00	0
4827	Q21	ЗУ	MO 11	073	2025-04-04 03:00:00	13.9
4828	Q22	ЗУ	MO 12	074	2025-04-04 03:00:00	0
4829	Q23	ЗУ	MO 13	075	2025-04-04 03:00:00	0
4830	Q24	ЗУ	MO 14	076	2025-04-04 03:00:00	0
4831	Q25	ЗУ	MO 15	077	2025-04-04 03:00:00	15.83
4832	TP3	ЗУ	CP-300 New	078	2025-04-04 03:00:00	71.94
4833	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 03:30:00	35.4
4834	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 03:30:00	5.93
4835	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 03:30:00	27.99
4836	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 03:30:00	0.0022
4837	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 03:30:00	0
4838	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 03:30:00	0
4839	QF 1,20	ЗУ	China 1	044	2025-04-04 03:30:00	8.57
4840	QF 1,21	ЗУ	China 2	045	2025-04-04 03:30:00	7.31
4841	QF 1,22	ЗУ	China 3	046	2025-04-04 03:30:00	9.88
4842	QF 2,20	ЗУ	China 4	047	2025-04-04 03:30:00	17.33
4843	QF 2,21	ЗУ	China 5	048	2025-04-04 03:30:00	19.02
4844	QF 2,22	ЗУ	China 6	049	2025-04-04 03:30:00	17.65
4845	QF 2,23	ЗУ	China 7	050	2025-04-04 03:30:00	8.1
4846	QF 2,19	ЗУ	China 8	051	2025-04-04 03:30:00	9.91
4847	Q8	ЗУ	DIG	061	2025-04-04 03:30:00	73.51
4848	Q4	ЗУ	BG 1	062	2025-04-04 03:30:00	0
4849	Q9	ЗУ	BG 2	063	2025-04-04 03:30:00	19.99
4850	Q10	ЗУ	SM 2	064	2025-04-04 03:30:00	1.3
4851	Q11	ЗУ	SM 3	065	2025-04-04 03:30:00	20.34
4852	Q12	ЗУ	SM 4	066	2025-04-04 03:30:00	22.93
4853	Q13	ЗУ	SM 5	067	2025-04-04 03:30:00	0
4854	Q14	ЗУ	SM 6	068	2025-04-04 03:30:00	0
4855	Q15	ЗУ	SM 7	069	2025-04-04 03:30:00	0
4856	Q16	ЗУ	SM 8	070	2025-04-04 03:30:00	0
4857	Q17	ЗУ	MO 9	071	2025-04-04 03:30:00	1.98
4858	Q20	ЗУ	MO 10	072	2025-04-04 03:30:00	0
4859	Q21	ЗУ	MO 11	073	2025-04-04 03:30:00	13.86
4860	Q22	ЗУ	MO 12	074	2025-04-04 03:30:00	0
4861	Q23	ЗУ	MO 13	075	2025-04-04 03:30:00	0
4862	Q24	ЗУ	MO 14	076	2025-04-04 03:30:00	0
4863	Q25	ЗУ	MO 15	077	2025-04-04 03:30:00	15.78
4864	TP3	ЗУ	CP-300 New	078	2025-04-04 03:30:00	79.46
4865	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 04:00:00	35.28
4866	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 04:00:00	3.71
4867	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 04:00:00	28.76
4868	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 04:00:00	0.0025
4869	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 04:00:00	0
4870	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 04:00:00	0
4871	QF 1,20	ЗУ	China 1	044	2025-04-04 04:00:00	9.21
4872	QF 1,21	ЗУ	China 2	045	2025-04-04 04:00:00	7.95
4873	QF 1,22	ЗУ	China 3	046	2025-04-04 04:00:00	10.32
4874	QF 2,20	ЗУ	China 4	047	2025-04-04 04:00:00	18.04
4875	QF 2,21	ЗУ	China 5	048	2025-04-04 04:00:00	19.9
4876	QF 2,22	ЗУ	China 6	049	2025-04-04 04:00:00	18.05
4877	QF 2,23	ЗУ	China 7	050	2025-04-04 04:00:00	8.71
4878	QF 2,19	ЗУ	China 8	051	2025-04-04 04:00:00	11.12
4879	Q8	ЗУ	DIG	061	2025-04-04 04:00:00	76.42
4880	Q4	ЗУ	BG 1	062	2025-04-04 04:00:00	0
4881	Q9	ЗУ	BG 2	063	2025-04-04 04:00:00	20.03
4882	Q10	ЗУ	SM 2	064	2025-04-04 04:00:00	1.31
4883	Q11	ЗУ	SM 3	065	2025-04-04 04:00:00	20.26
4884	Q12	ЗУ	SM 4	066	2025-04-04 04:00:00	22.88
4885	Q13	ЗУ	SM 5	067	2025-04-04 04:00:00	0
4886	Q14	ЗУ	SM 6	068	2025-04-04 04:00:00	0
4887	Q15	ЗУ	SM 7	069	2025-04-04 04:00:00	0
4888	Q16	ЗУ	SM 8	070	2025-04-04 04:00:00	0
4889	Q17	ЗУ	MO 9	071	2025-04-04 04:00:00	1.96
4890	Q20	ЗУ	MO 10	072	2025-04-04 04:00:00	0
4891	Q21	ЗУ	MO 11	073	2025-04-04 04:00:00	13.88
4892	Q22	ЗУ	MO 12	074	2025-04-04 04:00:00	0
4893	Q23	ЗУ	MO 13	075	2025-04-04 04:00:00	0
4894	Q24	ЗУ	MO 14	076	2025-04-04 04:00:00	0
4895	Q25	ЗУ	MO 15	077	2025-04-04 04:00:00	15.76
4896	TP3	ЗУ	CP-300 New	078	2025-04-04 04:00:00	77.58
4897	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 04:30:00	33.99
4898	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 04:30:00	3.16
4899	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 04:30:00	27.69
4900	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 04:30:00	0.0022
4901	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 04:30:00	0
4902	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 04:30:00	0
4903	QF 1,20	ЗУ	China 1	044	2025-04-04 04:30:00	8.13
4904	QF 1,21	ЗУ	China 2	045	2025-04-04 04:30:00	6.96
4905	QF 1,22	ЗУ	China 3	046	2025-04-04 04:30:00	9.36
4906	QF 2,20	ЗУ	China 4	047	2025-04-04 04:30:00	16.11
4907	QF 2,21	ЗУ	China 5	048	2025-04-04 04:30:00	18.27
4908	QF 2,22	ЗУ	China 6	049	2025-04-04 04:30:00	16.84
4909	QF 2,23	ЗУ	China 7	050	2025-04-04 04:30:00	8.33
4910	QF 2,19	ЗУ	China 8	051	2025-04-04 04:30:00	9.62
4911	Q8	ЗУ	DIG	061	2025-04-04 04:30:00	70.18
4912	Q4	ЗУ	BG 1	062	2025-04-04 04:30:00	0
4913	Q9	ЗУ	BG 2	063	2025-04-04 04:30:00	19.94
4914	Q10	ЗУ	SM 2	064	2025-04-04 04:30:00	1.31
4915	Q11	ЗУ	SM 3	065	2025-04-04 04:30:00	20.29
4916	Q12	ЗУ	SM 4	066	2025-04-04 04:30:00	22.89
4917	Q13	ЗУ	SM 5	067	2025-04-04 04:30:00	0
4918	Q14	ЗУ	SM 6	068	2025-04-04 04:30:00	0
4919	Q15	ЗУ	SM 7	069	2025-04-04 04:30:00	0
4920	Q16	ЗУ	SM 8	070	2025-04-04 04:30:00	0
4921	Q17	ЗУ	MO 9	071	2025-04-04 04:30:00	1.9
4922	Q20	ЗУ	MO 10	072	2025-04-04 04:30:00	0
4923	Q21	ЗУ	MO 11	073	2025-04-04 04:30:00	13.86
4924	Q22	ЗУ	MO 12	074	2025-04-04 04:30:00	0
4925	Q23	ЗУ	MO 13	075	2025-04-04 04:30:00	0
4926	Q24	ЗУ	MO 14	076	2025-04-04 04:30:00	0
4927	Q25	ЗУ	MO 15	077	2025-04-04 04:30:00	15.82
4928	TP3	ЗУ	CP-300 New	078	2025-04-04 04:30:00	77.21
4929	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 05:00:00	33.59
4930	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 05:00:00	3.1
4931	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 05:00:00	27.17
4932	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 05:00:00	0.002
4933	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 05:00:00	0
4934	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 05:00:00	0
4935	QF 1,20	ЗУ	China 1	044	2025-04-04 05:00:00	9.43
4936	QF 1,21	ЗУ	China 2	045	2025-04-04 05:00:00	8.25
4937	QF 1,22	ЗУ	China 3	046	2025-04-04 05:00:00	10.68
4938	QF 2,20	ЗУ	China 4	047	2025-04-04 05:00:00	17.53
4939	QF 2,21	ЗУ	China 5	048	2025-04-04 05:00:00	19.8
4940	QF 2,22	ЗУ	China 6	049	2025-04-04 05:00:00	18.48
4941	QF 2,23	ЗУ	China 7	050	2025-04-04 05:00:00	9.31
4942	QF 2,19	ЗУ	China 8	051	2025-04-04 05:00:00	11.14
4943	Q8	ЗУ	DIG	061	2025-04-04 05:00:00	62.52
4944	Q4	ЗУ	BG 1	062	2025-04-04 05:00:00	0
4945	Q9	ЗУ	BG 2	063	2025-04-04 05:00:00	19.92
4946	Q10	ЗУ	SM 2	064	2025-04-04 05:00:00	1.3
4947	Q11	ЗУ	SM 3	065	2025-04-04 05:00:00	20.28
4948	Q12	ЗУ	SM 4	066	2025-04-04 05:00:00	22.85
4949	Q13	ЗУ	SM 5	067	2025-04-04 05:00:00	0
4950	Q14	ЗУ	SM 6	068	2025-04-04 05:00:00	0
4951	Q15	ЗУ	SM 7	069	2025-04-04 05:00:00	0
4952	Q16	ЗУ	SM 8	070	2025-04-04 05:00:00	0
4953	Q17	ЗУ	MO 9	071	2025-04-04 05:00:00	1.92
4954	Q20	ЗУ	MO 10	072	2025-04-04 05:00:00	0
4955	Q21	ЗУ	MO 11	073	2025-04-04 05:00:00	13.85
4956	Q22	ЗУ	MO 12	074	2025-04-04 05:00:00	0
4957	Q23	ЗУ	MO 13	075	2025-04-04 05:00:00	0
4958	Q24	ЗУ	MO 14	076	2025-04-04 05:00:00	0
4959	Q25	ЗУ	MO 15	077	2025-04-04 05:00:00	15.78
4960	TP3	ЗУ	CP-300 New	078	2025-04-04 05:00:00	77.78
4961	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 05:30:00	22.66
4962	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 05:30:00	3.51
4963	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 05:30:00	16.8
4964	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 05:30:00	0.0021
4965	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 05:30:00	0
4966	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 05:30:00	0
4967	QF 1,20	ЗУ	China 1	044	2025-04-04 05:30:00	9.32
4968	QF 1,21	ЗУ	China 2	045	2025-04-04 05:30:00	8.1
4969	QF 1,22	ЗУ	China 3	046	2025-04-04 05:30:00	10.45
4970	QF 2,20	ЗУ	China 4	047	2025-04-04 05:30:00	17.42
4971	QF 2,21	ЗУ	China 5	048	2025-04-04 05:30:00	19.56
4972	QF 2,22	ЗУ	China 6	049	2025-04-04 05:30:00	18.57
4973	QF 2,23	ЗУ	China 7	050	2025-04-04 05:30:00	9.16
4974	QF 2,19	ЗУ	China 8	051	2025-04-04 05:30:00	11.1
4975	Q8	ЗУ	DIG	061	2025-04-04 05:30:00	75.18
4976	Q4	ЗУ	BG 1	062	2025-04-04 05:30:00	0
4977	Q9	ЗУ	BG 2	063	2025-04-04 05:30:00	19.97
4978	Q10	ЗУ	SM 2	064	2025-04-04 05:30:00	1.28
4979	Q11	ЗУ	SM 3	065	2025-04-04 05:30:00	20.27
4980	Q12	ЗУ	SM 4	066	2025-04-04 05:30:00	22.63
4981	Q13	ЗУ	SM 5	067	2025-04-04 05:30:00	0
4982	Q14	ЗУ	SM 6	068	2025-04-04 05:30:00	0
4983	Q15	ЗУ	SM 7	069	2025-04-04 05:30:00	0
4984	Q16	ЗУ	SM 8	070	2025-04-04 05:30:00	0
4985	Q17	ЗУ	MO 9	071	2025-04-04 05:30:00	2.04
4986	Q20	ЗУ	MO 10	072	2025-04-04 05:30:00	0
4987	Q21	ЗУ	MO 11	073	2025-04-04 05:30:00	13.85
4988	Q22	ЗУ	MO 12	074	2025-04-04 05:30:00	0
4989	Q23	ЗУ	MO 13	075	2025-04-04 05:30:00	0
4990	Q24	ЗУ	MO 14	076	2025-04-04 05:30:00	0
4991	Q25	ЗУ	MO 15	077	2025-04-04 05:30:00	15.74
4992	TP3	ЗУ	CP-300 New	078	2025-04-04 05:30:00	74.87
4993	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 06:00:00	22.85
4994	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 06:00:00	3.93
4995	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 06:00:00	16.77
4996	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 06:00:00	0.0023
4997	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 06:00:00	0
4998	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 06:00:00	0
4999	QF 1,20	ЗУ	China 1	044	2025-04-04 06:00:00	10.43
5000	QF 1,21	ЗУ	China 2	045	2025-04-04 06:00:00	9.15
5001	QF 1,22	ЗУ	China 3	046	2025-04-04 06:00:00	11.55
5002	QF 2,20	ЗУ	China 4	047	2025-04-04 06:00:00	18.72
5003	QF 2,21	ЗУ	China 5	048	2025-04-04 06:00:00	21.18
5004	QF 2,22	ЗУ	China 6	049	2025-04-04 06:00:00	19.67
5005	QF 2,23	ЗУ	China 7	050	2025-04-04 06:00:00	9.94
5006	QF 2,19	ЗУ	China 8	051	2025-04-04 06:00:00	12.35
5007	Q8	ЗУ	DIG	061	2025-04-04 06:00:00	80.28
5008	Q4	ЗУ	BG 1	062	2025-04-04 06:00:00	0
5009	Q9	ЗУ	BG 2	063	2025-04-04 06:00:00	19.99
5010	Q10	ЗУ	SM 2	064	2025-04-04 06:00:00	1.33
5011	Q11	ЗУ	SM 3	065	2025-04-04 06:00:00	20.32
5012	Q12	ЗУ	SM 4	066	2025-04-04 06:00:00	22.71
5013	Q13	ЗУ	SM 5	067	2025-04-04 06:00:00	0
5014	Q14	ЗУ	SM 6	068	2025-04-04 06:00:00	0
5015	Q15	ЗУ	SM 7	069	2025-04-04 06:00:00	0
5016	Q16	ЗУ	SM 8	070	2025-04-04 06:00:00	0
5017	Q17	ЗУ	MO 9	071	2025-04-04 06:00:00	1.97
5018	Q20	ЗУ	MO 10	072	2025-04-04 06:00:00	0
5019	Q21	ЗУ	MO 11	073	2025-04-04 06:00:00	13.86
5020	Q22	ЗУ	MO 12	074	2025-04-04 06:00:00	0
5021	Q23	ЗУ	MO 13	075	2025-04-04 06:00:00	0
5022	Q24	ЗУ	MO 14	076	2025-04-04 06:00:00	0
5023	Q25	ЗУ	MO 15	077	2025-04-04 06:00:00	15.81
5024	TP3	ЗУ	CP-300 New	078	2025-04-04 06:00:00	76.39
5025	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 06:30:00	23.18
5026	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 06:30:00	4.4
5027	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 06:30:00	16.74
5028	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 06:30:00	0.0034
5029	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 06:30:00	0
5030	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 06:30:00	0
5031	QF 1,20	ЗУ	China 1	044	2025-04-04 06:30:00	11.31
5032	QF 1,21	ЗУ	China 2	045	2025-04-04 06:30:00	9.83
5033	QF 1,22	ЗУ	China 3	046	2025-04-04 06:30:00	12.58
5034	QF 2,20	ЗУ	China 4	047	2025-04-04 06:30:00	19.42
5035	QF 2,21	ЗУ	China 5	048	2025-04-04 06:30:00	22.59
5036	QF 2,22	ЗУ	China 6	049	2025-04-04 06:30:00	20.88
5037	QF 2,23	ЗУ	China 7	050	2025-04-04 06:30:00	10.48
5038	QF 2,19	ЗУ	China 8	051	2025-04-04 06:30:00	13.07
5039	Q8	ЗУ	DIG	061	2025-04-04 06:30:00	85.59
5040	Q4	ЗУ	BG 1	062	2025-04-04 06:30:00	0
5041	Q9	ЗУ	BG 2	063	2025-04-04 06:30:00	20.01
5042	Q10	ЗУ	SM 2	064	2025-04-04 06:30:00	1.38
5043	Q11	ЗУ	SM 3	065	2025-04-04 06:30:00	20.41
5044	Q12	ЗУ	SM 4	066	2025-04-04 06:30:00	22.78
5045	Q13	ЗУ	SM 5	067	2025-04-04 06:30:00	0
5046	Q14	ЗУ	SM 6	068	2025-04-04 06:30:00	0
5047	Q15	ЗУ	SM 7	069	2025-04-04 06:30:00	0
5048	Q16	ЗУ	SM 8	070	2025-04-04 06:30:00	0
5049	Q17	ЗУ	MO 9	071	2025-04-04 06:30:00	1.92
5050	Q20	ЗУ	MO 10	072	2025-04-04 06:30:00	0
5051	Q21	ЗУ	MO 11	073	2025-04-04 06:30:00	13.84
5052	Q22	ЗУ	MO 12	074	2025-04-04 06:30:00	0
5053	Q23	ЗУ	MO 13	075	2025-04-04 06:30:00	0
5054	Q24	ЗУ	MO 14	076	2025-04-04 06:30:00	0
5055	Q25	ЗУ	MO 15	077	2025-04-04 06:30:00	15.97
5056	TP3	ЗУ	CP-300 New	078	2025-04-04 06:30:00	75.16
5057	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 07:00:00	23.03
5058	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 07:00:00	4.25
5059	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 07:00:00	16.72
5060	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 07:00:00	1.39
5061	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 07:00:00	1.03
5062	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 07:00:00	1.09
5063	QF 1,20	ЗУ	China 1	044	2025-04-04 07:00:00	11.28
5064	QF 1,21	ЗУ	China 2	045	2025-04-04 07:00:00	9.77
5065	QF 1,22	ЗУ	China 3	046	2025-04-04 07:00:00	12.43
5066	QF 2,20	ЗУ	China 4	047	2025-04-04 07:00:00	19.37
5067	QF 2,21	ЗУ	China 5	048	2025-04-04 07:00:00	22.02
5068	QF 2,22	ЗУ	China 6	049	2025-04-04 07:00:00	20.27
5069	QF 2,23	ЗУ	China 7	050	2025-04-04 07:00:00	10.38
5070	QF 2,19	ЗУ	China 8	051	2025-04-04 07:00:00	13.21
5071	Q8	ЗУ	DIG	061	2025-04-04 07:00:00	92.03
5072	Q4	ЗУ	BG 1	062	2025-04-04 07:00:00	0
5073	Q9	ЗУ	BG 2	063	2025-04-04 07:00:00	19.96
5074	Q10	ЗУ	SM 2	064	2025-04-04 07:00:00	1.34
5075	Q11	ЗУ	SM 3	065	2025-04-04 07:00:00	19.02
5076	Q12	ЗУ	SM 4	066	2025-04-04 07:00:00	22.81
5077	Q13	ЗУ	SM 5	067	2025-04-04 07:00:00	0
5078	Q14	ЗУ	SM 6	068	2025-04-04 07:00:00	0
5079	Q15	ЗУ	SM 7	069	2025-04-04 07:00:00	0
5080	Q16	ЗУ	SM 8	070	2025-04-04 07:00:00	0
5081	Q17	ЗУ	MO 9	071	2025-04-04 07:00:00	1.92
5082	Q20	ЗУ	MO 10	072	2025-04-04 07:00:00	0
5083	Q21	ЗУ	MO 11	073	2025-04-04 07:00:00	13.84
5084	Q22	ЗУ	MO 12	074	2025-04-04 07:00:00	0
5085	Q23	ЗУ	MO 13	075	2025-04-04 07:00:00	0
5086	Q24	ЗУ	MO 14	076	2025-04-04 07:00:00	0
5087	Q25	ЗУ	MO 15	077	2025-04-04 07:00:00	15.82
5088	TP3	ЗУ	CP-300 New	078	2025-04-04 07:00:00	72.32
5089	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 07:30:00	22.87
5090	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 07:30:00	4.04
5091	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 07:30:00	16.77
5092	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 07:30:00	4.04
5093	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 07:30:00	7.97
5094	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 07:30:00	7.84
5095	QF 1,20	ЗУ	China 1	044	2025-04-04 07:30:00	11.76
5096	QF 1,21	ЗУ	China 2	045	2025-04-04 07:30:00	10.35
5097	QF 1,22	ЗУ	China 3	046	2025-04-04 07:30:00	13.07
5098	QF 2,20	ЗУ	China 4	047	2025-04-04 07:30:00	19.45
5099	QF 2,21	ЗУ	China 5	048	2025-04-04 07:30:00	22.54
5100	QF 2,22	ЗУ	China 6	049	2025-04-04 07:30:00	20.17
5101	QF 2,23	ЗУ	China 7	050	2025-04-04 07:30:00	10.57
5102	QF 2,19	ЗУ	China 8	051	2025-04-04 07:30:00	14.07
5103	Q8	ЗУ	DIG	061	2025-04-04 07:30:00	92.23
5104	Q4	ЗУ	BG 1	062	2025-04-04 07:30:00	0
5105	Q9	ЗУ	BG 2	063	2025-04-04 07:30:00	19.96
5106	Q10	ЗУ	SM 2	064	2025-04-04 07:30:00	1.32
5107	Q11	ЗУ	SM 3	065	2025-04-04 07:30:00	20.17
5108	Q12	ЗУ	SM 4	066	2025-04-04 07:30:00	22.71
5109	Q13	ЗУ	SM 5	067	2025-04-04 07:30:00	0
5110	Q14	ЗУ	SM 6	068	2025-04-04 07:30:00	0
5111	Q15	ЗУ	SM 7	069	2025-04-04 07:30:00	0
5112	Q16	ЗУ	SM 8	070	2025-04-04 07:30:00	0
5113	Q17	ЗУ	MO 9	071	2025-04-04 07:30:00	1.91
5114	Q20	ЗУ	MO 10	072	2025-04-04 07:30:00	0
5115	Q21	ЗУ	MO 11	073	2025-04-04 07:30:00	13.82
5116	Q22	ЗУ	MO 12	074	2025-04-04 07:30:00	0
5117	Q23	ЗУ	MO 13	075	2025-04-04 07:30:00	0
5118	Q24	ЗУ	MO 14	076	2025-04-04 07:30:00	0
5119	Q25	ЗУ	MO 15	077	2025-04-04 07:30:00	15.78
5120	TP3	ЗУ	CP-300 New	078	2025-04-04 07:30:00	69.56
5121	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 08:00:00	22.72
5122	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 08:00:00	3.82
5123	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 08:00:00	16.8
5124	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 08:00:00	8.17
5125	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 08:00:00	19.1
5126	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 08:00:00	18.67
5127	QF 1,20	ЗУ	China 1	044	2025-04-04 08:00:00	13.5
5128	QF 1,21	ЗУ	China 2	045	2025-04-04 08:00:00	12.11
5129	QF 1,22	ЗУ	China 3	046	2025-04-04 08:00:00	15.3
5130	QF 2,20	ЗУ	China 4	047	2025-04-04 08:00:00	20.99
5131	QF 2,21	ЗУ	China 5	048	2025-04-04 08:00:00	23.98
5132	QF 2,22	ЗУ	China 6	049	2025-04-04 08:00:00	22.04
5133	QF 2,23	ЗУ	China 7	050	2025-04-04 08:00:00	11.31
5134	QF 2,19	ЗУ	China 8	051	2025-04-04 08:00:00	15.89
5135	Q8	ЗУ	DIG	061	2025-04-04 08:00:00	90.1
5136	Q4	ЗУ	BG 1	062	2025-04-04 08:00:00	0
5137	Q9	ЗУ	BG 2	063	2025-04-04 08:00:00	19.99
5138	Q10	ЗУ	SM 2	064	2025-04-04 08:00:00	1.3
5139	Q11	ЗУ	SM 3	065	2025-04-04 08:00:00	20.2
5140	Q12	ЗУ	SM 4	066	2025-04-04 08:00:00	22.68
5141	Q13	ЗУ	SM 5	067	2025-04-04 08:00:00	0
5142	Q14	ЗУ	SM 6	068	2025-04-04 08:00:00	0
5143	Q15	ЗУ	SM 7	069	2025-04-04 08:00:00	0
5144	Q16	ЗУ	SM 8	070	2025-04-04 08:00:00	0
5145	Q17	ЗУ	MO 9	071	2025-04-04 08:00:00	1.99
5146	Q20	ЗУ	MO 10	072	2025-04-04 08:00:00	0
5147	Q21	ЗУ	MO 11	073	2025-04-04 08:00:00	13.85
5148	Q22	ЗУ	MO 12	074	2025-04-04 08:00:00	0
5149	Q23	ЗУ	MO 13	075	2025-04-04 08:00:00	0
5150	Q24	ЗУ	MO 14	076	2025-04-04 08:00:00	0
5151	Q25	ЗУ	MO 15	077	2025-04-04 08:00:00	15.77
5152	TP3	ЗУ	CP-300 New	078	2025-04-04 08:00:00	67.7
5153	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 08:30:00	19.47
5154	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 08:30:00	3.15
5155	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 08:30:00	14.2
5156	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 08:30:00	9.72
5157	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 08:30:00	23.51
5158	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 08:30:00	22.97
5159	QF 1,20	ЗУ	China 1	044	2025-04-04 08:30:00	12.83
5160	QF 1,21	ЗУ	China 2	045	2025-04-04 08:30:00	11.22
5161	QF 1,22	ЗУ	China 3	046	2025-04-04 08:30:00	14.45
5162	QF 2,20	ЗУ	China 4	047	2025-04-04 08:30:00	19.11
5163	QF 2,21	ЗУ	China 5	048	2025-04-04 08:30:00	22.28
5164	QF 2,22	ЗУ	China 6	049	2025-04-04 08:30:00	19.99
5165	QF 2,23	ЗУ	China 7	050	2025-04-04 08:30:00	9.94
5166	QF 2,19	ЗУ	China 8	051	2025-04-04 08:30:00	15.41
5167	Q8	ЗУ	DIG	061	2025-04-04 08:30:00	89.73
5168	Q4	ЗУ	BG 1	062	2025-04-04 08:30:00	0
5169	Q9	ЗУ	BG 2	063	2025-04-04 08:30:00	19.98
5170	Q10	ЗУ	SM 2	064	2025-04-04 08:30:00	1.27
5171	Q11	ЗУ	SM 3	065	2025-04-04 08:30:00	20.13
5172	Q12	ЗУ	SM 4	066	2025-04-04 08:30:00	22.75
5173	Q13	ЗУ	SM 5	067	2025-04-04 08:30:00	0
5174	Q14	ЗУ	SM 6	068	2025-04-04 08:30:00	0
5175	Q15	ЗУ	SM 7	069	2025-04-04 08:30:00	0
5176	Q16	ЗУ	SM 8	070	2025-04-04 08:30:00	0
5177	Q17	ЗУ	MO 9	071	2025-04-04 08:30:00	2.14
5178	Q20	ЗУ	MO 10	072	2025-04-04 08:30:00	0
5179	Q21	ЗУ	MO 11	073	2025-04-04 08:30:00	13.8
5180	Q22	ЗУ	MO 12	074	2025-04-04 08:30:00	0
5181	Q23	ЗУ	MO 13	075	2025-04-04 08:30:00	0
5182	Q24	ЗУ	MO 14	076	2025-04-04 08:30:00	0
5183	Q25	ЗУ	MO 15	077	2025-04-04 08:30:00	15.67
5184	TP3	ЗУ	CP-300 New	078	2025-04-04 08:30:00	64.09
5185	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 09:00:00	0
5186	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 09:00:00	0.0011
5187	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 09:00:00	0.0027
5188	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 09:00:00	11.72
5189	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 09:00:00	32.08
5190	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 09:00:00	26.81
5191	QF 1,20	ЗУ	China 1	044	2025-04-04 09:00:00	14.3
5192	QF 1,21	ЗУ	China 2	045	2025-04-04 09:00:00	12.87
5193	QF 1,22	ЗУ	China 3	046	2025-04-04 09:00:00	16.18
5194	QF 2,20	ЗУ	China 4	047	2025-04-04 09:00:00	20.61
5195	QF 2,21	ЗУ	China 5	048	2025-04-04 09:00:00	23.62
5196	QF 2,22	ЗУ	China 6	049	2025-04-04 09:00:00	21.92
5197	QF 2,23	ЗУ	China 7	050	2025-04-04 09:00:00	10.85
5198	QF 2,19	ЗУ	China 8	051	2025-04-04 09:00:00	16.93
5199	Q8	ЗУ	DIG	061	2025-04-04 09:00:00	88.95
5200	Q4	ЗУ	BG 1	062	2025-04-04 09:00:00	0
5201	Q9	ЗУ	BG 2	063	2025-04-04 09:00:00	19.95
5202	Q10	ЗУ	SM 2	064	2025-04-04 09:00:00	1.26
5203	Q11	ЗУ	SM 3	065	2025-04-04 09:00:00	20.03
5204	Q12	ЗУ	SM 4	066	2025-04-04 09:00:00	22.8
5205	Q13	ЗУ	SM 5	067	2025-04-04 09:00:00	0
5206	Q14	ЗУ	SM 6	068	2025-04-04 09:00:00	0
5207	Q15	ЗУ	SM 7	069	2025-04-04 09:00:00	0
5208	Q16	ЗУ	SM 8	070	2025-04-04 09:00:00	0
5209	Q17	ЗУ	MO 9	071	2025-04-04 09:00:00	2.17
5210	Q20	ЗУ	MO 10	072	2025-04-04 09:00:00	0
5211	Q21	ЗУ	MO 11	073	2025-04-04 09:00:00	13.8
5212	Q22	ЗУ	MO 12	074	2025-04-04 09:00:00	0
5213	Q23	ЗУ	MO 13	075	2025-04-04 09:00:00	0
5214	Q24	ЗУ	MO 14	076	2025-04-04 09:00:00	0
5215	Q25	ЗУ	MO 15	077	2025-04-04 09:00:00	15.66
5216	TP3	ЗУ	CP-300 New	078	2025-04-04 09:00:00	62.81
5217	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 09:30:00	0
5218	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 09:30:00	0.0018
5219	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 09:30:00	0.003
5220	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 09:30:00	12.71
5221	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 09:30:00	37.83
5222	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 09:30:00	27.84
5223	QF 1,20	ЗУ	China 1	044	2025-04-04 09:30:00	13.91
5224	QF 1,21	ЗУ	China 2	045	2025-04-04 09:30:00	12.94
5225	QF 1,22	ЗУ	China 3	046	2025-04-04 09:30:00	16.54
5226	QF 2,20	ЗУ	China 4	047	2025-04-04 09:30:00	21.19
5227	QF 2,21	ЗУ	China 5	048	2025-04-04 09:30:00	23.67
5228	QF 2,22	ЗУ	China 6	049	2025-04-04 09:30:00	21.65
5229	QF 2,23	ЗУ	China 7	050	2025-04-04 09:30:00	10.89
5230	QF 2,19	ЗУ	China 8	051	2025-04-04 09:30:00	17.03
5231	Q8	ЗУ	DIG	061	2025-04-04 09:30:00	75.51
5232	Q4	ЗУ	BG 1	062	2025-04-04 09:30:00	0
5233	Q9	ЗУ	BG 2	063	2025-04-04 09:30:00	19.94
5234	Q10	ЗУ	SM 2	064	2025-04-04 09:30:00	1.26
5235	Q11	ЗУ	SM 3	065	2025-04-04 09:30:00	20.08
5236	Q12	ЗУ	SM 4	066	2025-04-04 09:30:00	22.93
5237	Q13	ЗУ	SM 5	067	2025-04-04 09:30:00	0
5238	Q14	ЗУ	SM 6	068	2025-04-04 09:30:00	0
5239	Q15	ЗУ	SM 7	069	2025-04-04 09:30:00	0
5240	Q16	ЗУ	SM 8	070	2025-04-04 09:30:00	0
5241	Q17	ЗУ	MO 9	071	2025-04-04 09:30:00	2.16
5242	Q20	ЗУ	MO 10	072	2025-04-04 09:30:00	0
5243	Q21	ЗУ	MO 11	073	2025-04-04 09:30:00	13.83
5244	Q22	ЗУ	MO 12	074	2025-04-04 09:30:00	0
5245	Q23	ЗУ	MO 13	075	2025-04-04 09:30:00	0
5246	Q24	ЗУ	MO 14	076	2025-04-04 09:30:00	0
5247	Q25	ЗУ	MO 15	077	2025-04-04 09:30:00	15.66
5248	TP3	ЗУ	CP-300 New	078	2025-04-04 09:30:00	64.05
5249	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 10:00:00	0
5250	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 10:00:00	0.0011
5251	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 10:00:00	0.0031
5252	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 10:00:00	12.38
5253	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 10:00:00	37.6
5254	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 10:00:00	35.28
5255	QF 1,20	ЗУ	China 1	044	2025-04-04 10:00:00	14.71
5256	QF 1,21	ЗУ	China 2	045	2025-04-04 10:00:00	13.86
5257	QF 1,22	ЗУ	China 3	046	2025-04-04 10:00:00	17.23
5258	QF 2,20	ЗУ	China 4	047	2025-04-04 10:00:00	22.13
5259	QF 2,21	ЗУ	China 5	048	2025-04-04 10:00:00	24.48
5260	QF 2,22	ЗУ	China 6	049	2025-04-04 10:00:00	22.65
5261	QF 2,23	ЗУ	China 7	050	2025-04-04 10:00:00	11.39
5262	QF 2,19	ЗУ	China 8	051	2025-04-04 10:00:00	18.12
5263	Q8	ЗУ	DIG	061	2025-04-04 10:00:00	73.01
5264	Q4	ЗУ	BG 1	062	2025-04-04 10:00:00	0
5265	Q9	ЗУ	BG 2	063	2025-04-04 10:00:00	19.97
5266	Q10	ЗУ	SM 2	064	2025-04-04 10:00:00	1.27
5267	Q11	ЗУ	SM 3	065	2025-04-04 10:00:00	20.1
5268	Q12	ЗУ	SM 4	066	2025-04-04 10:00:00	22.96
5269	Q13	ЗУ	SM 5	067	2025-04-04 10:00:00	0
5270	Q14	ЗУ	SM 6	068	2025-04-04 10:00:00	0
5271	Q15	ЗУ	SM 7	069	2025-04-04 10:00:00	0
5272	Q16	ЗУ	SM 8	070	2025-04-04 10:00:00	0
5273	Q17	ЗУ	MO 9	071	2025-04-04 10:00:00	2.11
5274	Q20	ЗУ	MO 10	072	2025-04-04 10:00:00	0
5275	Q21	ЗУ	MO 11	073	2025-04-04 10:00:00	13.85
5276	Q22	ЗУ	MO 12	074	2025-04-04 10:00:00	0
5277	Q23	ЗУ	MO 13	075	2025-04-04 10:00:00	0
5278	Q24	ЗУ	MO 14	076	2025-04-04 10:00:00	0
5279	Q25	ЗУ	MO 15	077	2025-04-04 10:00:00	15.72
5280	TP3	ЗУ	CP-300 New	078	2025-04-04 10:00:00	60.81
5281	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 10:30:00	0
5282	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 10:30:00	0.0022
5283	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 10:30:00	0.0031
5284	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 10:30:00	11.88
5285	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 10:30:00	37.5
5286	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 10:30:00	36.74
5287	QF 1,20	ЗУ	China 1	044	2025-04-04 10:30:00	16.89
5288	QF 1,21	ЗУ	China 2	045	2025-04-04 10:30:00	15.88
5289	QF 1,22	ЗУ	China 3	046	2025-04-04 10:30:00	19.4
5290	QF 2,20	ЗУ	China 4	047	2025-04-04 10:30:00	23.44
5291	QF 2,21	ЗУ	China 5	048	2025-04-04 10:30:00	25.8
5292	QF 2,22	ЗУ	China 6	049	2025-04-04 10:30:00	24.07
5293	QF 2,23	ЗУ	China 7	050	2025-04-04 10:30:00	12.12
5294	QF 2,19	ЗУ	China 8	051	2025-04-04 10:30:00	19.94
5295	Q8	ЗУ	DIG	061	2025-04-04 10:30:00	48.67
5296	Q4	ЗУ	BG 1	062	2025-04-04 10:30:00	0
5297	Q9	ЗУ	BG 2	063	2025-04-04 10:30:00	20.01
5298	Q10	ЗУ	SM 2	064	2025-04-04 10:30:00	1.27
5299	Q11	ЗУ	SM 3	065	2025-04-04 10:30:00	20.13
5300	Q12	ЗУ	SM 4	066	2025-04-04 10:30:00	23.15
5301	Q13	ЗУ	SM 5	067	2025-04-04 10:30:00	0
5302	Q14	ЗУ	SM 6	068	2025-04-04 10:30:00	0
5303	Q15	ЗУ	SM 7	069	2025-04-04 10:30:00	0
5304	Q16	ЗУ	SM 8	070	2025-04-04 10:30:00	0
5305	Q17	ЗУ	MO 9	071	2025-04-04 10:30:00	2.19
5306	Q20	ЗУ	MO 10	072	2025-04-04 10:30:00	0
5307	Q21	ЗУ	MO 11	073	2025-04-04 10:30:00	13.85
5308	Q22	ЗУ	MO 12	074	2025-04-04 10:30:00	0
5309	Q23	ЗУ	MO 13	075	2025-04-04 10:30:00	0
5310	Q24	ЗУ	MO 14	076	2025-04-04 10:30:00	0
5311	Q25	ЗУ	MO 15	077	2025-04-04 10:30:00	15.71
5312	TP3	ЗУ	CP-300 New	078	2025-04-04 10:30:00	60.54
5313	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 11:00:00	0
5314	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 11:00:00	0.001
5315	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 11:00:00	0.0029
5316	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 11:00:00	7.89
5317	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 11:00:00	30.07
5318	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 11:00:00	28.99
5319	QF 1,20	ЗУ	China 1	044	2025-04-04 11:00:00	18.42
5320	QF 1,21	ЗУ	China 2	045	2025-04-04 11:00:00	16.74
5321	QF 1,22	ЗУ	China 3	046	2025-04-04 11:00:00	20.64
5322	QF 2,20	ЗУ	China 4	047	2025-04-04 11:00:00	24.48
5323	QF 2,21	ЗУ	China 5	048	2025-04-04 11:00:00	26.51
5324	QF 2,22	ЗУ	China 6	049	2025-04-04 11:00:00	25.43
5325	QF 2,23	ЗУ	China 7	050	2025-04-04 11:00:00	12.74
5326	QF 2,19	ЗУ	China 8	051	2025-04-04 11:00:00	21.02
5327	Q8	ЗУ	DIG	061	2025-04-04 11:00:00	57.48
5328	Q4	ЗУ	BG 1	062	2025-04-04 11:00:00	0
5329	Q9	ЗУ	BG 2	063	2025-04-04 11:00:00	19.95
5330	Q10	ЗУ	SM 2	064	2025-04-04 11:00:00	1.26
5331	Q11	ЗУ	SM 3	065	2025-04-04 11:00:00	20.16
5332	Q12	ЗУ	SM 4	066	2025-04-04 11:00:00	23.05
5333	Q13	ЗУ	SM 5	067	2025-04-04 11:00:00	0
5334	Q14	ЗУ	SM 6	068	2025-04-04 11:00:00	0
5335	Q15	ЗУ	SM 7	069	2025-04-04 11:00:00	0
5336	Q16	ЗУ	SM 8	070	2025-04-04 11:00:00	0
5337	Q17	ЗУ	MO 9	071	2025-04-04 11:00:00	2.2
5338	Q20	ЗУ	MO 10	072	2025-04-04 11:00:00	0
5339	Q21	ЗУ	MO 11	073	2025-04-04 11:00:00	13.81
5340	Q22	ЗУ	MO 12	074	2025-04-04 11:00:00	0
5341	Q23	ЗУ	MO 13	075	2025-04-04 11:00:00	0
5342	Q24	ЗУ	MO 14	076	2025-04-04 11:00:00	0
5343	Q25	ЗУ	MO 15	077	2025-04-04 11:00:00	15.7
5344	TP3	ЗУ	CP-300 New	078	2025-04-04 11:00:00	60.65
5345	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 11:30:00	0
5346	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 11:30:00	0.0018
5347	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 11:30:00	0.0034
5348	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 11:30:00	6.26
5349	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 11:30:00	36.46
5350	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 11:30:00	34.67
5351	QF 1,20	ЗУ	China 1	044	2025-04-04 11:30:00	18.4
5352	QF 1,21	ЗУ	China 2	045	2025-04-04 11:30:00	16.78
5353	QF 1,22	ЗУ	China 3	046	2025-04-04 11:30:00	20.33
5354	QF 2,20	ЗУ	China 4	047	2025-04-04 11:30:00	24.3
5355	QF 2,21	ЗУ	China 5	048	2025-04-04 11:30:00	26.43
5356	QF 2,22	ЗУ	China 6	049	2025-04-04 11:30:00	24.72
5357	QF 2,23	ЗУ	China 7	050	2025-04-04 11:30:00	12.59
5358	QF 2,19	ЗУ	China 8	051	2025-04-04 11:30:00	20.95
5359	Q8	ЗУ	DIG	061	2025-04-04 11:30:00	56.7
5360	Q4	ЗУ	BG 1	062	2025-04-04 11:30:00	0
5361	Q9	ЗУ	BG 2	063	2025-04-04 11:30:00	19.99
5362	Q10	ЗУ	SM 2	064	2025-04-04 11:30:00	1.27
5363	Q11	ЗУ	SM 3	065	2025-04-04 11:30:00	20.13
5364	Q12	ЗУ	SM 4	066	2025-04-04 11:30:00	23.03
5365	Q13	ЗУ	SM 5	067	2025-04-04 11:30:00	0
5366	Q14	ЗУ	SM 6	068	2025-04-04 11:30:00	0
5367	Q15	ЗУ	SM 7	069	2025-04-04 11:30:00	0
5368	Q16	ЗУ	SM 8	070	2025-04-04 11:30:00	0
5369	Q17	ЗУ	MO 9	071	2025-04-04 11:30:00	2.16
5370	Q20	ЗУ	MO 10	072	2025-04-04 11:30:00	0
5371	Q21	ЗУ	MO 11	073	2025-04-04 11:30:00	13.86
5372	Q22	ЗУ	MO 12	074	2025-04-04 11:30:00	0
5373	Q23	ЗУ	MO 13	075	2025-04-04 11:30:00	0
5374	Q24	ЗУ	MO 14	076	2025-04-04 11:30:00	0
5375	Q25	ЗУ	MO 15	077	2025-04-04 11:30:00	14.23
5376	TP3	ЗУ	CP-300 New	078	2025-04-04 11:30:00	58.98
5377	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 12:00:00	0
5378	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 12:00:00	0.0018
5379	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 12:00:00	0.0034
5380	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 12:00:00	4.82
5381	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 12:00:00	36.53
5382	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 12:00:00	34.91
5383	QF 1,20	ЗУ	China 1	044	2025-04-04 12:00:00	19.1
5384	QF 1,21	ЗУ	China 2	045	2025-04-04 12:00:00	17.31
5385	QF 1,22	ЗУ	China 3	046	2025-04-04 12:00:00	20.87
5386	QF 2,20	ЗУ	China 4	047	2025-04-04 12:00:00	24.49
5387	QF 2,21	ЗУ	China 5	048	2025-04-04 12:00:00	26.59
5388	QF 2,22	ЗУ	China 6	049	2025-04-04 12:00:00	25.36
5389	QF 2,23	ЗУ	China 7	050	2025-04-04 12:00:00	12.68
5390	QF 2,19	ЗУ	China 8	051	2025-04-04 12:00:00	21.52
5391	Q8	ЗУ	DIG	061	2025-04-04 12:00:00	57.07
5392	Q4	ЗУ	BG 1	062	2025-04-04 12:00:00	0
5393	Q9	ЗУ	BG 2	063	2025-04-04 12:00:00	20.02
5394	Q10	ЗУ	SM 2	064	2025-04-04 12:00:00	1.31
5395	Q11	ЗУ	SM 3	065	2025-04-04 12:00:00	20.21
5396	Q12	ЗУ	SM 4	066	2025-04-04 12:00:00	23.07
5397	Q13	ЗУ	SM 5	067	2025-04-04 12:00:00	0
5398	Q14	ЗУ	SM 6	068	2025-04-04 12:00:00	0
5399	Q15	ЗУ	SM 7	069	2025-04-04 12:00:00	0
5400	Q16	ЗУ	SM 8	070	2025-04-04 12:00:00	0
5401	Q17	ЗУ	MO 9	071	2025-04-04 12:00:00	1.95
5402	Q20	ЗУ	MO 10	072	2025-04-04 12:00:00	0
5403	Q21	ЗУ	MO 11	073	2025-04-04 12:00:00	13.84
5404	Q22	ЗУ	MO 12	074	2025-04-04 12:00:00	0
5405	Q23	ЗУ	MO 13	075	2025-04-04 12:00:00	0
5406	Q24	ЗУ	MO 14	076	2025-04-04 12:00:00	0
5407	Q25	ЗУ	MO 15	077	2025-04-04 12:00:00	14.16
5408	TP3	ЗУ	CP-300 New	078	2025-04-04 12:00:00	54.78
5409	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 12:30:00	0
5410	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 12:30:00	0.0005
5411	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 12:30:00	0.0028
5412	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 12:30:00	4.64
5413	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 12:30:00	36.66
5414	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 12:30:00	35.03
5415	QF 1,20	ЗУ	China 1	044	2025-04-04 12:30:00	19.53
5416	QF 1,21	ЗУ	China 2	045	2025-04-04 12:30:00	18.07
5417	QF 1,22	ЗУ	China 3	046	2025-04-04 12:30:00	21.38
5418	QF 2,20	ЗУ	China 4	047	2025-04-04 12:30:00	24.5
5419	QF 2,21	ЗУ	China 5	048	2025-04-04 12:30:00	25.9
5420	QF 2,22	ЗУ	China 6	049	2025-04-04 12:30:00	24.72
5421	QF 2,23	ЗУ	China 7	050	2025-04-04 12:30:00	12.65
5422	QF 2,19	ЗУ	China 8	051	2025-04-04 12:30:00	21.99
5423	Q8	ЗУ	DIG	061	2025-04-04 12:30:00	55.71
5424	Q4	ЗУ	BG 1	062	2025-04-04 12:30:00	0
5425	Q9	ЗУ	BG 2	063	2025-04-04 12:30:00	19.99
5426	Q10	ЗУ	SM 2	064	2025-04-04 12:30:00	1.29
5427	Q11	ЗУ	SM 3	065	2025-04-04 12:30:00	20.15
5428	Q12	ЗУ	SM 4	066	2025-04-04 12:30:00	23.03
5429	Q13	ЗУ	SM 5	067	2025-04-04 12:30:00	0
5430	Q14	ЗУ	SM 6	068	2025-04-04 12:30:00	0
5431	Q15	ЗУ	SM 7	069	2025-04-04 12:30:00	0
5432	Q16	ЗУ	SM 8	070	2025-04-04 12:30:00	0
5433	Q17	ЗУ	MO 9	071	2025-04-04 12:30:00	2.06
5434	Q20	ЗУ	MO 10	072	2025-04-04 12:30:00	0
5435	Q21	ЗУ	MO 11	073	2025-04-04 12:30:00	13.85
5436	Q22	ЗУ	MO 12	074	2025-04-04 12:30:00	0
5437	Q23	ЗУ	MO 13	075	2025-04-04 12:30:00	0
5438	Q24	ЗУ	MO 14	076	2025-04-04 12:30:00	0
5439	Q25	ЗУ	MO 15	077	2025-04-04 12:30:00	14.08
5440	TP3	ЗУ	CP-300 New	078	2025-04-04 12:30:00	56.11
5441	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 13:00:00	0
5442	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 13:00:00	0.0014
5443	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 13:00:00	0.0035
5444	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 13:00:00	4.07
5445	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 13:00:00	28.42
5446	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 13:00:00	27.18
5447	QF 1,20	ЗУ	China 1	044	2025-04-04 13:00:00	18.66
5448	QF 1,21	ЗУ	China 2	045	2025-04-04 13:00:00	16.76
5449	QF 1,22	ЗУ	China 3	046	2025-04-04 13:00:00	19.69
5450	QF 2,20	ЗУ	China 4	047	2025-04-04 13:00:00	21.87
5451	QF 2,21	ЗУ	China 5	048	2025-04-04 13:00:00	24.09
5452	QF 2,22	ЗУ	China 6	049	2025-04-04 13:00:00	22.11
5453	QF 2,23	ЗУ	China 7	050	2025-04-04 13:00:00	11.62
5454	QF 2,19	ЗУ	China 8	051	2025-04-04 13:00:00	20.45
5455	Q8	ЗУ	DIG	061	2025-04-04 13:00:00	49.3
5456	Q4	ЗУ	BG 1	062	2025-04-04 13:00:00	0
5457	Q9	ЗУ	BG 2	063	2025-04-04 13:00:00	19.93
5458	Q10	ЗУ	SM 2	064	2025-04-04 13:00:00	1.27
5459	Q11	ЗУ	SM 3	065	2025-04-04 13:00:00	20.08
5460	Q12	ЗУ	SM 4	066	2025-04-04 13:00:00	23.11
5461	Q13	ЗУ	SM 5	067	2025-04-04 13:00:00	0
5462	Q14	ЗУ	SM 6	068	2025-04-04 13:00:00	0
5463	Q15	ЗУ	SM 7	069	2025-04-04 13:00:00	0
5464	Q16	ЗУ	SM 8	070	2025-04-04 13:00:00	0
5465	Q17	ЗУ	MO 9	071	2025-04-04 13:00:00	2.16
5466	Q20	ЗУ	MO 10	072	2025-04-04 13:00:00	0
5467	Q21	ЗУ	MO 11	073	2025-04-04 13:00:00	13.84
5468	Q22	ЗУ	MO 12	074	2025-04-04 13:00:00	0
5469	Q23	ЗУ	MO 13	075	2025-04-04 13:00:00	0
5470	Q24	ЗУ	MO 14	076	2025-04-04 13:00:00	0
5471	Q25	ЗУ	MO 15	077	2025-04-04 13:00:00	14.04
5472	TP3	ЗУ	CP-300 New	078	2025-04-04 13:00:00	54.77
5473	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 13:30:00	1.05
5474	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 13:30:00	0.8601
5475	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 13:30:00	0.1882
5476	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 13:30:00	3.32
5477	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 13:30:00	13.33
5478	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 13:30:00	13.01
5479	QF 1,20	ЗУ	China 1	044	2025-04-04 13:30:00	18.8
5480	QF 1,21	ЗУ	China 2	045	2025-04-04 13:30:00	16.7
5481	QF 1,22	ЗУ	China 3	046	2025-04-04 13:30:00	20.5
5482	QF 2,20	ЗУ	China 4	047	2025-04-04 13:30:00	21.45
5483	QF 2,21	ЗУ	China 5	048	2025-04-04 13:30:00	23.35
5484	QF 2,22	ЗУ	China 6	049	2025-04-04 13:30:00	23
5485	QF 2,23	ЗУ	China 7	050	2025-04-04 13:30:00	11.63
5486	QF 2,19	ЗУ	China 8	051	2025-04-04 13:30:00	20.35
5487	Q8	ЗУ	DIG	061	2025-04-04 13:30:00	49.51
5488	Q4	ЗУ	BG 1	062	2025-04-04 13:30:00	0
5489	Q9	ЗУ	BG 2	063	2025-04-04 13:30:00	20.03
5490	Q10	ЗУ	SM 2	064	2025-04-04 13:30:00	1.29
5491	Q11	ЗУ	SM 3	065	2025-04-04 13:30:00	20.11
5492	Q12	ЗУ	SM 4	066	2025-04-04 13:30:00	23.23
5493	Q13	ЗУ	SM 5	067	2025-04-04 13:30:00	0
5494	Q14	ЗУ	SM 6	068	2025-04-04 13:30:00	0
5495	Q15	ЗУ	SM 7	069	2025-04-04 13:30:00	0
5496	Q16	ЗУ	SM 8	070	2025-04-04 13:30:00	0
5497	Q17	ЗУ	MO 9	071	2025-04-04 13:30:00	2.12
5498	Q20	ЗУ	MO 10	072	2025-04-04 13:30:00	0
5499	Q21	ЗУ	MO 11	073	2025-04-04 13:30:00	13.85
5500	Q22	ЗУ	MO 12	074	2025-04-04 13:30:00	0
5501	Q23	ЗУ	MO 13	075	2025-04-04 13:30:00	0
5502	Q24	ЗУ	MO 14	076	2025-04-04 13:30:00	0
5503	Q25	ЗУ	MO 15	077	2025-04-04 13:30:00	1.45
5504	TP3	ЗУ	CP-300 New	078	2025-04-04 13:30:00	51.48
5505	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 14:00:00	5.25
5506	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 14:00:00	2.11
5507	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 14:00:00	1.49
5508	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 14:00:00	4.23
5509	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 14:00:00	22.63
5510	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 14:00:00	21.91
5511	QF 1,20	ЗУ	China 1	044	2025-04-04 14:00:00	19.34
5512	QF 1,21	ЗУ	China 2	045	2025-04-04 14:00:00	17.35
5513	QF 1,22	ЗУ	China 3	046	2025-04-04 14:00:00	20.59
5514	QF 2,20	ЗУ	China 4	047	2025-04-04 14:00:00	21.6
5515	QF 2,21	ЗУ	China 5	048	2025-04-04 14:00:00	24.11
5516	QF 2,22	ЗУ	China 6	049	2025-04-04 14:00:00	23.11
5517	QF 2,23	ЗУ	China 7	050	2025-04-04 14:00:00	11.76
5518	QF 2,19	ЗУ	China 8	051	2025-04-04 14:00:00	21.23
5519	Q8	ЗУ	DIG	061	2025-04-04 14:00:00	50.24
5520	Q4	ЗУ	BG 1	062	2025-04-04 14:00:00	0
5521	Q9	ЗУ	BG 2	063	2025-04-04 14:00:00	20.02
5522	Q10	ЗУ	SM 2	064	2025-04-04 14:00:00	1.28
5523	Q11	ЗУ	SM 3	065	2025-04-04 14:00:00	20.06
5524	Q12	ЗУ	SM 4	066	2025-04-04 14:00:00	23.23
5525	Q13	ЗУ	SM 5	067	2025-04-04 14:00:00	0
5526	Q14	ЗУ	SM 6	068	2025-04-04 14:00:00	0
5527	Q15	ЗУ	SM 7	069	2025-04-04 14:00:00	0
5528	Q16	ЗУ	SM 8	070	2025-04-04 14:00:00	0
5529	Q17	ЗУ	MO 9	071	2025-04-04 14:00:00	2.18
5530	Q20	ЗУ	MO 10	072	2025-04-04 14:00:00	0
5531	Q21	ЗУ	MO 11	073	2025-04-04 14:00:00	13.86
5532	Q22	ЗУ	MO 12	074	2025-04-04 14:00:00	0
5533	Q23	ЗУ	MO 13	075	2025-04-04 14:00:00	0
5534	Q24	ЗУ	MO 14	076	2025-04-04 14:00:00	0
5535	Q25	ЗУ	MO 15	077	2025-04-04 14:00:00	0
5536	TP3	ЗУ	CP-300 New	078	2025-04-04 14:00:00	52.89
5537	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 14:30:00	15.33
5538	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 14:30:00	5.73
5539	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 14:30:00	7.64
5540	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 14:30:00	3.86
5541	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 14:30:00	19.94
5542	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 14:30:00	19.25
5543	QF 1,20	ЗУ	China 1	044	2025-04-04 14:30:00	21.54
5544	QF 1,21	ЗУ	China 2	045	2025-04-04 14:30:00	19.2
5545	QF 1,22	ЗУ	China 3	046	2025-04-04 14:30:00	22.27
5546	QF 2,20	ЗУ	China 4	047	2025-04-04 14:30:00	22.73
5547	QF 2,21	ЗУ	China 5	048	2025-04-04 14:30:00	25.66
5548	QF 2,22	ЗУ	China 6	049	2025-04-04 14:30:00	24.76
5549	QF 2,23	ЗУ	China 7	050	2025-04-04 14:30:00	12.5
5550	QF 2,19	ЗУ	China 8	051	2025-04-04 14:30:00	22.64
5551	Q8	ЗУ	DIG	061	2025-04-04 14:30:00	48.66
5552	Q4	ЗУ	BG 1	062	2025-04-04 14:30:00	0
5553	Q9	ЗУ	BG 2	063	2025-04-04 14:30:00	19.98
5554	Q10	ЗУ	SM 2	064	2025-04-04 14:30:00	1.29
5555	Q11	ЗУ	SM 3	065	2025-04-04 14:30:00	20.08
5556	Q12	ЗУ	SM 4	066	2025-04-04 14:30:00	23.24
5557	Q13	ЗУ	SM 5	067	2025-04-04 14:30:00	0
5558	Q14	ЗУ	SM 6	068	2025-04-04 14:30:00	0
5559	Q15	ЗУ	SM 7	069	2025-04-04 14:30:00	0
5560	Q16	ЗУ	SM 8	070	2025-04-04 14:30:00	0
5561	Q17	ЗУ	MO 9	071	2025-04-04 14:30:00	2.06
5562	Q20	ЗУ	MO 10	072	2025-04-04 14:30:00	0
5563	Q21	ЗУ	MO 11	073	2025-04-04 14:30:00	13.84
5564	Q22	ЗУ	MO 12	074	2025-04-04 14:30:00	0
5565	Q23	ЗУ	MO 13	075	2025-04-04 14:30:00	0
5566	Q24	ЗУ	MO 14	076	2025-04-04 14:30:00	0
5567	Q25	ЗУ	MO 15	077	2025-04-04 14:30:00	0
5568	TP3	ЗУ	CP-300 New	078	2025-04-04 14:30:00	53.98
5569	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 15:00:00	22.23
5570	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 15:00:00	8.08
5571	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 15:00:00	12.76
5572	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 15:00:00	4.23
5573	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 15:00:00	22.79
5574	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 15:00:00	22.12
5575	QF 1,20	ЗУ	China 1	044	2025-04-04 15:00:00	21.52
5576	QF 1,21	ЗУ	China 2	045	2025-04-04 15:00:00	19.42
5577	QF 1,22	ЗУ	China 3	046	2025-04-04 15:00:00	22.88
5578	QF 2,20	ЗУ	China 4	047	2025-04-04 15:00:00	23.1
5579	QF 2,21	ЗУ	China 5	048	2025-04-04 15:00:00	25.45
5580	QF 2,22	ЗУ	China 6	049	2025-04-04 15:00:00	24.53
5581	QF 2,23	ЗУ	China 7	050	2025-04-04 15:00:00	12.53
5582	QF 2,19	ЗУ	China 8	051	2025-04-04 15:00:00	23.24
5583	Q8	ЗУ	DIG	061	2025-04-04 15:00:00	49.39
5584	Q4	ЗУ	BG 1	062	2025-04-04 15:00:00	0
5585	Q9	ЗУ	BG 2	063	2025-04-04 15:00:00	19.95
5586	Q10	ЗУ	SM 2	064	2025-04-04 15:00:00	1.3
5587	Q11	ЗУ	SM 3	065	2025-04-04 15:00:00	20.09
5588	Q12	ЗУ	SM 4	066	2025-04-04 15:00:00	23.23
5589	Q13	ЗУ	SM 5	067	2025-04-04 15:00:00	0
5590	Q14	ЗУ	SM 6	068	2025-04-04 15:00:00	0
5591	Q15	ЗУ	SM 7	069	2025-04-04 15:00:00	0
5592	Q16	ЗУ	SM 8	070	2025-04-04 15:00:00	0
5593	Q17	ЗУ	MO 9	071	2025-04-04 15:00:00	1.99
5594	Q20	ЗУ	MO 10	072	2025-04-04 15:00:00	0
5595	Q21	ЗУ	MO 11	073	2025-04-04 15:00:00	13.88
5596	Q22	ЗУ	MO 12	074	2025-04-04 15:00:00	0
5597	Q23	ЗУ	MO 13	075	2025-04-04 15:00:00	0
5598	Q24	ЗУ	MO 14	076	2025-04-04 15:00:00	0
5599	Q25	ЗУ	MO 15	077	2025-04-04 15:00:00	0
5600	TP3	ЗУ	CP-300 New	078	2025-04-04 15:00:00	55.2
5601	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 15:30:00	26.63
5602	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 15:30:00	9.22
5603	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 15:30:00	15.72
5604	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 15:30:00	4.53
5605	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 15:30:00	22.86
5606	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 15:30:00	22.19
5607	QF 1,20	ЗУ	China 1	044	2025-04-04 15:30:00	19.38
5608	QF 1,21	ЗУ	China 2	045	2025-04-04 15:30:00	17.64
5609	QF 1,22	ЗУ	China 3	046	2025-04-04 15:30:00	20.46
5610	QF 2,20	ЗУ	China 4	047	2025-04-04 15:30:00	20.77
5611	QF 2,21	ЗУ	China 5	048	2025-04-04 15:30:00	23.23
5612	QF 2,22	ЗУ	China 6	049	2025-04-04 15:30:00	21.65
5613	QF 2,23	ЗУ	China 7	050	2025-04-04 15:30:00	11.13
5614	QF 2,19	ЗУ	China 8	051	2025-04-04 15:30:00	20.83
5615	Q8	ЗУ	DIG	061	2025-04-04 15:30:00	51.2
5616	Q4	ЗУ	BG 1	062	2025-04-04 15:30:00	0
5617	Q9	ЗУ	BG 2	063	2025-04-04 15:30:00	19.99
5618	Q10	ЗУ	SM 2	064	2025-04-04 15:30:00	1.33
5619	Q11	ЗУ	SM 3	065	2025-04-04 15:30:00	20.14
5620	Q12	ЗУ	SM 4	066	2025-04-04 15:30:00	23.37
5621	Q13	ЗУ	SM 5	067	2025-04-04 15:30:00	0
5622	Q14	ЗУ	SM 6	068	2025-04-04 15:30:00	0
5623	Q15	ЗУ	SM 7	069	2025-04-04 15:30:00	0
5624	Q16	ЗУ	SM 8	070	2025-04-04 15:30:00	0
5625	Q17	ЗУ	MO 9	071	2025-04-04 15:30:00	1.96
5626	Q20	ЗУ	MO 10	072	2025-04-04 15:30:00	0
5627	Q21	ЗУ	MO 11	073	2025-04-04 15:30:00	13.88
5628	Q22	ЗУ	MO 12	074	2025-04-04 15:30:00	0
5629	Q23	ЗУ	MO 13	075	2025-04-04 15:30:00	0
5630	Q24	ЗУ	MO 14	076	2025-04-04 15:30:00	0
5631	Q25	ЗУ	MO 15	077	2025-04-04 15:30:00	0
5632	TP3	ЗУ	CP-300 New	078	2025-04-04 15:30:00	52.27
5633	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 16:00:00	35.07
5634	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 16:00:00	11.51
5635	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 16:00:00	22.72
5636	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 16:00:00	4.68
5637	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 16:00:00	22.85
5638	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 16:00:00	22.21
5639	QF 1,20	ЗУ	China 1	044	2025-04-04 16:00:00	18.59
5640	QF 1,21	ЗУ	China 2	045	2025-04-04 16:00:00	16.55
5641	QF 1,22	ЗУ	China 3	046	2025-04-04 16:00:00	18.8
5642	QF 2,20	ЗУ	China 4	047	2025-04-04 16:00:00	19.39
5643	QF 2,21	ЗУ	China 5	048	2025-04-04 16:00:00	21.82
5644	QF 2,22	ЗУ	China 6	049	2025-04-04 16:00:00	19.87
5645	QF 2,23	ЗУ	China 7	050	2025-04-04 16:00:00	10.33
5646	QF 2,19	ЗУ	China 8	051	2025-04-04 16:00:00	19.5
5647	Q8	ЗУ	DIG	061	2025-04-04 16:00:00	57.11
5648	Q4	ЗУ	BG 1	062	2025-04-04 16:00:00	0
5649	Q9	ЗУ	BG 2	063	2025-04-04 16:00:00	20.05
5650	Q10	ЗУ	SM 2	064	2025-04-04 16:00:00	1.35
5651	Q11	ЗУ	SM 3	065	2025-04-04 16:00:00	20.17
5652	Q12	ЗУ	SM 4	066	2025-04-04 16:00:00	23.38
5653	Q13	ЗУ	SM 5	067	2025-04-04 16:00:00	0
5654	Q14	ЗУ	SM 6	068	2025-04-04 16:00:00	0
5655	Q15	ЗУ	SM 7	069	2025-04-04 16:00:00	0
5656	Q16	ЗУ	SM 8	070	2025-04-04 16:00:00	0
5657	Q17	ЗУ	MO 9	071	2025-04-04 16:00:00	1.99
5658	Q20	ЗУ	MO 10	072	2025-04-04 16:00:00	0
5659	Q21	ЗУ	MO 11	073	2025-04-04 16:00:00	13.86
5660	Q22	ЗУ	MO 12	074	2025-04-04 16:00:00	0
5661	Q23	ЗУ	MO 13	075	2025-04-04 16:00:00	0
5662	Q24	ЗУ	MO 14	076	2025-04-04 16:00:00	0
5663	Q25	ЗУ	MO 15	077	2025-04-04 16:00:00	0
5664	TP3	ЗУ	CP-300 New	078	2025-04-04 16:00:00	52.21
5665	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 16:30:00	35.11
5666	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 16:30:00	11.14
5667	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 16:30:00	23
5668	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 16:30:00	2.81
5669	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 16:30:00	13.45
5670	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 16:30:00	13.04
5671	QF 1,20	ЗУ	China 1	044	2025-04-04 16:30:00	16.46
5672	QF 1,21	ЗУ	China 2	045	2025-04-04 16:30:00	14.26
5673	QF 1,22	ЗУ	China 3	046	2025-04-04 16:30:00	16.88
5674	QF 2,20	ЗУ	China 4	047	2025-04-04 16:30:00	16.65
5675	QF 2,21	ЗУ	China 5	048	2025-04-04 16:30:00	18.82
5676	QF 2,22	ЗУ	China 6	049	2025-04-04 16:30:00	16.68
5677	QF 2,23	ЗУ	China 7	050	2025-04-04 16:30:00	8.45
5678	QF 2,19	ЗУ	China 8	051	2025-04-04 16:30:00	17.07
5679	Q8	ЗУ	DIG	061	2025-04-04 16:30:00	62.48
5680	Q4	ЗУ	BG 1	062	2025-04-04 16:30:00	0
5681	Q9	ЗУ	BG 2	063	2025-04-04 16:30:00	20.07
5682	Q10	ЗУ	SM 2	064	2025-04-04 16:30:00	1.36
5683	Q11	ЗУ	SM 3	065	2025-04-04 16:30:00	20.14
5684	Q12	ЗУ	SM 4	066	2025-04-04 16:30:00	23.41
5685	Q13	ЗУ	SM 5	067	2025-04-04 16:30:00	0
5686	Q14	ЗУ	SM 6	068	2025-04-04 16:30:00	0
5687	Q15	ЗУ	SM 7	069	2025-04-04 16:30:00	0
5688	Q16	ЗУ	SM 8	070	2025-04-04 16:30:00	0
5689	Q17	ЗУ	MO 9	071	2025-04-04 16:30:00	1.99
5690	Q20	ЗУ	MO 10	072	2025-04-04 16:30:00	0
5691	Q21	ЗУ	MO 11	073	2025-04-04 16:30:00	13.84
5692	Q22	ЗУ	MO 12	074	2025-04-04 16:30:00	0
5693	Q23	ЗУ	MO 13	075	2025-04-04 16:30:00	0
5694	Q24	ЗУ	MO 14	076	2025-04-04 16:30:00	0
5695	Q25	ЗУ	MO 15	077	2025-04-04 16:30:00	0
5696	TP3	ЗУ	CP-300 New	078	2025-04-04 16:30:00	49.13
5697	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 17:00:00	34.97
5698	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 17:00:00	10
5699	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 17:00:00	23.71
5700	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 17:00:00	0.0028
5701	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 17:00:00	0
5702	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 17:00:00	0
5703	QF 1,20	ЗУ	China 1	044	2025-04-04 17:00:00	16.55
5704	QF 1,21	ЗУ	China 2	045	2025-04-04 17:00:00	14.08
5705	QF 1,22	ЗУ	China 3	046	2025-04-04 17:00:00	17.03
5706	QF 2,20	ЗУ	China 4	047	2025-04-04 17:00:00	16.51
5707	QF 2,21	ЗУ	China 5	048	2025-04-04 17:00:00	18.37
5708	QF 2,22	ЗУ	China 6	049	2025-04-04 17:00:00	16.28
5709	QF 2,23	ЗУ	China 7	050	2025-04-04 17:00:00	8.16
5710	QF 2,19	ЗУ	China 8	051	2025-04-04 17:00:00	17.34
5711	Q8	ЗУ	DIG	061	2025-04-04 17:00:00	69.47
5712	Q4	ЗУ	BG 1	062	2025-04-04 17:00:00	0
5713	Q9	ЗУ	BG 2	063	2025-04-04 17:00:00	20.02
5714	Q10	ЗУ	SM 2	064	2025-04-04 17:00:00	1.36
5715	Q11	ЗУ	SM 3	065	2025-04-04 17:00:00	20.1
5716	Q12	ЗУ	SM 4	066	2025-04-04 17:00:00	23.42
5717	Q13	ЗУ	SM 5	067	2025-04-04 17:00:00	0
5718	Q14	ЗУ	SM 6	068	2025-04-04 17:00:00	0
5719	Q15	ЗУ	SM 7	069	2025-04-04 17:00:00	0
5720	Q16	ЗУ	SM 8	070	2025-04-04 17:00:00	0
5721	Q17	ЗУ	MO 9	071	2025-04-04 17:00:00	2.01
5722	Q20	ЗУ	MO 10	072	2025-04-04 17:00:00	0
5723	Q21	ЗУ	MO 11	073	2025-04-04 17:00:00	13.85
5724	Q22	ЗУ	MO 12	074	2025-04-04 17:00:00	0
5725	Q23	ЗУ	MO 13	075	2025-04-04 17:00:00	0
5726	Q24	ЗУ	MO 14	076	2025-04-04 17:00:00	0
5727	Q25	ЗУ	MO 15	077	2025-04-04 17:00:00	0
5728	TP3	ЗУ	CP-300 New	078	2025-04-04 17:00:00	50.44
5729	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 17:30:00	27.96
5730	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 17:30:00	6.46
5731	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 17:30:00	20.08
5732	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 17:30:00	0.003
5733	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 17:30:00	0
5734	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 17:30:00	0
5735	QF 1,20	ЗУ	China 1	044	2025-04-04 17:30:00	14.66
5736	QF 1,21	ЗУ	China 2	045	2025-04-04 17:30:00	12.19
5737	QF 1,22	ЗУ	China 3	046	2025-04-04 17:30:00	14.98
5738	QF 2,20	ЗУ	China 4	047	2025-04-04 17:30:00	14.93
5739	QF 2,21	ЗУ	China 5	048	2025-04-04 17:30:00	16.82
5740	QF 2,22	ЗУ	China 6	049	2025-04-04 17:30:00	14.61
5741	QF 2,23	ЗУ	China 7	050	2025-04-04 17:30:00	7.29
5742	QF 2,19	ЗУ	China 8	051	2025-04-04 17:30:00	15.39
5743	Q8	ЗУ	DIG	061	2025-04-04 17:30:00	72.83
5744	Q4	ЗУ	BG 1	062	2025-04-04 17:30:00	0
5745	Q9	ЗУ	BG 2	063	2025-04-04 17:30:00	20
5746	Q10	ЗУ	SM 2	064	2025-04-04 17:30:00	1.35
5747	Q11	ЗУ	SM 3	065	2025-04-04 17:30:00	20.05
5748	Q12	ЗУ	SM 4	066	2025-04-04 17:30:00	23.44
5749	Q13	ЗУ	SM 5	067	2025-04-04 17:30:00	0
5750	Q14	ЗУ	SM 6	068	2025-04-04 17:30:00	0
5751	Q15	ЗУ	SM 7	069	2025-04-04 17:30:00	0
5752	Q16	ЗУ	SM 8	070	2025-04-04 17:30:00	0
5753	Q17	ЗУ	MO 9	071	2025-04-04 17:30:00	2
5754	Q20	ЗУ	MO 10	072	2025-04-04 17:30:00	0
5755	Q21	ЗУ	MO 11	073	2025-04-04 17:30:00	13.85
5756	Q22	ЗУ	MO 12	074	2025-04-04 17:30:00	0
5757	Q23	ЗУ	MO 13	075	2025-04-04 17:30:00	0
5758	Q24	ЗУ	MO 14	076	2025-04-04 17:30:00	0
5759	Q25	ЗУ	MO 15	077	2025-04-04 17:30:00	0
5760	TP3	ЗУ	CP-300 New	078	2025-04-04 17:30:00	50.49
5761	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 18:00:00	33.18
5762	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 18:00:00	5.95
5763	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 18:00:00	25.48
5764	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 18:00:00	0.0036
5765	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 18:00:00	0
5766	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 18:00:00	0
5767	QF 1,20	ЗУ	China 1	044	2025-04-04 18:00:00	14.88
5768	QF 1,21	ЗУ	China 2	045	2025-04-04 18:00:00	12.46
5769	QF 1,22	ЗУ	China 3	046	2025-04-04 18:00:00	15.31
5770	QF 2,20	ЗУ	China 4	047	2025-04-04 18:00:00	15.14
5771	QF 2,21	ЗУ	China 5	048	2025-04-04 18:00:00	16.88
5772	QF 2,22	ЗУ	China 6	049	2025-04-04 18:00:00	14.89
5773	QF 2,23	ЗУ	China 7	050	2025-04-04 18:00:00	7.45
5774	QF 2,19	ЗУ	China 8	051	2025-04-04 18:00:00	15.72
5775	Q8	ЗУ	DIG	061	2025-04-04 18:00:00	58.57
5776	Q4	ЗУ	BG 1	062	2025-04-04 18:00:00	0
5777	Q9	ЗУ	BG 2	063	2025-04-04 18:00:00	19.94
5778	Q10	ЗУ	SM 2	064	2025-04-04 18:00:00	1.35
5779	Q11	ЗУ	SM 3	065	2025-04-04 18:00:00	20.1
5780	Q12	ЗУ	SM 4	066	2025-04-04 18:00:00	23.41
5781	Q13	ЗУ	SM 5	067	2025-04-04 18:00:00	0
5782	Q14	ЗУ	SM 6	068	2025-04-04 18:00:00	0
5783	Q15	ЗУ	SM 7	069	2025-04-04 18:00:00	0
5784	Q16	ЗУ	SM 8	070	2025-04-04 18:00:00	0
5785	Q17	ЗУ	MO 9	071	2025-04-04 18:00:00	1.99
5786	Q20	ЗУ	MO 10	072	2025-04-04 18:00:00	0
5787	Q21	ЗУ	MO 11	073	2025-04-04 18:00:00	13.86
5788	Q22	ЗУ	MO 12	074	2025-04-04 18:00:00	0
5789	Q23	ЗУ	MO 13	075	2025-04-04 18:00:00	0
5790	Q24	ЗУ	MO 14	076	2025-04-04 18:00:00	0
5791	Q25	ЗУ	MO 15	077	2025-04-04 18:00:00	0
5792	TP3	ЗУ	CP-300 New	078	2025-04-04 18:00:00	48.84
5793	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 18:30:00	33.01
5794	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 18:30:00	4.89
5795	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 18:30:00	26
5796	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 18:30:00	0.0031
5797	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 18:30:00	0
5798	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 18:30:00	0
5799	QF 1,20	ЗУ	China 1	044	2025-04-04 18:30:00	13.85
5800	QF 1,21	ЗУ	China 2	045	2025-04-04 18:30:00	11.77
5801	QF 1,22	ЗУ	China 3	046	2025-04-04 18:30:00	14.6
5802	QF 2,20	ЗУ	China 4	047	2025-04-04 18:30:00	14.39
5803	QF 2,21	ЗУ	China 5	048	2025-04-04 18:30:00	16.2
5804	QF 2,22	ЗУ	China 6	049	2025-04-04 18:30:00	14.5
5805	QF 2,23	ЗУ	China 7	050	2025-04-04 18:30:00	7.16
5806	QF 2,19	ЗУ	China 8	051	2025-04-04 18:30:00	15.01
5807	Q8	ЗУ	DIG	061	2025-04-04 18:30:00	53.09
5808	Q4	ЗУ	BG 1	062	2025-04-04 18:30:00	0
5809	Q9	ЗУ	BG 2	063	2025-04-04 18:30:00	19.97
5810	Q10	ЗУ	SM 2	064	2025-04-04 18:30:00	1.36
5811	Q11	ЗУ	SM 3	065	2025-04-04 18:30:00	20.12
5812	Q12	ЗУ	SM 4	066	2025-04-04 18:30:00	23.46
5813	Q13	ЗУ	SM 5	067	2025-04-04 18:30:00	0
5814	Q14	ЗУ	SM 6	068	2025-04-04 18:30:00	0
5815	Q15	ЗУ	SM 7	069	2025-04-04 18:30:00	0
5816	Q16	ЗУ	SM 8	070	2025-04-04 18:30:00	0
5817	Q17	ЗУ	MO 9	071	2025-04-04 18:30:00	2.01
5818	Q20	ЗУ	MO 10	072	2025-04-04 18:30:00	0
5819	Q21	ЗУ	MO 11	073	2025-04-04 18:30:00	13.86
5820	Q22	ЗУ	MO 12	074	2025-04-04 18:30:00	0
5821	Q23	ЗУ	MO 13	075	2025-04-04 18:30:00	0
5822	Q24	ЗУ	MO 14	076	2025-04-04 18:30:00	0
5823	Q25	ЗУ	MO 15	077	2025-04-04 18:30:00	0
5824	TP3	ЗУ	CP-300 New	078	2025-04-04 18:30:00	50.25
5825	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 19:00:00	19.71
5826	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 19:00:00	3.49
5827	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 19:00:00	14.72
5828	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 19:00:00	0.0033
5829	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 19:00:00	0
5830	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 19:00:00	0
5831	QF 1,20	ЗУ	China 1	044	2025-04-04 19:00:00	12.6
5832	QF 1,21	ЗУ	China 2	045	2025-04-04 19:00:00	11.23
5833	QF 1,22	ЗУ	China 3	046	2025-04-04 19:00:00	13.93
5834	QF 2,20	ЗУ	China 4	047	2025-04-04 19:00:00	14.1
5835	QF 2,21	ЗУ	China 5	048	2025-04-04 19:00:00	16.22
5836	QF 2,22	ЗУ	China 6	049	2025-04-04 19:00:00	13.92
5837	QF 2,23	ЗУ	China 7	050	2025-04-04 19:00:00	6.95
5838	QF 2,19	ЗУ	China 8	051	2025-04-04 19:00:00	14.49
5839	Q8	ЗУ	DIG	061	2025-04-04 19:00:00	45.77
5840	Q4	ЗУ	BG 1	062	2025-04-04 19:00:00	0
5841	Q9	ЗУ	BG 2	063	2025-04-04 19:00:00	19.97
5842	Q10	ЗУ	SM 2	064	2025-04-04 19:00:00	1.37
5843	Q11	ЗУ	SM 3	065	2025-04-04 19:00:00	20.18
5844	Q12	ЗУ	SM 4	066	2025-04-04 19:00:00	23.41
5845	Q13	ЗУ	SM 5	067	2025-04-04 19:00:00	0
5846	Q14	ЗУ	SM 6	068	2025-04-04 19:00:00	0
5847	Q15	ЗУ	SM 7	069	2025-04-04 19:00:00	0
5848	Q16	ЗУ	SM 8	070	2025-04-04 19:00:00	0
5849	Q17	ЗУ	MO 9	071	2025-04-04 19:00:00	2.01
5850	Q20	ЗУ	MO 10	072	2025-04-04 19:00:00	0
5851	Q21	ЗУ	MO 11	073	2025-04-04 19:00:00	13.84
5852	Q22	ЗУ	MO 12	074	2025-04-04 19:00:00	0
5853	Q23	ЗУ	MO 13	075	2025-04-04 19:00:00	0
5854	Q24	ЗУ	MO 14	076	2025-04-04 19:00:00	0
5855	Q25	ЗУ	MO 15	077	2025-04-04 19:00:00	0
5856	TP3	ЗУ	CP-300 New	078	2025-04-04 19:00:00	45.21
5857	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 19:30:00	25.68
5858	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 19:30:00	5.17
5859	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 19:30:00	19.84
5860	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 19:30:00	0.0032
5861	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 19:30:00	0
5862	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 19:30:00	0
5863	QF 1,20	ЗУ	China 1	044	2025-04-04 19:30:00	14.08
5864	QF 1,21	ЗУ	China 2	045	2025-04-04 19:30:00	12.96
5865	QF 1,22	ЗУ	China 3	046	2025-04-04 19:30:00	15.51
5866	QF 2,20	ЗУ	China 4	047	2025-04-04 19:30:00	15.98
5867	QF 2,21	ЗУ	China 5	048	2025-04-04 19:30:00	18.12
5868	QF 2,22	ЗУ	China 6	049	2025-04-04 19:30:00	16.36
5869	QF 2,23	ЗУ	China 7	050	2025-04-04 19:30:00	7.96
5870	QF 2,19	ЗУ	China 8	051	2025-04-04 19:30:00	16.35
5871	Q8	ЗУ	DIG	061	2025-04-04 19:30:00	45.73
5872	Q4	ЗУ	BG 1	062	2025-04-04 19:30:00	0
5873	Q9	ЗУ	BG 2	063	2025-04-04 19:30:00	19.98
5874	Q10	ЗУ	SM 2	064	2025-04-04 19:30:00	1.38
5875	Q11	ЗУ	SM 3	065	2025-04-04 19:30:00	20.21
5876	Q12	ЗУ	SM 4	066	2025-04-04 19:30:00	23.34
5877	Q13	ЗУ	SM 5	067	2025-04-04 19:30:00	0
5878	Q14	ЗУ	SM 6	068	2025-04-04 19:30:00	0
5879	Q15	ЗУ	SM 7	069	2025-04-04 19:30:00	0
5880	Q16	ЗУ	SM 8	070	2025-04-04 19:30:00	0
5881	Q17	ЗУ	MO 9	071	2025-04-04 19:30:00	2.01
5882	Q20	ЗУ	MO 10	072	2025-04-04 19:30:00	0
5883	Q21	ЗУ	MO 11	073	2025-04-04 19:30:00	13.87
5884	Q22	ЗУ	MO 12	074	2025-04-04 19:30:00	0
5885	Q23	ЗУ	MO 13	075	2025-04-04 19:30:00	0
5886	Q24	ЗУ	MO 14	076	2025-04-04 19:30:00	0
5887	Q25	ЗУ	MO 15	077	2025-04-04 19:30:00	0
5888	TP3	ЗУ	CP-300 New	078	2025-04-04 19:30:00	46.45
5889	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 20:00:00	21.59
5890	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 20:00:00	4.84
5891	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 20:00:00	15.21
5892	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 20:00:00	0.0034
5893	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 20:00:00	0
5894	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 20:00:00	0
5895	QF 1,20	ЗУ	China 1	044	2025-04-04 20:00:00	13.74
5896	QF 1,21	ЗУ	China 2	045	2025-04-04 20:00:00	13.06
5897	QF 1,22	ЗУ	China 3	046	2025-04-04 20:00:00	15.86
5898	QF 2,20	ЗУ	China 4	047	2025-04-04 20:00:00	16.4
5899	QF 2,21	ЗУ	China 5	048	2025-04-04 20:00:00	18.79
5900	QF 2,22	ЗУ	China 6	049	2025-04-04 20:00:00	17.36
5901	QF 2,23	ЗУ	China 7	050	2025-04-04 20:00:00	8.23
5902	QF 2,19	ЗУ	China 8	051	2025-04-04 20:00:00	16.03
5903	Q8	ЗУ	DIG	061	2025-04-04 20:00:00	45.68
5904	Q4	ЗУ	BG 1	062	2025-04-04 20:00:00	0
5905	Q9	ЗУ	BG 2	063	2025-04-04 20:00:00	19.98
5906	Q10	ЗУ	SM 2	064	2025-04-04 20:00:00	1.37
5907	Q11	ЗУ	SM 3	065	2025-04-04 20:00:00	20.13
5908	Q12	ЗУ	SM 4	066	2025-04-04 20:00:00	23.35
5909	Q13	ЗУ	SM 5	067	2025-04-04 20:00:00	0
5910	Q14	ЗУ	SM 6	068	2025-04-04 20:00:00	0
5911	Q15	ЗУ	SM 7	069	2025-04-04 20:00:00	0
5912	Q16	ЗУ	SM 8	070	2025-04-04 20:00:00	0
5913	Q17	ЗУ	MO 9	071	2025-04-04 20:00:00	2.05
5914	Q20	ЗУ	MO 10	072	2025-04-04 20:00:00	0
5915	Q21	ЗУ	MO 11	073	2025-04-04 20:00:00	13.86
5916	Q22	ЗУ	MO 12	074	2025-04-04 20:00:00	0
5917	Q23	ЗУ	MO 13	075	2025-04-04 20:00:00	0
5918	Q24	ЗУ	MO 14	076	2025-04-04 20:00:00	0
5919	Q25	ЗУ	MO 15	077	2025-04-04 20:00:00	0
5920	TP3	ЗУ	CP-300 New	078	2025-04-04 20:00:00	47.42
5921	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 20:30:00	21.57
5922	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 20:30:00	4.75
5923	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 20:30:00	15.2
5924	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 20:30:00	0.0029
5925	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 20:30:00	0
5926	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 20:30:00	0
5927	QF 1,20	ЗУ	China 1	044	2025-04-04 20:30:00	15.83
5928	QF 1,21	ЗУ	China 2	045	2025-04-04 20:30:00	15.06
5929	QF 1,22	ЗУ	China 3	046	2025-04-04 20:30:00	17.85
5930	QF 2,20	ЗУ	China 4	047	2025-04-04 20:30:00	18.82
5931	QF 2,21	ЗУ	China 5	048	2025-04-04 20:30:00	22.09
5932	QF 2,22	ЗУ	China 6	049	2025-04-04 20:30:00	20.78
5933	QF 2,23	ЗУ	China 7	050	2025-04-04 20:30:00	9.58
5934	QF 2,19	ЗУ	China 8	051	2025-04-04 20:30:00	18.09
5935	Q8	ЗУ	DIG	061	2025-04-04 20:30:00	41.34
5936	Q4	ЗУ	BG 1	062	2025-04-04 20:30:00	0
5937	Q9	ЗУ	BG 2	063	2025-04-04 20:30:00	19.97
5938	Q10	ЗУ	SM 2	064	2025-04-04 20:30:00	1.36
5939	Q11	ЗУ	SM 3	065	2025-04-04 20:30:00	20.11
5940	Q12	ЗУ	SM 4	066	2025-04-04 20:30:00	23.28
5941	Q13	ЗУ	SM 5	067	2025-04-04 20:30:00	0
5942	Q14	ЗУ	SM 6	068	2025-04-04 20:30:00	0
5943	Q15	ЗУ	SM 7	069	2025-04-04 20:30:00	0
5944	Q16	ЗУ	SM 8	070	2025-04-04 20:30:00	0
5945	Q17	ЗУ	MO 9	071	2025-04-04 20:30:00	2.04
5946	Q20	ЗУ	MO 10	072	2025-04-04 20:30:00	0
5947	Q21	ЗУ	MO 11	073	2025-04-04 20:30:00	13.83
5948	Q22	ЗУ	MO 12	074	2025-04-04 20:30:00	0
5949	Q23	ЗУ	MO 13	075	2025-04-04 20:30:00	0
5950	Q24	ЗУ	MO 14	076	2025-04-04 20:30:00	0
5951	Q25	ЗУ	MO 15	077	2025-04-04 20:30:00	0
5952	TP3	ЗУ	CP-300 New	078	2025-04-04 20:30:00	47.87
5953	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 21:00:00	21.5
5954	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 21:00:00	4.71
5955	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 21:00:00	15.19
5956	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 21:00:00	0.0025
5957	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 21:00:00	0
5958	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 21:00:00	0
5959	QF 1,20	ЗУ	China 1	044	2025-04-04 21:00:00	17.4
5960	QF 1,21	ЗУ	China 2	045	2025-04-04 21:00:00	16.66
5961	QF 1,22	ЗУ	China 3	046	2025-04-04 21:00:00	19.3
5962	QF 2,20	ЗУ	China 4	047	2025-04-04 21:00:00	21.24
5963	QF 2,21	ЗУ	China 5	048	2025-04-04 21:00:00	25.05
5964	QF 2,22	ЗУ	China 6	049	2025-04-04 21:00:00	22
5965	QF 2,23	ЗУ	China 7	050	2025-04-04 21:00:00	10.56
5966	QF 2,19	ЗУ	China 8	051	2025-04-04 21:00:00	19.85
5967	Q8	ЗУ	DIG	061	2025-04-04 21:00:00	37.72
5968	Q4	ЗУ	BG 1	062	2025-04-04 21:00:00	0
5969	Q9	ЗУ	BG 2	063	2025-04-04 21:00:00	19.96
5970	Q10	ЗУ	SM 2	064	2025-04-04 21:00:00	1.37
5971	Q11	ЗУ	SM 3	065	2025-04-04 21:00:00	20.22
5972	Q12	ЗУ	SM 4	066	2025-04-04 21:00:00	23.2
5973	Q13	ЗУ	SM 5	067	2025-04-04 21:00:00	0
5974	Q14	ЗУ	SM 6	068	2025-04-04 21:00:00	0
5975	Q15	ЗУ	SM 7	069	2025-04-04 21:00:00	0
5976	Q16	ЗУ	SM 8	070	2025-04-04 21:00:00	0
5977	Q17	ЗУ	MO 9	071	2025-04-04 21:00:00	2.02
5978	Q20	ЗУ	MO 10	072	2025-04-04 21:00:00	0
5979	Q21	ЗУ	MO 11	073	2025-04-04 21:00:00	13.87
5980	Q22	ЗУ	MO 12	074	2025-04-04 21:00:00	2.98
5981	Q23	ЗУ	MO 13	075	2025-04-04 21:00:00	0
5982	Q24	ЗУ	MO 14	076	2025-04-04 21:00:00	0
5983	Q25	ЗУ	MO 15	077	2025-04-04 21:00:00	0
5984	TP3	ЗУ	CP-300 New	078	2025-04-04 21:00:00	45.84
5985	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 21:30:00	21.57
5986	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 21:30:00	4.8
5987	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 21:30:00	15.2
5988	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 21:30:00	0.0025
5989	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 21:30:00	0
5990	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 21:30:00	0
5991	QF 1,20	ЗУ	China 1	044	2025-04-04 21:30:00	17.32
5992	QF 1,21	ЗУ	China 2	045	2025-04-04 21:30:00	16.23
5993	QF 1,22	ЗУ	China 3	046	2025-04-04 21:30:00	19.12
5994	QF 2,20	ЗУ	China 4	047	2025-04-04 21:30:00	22.03
5995	QF 2,21	ЗУ	China 5	048	2025-04-04 21:30:00	25.53
5996	QF 2,22	ЗУ	China 6	049	2025-04-04 21:30:00	23.3
5997	QF 2,23	ЗУ	China 7	050	2025-04-04 21:30:00	10.86
5998	QF 2,19	ЗУ	China 8	051	2025-04-04 21:30:00	19.74
5999	Q8	ЗУ	DIG	061	2025-04-04 21:30:00	37.99
6000	Q4	ЗУ	BG 1	062	2025-04-04 21:30:00	0
6001	Q9	ЗУ	BG 2	063	2025-04-04 21:30:00	19.32
6002	Q10	ЗУ	SM 2	064	2025-04-04 21:30:00	1.39
6003	Q11	ЗУ	SM 3	065	2025-04-04 21:30:00	20.39
6004	Q12	ЗУ	SM 4	066	2025-04-04 21:30:00	23.18
6005	Q13	ЗУ	SM 5	067	2025-04-04 21:30:00	0
6006	Q14	ЗУ	SM 6	068	2025-04-04 21:30:00	0
6007	Q15	ЗУ	SM 7	069	2025-04-04 21:30:00	0
6008	Q16	ЗУ	SM 8	070	2025-04-04 21:30:00	0
6009	Q17	ЗУ	MO 9	071	2025-04-04 21:30:00	1.98
6010	Q20	ЗУ	MO 10	072	2025-04-04 21:30:00	0
6011	Q21	ЗУ	MO 11	073	2025-04-04 21:30:00	13.86
6012	Q22	ЗУ	MO 12	074	2025-04-04 21:30:00	8.19
6013	Q23	ЗУ	MO 13	075	2025-04-04 21:30:00	0
6014	Q24	ЗУ	MO 14	076	2025-04-04 21:30:00	0
6015	Q25	ЗУ	MO 15	077	2025-04-04 21:30:00	0
6016	TP3	ЗУ	CP-300 New	078	2025-04-04 21:30:00	45.12
6017	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 22:00:00	21.57
6018	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 22:00:00	4.67
6019	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 22:00:00	15.26
6020	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 22:00:00	0.0023
6021	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 22:00:00	0
6022	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 22:00:00	0
6023	QF 1,20	ЗУ	China 1	044	2025-04-04 22:00:00	18.98
6024	QF 1,21	ЗУ	China 2	045	2025-04-04 22:00:00	17.64
6025	QF 1,22	ЗУ	China 3	046	2025-04-04 22:00:00	20.68
6026	QF 2,20	ЗУ	China 4	047	2025-04-04 22:00:00	24.26
6027	QF 2,21	ЗУ	China 5	048	2025-04-04 22:00:00	28.47
6028	QF 2,22	ЗУ	China 6	049	2025-04-04 22:00:00	25.57
6029	QF 2,23	ЗУ	China 7	050	2025-04-04 22:00:00	11.89
6030	QF 2,19	ЗУ	China 8	051	2025-04-04 22:00:00	21.05
6031	Q8	ЗУ	DIG	061	2025-04-04 22:00:00	37.55
6032	Q4	ЗУ	BG 1	062	2025-04-04 22:00:00	0
6033	Q9	ЗУ	BG 2	063	2025-04-04 22:00:00	17.97
6034	Q10	ЗУ	SM 2	064	2025-04-04 22:00:00	1.35
6035	Q11	ЗУ	SM 3	065	2025-04-04 22:00:00	20.41
6036	Q12	ЗУ	SM 4	066	2025-04-04 22:00:00	23.23
6037	Q13	ЗУ	SM 5	067	2025-04-04 22:00:00	0
6038	Q14	ЗУ	SM 6	068	2025-04-04 22:00:00	0
6039	Q15	ЗУ	SM 7	069	2025-04-04 22:00:00	0
6040	Q16	ЗУ	SM 8	070	2025-04-04 22:00:00	0
6041	Q17	ЗУ	MO 9	071	2025-04-04 22:00:00	1.91
6042	Q20	ЗУ	MO 10	072	2025-04-04 22:00:00	0
6043	Q21	ЗУ	MO 11	073	2025-04-04 22:00:00	13.81
6044	Q22	ЗУ	MO 12	074	2025-04-04 22:00:00	17.63
6045	Q23	ЗУ	MO 13	075	2025-04-04 22:00:00	0
6046	Q24	ЗУ	MO 14	076	2025-04-04 22:00:00	0
6047	Q25	ЗУ	MO 15	077	2025-04-04 22:00:00	0
6048	TP3	ЗУ	CP-300 New	078	2025-04-04 22:00:00	43.39
6049	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 22:30:00	21.56
6050	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 22:30:00	4.69
6051	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 22:30:00	15.31
6052	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 22:30:00	0.0027
6053	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 22:30:00	0
6054	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 22:30:00	0
6055	QF 1,20	ЗУ	China 1	044	2025-04-04 22:30:00	21.18
6056	QF 1,21	ЗУ	China 2	045	2025-04-04 22:30:00	19.72
6057	QF 1,22	ЗУ	China 3	046	2025-04-04 22:30:00	22.94
6058	QF 2,20	ЗУ	China 4	047	2025-04-04 22:30:00	27.25
6059	QF 2,21	ЗУ	China 5	048	2025-04-04 22:30:00	31.4
6060	QF 2,22	ЗУ	China 6	049	2025-04-04 22:30:00	28.68
6061	QF 2,23	ЗУ	China 7	050	2025-04-04 22:30:00	13.39
6062	QF 2,19	ЗУ	China 8	051	2025-04-04 22:30:00	23.63
6063	Q8	ЗУ	DIG	061	2025-04-04 22:30:00	26.43
6064	Q4	ЗУ	BG 1	062	2025-04-04 22:30:00	0
6065	Q9	ЗУ	BG 2	063	2025-04-04 22:30:00	18.05
6066	Q10	ЗУ	SM 2	064	2025-04-04 22:30:00	1.37
6067	Q11	ЗУ	SM 3	065	2025-04-04 22:30:00	20.35
6068	Q12	ЗУ	SM 4	066	2025-04-04 22:30:00	23.31
6069	Q13	ЗУ	SM 5	067	2025-04-04 22:30:00	0
6070	Q14	ЗУ	SM 6	068	2025-04-04 22:30:00	0
6071	Q15	ЗУ	SM 7	069	2025-04-04 22:30:00	0
6072	Q16	ЗУ	SM 8	070	2025-04-04 22:30:00	0
6073	Q17	ЗУ	MO 9	071	2025-04-04 22:30:00	1.94
6074	Q20	ЗУ	MO 10	072	2025-04-04 22:30:00	0
6075	Q21	ЗУ	MO 11	073	2025-04-04 22:30:00	13.84
6076	Q22	ЗУ	MO 12	074	2025-04-04 22:30:00	17.56
6077	Q23	ЗУ	MO 13	075	2025-04-04 22:30:00	0
6078	Q24	ЗУ	MO 14	076	2025-04-04 22:30:00	0
6079	Q25	ЗУ	MO 15	077	2025-04-04 22:30:00	0
6080	TP3	ЗУ	CP-300 New	078	2025-04-04 22:30:00	42.89
6081	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 23:00:00	18.63
6082	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 23:00:00	4.29
6083	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 23:00:00	12.99
6084	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 23:00:00	0.6681
6085	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 23:00:00	0.5064
6086	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 23:00:00	0.5273
6087	QF 1,20	ЗУ	China 1	044	2025-04-04 23:00:00	21.81
6088	QF 1,21	ЗУ	China 2	045	2025-04-04 23:00:00	20.89
6089	QF 1,22	ЗУ	China 3	046	2025-04-04 23:00:00	23.9
6090	QF 2,20	ЗУ	China 4	047	2025-04-04 23:00:00	28.42
6091	QF 2,21	ЗУ	China 5	048	2025-04-04 23:00:00	32.58
6092	QF 2,22	ЗУ	China 6	049	2025-04-04 23:00:00	29.63
6093	QF 2,23	ЗУ	China 7	050	2025-04-04 23:00:00	13.91
6094	QF 2,19	ЗУ	China 8	051	2025-04-04 23:00:00	24.34
6095	Q8	ЗУ	DIG	061	2025-04-04 23:00:00	36.11
6096	Q4	ЗУ	BG 1	062	2025-04-04 23:00:00	0
6097	Q9	ЗУ	BG 2	063	2025-04-04 23:00:00	17.99
6098	Q10	ЗУ	SM 2	064	2025-04-04 23:00:00	1.4
6099	Q11	ЗУ	SM 3	065	2025-04-04 23:00:00	20.48
6100	Q12	ЗУ	SM 4	066	2025-04-04 23:00:00	23.3
6101	Q13	ЗУ	SM 5	067	2025-04-04 23:00:00	0
6102	Q14	ЗУ	SM 6	068	2025-04-04 23:00:00	0
6103	Q15	ЗУ	SM 7	069	2025-04-04 23:00:00	0
6104	Q16	ЗУ	SM 8	070	2025-04-04 23:00:00	0
6105	Q17	ЗУ	MO 9	071	2025-04-04 23:00:00	1.95
6106	Q20	ЗУ	MO 10	072	2025-04-04 23:00:00	0
6107	Q21	ЗУ	MO 11	073	2025-04-04 23:00:00	13.82
6108	Q22	ЗУ	MO 12	074	2025-04-04 23:00:00	17.57
6109	Q23	ЗУ	MO 13	075	2025-04-04 23:00:00	0
6110	Q24	ЗУ	MO 14	076	2025-04-04 23:00:00	0
6111	Q25	ЗУ	MO 15	077	2025-04-04 23:00:00	0
6112	TP3	ЗУ	CP-300 New	078	2025-04-04 23:00:00	41.84
6113	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-04 23:30:00	0
6114	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-04 23:30:00	0.0013
6115	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-04 23:30:00	0.0029
6116	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-04 23:30:00	3.18
6117	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-04 23:30:00	5.39
6118	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-04 23:30:00	5.27
6119	QF 1,20	ЗУ	China 1	044	2025-04-04 23:30:00	22.54
6120	QF 1,21	ЗУ	China 2	045	2025-04-04 23:30:00	21.65
6121	QF 1,22	ЗУ	China 3	046	2025-04-04 23:30:00	24.77
6122	QF 2,20	ЗУ	China 4	047	2025-04-04 23:30:00	30.05
6123	QF 2,21	ЗУ	China 5	048	2025-04-04 23:30:00	33.45
6124	QF 2,22	ЗУ	China 6	049	2025-04-04 23:30:00	31.48
6125	QF 2,23	ЗУ	China 7	050	2025-04-04 23:30:00	14.46
6126	QF 2,19	ЗУ	China 8	051	2025-04-04 23:30:00	25.17
6127	Q8	ЗУ	DIG	061	2025-04-04 23:30:00	36.39
6128	Q4	ЗУ	BG 1	062	2025-04-04 23:30:00	0
6129	Q9	ЗУ	BG 2	063	2025-04-04 23:30:00	17.69
6130	Q10	ЗУ	SM 2	064	2025-04-04 23:30:00	11.06
6131	Q11	ЗУ	SM 3	065	2025-04-04 23:30:00	20.43
6132	Q12	ЗУ	SM 4	066	2025-04-04 23:30:00	23.27
6133	Q13	ЗУ	SM 5	067	2025-04-04 23:30:00	0
6134	Q14	ЗУ	SM 6	068	2025-04-04 23:30:00	0
6135	Q15	ЗУ	SM 7	069	2025-04-04 23:30:00	0
6136	Q16	ЗУ	SM 8	070	2025-04-04 23:30:00	0
6137	Q17	ЗУ	MO 9	071	2025-04-04 23:30:00	1.96
6138	Q20	ЗУ	MO 10	072	2025-04-04 23:30:00	0
6139	Q21	ЗУ	MO 11	073	2025-04-04 23:30:00	13.83
6140	Q22	ЗУ	MO 12	074	2025-04-04 23:30:00	17.63
6141	Q23	ЗУ	MO 13	075	2025-04-04 23:30:00	0
6142	Q24	ЗУ	MO 14	076	2025-04-04 23:30:00	0
6143	Q25	ЗУ	MO 15	077	2025-04-04 23:30:00	0
6144	TP3	ЗУ	CP-300 New	078	2025-04-04 23:30:00	42.02
6145	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 00:00:00	0
6146	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 00:00:00	0.0007
6147	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 00:00:00	0.0029
6148	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 00:00:00	7.01
6149	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 00:00:00	16.59
6150	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 00:00:00	16.21
6151	QF 1,20	ЗУ	China 1	044	2025-04-05 00:00:00	23.03
6152	QF 1,21	ЗУ	China 2	045	2025-04-05 00:00:00	22.34
6153	QF 1,22	ЗУ	China 3	046	2025-04-05 00:00:00	24.82
6154	QF 2,20	ЗУ	China 4	047	2025-04-05 00:00:00	30.67
6155	QF 2,21	ЗУ	China 5	048	2025-04-05 00:00:00	34.6
6156	QF 2,22	ЗУ	China 6	049	2025-04-05 00:00:00	31.67
6157	QF 2,23	ЗУ	China 7	050	2025-04-05 00:00:00	15.02
6158	QF 2,19	ЗУ	China 8	051	2025-04-05 00:00:00	25.41
6159	Q8	ЗУ	DIG	061	2025-04-05 00:00:00	35.12
6160	Q4	ЗУ	BG 1	062	2025-04-05 00:00:00	0
6161	Q9	ЗУ	BG 2	063	2025-04-05 00:00:00	14.42
6162	Q10	ЗУ	SM 2	064	2025-04-05 00:00:00	18.9
6163	Q11	ЗУ	SM 3	065	2025-04-05 00:00:00	20.41
6164	Q12	ЗУ	SM 4	066	2025-04-05 00:00:00	23.27
6165	Q13	ЗУ	SM 5	067	2025-04-05 00:00:00	0
6166	Q14	ЗУ	SM 6	068	2025-04-05 00:00:00	0
6167	Q15	ЗУ	SM 7	069	2025-04-05 00:00:00	0
6168	Q16	ЗУ	SM 8	070	2025-04-05 00:00:00	0
6169	Q17	ЗУ	MO 9	071	2025-04-05 00:00:00	1.95
6170	Q20	ЗУ	MO 10	072	2025-04-05 00:00:00	0
6171	Q21	ЗУ	MO 11	073	2025-04-05 00:00:00	13.82
6172	Q22	ЗУ	MO 12	074	2025-04-05 00:00:00	17.61
6173	Q23	ЗУ	MO 13	075	2025-04-05 00:00:00	0
6174	Q24	ЗУ	MO 14	076	2025-04-05 00:00:00	0
6175	Q25	ЗУ	MO 15	077	2025-04-05 00:00:00	0
6176	TP3	ЗУ	CP-300 New	078	2025-04-05 00:00:00	39.17
6177	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 00:30:00	0
6178	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 00:30:00	0.0003
6179	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 00:30:00	0.0029
6180	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 00:30:00	9.53
6181	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 00:30:00	24
6182	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 00:30:00	23.49
6183	QF 1,20	ЗУ	China 1	044	2025-04-05 00:30:00	24.75
6184	QF 1,21	ЗУ	China 2	045	2025-04-05 00:30:00	24.46
6185	QF 1,22	ЗУ	China 3	046	2025-04-05 00:30:00	26.84
6186	QF 2,20	ЗУ	China 4	047	2025-04-05 00:30:00	32.57
6187	QF 2,21	ЗУ	China 5	048	2025-04-05 00:30:00	36.65
6188	QF 2,22	ЗУ	China 6	049	2025-04-05 00:30:00	34.28
6189	QF 2,23	ЗУ	China 7	050	2025-04-05 00:30:00	16.22
6190	QF 2,19	ЗУ	China 8	051	2025-04-05 00:30:00	27.37
6191	Q8	ЗУ	DIG	061	2025-04-05 00:30:00	34.77
6192	Q4	ЗУ	BG 1	062	2025-04-05 00:30:00	0
6193	Q9	ЗУ	BG 2	063	2025-04-05 00:30:00	14.41
6194	Q10	ЗУ	SM 2	064	2025-04-05 00:30:00	16.41
6195	Q11	ЗУ	SM 3	065	2025-04-05 00:30:00	20.17
6196	Q12	ЗУ	SM 4	066	2025-04-05 00:30:00	23.33
6197	Q13	ЗУ	SM 5	067	2025-04-05 00:30:00	0
6198	Q14	ЗУ	SM 6	068	2025-04-05 00:30:00	0
6199	Q15	ЗУ	SM 7	069	2025-04-05 00:30:00	0
6200	Q16	ЗУ	SM 8	070	2025-04-05 00:30:00	0
6201	Q17	ЗУ	MO 9	071	2025-04-05 00:30:00	1.94
6202	Q20	ЗУ	MO 10	072	2025-04-05 00:30:00	0
6203	Q21	ЗУ	MO 11	073	2025-04-05 00:30:00	13.83
6204	Q22	ЗУ	MO 12	074	2025-04-05 00:30:00	17.58
6205	Q23	ЗУ	MO 13	075	2025-04-05 00:30:00	0
6206	Q24	ЗУ	MO 14	076	2025-04-05 00:30:00	0
6207	Q25	ЗУ	MO 15	077	2025-04-05 00:30:00	0
6208	TP3	ЗУ	CP-300 New	078	2025-04-05 00:30:00	38.49
6209	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 01:00:00	0
6210	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 01:00:00	0.0013
6211	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 01:00:00	0.0031
6212	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 01:00:00	10.82
6213	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 01:00:00	28.92
6214	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 01:00:00	28.29
6215	QF 1,20	ЗУ	China 1	044	2025-04-05 01:00:00	24.78
6216	QF 1,21	ЗУ	China 2	045	2025-04-05 01:00:00	24.25
6217	QF 1,22	ЗУ	China 3	046	2025-04-05 01:00:00	26.75
6218	QF 2,20	ЗУ	China 4	047	2025-04-05 01:00:00	32.68
6219	QF 2,21	ЗУ	China 5	048	2025-04-05 01:00:00	36.01
6220	QF 2,22	ЗУ	China 6	049	2025-04-05 01:00:00	33.86
6221	QF 2,23	ЗУ	China 7	050	2025-04-05 01:00:00	16.45
6222	QF 2,19	ЗУ	China 8	051	2025-04-05 01:00:00	27.31
6223	Q8	ЗУ	DIG	061	2025-04-05 01:00:00	34.69
6224	Q4	ЗУ	BG 1	062	2025-04-05 01:00:00	0
6225	Q9	ЗУ	BG 2	063	2025-04-05 01:00:00	14.42
6226	Q10	ЗУ	SM 2	064	2025-04-05 01:00:00	15.96
6227	Q11	ЗУ	SM 3	065	2025-04-05 01:00:00	17.4
6228	Q12	ЗУ	SM 4	066	2025-04-05 01:00:00	23.39
6229	Q13	ЗУ	SM 5	067	2025-04-05 01:00:00	0
6230	Q14	ЗУ	SM 6	068	2025-04-05 01:00:00	0
6231	Q15	ЗУ	SM 7	069	2025-04-05 01:00:00	0
6232	Q16	ЗУ	SM 8	070	2025-04-05 01:00:00	0
6233	Q17	ЗУ	MO 9	071	2025-04-05 01:00:00	1.94
6234	Q20	ЗУ	MO 10	072	2025-04-05 01:00:00	0
6235	Q21	ЗУ	MO 11	073	2025-04-05 01:00:00	13.83
6236	Q22	ЗУ	MO 12	074	2025-04-05 01:00:00	17.61
6237	Q23	ЗУ	MO 13	075	2025-04-05 01:00:00	0
6238	Q24	ЗУ	MO 14	076	2025-04-05 01:00:00	0
6239	Q25	ЗУ	MO 15	077	2025-04-05 01:00:00	0
6240	TP3	ЗУ	CP-300 New	078	2025-04-05 01:00:00	39.15
6241	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 01:30:00	0
6242	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 01:30:00	0.001
6243	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 01:30:00	0.0029
6244	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 01:30:00	13.14
6245	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 01:30:00	38.17
6246	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 01:30:00	37.43
6247	QF 1,20	ЗУ	China 1	044	2025-04-05 01:30:00	25.16
6248	QF 1,21	ЗУ	China 2	045	2025-04-05 01:30:00	23.8
6249	QF 1,22	ЗУ	China 3	046	2025-04-05 01:30:00	26.54
6250	QF 2,20	ЗУ	China 4	047	2025-04-05 01:30:00	32.48
6251	QF 2,21	ЗУ	China 5	048	2025-04-05 01:30:00	35.38
6252	QF 2,22	ЗУ	China 6	049	2025-04-05 01:30:00	33.23
6253	QF 2,23	ЗУ	China 7	050	2025-04-05 01:30:00	16.51
6254	QF 2,19	ЗУ	China 8	051	2025-04-05 01:30:00	26.89
6255	Q8	ЗУ	DIG	061	2025-04-05 01:30:00	34.59
6256	Q4	ЗУ	BG 1	062	2025-04-05 01:30:00	0
6257	Q9	ЗУ	BG 2	063	2025-04-05 01:30:00	13.27
6258	Q10	ЗУ	SM 2	064	2025-04-05 01:30:00	17.89
6259	Q11	ЗУ	SM 3	065	2025-04-05 01:30:00	17.46
6260	Q12	ЗУ	SM 4	066	2025-04-05 01:30:00	22.64
6261	Q13	ЗУ	SM 5	067	2025-04-05 01:30:00	0
6262	Q14	ЗУ	SM 6	068	2025-04-05 01:30:00	0
6263	Q15	ЗУ	SM 7	069	2025-04-05 01:30:00	0
6264	Q16	ЗУ	SM 8	070	2025-04-05 01:30:00	0
6265	Q17	ЗУ	MO 9	071	2025-04-05 01:30:00	1.96
6266	Q20	ЗУ	MO 10	072	2025-04-05 01:30:00	0
6267	Q21	ЗУ	MO 11	073	2025-04-05 01:30:00	13.84
6268	Q22	ЗУ	MO 12	074	2025-04-05 01:30:00	17.61
6269	Q23	ЗУ	MO 13	075	2025-04-05 01:30:00	0
6270	Q24	ЗУ	MO 14	076	2025-04-05 01:30:00	0
6271	Q25	ЗУ	MO 15	077	2025-04-05 01:30:00	0
6272	TP3	ЗУ	CP-300 New	078	2025-04-05 01:30:00	35.59
6273	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 02:00:00	0
6274	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 02:00:00	0.0008
6275	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 02:00:00	0.003
6276	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 02:00:00	12.42
6277	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 02:00:00	38.07
6278	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 02:00:00	37.27
6279	QF 1,20	ЗУ	China 1	044	2025-04-05 02:00:00	23.29
6280	QF 1,21	ЗУ	China 2	045	2025-04-05 02:00:00	22.25
6281	QF 1,22	ЗУ	China 3	046	2025-04-05 02:00:00	25.34
6282	QF 2,20	ЗУ	China 4	047	2025-04-05 02:00:00	30.1
6283	QF 2,21	ЗУ	China 5	048	2025-04-05 02:00:00	32.46
6284	QF 2,22	ЗУ	China 6	049	2025-04-05 02:00:00	31.2
6285	QF 2,23	ЗУ	China 7	050	2025-04-05 02:00:00	15.46
6286	QF 2,19	ЗУ	China 8	051	2025-04-05 02:00:00	25.13
6287	Q8	ЗУ	DIG	061	2025-04-05 02:00:00	34.59
6288	Q4	ЗУ	BG 1	062	2025-04-05 02:00:00	0
6289	Q9	ЗУ	BG 2	063	2025-04-05 02:00:00	2.22
6290	Q10	ЗУ	SM 2	064	2025-04-05 02:00:00	18.47
6291	Q11	ЗУ	SM 3	065	2025-04-05 02:00:00	17.43
6292	Q12	ЗУ	SM 4	066	2025-04-05 02:00:00	18.84
6293	Q13	ЗУ	SM 5	067	2025-04-05 02:00:00	0
6294	Q14	ЗУ	SM 6	068	2025-04-05 02:00:00	0
6295	Q15	ЗУ	SM 7	069	2025-04-05 02:00:00	0
6296	Q16	ЗУ	SM 8	070	2025-04-05 02:00:00	0
6297	Q17	ЗУ	MO 9	071	2025-04-05 02:00:00	1.96
6298	Q20	ЗУ	MO 10	072	2025-04-05 02:00:00	0
6299	Q21	ЗУ	MO 11	073	2025-04-05 02:00:00	13.81
6300	Q22	ЗУ	MO 12	074	2025-04-05 02:00:00	17.61
6301	Q23	ЗУ	MO 13	075	2025-04-05 02:00:00	0.5513
6302	Q24	ЗУ	MO 14	076	2025-04-05 02:00:00	0
6303	Q25	ЗУ	MO 15	077	2025-04-05 02:00:00	0
6304	TP3	ЗУ	CP-300 New	078	2025-04-05 02:00:00	35.07
6305	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 02:30:00	0
6306	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 02:30:00	0.0009
6307	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 02:30:00	0.0028
6308	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 02:30:00	10.6
6309	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 02:30:00	37.74
6310	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 02:30:00	36.89
6311	QF 1,20	ЗУ	China 1	044	2025-04-05 02:30:00	24.98
6312	QF 1,21	ЗУ	China 2	045	2025-04-05 02:30:00	23.57
6313	QF 1,22	ЗУ	China 3	046	2025-04-05 02:30:00	26.71
6314	QF 2,20	ЗУ	China 4	047	2025-04-05 02:30:00	31.51
6315	QF 2,21	ЗУ	China 5	048	2025-04-05 02:30:00	34.83
6316	QF 2,22	ЗУ	China 6	049	2025-04-05 02:30:00	32.36
6317	QF 2,23	ЗУ	China 7	050	2025-04-05 02:30:00	16.59
6318	QF 2,19	ЗУ	China 8	051	2025-04-05 02:30:00	26.98
6319	Q8	ЗУ	DIG	061	2025-04-05 02:30:00	34.83
6320	Q4	ЗУ	BG 1	062	2025-04-05 02:30:00	0
6321	Q9	ЗУ	BG 2	063	2025-04-05 02:30:00	2.62
6322	Q10	ЗУ	SM 2	064	2025-04-05 02:30:00	18.37
6323	Q11	ЗУ	SM 3	065	2025-04-05 02:30:00	16.4
6324	Q12	ЗУ	SM 4	066	2025-04-05 02:30:00	18.75
6325	Q13	ЗУ	SM 5	067	2025-04-05 02:30:00	0
6326	Q14	ЗУ	SM 6	068	2025-04-05 02:30:00	0
6327	Q15	ЗУ	SM 7	069	2025-04-05 02:30:00	0
6328	Q16	ЗУ	SM 8	070	2025-04-05 02:30:00	0
6329	Q17	ЗУ	MO 9	071	2025-04-05 02:30:00	1.87
6330	Q20	ЗУ	MO 10	072	2025-04-05 02:30:00	0
6331	Q21	ЗУ	MO 11	073	2025-04-05 02:30:00	13.8
6332	Q22	ЗУ	MO 12	074	2025-04-05 02:30:00	23.4
6333	Q23	ЗУ	MO 13	075	2025-04-05 02:30:00	0.3835
6334	Q24	ЗУ	MO 14	076	2025-04-05 02:30:00	0
6335	Q25	ЗУ	MO 15	077	2025-04-05 02:30:00	0
6336	TP3	ЗУ	CP-300 New	078	2025-04-05 02:30:00	35.24
6337	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 03:00:00	0
6338	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 03:00:00	0.0013
6339	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 03:00:00	0.0031
6340	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 03:00:00	6.51
6341	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 03:00:00	30.18
6342	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 03:00:00	29.33
6343	QF 1,20	ЗУ	China 1	044	2025-04-05 03:00:00	27.09
6344	QF 1,21	ЗУ	China 2	045	2025-04-05 03:00:00	25.76
6345	QF 1,22	ЗУ	China 3	046	2025-04-05 03:00:00	27.57
6346	QF 2,20	ЗУ	China 4	047	2025-04-05 03:00:00	33.12
6347	QF 2,21	ЗУ	China 5	048	2025-04-05 03:00:00	37
6348	QF 2,22	ЗУ	China 6	049	2025-04-05 03:00:00	34.37
6349	QF 2,23	ЗУ	China 7	050	2025-04-05 03:00:00	17.41
6350	QF 2,19	ЗУ	China 8	051	2025-04-05 03:00:00	28.67
6351	Q8	ЗУ	DIG	061	2025-04-05 03:00:00	33.5
6352	Q4	ЗУ	BG 1	062	2025-04-05 03:00:00	0
6353	Q9	ЗУ	BG 2	063	2025-04-05 03:00:00	2.62
6354	Q10	ЗУ	SM 2	064	2025-04-05 03:00:00	18.47
6355	Q11	ЗУ	SM 3	065	2025-04-05 03:00:00	7.04
6356	Q12	ЗУ	SM 4	066	2025-04-05 03:00:00	18.86
6357	Q13	ЗУ	SM 5	067	2025-04-05 03:00:00	0
6358	Q14	ЗУ	SM 6	068	2025-04-05 03:00:00	0
6359	Q15	ЗУ	SM 7	069	2025-04-05 03:00:00	0
6360	Q16	ЗУ	SM 8	070	2025-04-05 03:00:00	0
6361	Q17	ЗУ	MO 9	071	2025-04-05 03:00:00	1.78
6362	Q20	ЗУ	MO 10	072	2025-04-05 03:00:00	0
6363	Q21	ЗУ	MO 11	073	2025-04-05 03:00:00	13.78
6364	Q22	ЗУ	MO 12	074	2025-04-05 03:00:00	30.72
6365	Q23	ЗУ	MO 13	075	2025-04-05 03:00:00	5.78
6366	Q24	ЗУ	MO 14	076	2025-04-05 03:00:00	0
6367	Q25	ЗУ	MO 15	077	2025-04-05 03:00:00	0
6368	TP3	ЗУ	CP-300 New	078	2025-04-05 03:00:00	33.6
6369	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 03:30:00	0
6370	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 03:30:00	0.0009
6371	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 03:30:00	0.003
6372	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 03:30:00	5.57
6373	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 03:30:00	36.54
6374	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 03:30:00	35.29
6375	QF 1,20	ЗУ	China 1	044	2025-04-05 03:30:00	24.73
6376	QF 1,21	ЗУ	China 2	045	2025-04-05 03:30:00	22.89
6377	QF 1,22	ЗУ	China 3	046	2025-04-05 03:30:00	24.19
6378	QF 2,20	ЗУ	China 4	047	2025-04-05 03:30:00	28.83
6379	QF 2,21	ЗУ	China 5	048	2025-04-05 03:30:00	33.05
6380	QF 2,22	ЗУ	China 6	049	2025-04-05 03:30:00	30.38
6381	QF 2,23	ЗУ	China 7	050	2025-04-05 03:30:00	15.73
6382	QF 2,19	ЗУ	China 8	051	2025-04-05 03:30:00	25.68
6383	Q8	ЗУ	DIG	061	2025-04-05 03:30:00	39.51
6384	Q4	ЗУ	BG 1	062	2025-04-05 03:30:00	0
6385	Q9	ЗУ	BG 2	063	2025-04-05 03:30:00	2.63
6386	Q10	ЗУ	SM 2	064	2025-04-05 03:30:00	18.46
6387	Q11	ЗУ	SM 3	065	2025-04-05 03:30:00	7.06
6388	Q12	ЗУ	SM 4	066	2025-04-05 03:30:00	16.02
6389	Q13	ЗУ	SM 5	067	2025-04-05 03:30:00	0
6390	Q14	ЗУ	SM 6	068	2025-04-05 03:30:00	0
6391	Q15	ЗУ	SM 7	069	2025-04-05 03:30:00	0
6392	Q16	ЗУ	SM 8	070	2025-04-05 03:30:00	0
6393	Q17	ЗУ	MO 9	071	2025-04-05 03:30:00	2.05
6394	Q20	ЗУ	MO 10	072	2025-04-05 03:30:00	0
6395	Q21	ЗУ	MO 11	073	2025-04-05 03:30:00	12.29
6396	Q22	ЗУ	MO 12	074	2025-04-05 03:30:00	30.68
6397	Q23	ЗУ	MO 13	075	2025-04-05 03:30:00	9.68
6398	Q24	ЗУ	MO 14	076	2025-04-05 03:30:00	0
6399	Q25	ЗУ	MO 15	077	2025-04-05 03:30:00	0
6400	TP3	ЗУ	CP-300 New	078	2025-04-05 03:30:00	30.74
6401	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 04:00:00	0
6402	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 04:00:00	0.0008
6403	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 04:00:00	0.003
6404	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 04:00:00	5.14
6405	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 04:00:00	36.59
6406	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 04:00:00	35.06
6407	QF 1,20	ЗУ	China 1	044	2025-04-05 04:00:00	25.48
6408	QF 1,21	ЗУ	China 2	045	2025-04-05 04:00:00	24.34
6409	QF 1,22	ЗУ	China 3	046	2025-04-05 04:00:00	26.72
6410	QF 2,20	ЗУ	China 4	047	2025-04-05 04:00:00	30.44
6411	QF 2,21	ЗУ	China 5	048	2025-04-05 04:00:00	34.68
6412	QF 2,22	ЗУ	China 6	049	2025-04-05 04:00:00	32.95
6413	QF 2,23	ЗУ	China 7	050	2025-04-05 04:00:00	16.66
6414	QF 2,19	ЗУ	China 8	051	2025-04-05 04:00:00	26.89
6415	Q8	ЗУ	DIG	061	2025-04-05 04:00:00	51.5
6416	Q4	ЗУ	BG 1	062	2025-04-05 04:00:00	0
6417	Q9	ЗУ	BG 2	063	2025-04-05 04:00:00	2.41
6418	Q10	ЗУ	SM 2	064	2025-04-05 04:00:00	18.53
6419	Q11	ЗУ	SM 3	065	2025-04-05 04:00:00	7.11
6420	Q12	ЗУ	SM 4	066	2025-04-05 04:00:00	2.09
6421	Q13	ЗУ	SM 5	067	2025-04-05 04:00:00	0
6422	Q14	ЗУ	SM 6	068	2025-04-05 04:00:00	0
6423	Q15	ЗУ	SM 7	069	2025-04-05 04:00:00	0
6424	Q16	ЗУ	SM 8	070	2025-04-05 04:00:00	0
6425	Q17	ЗУ	MO 9	071	2025-04-05 04:00:00	2.6
6426	Q20	ЗУ	MO 10	072	2025-04-05 04:00:00	0
6427	Q21	ЗУ	MO 11	073	2025-04-05 04:00:00	10.54
6428	Q22	ЗУ	MO 12	074	2025-04-05 04:00:00	30.68
6429	Q23	ЗУ	MO 13	075	2025-04-05 04:00:00	9.71
6430	Q24	ЗУ	MO 14	076	2025-04-05 04:00:00	0
6431	Q25	ЗУ	MO 15	077	2025-04-05 04:00:00	0
6432	TP3	ЗУ	CP-300 New	078	2025-04-05 04:00:00	27.13
6433	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 04:30:00	0
6434	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 04:30:00	0.0013
6435	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 04:30:00	0.003
6436	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 04:30:00	5.11
6437	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 04:30:00	36.54
6438	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 04:30:00	34.94
6439	QF 1,20	ЗУ	China 1	044	2025-04-05 04:30:00	26.67
6440	QF 1,21	ЗУ	China 2	045	2025-04-05 04:30:00	24.74
6441	QF 1,22	ЗУ	China 3	046	2025-04-05 04:30:00	27.42
6442	QF 2,20	ЗУ	China 4	047	2025-04-05 04:30:00	32.14
6443	QF 2,21	ЗУ	China 5	048	2025-04-05 04:30:00	36.24
6444	QF 2,22	ЗУ	China 6	049	2025-04-05 04:30:00	32.96
6445	QF 2,23	ЗУ	China 7	050	2025-04-05 04:30:00	17.2
6446	QF 2,19	ЗУ	China 8	051	2025-04-05 04:30:00	27.67
6447	Q8	ЗУ	DIG	061	2025-04-05 04:30:00	61.86
6448	Q4	ЗУ	BG 1	062	2025-04-05 04:30:00	0
6449	Q9	ЗУ	BG 2	063	2025-04-05 04:30:00	2.16
6450	Q10	ЗУ	SM 2	064	2025-04-05 04:30:00	19.2
6451	Q11	ЗУ	SM 3	065	2025-04-05 04:30:00	7.18
6452	Q12	ЗУ	SM 4	066	2025-04-05 04:30:00	2.06
6453	Q13	ЗУ	SM 5	067	2025-04-05 04:30:00	0
6454	Q14	ЗУ	SM 6	068	2025-04-05 04:30:00	0
6455	Q15	ЗУ	SM 7	069	2025-04-05 04:30:00	0
6456	Q16	ЗУ	SM 8	070	2025-04-05 04:30:00	0
6457	Q17	ЗУ	MO 9	071	2025-04-05 04:30:00	2.56
6458	Q20	ЗУ	MO 10	072	2025-04-05 04:30:00	0
6459	Q21	ЗУ	MO 11	073	2025-04-05 04:30:00	10.54
6460	Q22	ЗУ	MO 12	074	2025-04-05 04:30:00	30.58
6461	Q23	ЗУ	MO 13	075	2025-04-05 04:30:00	9.7
6462	Q24	ЗУ	MO 14	076	2025-04-05 04:30:00	0.3064
6463	Q25	ЗУ	MO 15	077	2025-04-05 04:30:00	0
6464	TP3	ЗУ	CP-300 New	078	2025-04-05 04:30:00	26.05
6465	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 05:00:00	0
6466	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 05:00:00	0.0009
6467	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 05:00:00	0.003
6468	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 05:00:00	5.22
6469	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 05:00:00	34.59
6470	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 05:00:00	33.15
6471	QF 1,20	ЗУ	China 1	044	2025-04-05 05:00:00	26.07
6472	QF 1,21	ЗУ	China 2	045	2025-04-05 05:00:00	24.58
6473	QF 1,22	ЗУ	China 3	046	2025-04-05 05:00:00	27.27
6474	QF 2,20	ЗУ	China 4	047	2025-04-05 05:00:00	31.76
6475	QF 2,21	ЗУ	China 5	048	2025-04-05 05:00:00	35.38
6476	QF 2,22	ЗУ	China 6	049	2025-04-05 05:00:00	33.2
6477	QF 2,23	ЗУ	China 7	050	2025-04-05 05:00:00	17.08
6478	QF 2,19	ЗУ	China 8	051	2025-04-05 05:00:00	26.76
6479	Q8	ЗУ	DIG	061	2025-04-05 05:00:00	55.33
6480	Q4	ЗУ	BG 1	062	2025-04-05 05:00:00	0
6481	Q9	ЗУ	BG 2	063	2025-04-05 05:00:00	2.17
6482	Q10	ЗУ	SM 2	064	2025-04-05 05:00:00	22.48
6483	Q11	ЗУ	SM 3	065	2025-04-05 05:00:00	7.23
6484	Q12	ЗУ	SM 4	066	2025-04-05 05:00:00	0.7505
6485	Q13	ЗУ	SM 5	067	2025-04-05 05:00:00	0
6486	Q14	ЗУ	SM 6	068	2025-04-05 05:00:00	0
6487	Q15	ЗУ	SM 7	069	2025-04-05 05:00:00	0
6488	Q16	ЗУ	SM 8	070	2025-04-05 05:00:00	0
6489	Q17	ЗУ	MO 9	071	2025-04-05 05:00:00	2.53
6490	Q20	ЗУ	MO 10	072	2025-04-05 05:00:00	0
6491	Q21	ЗУ	MO 11	073	2025-04-05 05:00:00	10.54
6492	Q22	ЗУ	MO 12	074	2025-04-05 05:00:00	30.58
6493	Q23	ЗУ	MO 13	075	2025-04-05 05:00:00	9.69
6494	Q24	ЗУ	MO 14	076	2025-04-05 05:00:00	0.3668
6495	Q25	ЗУ	MO 15	077	2025-04-05 05:00:00	0
6496	TP3	ЗУ	CP-300 New	078	2025-04-05 05:00:00	22.59
6497	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 05:30:00	0
6498	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 05:30:00	0.0009
6499	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 05:30:00	0.0031
6500	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 05:30:00	4.88
6501	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 05:30:00	22.86
6502	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 05:30:00	22.42
6503	QF 1,20	ЗУ	China 1	044	2025-04-05 05:30:00	25.76
6504	QF 1,21	ЗУ	China 2	045	2025-04-05 05:30:00	23.47
6505	QF 1,22	ЗУ	China 3	046	2025-04-05 05:30:00	26.32
6506	QF 2,20	ЗУ	China 4	047	2025-04-05 05:30:00	31.27
6507	QF 2,21	ЗУ	China 5	048	2025-04-05 05:30:00	34.23
6508	QF 2,22	ЗУ	China 6	049	2025-04-05 05:30:00	32.46
6509	QF 2,23	ЗУ	China 7	050	2025-04-05 05:30:00	16.22
6510	QF 2,19	ЗУ	China 8	051	2025-04-05 05:30:00	26.1
6511	Q8	ЗУ	DIG	061	2025-04-05 05:30:00	60.05
6512	Q4	ЗУ	BG 1	062	2025-04-05 05:30:00	0
6513	Q9	ЗУ	BG 2	063	2025-04-05 05:30:00	2.14
6514	Q10	ЗУ	SM 2	064	2025-04-05 05:30:00	23.88
6515	Q11	ЗУ	SM 3	065	2025-04-05 05:30:00	7.07
6516	Q12	ЗУ	SM 4	066	2025-04-05 05:30:00	0
6517	Q13	ЗУ	SM 5	067	2025-04-05 05:30:00	0
6518	Q14	ЗУ	SM 6	068	2025-04-05 05:30:00	0
6519	Q15	ЗУ	SM 7	069	2025-04-05 05:30:00	0
6520	Q16	ЗУ	SM 8	070	2025-04-05 05:30:00	0
6521	Q17	ЗУ	MO 9	071	2025-04-05 05:30:00	2.52
6522	Q20	ЗУ	MO 10	072	2025-04-05 05:30:00	0
6523	Q21	ЗУ	MO 11	073	2025-04-05 05:30:00	5.59
6524	Q22	ЗУ	MO 12	074	2025-04-05 05:30:00	30.54
6525	Q23	ЗУ	MO 13	075	2025-04-05 05:30:00	9.74
6526	Q24	ЗУ	MO 14	076	2025-04-05 05:30:00	0.3648
6527	Q25	ЗУ	MO 15	077	2025-04-05 05:30:00	0
6528	TP3	ЗУ	CP-300 New	078	2025-04-05 05:30:00	18.58
6529	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 06:00:00	0
6530	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 06:00:00	0.0011
6531	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 06:00:00	0.0027
6532	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 06:00:00	4.87
6533	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 06:00:00	22.91
6534	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 06:00:00	22.46
6535	QF 1,20	ЗУ	China 1	044	2025-04-05 06:00:00	24.46
6536	QF 1,21	ЗУ	China 2	045	2025-04-05 06:00:00	22.83
6537	QF 1,22	ЗУ	China 3	046	2025-04-05 06:00:00	25.16
6538	QF 2,20	ЗУ	China 4	047	2025-04-05 06:00:00	29.92
6539	QF 2,21	ЗУ	China 5	048	2025-04-05 06:00:00	33.18
6540	QF 2,22	ЗУ	China 6	049	2025-04-05 06:00:00	31.3
6541	QF 2,23	ЗУ	China 7	050	2025-04-05 06:00:00	15.56
6542	QF 2,19	ЗУ	China 8	051	2025-04-05 06:00:00	25.14
6543	Q8	ЗУ	DIG	061	2025-04-05 06:00:00	60
6544	Q4	ЗУ	BG 1	062	2025-04-05 06:00:00	0
6545	Q9	ЗУ	BG 2	063	2025-04-05 06:00:00	1.24
6546	Q10	ЗУ	SM 2	064	2025-04-05 06:00:00	29.08
6547	Q11	ЗУ	SM 3	065	2025-04-05 06:00:00	7.1
6548	Q12	ЗУ	SM 4	066	2025-04-05 06:00:00	0
6549	Q13	ЗУ	SM 5	067	2025-04-05 06:00:00	0
6550	Q14	ЗУ	SM 6	068	2025-04-05 06:00:00	0
6551	Q15	ЗУ	SM 7	069	2025-04-05 06:00:00	0
6552	Q16	ЗУ	SM 8	070	2025-04-05 06:00:00	0
6553	Q17	ЗУ	MO 9	071	2025-04-05 06:00:00	2.53
6554	Q20	ЗУ	MO 10	072	2025-04-05 06:00:00	0
6555	Q21	ЗУ	MO 11	073	2025-04-05 06:00:00	0
6556	Q22	ЗУ	MO 12	074	2025-04-05 06:00:00	30.53
6557	Q23	ЗУ	MO 13	075	2025-04-05 06:00:00	9.73
6558	Q24	ЗУ	MO 14	076	2025-04-05 06:00:00	0.3645
6559	Q25	ЗУ	MO 15	077	2025-04-05 06:00:00	0
6560	TP3	ЗУ	CP-300 New	078	2025-04-05 06:00:00	18.3
6561	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 06:30:00	0
6562	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 06:30:00	0.0008
6563	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 06:30:00	0.0027
6564	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 06:30:00	4.94
6565	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 06:30:00	22.95
6566	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 06:30:00	22.5
6567	QF 1,20	ЗУ	China 1	044	2025-04-05 06:30:00	21.16
6568	QF 1,21	ЗУ	China 2	045	2025-04-05 06:30:00	19.1
6569	QF 1,22	ЗУ	China 3	046	2025-04-05 06:30:00	21.45
6570	QF 2,20	ЗУ	China 4	047	2025-04-05 06:30:00	26.05
6571	QF 2,21	ЗУ	China 5	048	2025-04-05 06:30:00	29.4
6572	QF 2,22	ЗУ	China 6	049	2025-04-05 06:30:00	27.09
6573	QF 2,23	ЗУ	China 7	050	2025-04-05 06:30:00	13.03
6574	QF 2,19	ЗУ	China 8	051	2025-04-05 06:30:00	21.23
6575	Q8	ЗУ	DIG	061	2025-04-05 06:30:00	59.99
6576	Q4	ЗУ	BG 1	062	2025-04-05 06:30:00	0
6577	Q9	ЗУ	BG 2	063	2025-04-05 06:30:00	0.4383
6578	Q10	ЗУ	SM 2	064	2025-04-05 06:30:00	29.82
6579	Q11	ЗУ	SM 3	065	2025-04-05 06:30:00	7.18
6580	Q12	ЗУ	SM 4	066	2025-04-05 06:30:00	0
6581	Q13	ЗУ	SM 5	067	2025-04-05 06:30:00	0
6582	Q14	ЗУ	SM 6	068	2025-04-05 06:30:00	0
6583	Q15	ЗУ	SM 7	069	2025-04-05 06:30:00	0
6584	Q16	ЗУ	SM 8	070	2025-04-05 06:30:00	0
6585	Q17	ЗУ	MO 9	071	2025-04-05 06:30:00	2.53
6586	Q20	ЗУ	MO 10	072	2025-04-05 06:30:00	0
6587	Q21	ЗУ	MO 11	073	2025-04-05 06:30:00	0
6588	Q22	ЗУ	MO 12	074	2025-04-05 06:30:00	30.56
6589	Q23	ЗУ	MO 13	075	2025-04-05 06:30:00	9.69
6590	Q24	ЗУ	MO 14	076	2025-04-05 06:30:00	0.9547
6591	Q25	ЗУ	MO 15	077	2025-04-05 06:30:00	0
6592	TP3	ЗУ	CP-300 New	078	2025-04-05 06:30:00	17.27
6593	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 07:00:00	0
6594	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 07:00:00	0.0019
6595	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 07:00:00	0.0029
6596	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 07:00:00	4.83
6597	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 07:00:00	23.01
6598	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 07:00:00	22.53
6599	QF 1,20	ЗУ	China 1	044	2025-04-05 07:00:00	23.14
6600	QF 1,21	ЗУ	China 2	045	2025-04-05 07:00:00	20.92
6601	QF 1,22	ЗУ	China 3	046	2025-04-05 07:00:00	23.58
6602	QF 2,20	ЗУ	China 4	047	2025-04-05 07:00:00	28.36
6603	QF 2,21	ЗУ	China 5	048	2025-04-05 07:00:00	31.4
6604	QF 2,22	ЗУ	China 6	049	2025-04-05 07:00:00	29.57
6605	QF 2,23	ЗУ	China 7	050	2025-04-05 07:00:00	13.17
6606	QF 2,19	ЗУ	China 8	051	2025-04-05 07:00:00	22.99
6607	Q8	ЗУ	DIG	061	2025-04-05 07:00:00	59.59
6608	Q4	ЗУ	BG 1	062	2025-04-05 07:00:00	0
6609	Q9	ЗУ	BG 2	063	2025-04-05 07:00:00	0
6610	Q10	ЗУ	SM 2	064	2025-04-05 07:00:00	32.16
6611	Q11	ЗУ	SM 3	065	2025-04-05 07:00:00	7.27
6612	Q12	ЗУ	SM 4	066	2025-04-05 07:00:00	0
6613	Q13	ЗУ	SM 5	067	2025-04-05 07:00:00	0
6614	Q14	ЗУ	SM 6	068	2025-04-05 07:00:00	0
6615	Q15	ЗУ	SM 7	069	2025-04-05 07:00:00	0
6616	Q16	ЗУ	SM 8	070	2025-04-05 07:00:00	0
6617	Q17	ЗУ	MO 9	071	2025-04-05 07:00:00	2.52
6618	Q20	ЗУ	MO 10	072	2025-04-05 07:00:00	0
6619	Q21	ЗУ	MO 11	073	2025-04-05 07:00:00	0
6620	Q22	ЗУ	MO 12	074	2025-04-05 07:00:00	30.39
6621	Q23	ЗУ	MO 13	075	2025-04-05 07:00:00	9.64
6622	Q24	ЗУ	MO 14	076	2025-04-05 07:00:00	10.77
6623	Q25	ЗУ	MO 15	077	2025-04-05 07:00:00	0
6624	TP3	ЗУ	CP-300 New	078	2025-04-05 07:00:00	14.57
6625	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 07:30:00	0.6434
6626	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 07:30:00	0.5137
6627	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 07:30:00	0.1106
6628	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 07:30:00	4.79
6629	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 07:30:00	22.98
6630	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 07:30:00	22.51
6631	QF 1,20	ЗУ	China 1	044	2025-04-05 07:30:00	21.75
6632	QF 1,21	ЗУ	China 2	045	2025-04-05 07:30:00	19.5
6633	QF 1,22	ЗУ	China 3	046	2025-04-05 07:30:00	22.61
6634	QF 2,20	ЗУ	China 4	047	2025-04-05 07:30:00	27.09
6635	QF 2,21	ЗУ	China 5	048	2025-04-05 07:30:00	30.61
6636	QF 2,22	ЗУ	China 6	049	2025-04-05 07:30:00	28.46
6637	QF 2,23	ЗУ	China 7	050	2025-04-05 07:30:00	14.08
6638	QF 2,19	ЗУ	China 8	051	2025-04-05 07:30:00	21.02
6639	Q8	ЗУ	DIG	061	2025-04-05 07:30:00	59.4
6640	Q4	ЗУ	BG 1	062	2025-04-05 07:30:00	0
6641	Q9	ЗУ	BG 2	063	2025-04-05 07:30:00	0
6642	Q10	ЗУ	SM 2	064	2025-04-05 07:30:00	32.21
6643	Q11	ЗУ	SM 3	065	2025-04-05 07:30:00	7.38
6644	Q12	ЗУ	SM 4	066	2025-04-05 07:30:00	0
6645	Q13	ЗУ	SM 5	067	2025-04-05 07:30:00	0
6646	Q14	ЗУ	SM 6	068	2025-04-05 07:30:00	0
6647	Q15	ЗУ	SM 7	069	2025-04-05 07:30:00	0
6648	Q16	ЗУ	SM 8	070	2025-04-05 07:30:00	0
6649	Q17	ЗУ	MO 9	071	2025-04-05 07:30:00	2.48
6650	Q20	ЗУ	MO 10	072	2025-04-05 07:30:00	0
6651	Q21	ЗУ	MO 11	073	2025-04-05 07:30:00	0
6652	Q22	ЗУ	MO 12	074	2025-04-05 07:30:00	30.35
6653	Q23	ЗУ	MO 13	075	2025-04-05 07:30:00	9.67
6654	Q24	ЗУ	MO 14	076	2025-04-05 07:30:00	10.73
6655	Q25	ЗУ	MO 15	077	2025-04-05 07:30:00	0.3219
6656	TP3	ЗУ	CP-300 New	078	2025-04-05 07:30:00	12.41
6657	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 08:00:00	0
6658	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 08:00:00	0.0019
6659	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 08:00:00	0.0029
6660	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 08:00:00	5.2
6661	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 08:00:00	23.11
6662	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 08:00:00	22.66
6663	QF 1,20	ЗУ	China 1	044	2025-04-05 08:00:00	19.43
6664	QF 1,21	ЗУ	China 2	045	2025-04-05 08:00:00	17.73
6665	QF 1,22	ЗУ	China 3	046	2025-04-05 08:00:00	20.33
6666	QF 2,20	ЗУ	China 4	047	2025-04-05 08:00:00	25.5
6667	QF 2,21	ЗУ	China 5	048	2025-04-05 08:00:00	28.33
6668	QF 2,22	ЗУ	China 6	049	2025-04-05 08:00:00	26.53
6669	QF 2,23	ЗУ	China 7	050	2025-04-05 08:00:00	13.11
6670	QF 2,19	ЗУ	China 8	051	2025-04-05 08:00:00	18.93
6671	Q8	ЗУ	DIG	061	2025-04-05 08:00:00	50.52
6672	Q4	ЗУ	BG 1	062	2025-04-05 08:00:00	1.09
6673	Q9	ЗУ	BG 2	063	2025-04-05 08:00:00	0.0152
6674	Q10	ЗУ	SM 2	064	2025-04-05 08:00:00	32.27
6675	Q11	ЗУ	SM 3	065	2025-04-05 08:00:00	6.32
6676	Q12	ЗУ	SM 4	066	2025-04-05 08:00:00	0
6677	Q13	ЗУ	SM 5	067	2025-04-05 08:00:00	0
6678	Q14	ЗУ	SM 6	068	2025-04-05 08:00:00	0
6679	Q15	ЗУ	SM 7	069	2025-04-05 08:00:00	0
6680	Q16	ЗУ	SM 8	070	2025-04-05 08:00:00	0
6681	Q17	ЗУ	MO 9	071	2025-04-05 08:00:00	2.56
6682	Q20	ЗУ	MO 10	072	2025-04-05 08:00:00	0
6683	Q21	ЗУ	MO 11	073	2025-04-05 08:00:00	0
6684	Q22	ЗУ	MO 12	074	2025-04-05 08:00:00	30.45
6685	Q23	ЗУ	MO 13	075	2025-04-05 08:00:00	15.48
6686	Q24	ЗУ	MO 14	076	2025-04-05 08:00:00	10.71
6687	Q25	ЗУ	MO 15	077	2025-04-05 08:00:00	9.9
6688	TP3	ЗУ	CP-300 New	078	2025-04-05 08:00:00	8.87
6689	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 08:30:00	0
6690	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 08:30:00	0.0015
6691	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 08:30:00	0.0028
6692	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 08:30:00	4.52
6693	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 08:30:00	19.6
6694	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 08:30:00	19.23
6695	QF 1,20	ЗУ	China 1	044	2025-04-05 08:30:00	14.66
6696	QF 1,21	ЗУ	China 2	045	2025-04-05 08:30:00	13.01
6697	QF 1,22	ЗУ	China 3	046	2025-04-05 08:30:00	15.57
6698	QF 2,20	ЗУ	China 4	047	2025-04-05 08:30:00	20.05
6699	QF 2,21	ЗУ	China 5	048	2025-04-05 08:30:00	21.57
6700	QF 2,22	ЗУ	China 6	049	2025-04-05 08:30:00	20.42
6701	QF 2,23	ЗУ	China 7	050	2025-04-05 08:30:00	10.23
6702	QF 2,19	ЗУ	China 8	051	2025-04-05 08:30:00	14.42
6703	Q8	ЗУ	DIG	061	2025-04-05 08:30:00	61.97
6704	Q4	ЗУ	BG 1	062	2025-04-05 08:30:00	1.06
6705	Q9	ЗУ	BG 2	063	2025-04-05 08:30:00	0.4637
6706	Q10	ЗУ	SM 2	064	2025-04-05 08:30:00	32.25
6707	Q11	ЗУ	SM 3	065	2025-04-05 08:30:00	5.87
6708	Q12	ЗУ	SM 4	066	2025-04-05 08:30:00	0
6709	Q13	ЗУ	SM 5	067	2025-04-05 08:30:00	0
6710	Q14	ЗУ	SM 6	068	2025-04-05 08:30:00	0
6711	Q15	ЗУ	SM 7	069	2025-04-05 08:30:00	0
6712	Q16	ЗУ	SM 8	070	2025-04-05 08:30:00	0
6713	Q17	ЗУ	MO 9	071	2025-04-05 08:30:00	2.75
6714	Q20	ЗУ	MO 10	072	2025-04-05 08:30:00	0
6715	Q21	ЗУ	MO 11	073	2025-04-05 08:30:00	0
6716	Q22	ЗУ	MO 12	074	2025-04-05 08:30:00	30.34
6717	Q23	ЗУ	MO 13	075	2025-04-05 08:30:00	19.65
6718	Q24	ЗУ	MO 14	076	2025-04-05 08:30:00	10.72
6719	Q25	ЗУ	MO 15	077	2025-04-05 08:30:00	9.82
6720	TP3	ЗУ	CP-300 New	078	2025-04-05 08:30:00	7.04
6721	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 09:00:00	0
6722	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 09:00:00	0.0024
6723	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 09:00:00	0.0029
6724	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 09:00:00	0.8954
6725	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 09:00:00	0.6952
6726	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 09:00:00	0.7348
6727	QF 1,20	ЗУ	China 1	044	2025-04-05 09:00:00	12.18
6728	QF 1,21	ЗУ	China 2	045	2025-04-05 09:00:00	10.69
6729	QF 1,22	ЗУ	China 3	046	2025-04-05 09:00:00	13.18
6730	QF 2,20	ЗУ	China 4	047	2025-04-05 09:00:00	17.72
6731	QF 2,21	ЗУ	China 5	048	2025-04-05 09:00:00	18.45
6732	QF 2,22	ЗУ	China 6	049	2025-04-05 09:00:00	17.33
6733	QF 2,23	ЗУ	China 7	050	2025-04-05 09:00:00	8.86
6734	QF 2,19	ЗУ	China 8	051	2025-04-05 09:00:00	12.32
6735	Q8	ЗУ	DIG	061	2025-04-05 09:00:00	55.48
6736	Q4	ЗУ	BG 1	062	2025-04-05 09:00:00	1.06
6737	Q9	ЗУ	BG 2	063	2025-04-05 09:00:00	0.6245
6738	Q10	ЗУ	SM 2	064	2025-04-05 09:00:00	32.23
6739	Q11	ЗУ	SM 3	065	2025-04-05 09:00:00	5.88
6740	Q12	ЗУ	SM 4	066	2025-04-05 09:00:00	0
6741	Q13	ЗУ	SM 5	067	2025-04-05 09:00:00	0
6742	Q14	ЗУ	SM 6	068	2025-04-05 09:00:00	0
6743	Q15	ЗУ	SM 7	069	2025-04-05 09:00:00	0
6744	Q16	ЗУ	SM 8	070	2025-04-05 09:00:00	0
6745	Q17	ЗУ	MO 9	071	2025-04-05 09:00:00	3.17
6746	Q20	ЗУ	MO 10	072	2025-04-05 09:00:00	0
6747	Q21	ЗУ	MO 11	073	2025-04-05 09:00:00	0
6748	Q22	ЗУ	MO 12	074	2025-04-05 09:00:00	30.32
6749	Q23	ЗУ	MO 13	075	2025-04-05 09:00:00	19.59
6750	Q24	ЗУ	MO 14	076	2025-04-05 09:00:00	10.71
6751	Q25	ЗУ	MO 15	077	2025-04-05 09:00:00	9.83
6752	TP3	ЗУ	CP-300 New	078	2025-04-05 09:00:00	5.53
6753	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 09:30:00	0
6754	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 09:30:00	0.002
6755	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 09:30:00	0.0029
6756	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 09:30:00	0.0034
6757	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 09:30:00	0
6758	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 09:30:00	0
6759	QF 1,20	ЗУ	China 1	044	2025-04-05 09:30:00	10.48
6760	QF 1,21	ЗУ	China 2	045	2025-04-05 09:30:00	9.01
6761	QF 1,22	ЗУ	China 3	046	2025-04-05 09:30:00	11.25
6762	QF 2,20	ЗУ	China 4	047	2025-04-05 09:30:00	15.87
6763	QF 2,21	ЗУ	China 5	048	2025-04-05 09:30:00	16.75
6764	QF 2,22	ЗУ	China 6	049	2025-04-05 09:30:00	15.47
6765	QF 2,23	ЗУ	China 7	050	2025-04-05 09:30:00	7.97
6766	QF 2,19	ЗУ	China 8	051	2025-04-05 09:30:00	10.23
6767	Q8	ЗУ	DIG	061	2025-04-05 09:30:00	71.72
6768	Q4	ЗУ	BG 1	062	2025-04-05 09:30:00	1.04
6769	Q9	ЗУ	BG 2	063	2025-04-05 09:30:00	2.41
6770	Q10	ЗУ	SM 2	064	2025-04-05 09:30:00	32.19
6771	Q11	ЗУ	SM 3	065	2025-04-05 09:30:00	5.97
6772	Q12	ЗУ	SM 4	066	2025-04-05 09:30:00	0
6773	Q13	ЗУ	SM 5	067	2025-04-05 09:30:00	0
6774	Q14	ЗУ	SM 6	068	2025-04-05 09:30:00	0
6775	Q15	ЗУ	SM 7	069	2025-04-05 09:30:00	0
6776	Q16	ЗУ	SM 8	070	2025-04-05 09:30:00	0
6777	Q17	ЗУ	MO 9	071	2025-04-05 09:30:00	3.16
6778	Q20	ЗУ	MO 10	072	2025-04-05 09:30:00	0
6779	Q21	ЗУ	MO 11	073	2025-04-05 09:30:00	0
6780	Q22	ЗУ	MO 12	074	2025-04-05 09:30:00	30.31
6781	Q23	ЗУ	MO 13	075	2025-04-05 09:30:00	19.6
6782	Q24	ЗУ	MO 14	076	2025-04-05 09:30:00	10.7
6783	Q25	ЗУ	MO 15	077	2025-04-05 09:30:00	9.79
6784	TP3	ЗУ	CP-300 New	078	2025-04-05 09:30:00	10.7
6785	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 10:00:00	0
6786	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 10:00:00	0.0016
6787	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 10:00:00	0.0026
6788	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 10:00:00	0.0035
6789	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 10:00:00	0
6790	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 10:00:00	0
6791	QF 1,20	ЗУ	China 1	044	2025-04-05 10:00:00	7.18
6792	QF 1,21	ЗУ	China 2	045	2025-04-05 10:00:00	5.21
6793	QF 1,22	ЗУ	China 3	046	2025-04-05 10:00:00	8.08
6794	QF 2,20	ЗУ	China 4	047	2025-04-05 10:00:00	12.06
6795	QF 2,21	ЗУ	China 5	048	2025-04-05 10:00:00	13.08
6796	QF 2,22	ЗУ	China 6	049	2025-04-05 10:00:00	11.87
6797	QF 2,23	ЗУ	China 7	050	2025-04-05 10:00:00	6.12
6798	QF 2,19	ЗУ	China 8	051	2025-04-05 10:00:00	6.85
6799	Q8	ЗУ	DIG	061	2025-04-05 10:00:00	75.55
6800	Q4	ЗУ	BG 1	062	2025-04-05 10:00:00	1.03
6801	Q9	ЗУ	BG 2	063	2025-04-05 10:00:00	9.13
6802	Q10	ЗУ	SM 2	064	2025-04-05 10:00:00	32.27
6803	Q11	ЗУ	SM 3	065	2025-04-05 10:00:00	2.77
6804	Q12	ЗУ	SM 4	066	2025-04-05 10:00:00	0
6805	Q13	ЗУ	SM 5	067	2025-04-05 10:00:00	0
6806	Q14	ЗУ	SM 6	068	2025-04-05 10:00:00	0
6807	Q15	ЗУ	SM 7	069	2025-04-05 10:00:00	0
6808	Q16	ЗУ	SM 8	070	2025-04-05 10:00:00	0
6809	Q17	ЗУ	MO 9	071	2025-04-05 10:00:00	3.19
6810	Q20	ЗУ	MO 10	072	2025-04-05 10:00:00	0
6811	Q21	ЗУ	MO 11	073	2025-04-05 10:00:00	0
6812	Q22	ЗУ	MO 12	074	2025-04-05 10:00:00	30.29
6813	Q23	ЗУ	MO 13	075	2025-04-05 10:00:00	19.62
6814	Q24	ЗУ	MO 14	076	2025-04-05 10:00:00	10.68
6815	Q25	ЗУ	MO 15	077	2025-04-05 10:00:00	9.81
6816	TP3	ЗУ	CP-300 New	078	2025-04-05 10:00:00	15.2
6817	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 10:30:00	0
6818	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 10:30:00	0.0016
6819	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 10:30:00	0.0024
6820	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 10:30:00	0.003
6821	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 10:30:00	0
6822	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 10:30:00	0
6823	QF 1,20	ЗУ	China 1	044	2025-04-05 10:30:00	5.97
6824	QF 1,21	ЗУ	China 2	045	2025-04-05 10:30:00	3.85
6825	QF 1,22	ЗУ	China 3	046	2025-04-05 10:30:00	6.79
6826	QF 2,20	ЗУ	China 4	047	2025-04-05 10:30:00	10.37
6827	QF 2,21	ЗУ	China 5	048	2025-04-05 10:30:00	12.52
6828	QF 2,22	ЗУ	China 6	049	2025-04-05 10:30:00	10.93
6829	QF 2,23	ЗУ	China 7	050	2025-04-05 10:30:00	5.73
6830	QF 2,19	ЗУ	China 8	051	2025-04-05 10:30:00	5.9
6831	Q8	ЗУ	DIG	061	2025-04-05 10:30:00	75.38
6832	Q4	ЗУ	BG 1	062	2025-04-05 10:30:00	1.01
6833	Q9	ЗУ	BG 2	063	2025-04-05 10:30:00	9.14
6834	Q10	ЗУ	SM 2	064	2025-04-05 10:30:00	32.28
6835	Q11	ЗУ	SM 3	065	2025-04-05 10:30:00	1.84
6836	Q12	ЗУ	SM 4	066	2025-04-05 10:30:00	0
6837	Q13	ЗУ	SM 5	067	2025-04-05 10:30:00	0
6838	Q14	ЗУ	SM 6	068	2025-04-05 10:30:00	0
6839	Q15	ЗУ	SM 7	069	2025-04-05 10:30:00	0
6840	Q16	ЗУ	SM 8	070	2025-04-05 10:30:00	0
6841	Q17	ЗУ	MO 9	071	2025-04-05 10:30:00	3.19
6842	Q20	ЗУ	MO 10	072	2025-04-05 10:30:00	0
6843	Q21	ЗУ	MO 11	073	2025-04-05 10:30:00	0
6844	Q22	ЗУ	MO 12	074	2025-04-05 10:30:00	30.27
6845	Q23	ЗУ	MO 13	075	2025-04-05 10:30:00	19.62
6846	Q24	ЗУ	MO 14	076	2025-04-05 10:30:00	10.68
6847	Q25	ЗУ	MO 15	077	2025-04-05 10:30:00	9.77
6848	TP3	ЗУ	CP-300 New	078	2025-04-05 10:30:00	16.26
6849	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 11:00:00	0
6850	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 11:00:00	0.0017
6851	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 11:00:00	0.0028
6852	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 11:00:00	0.0035
6853	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 11:00:00	0
6854	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 11:00:00	0
6855	QF 1,20	ЗУ	China 1	044	2025-04-05 11:00:00	4.81
6856	QF 1,21	ЗУ	China 2	045	2025-04-05 11:00:00	2.89
6857	QF 1,22	ЗУ	China 3	046	2025-04-05 11:00:00	5.17
6858	QF 2,20	ЗУ	China 4	047	2025-04-05 11:00:00	8.94
6859	QF 2,21	ЗУ	China 5	048	2025-04-05 11:00:00	11.13
6860	QF 2,22	ЗУ	China 6	049	2025-04-05 11:00:00	9.78
6861	QF 2,23	ЗУ	China 7	050	2025-04-05 11:00:00	5.08
6862	QF 2,19	ЗУ	China 8	051	2025-04-05 11:00:00	4.92
6863	Q8	ЗУ	DIG	061	2025-04-05 11:00:00	75.25
6864	Q4	ЗУ	BG 1	062	2025-04-05 11:00:00	1.02
6865	Q9	ЗУ	BG 2	063	2025-04-05 11:00:00	9.16
6866	Q10	ЗУ	SM 2	064	2025-04-05 11:00:00	32.18
6867	Q11	ЗУ	SM 3	065	2025-04-05 11:00:00	3.18
6868	Q12	ЗУ	SM 4	066	2025-04-05 11:00:00	0
6869	Q13	ЗУ	SM 5	067	2025-04-05 11:00:00	0
6870	Q14	ЗУ	SM 6	068	2025-04-05 11:00:00	0
6871	Q15	ЗУ	SM 7	069	2025-04-05 11:00:00	0
6872	Q16	ЗУ	SM 8	070	2025-04-05 11:00:00	0
6873	Q17	ЗУ	MO 9	071	2025-04-05 11:00:00	3.18
6874	Q20	ЗУ	MO 10	072	2025-04-05 11:00:00	0
6875	Q21	ЗУ	MO 11	073	2025-04-05 11:00:00	0
6876	Q22	ЗУ	MO 12	074	2025-04-05 11:00:00	30.25
6877	Q23	ЗУ	MO 13	075	2025-04-05 11:00:00	19.6
6878	Q24	ЗУ	MO 14	076	2025-04-05 11:00:00	10.68
6879	Q25	ЗУ	MO 15	077	2025-04-05 11:00:00	9.76
6880	TP3	ЗУ	CP-300 New	078	2025-04-05 11:00:00	17.49
6881	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 11:30:00	0
6882	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 11:30:00	0.0023
6883	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 11:30:00	0.0026
6884	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 11:30:00	0.0032
6885	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 11:30:00	0
6886	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 11:30:00	0
6887	QF 1,20	ЗУ	China 1	044	2025-04-05 11:30:00	3.97
6888	QF 1,21	ЗУ	China 2	045	2025-04-05 11:30:00	2.22
6889	QF 1,22	ЗУ	China 3	046	2025-04-05 11:30:00	4.41
6890	QF 2,20	ЗУ	China 4	047	2025-04-05 11:30:00	8.09
6891	QF 2,21	ЗУ	China 5	048	2025-04-05 11:30:00	9.94
6892	QF 2,22	ЗУ	China 6	049	2025-04-05 11:30:00	8.55
6893	QF 2,23	ЗУ	China 7	050	2025-04-05 11:30:00	4.72
6894	QF 2,19	ЗУ	China 8	051	2025-04-05 11:30:00	4.74
6895	Q8	ЗУ	DIG	061	2025-04-05 11:30:00	74.67
6896	Q4	ЗУ	BG 1	062	2025-04-05 11:30:00	6.91
6897	Q9	ЗУ	BG 2	063	2025-04-05 11:30:00	9.17
6898	Q10	ЗУ	SM 2	064	2025-04-05 11:30:00	32.22
6899	Q11	ЗУ	SM 3	065	2025-04-05 11:30:00	4.11
6900	Q12	ЗУ	SM 4	066	2025-04-05 11:30:00	0
6901	Q13	ЗУ	SM 5	067	2025-04-05 11:30:00	0
6902	Q14	ЗУ	SM 6	068	2025-04-05 11:30:00	0
6903	Q15	ЗУ	SM 7	069	2025-04-05 11:30:00	0
6904	Q16	ЗУ	SM 8	070	2025-04-05 11:30:00	0
6905	Q17	ЗУ	MO 9	071	2025-04-05 11:30:00	3.2
6906	Q20	ЗУ	MO 10	072	2025-04-05 11:30:00	0
6907	Q21	ЗУ	MO 11	073	2025-04-05 11:30:00	0
6908	Q22	ЗУ	MO 12	074	2025-04-05 11:30:00	30.26
6909	Q23	ЗУ	MO 13	075	2025-04-05 11:30:00	19.63
6910	Q24	ЗУ	MO 14	076	2025-04-05 11:30:00	11.34
6911	Q25	ЗУ	MO 15	077	2025-04-05 11:30:00	9.77
6912	TP3	ЗУ	CP-300 New	078	2025-04-05 11:30:00	19.23
6913	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 12:00:00	0
6914	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 12:00:00	0.0014
6915	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 12:00:00	0.0029
6916	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 12:00:00	0.0035
6917	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 12:00:00	0
6918	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 12:00:00	0
6919	QF 1,20	ЗУ	China 1	044	2025-04-05 12:00:00	3.94
6920	QF 1,21	ЗУ	China 2	045	2025-04-05 12:00:00	2.15
6921	QF 1,22	ЗУ	China 3	046	2025-04-05 12:00:00	4.39
6922	QF 2,20	ЗУ	China 4	047	2025-04-05 12:00:00	8.05
6923	QF 2,21	ЗУ	China 5	048	2025-04-05 12:00:00	10.09
6924	QF 2,22	ЗУ	China 6	049	2025-04-05 12:00:00	8.19
6925	QF 2,23	ЗУ	China 7	050	2025-04-05 12:00:00	4.67
6926	QF 2,19	ЗУ	China 8	051	2025-04-05 12:00:00	4.63
6927	Q8	ЗУ	DIG	061	2025-04-05 12:00:00	74.94
6928	Q4	ЗУ	BG 1	062	2025-04-05 12:00:00	9.32
6929	Q9	ЗУ	BG 2	063	2025-04-05 12:00:00	9.2
6930	Q10	ЗУ	SM 2	064	2025-04-05 12:00:00	32.25
6931	Q11	ЗУ	SM 3	065	2025-04-05 12:00:00	4.61
6932	Q12	ЗУ	SM 4	066	2025-04-05 12:00:00	0
6933	Q13	ЗУ	SM 5	067	2025-04-05 12:00:00	0
6934	Q14	ЗУ	SM 6	068	2025-04-05 12:00:00	0
6935	Q15	ЗУ	SM 7	069	2025-04-05 12:00:00	0
6936	Q16	ЗУ	SM 8	070	2025-04-05 12:00:00	0
6937	Q17	ЗУ	MO 9	071	2025-04-05 12:00:00	3.22
6938	Q20	ЗУ	MO 10	072	2025-04-05 12:00:00	0
6939	Q21	ЗУ	MO 11	073	2025-04-05 12:00:00	0
6940	Q22	ЗУ	MO 12	074	2025-04-05 12:00:00	30.26
6941	Q23	ЗУ	MO 13	075	2025-04-05 12:00:00	19.66
6942	Q24	ЗУ	MO 14	076	2025-04-05 12:00:00	19.26
6943	Q25	ЗУ	MO 15	077	2025-04-05 12:00:00	9.83
6944	TP3	ЗУ	CP-300 New	078	2025-04-05 12:00:00	23.51
6945	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 12:30:00	0
6946	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 12:30:00	0.0018
6947	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 12:30:00	0.0026
6948	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 12:30:00	0.0035
6949	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 12:30:00	0
6950	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 12:30:00	0
6951	QF 1,20	ЗУ	China 1	044	2025-04-05 12:30:00	3.33
6952	QF 1,21	ЗУ	China 2	045	2025-04-05 12:30:00	1.27
6953	QF 1,22	ЗУ	China 3	046	2025-04-05 12:30:00	3.87
6954	QF 2,20	ЗУ	China 4	047	2025-04-05 12:30:00	7.21
6955	QF 2,21	ЗУ	China 5	048	2025-04-05 12:30:00	9.15
6956	QF 2,22	ЗУ	China 6	049	2025-04-05 12:30:00	7.18
6957	QF 2,23	ЗУ	China 7	050	2025-04-05 12:30:00	4.09
6958	QF 2,19	ЗУ	China 8	051	2025-04-05 12:30:00	3.99
6959	Q8	ЗУ	DIG	061	2025-04-05 12:30:00	65.63
6960	Q4	ЗУ	BG 1	062	2025-04-05 12:30:00	8.69
6961	Q9	ЗУ	BG 2	063	2025-04-05 12:30:00	9.17
6962	Q10	ЗУ	SM 2	064	2025-04-05 12:30:00	32.18
6963	Q11	ЗУ	SM 3	065	2025-04-05 12:30:00	5.14
6964	Q12	ЗУ	SM 4	066	2025-04-05 12:30:00	0
6965	Q13	ЗУ	SM 5	067	2025-04-05 12:30:00	0
6966	Q14	ЗУ	SM 6	068	2025-04-05 12:30:00	0
6967	Q15	ЗУ	SM 7	069	2025-04-05 12:30:00	0
6968	Q16	ЗУ	SM 8	070	2025-04-05 12:30:00	0
6969	Q17	ЗУ	MO 9	071	2025-04-05 12:30:00	3.22
6970	Q20	ЗУ	MO 10	072	2025-04-05 12:30:00	0
6971	Q21	ЗУ	MO 11	073	2025-04-05 12:30:00	0
6972	Q22	ЗУ	MO 12	074	2025-04-05 12:30:00	30.23
6973	Q23	ЗУ	MO 13	075	2025-04-05 12:30:00	19.64
6974	Q24	ЗУ	MO 14	076	2025-04-05 12:30:00	19.21
6975	Q25	ЗУ	MO 15	077	2025-04-05 12:30:00	9.77
6976	TP3	ЗУ	CP-300 New	078	2025-04-05 12:30:00	28.95
6977	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 13:00:00	0
6978	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 13:00:00	0.0016
6979	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 13:00:00	0.0024
6980	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 13:00:00	0.0032
6981	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 13:00:00	0
6982	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 13:00:00	0
6983	QF 1,20	ЗУ	China 1	044	2025-04-05 13:00:00	1.27
6984	QF 1,21	ЗУ	China 2	045	2025-04-05 13:00:00	0.0954
6985	QF 1,22	ЗУ	China 3	046	2025-04-05 13:00:00	2.48
6986	QF 2,20	ЗУ	China 4	047	2025-04-05 13:00:00	3.94
6987	QF 2,21	ЗУ	China 5	048	2025-04-05 13:00:00	4.89
6988	QF 2,22	ЗУ	China 6	049	2025-04-05 13:00:00	3.1
6989	QF 2,23	ЗУ	China 7	050	2025-04-05 13:00:00	1.51
6990	QF 2,19	ЗУ	China 8	051	2025-04-05 13:00:00	3.79
6991	Q8	ЗУ	DIG	061	2025-04-05 13:00:00	46.39
6992	Q4	ЗУ	BG 1	062	2025-04-05 13:00:00	9.09
6993	Q9	ЗУ	BG 2	063	2025-04-05 13:00:00	9.22
6994	Q10	ЗУ	SM 2	064	2025-04-05 13:00:00	32.1
6995	Q11	ЗУ	SM 3	065	2025-04-05 13:00:00	7.77
6996	Q12	ЗУ	SM 4	066	2025-04-05 13:00:00	0.1131
6997	Q13	ЗУ	SM 5	067	2025-04-05 13:00:00	0
6998	Q14	ЗУ	SM 6	068	2025-04-05 13:00:00	0
6999	Q15	ЗУ	SM 7	069	2025-04-05 13:00:00	0
7000	Q16	ЗУ	SM 8	070	2025-04-05 13:00:00	0
7001	Q17	ЗУ	MO 9	071	2025-04-05 13:00:00	3.21
7002	Q20	ЗУ	MO 10	072	2025-04-05 13:00:00	0
7003	Q21	ЗУ	MO 11	073	2025-04-05 13:00:00	0
7004	Q22	ЗУ	MO 12	074	2025-04-05 13:00:00	30.17
7005	Q23	ЗУ	MO 13	075	2025-04-05 13:00:00	19.73
7006	Q24	ЗУ	MO 14	076	2025-04-05 13:00:00	19.24
7007	Q25	ЗУ	MO 15	077	2025-04-05 13:00:00	16.92
7008	TP3	ЗУ	CP-300 New	078	2025-04-05 13:00:00	31.66
7009	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 13:30:00	0
7010	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 13:30:00	0.0018
7011	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 13:30:00	0.0027
7012	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 13:30:00	0.0036
7013	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 13:30:00	0
7014	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 13:30:00	0
7015	QF 1,20	ЗУ	China 1	044	2025-04-05 13:30:00	1.2
7016	QF 1,21	ЗУ	China 2	045	2025-04-05 13:30:00	0.2504
7017	QF 1,22	ЗУ	China 3	046	2025-04-05 13:30:00	2.75
7018	QF 2,20	ЗУ	China 4	047	2025-04-05 13:30:00	4.95
7019	QF 2,21	ЗУ	China 5	048	2025-04-05 13:30:00	6.31
7020	QF 2,22	ЗУ	China 6	049	2025-04-05 13:30:00	4.42
7021	QF 2,23	ЗУ	China 7	050	2025-04-05 13:30:00	1.98
7022	QF 2,19	ЗУ	China 8	051	2025-04-05 13:30:00	3.76
7023	Q8	ЗУ	DIG	061	2025-04-05 13:30:00	61.06
7024	Q4	ЗУ	BG 1	062	2025-04-05 13:30:00	10.13
7025	Q9	ЗУ	BG 2	063	2025-04-05 13:30:00	9.18
7026	Q10	ЗУ	SM 2	064	2025-04-05 13:30:00	32.11
7027	Q11	ЗУ	SM 3	065	2025-04-05 13:30:00	11.11
7028	Q12	ЗУ	SM 4	066	2025-04-05 13:30:00	1.7
7029	Q13	ЗУ	SM 5	067	2025-04-05 13:30:00	0
7030	Q14	ЗУ	SM 6	068	2025-04-05 13:30:00	0
7031	Q15	ЗУ	SM 7	069	2025-04-05 13:30:00	0
7032	Q16	ЗУ	SM 8	070	2025-04-05 13:30:00	0
7033	Q17	ЗУ	MO 9	071	2025-04-05 13:30:00	3.25
7034	Q20	ЗУ	MO 10	072	2025-04-05 13:30:00	0
7035	Q21	ЗУ	MO 11	073	2025-04-05 13:30:00	0
7036	Q22	ЗУ	MO 12	074	2025-04-05 13:30:00	30.17
7037	Q23	ЗУ	MO 13	075	2025-04-05 13:30:00	19.67
7038	Q24	ЗУ	MO 14	076	2025-04-05 13:30:00	19.27
7039	Q25	ЗУ	MO 15	077	2025-04-05 13:30:00	17.02
7040	TP3	ЗУ	CP-300 New	078	2025-04-05 13:30:00	34.44
7041	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 14:00:00	0
7042	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 14:00:00	0.0025
7043	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 14:00:00	0.0028
7044	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 14:00:00	0.0034
7045	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 14:00:00	0
7046	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 14:00:00	0
7047	QF 1,20	ЗУ	China 1	044	2025-04-05 14:00:00	2.12
7048	QF 1,21	ЗУ	China 2	045	2025-04-05 14:00:00	0.4706
7049	QF 1,22	ЗУ	China 3	046	2025-04-05 14:00:00	3.22
7050	QF 2,20	ЗУ	China 4	047	2025-04-05 14:00:00	6.44
7051	QF 2,21	ЗУ	China 5	048	2025-04-05 14:00:00	8.46
7052	QF 2,22	ЗУ	China 6	049	2025-04-05 14:00:00	6.37
7053	QF 2,23	ЗУ	China 7	050	2025-04-05 14:00:00	2.87
7054	QF 2,19	ЗУ	China 8	051	2025-04-05 14:00:00	3.87
7055	Q8	ЗУ	DIG	061	2025-04-05 14:00:00	60.52
7056	Q4	ЗУ	BG 1	062	2025-04-05 14:00:00	10.42
7057	Q9	ЗУ	BG 2	063	2025-04-05 14:00:00	9.18
7058	Q10	ЗУ	SM 2	064	2025-04-05 14:00:00	32.15
7059	Q11	ЗУ	SM 3	065	2025-04-05 14:00:00	11
7060	Q12	ЗУ	SM 4	066	2025-04-05 14:00:00	4.6
7061	Q13	ЗУ	SM 5	067	2025-04-05 14:00:00	0
7062	Q14	ЗУ	SM 6	068	2025-04-05 14:00:00	0
7063	Q15	ЗУ	SM 7	069	2025-04-05 14:00:00	0
7064	Q16	ЗУ	SM 8	070	2025-04-05 14:00:00	0
7065	Q17	ЗУ	MO 9	071	2025-04-05 14:00:00	3.25
7066	Q20	ЗУ	MO 10	072	2025-04-05 14:00:00	0
7067	Q21	ЗУ	MO 11	073	2025-04-05 14:00:00	0
7068	Q22	ЗУ	MO 12	074	2025-04-05 14:00:00	30.2
7069	Q23	ЗУ	MO 13	075	2025-04-05 14:00:00	19.61
7070	Q24	ЗУ	MO 14	076	2025-04-05 14:00:00	19.28
7071	Q25	ЗУ	MO 15	077	2025-04-05 14:00:00	17.06
7072	TP3	ЗУ	CP-300 New	078	2025-04-05 14:00:00	36.09
7073	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 14:30:00	0
7074	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 14:30:00	0.0018
7075	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 14:30:00	0.0027
7076	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 14:30:00	0.0033
7077	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 14:30:00	0
7078	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 14:30:00	0
7079	QF 1,20	ЗУ	China 1	044	2025-04-05 14:30:00	3.77
7080	QF 1,21	ЗУ	China 2	045	2025-04-05 14:30:00	1.6
7081	QF 1,22	ЗУ	China 3	046	2025-04-05 14:30:00	4.24
7082	QF 2,20	ЗУ	China 4	047	2025-04-05 14:30:00	8.18
7083	QF 2,21	ЗУ	China 5	048	2025-04-05 14:30:00	12.06
7084	QF 2,22	ЗУ	China 6	049	2025-04-05 14:30:00	8.87
7085	QF 2,23	ЗУ	China 7	050	2025-04-05 14:30:00	3.92
7086	QF 2,19	ЗУ	China 8	051	2025-04-05 14:30:00	4.02
7087	Q8	ЗУ	DIG	061	2025-04-05 14:30:00	61.26
7088	Q4	ЗУ	BG 1	062	2025-04-05 14:30:00	11.86
7089	Q9	ЗУ	BG 2	063	2025-04-05 14:30:00	11.56
7090	Q10	ЗУ	SM 2	064	2025-04-05 14:30:00	32.24
7091	Q11	ЗУ	SM 3	065	2025-04-05 14:30:00	10.97
7092	Q12	ЗУ	SM 4	066	2025-04-05 14:30:00	5.46
7093	Q13	ЗУ	SM 5	067	2025-04-05 14:30:00	0
7094	Q14	ЗУ	SM 6	068	2025-04-05 14:30:00	0
7095	Q15	ЗУ	SM 7	069	2025-04-05 14:30:00	0
7096	Q16	ЗУ	SM 8	070	2025-04-05 14:30:00	0
7097	Q17	ЗУ	MO 9	071	2025-04-05 14:30:00	3.28
7098	Q20	ЗУ	MO 10	072	2025-04-05 14:30:00	0
7099	Q21	ЗУ	MO 11	073	2025-04-05 14:30:00	0
7100	Q22	ЗУ	MO 12	074	2025-04-05 14:30:00	30.19
7101	Q23	ЗУ	MO 13	075	2025-04-05 14:30:00	19.69
7102	Q24	ЗУ	MO 14	076	2025-04-05 14:30:00	19.31
7103	Q25	ЗУ	MO 15	077	2025-04-05 14:30:00	17.1
7104	TP3	ЗУ	CP-300 New	078	2025-04-05 14:30:00	36.13
7105	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 15:00:00	0
7106	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 15:00:00	0.0012
7107	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 15:00:00	0.0027
7108	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 15:00:00	0.0033
7109	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 15:00:00	0
7110	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 15:00:00	0
7111	QF 1,20	ЗУ	China 1	044	2025-04-05 15:00:00	4.31
7112	QF 1,21	ЗУ	China 2	045	2025-04-05 15:00:00	2.26
7113	QF 1,22	ЗУ	China 3	046	2025-04-05 15:00:00	4.82
7114	QF 2,20	ЗУ	China 4	047	2025-04-05 15:00:00	8.89
7115	QF 2,21	ЗУ	China 5	048	2025-04-05 15:00:00	13.16
7116	QF 2,22	ЗУ	China 6	049	2025-04-05 15:00:00	10.39
7117	QF 2,23	ЗУ	China 7	050	2025-04-05 15:00:00	4.41
7118	QF 2,19	ЗУ	China 8	051	2025-04-05 15:00:00	4.47
7119	Q8	ЗУ	DIG	061	2025-04-05 15:00:00	60.34
7120	Q4	ЗУ	BG 1	062	2025-04-05 15:00:00	13.82
7121	Q9	ЗУ	BG 2	063	2025-04-05 15:00:00	20.05
7122	Q10	ЗУ	SM 2	064	2025-04-05 15:00:00	32.22
7123	Q11	ЗУ	SM 3	065	2025-04-05 15:00:00	10.97
7124	Q12	ЗУ	SM 4	066	2025-04-05 15:00:00	9.63
7125	Q13	ЗУ	SM 5	067	2025-04-05 15:00:00	0
7126	Q14	ЗУ	SM 6	068	2025-04-05 15:00:00	0
7127	Q15	ЗУ	SM 7	069	2025-04-05 15:00:00	0
7128	Q16	ЗУ	SM 8	070	2025-04-05 15:00:00	0
7129	Q17	ЗУ	MO 9	071	2025-04-05 15:00:00	3.29
7130	Q20	ЗУ	MO 10	072	2025-04-05 15:00:00	0
7131	Q21	ЗУ	MO 11	073	2025-04-05 15:00:00	0
7132	Q22	ЗУ	MO 12	074	2025-04-05 15:00:00	30.15
7133	Q23	ЗУ	MO 13	075	2025-04-05 15:00:00	19.73
7134	Q24	ЗУ	MO 14	076	2025-04-05 15:00:00	19.26
7135	Q25	ЗУ	MO 15	077	2025-04-05 15:00:00	17.03
7136	TP3	ЗУ	CP-300 New	078	2025-04-05 15:00:00	33.22
7137	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 15:30:00	0
7138	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 15:30:00	0.0014
7139	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 15:30:00	0.0026
7140	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 15:30:00	0.0031
7141	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 15:30:00	0
7142	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 15:30:00	0
7143	QF 1,20	ЗУ	China 1	044	2025-04-05 15:30:00	5.5
7144	QF 1,21	ЗУ	China 2	045	2025-04-05 15:30:00	3.42
7145	QF 1,22	ЗУ	China 3	046	2025-04-05 15:30:00	6.61
7146	QF 2,20	ЗУ	China 4	047	2025-04-05 15:30:00	10.5
7147	QF 2,21	ЗУ	China 5	048	2025-04-05 15:30:00	14.99
7148	QF 2,22	ЗУ	China 6	049	2025-04-05 15:30:00	12.47
7149	QF 2,23	ЗУ	China 7	050	2025-04-05 15:30:00	5.12
7150	QF 2,19	ЗУ	China 8	051	2025-04-05 15:30:00	5.09
7151	Q8	ЗУ	DIG	061	2025-04-05 15:30:00	58.88
7152	Q4	ЗУ	BG 1	062	2025-04-05 15:30:00	15.28
7153	Q9	ЗУ	BG 2	063	2025-04-05 15:30:00	20.07
7154	Q10	ЗУ	SM 2	064	2025-04-05 15:30:00	32.22
7155	Q11	ЗУ	SM 3	065	2025-04-05 15:30:00	10.93
7156	Q12	ЗУ	SM 4	066	2025-04-05 15:30:00	9.63
7157	Q13	ЗУ	SM 5	067	2025-04-05 15:30:00	0
7158	Q14	ЗУ	SM 6	068	2025-04-05 15:30:00	0
7159	Q15	ЗУ	SM 7	069	2025-04-05 15:30:00	0
7160	Q16	ЗУ	SM 8	070	2025-04-05 15:30:00	0
7161	Q17	ЗУ	MO 9	071	2025-04-05 15:30:00	3.31
7162	Q20	ЗУ	MO 10	072	2025-04-05 15:30:00	0
7163	Q21	ЗУ	MO 11	073	2025-04-05 15:30:00	0
7164	Q22	ЗУ	MO 12	074	2025-04-05 15:30:00	30.16
7165	Q23	ЗУ	MO 13	075	2025-04-05 15:30:00	19.73
7166	Q24	ЗУ	MO 14	076	2025-04-05 15:30:00	19.27
7167	Q25	ЗУ	MO 15	077	2025-04-05 15:30:00	17.06
7168	TP3	ЗУ	CP-300 New	078	2025-04-05 15:30:00	34.08
7169	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 16:00:00	0
7170	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 16:00:00	0.0011
7171	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 16:00:00	0.0027
7172	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 16:00:00	0.0034
7173	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 16:00:00	0
7174	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 16:00:00	0
7175	QF 1,20	ЗУ	China 1	044	2025-04-05 16:00:00	7.63
7176	QF 1,21	ЗУ	China 2	045	2025-04-05 16:00:00	5.24
7177	QF 1,22	ЗУ	China 3	046	2025-04-05 16:00:00	9.11
7178	QF 2,20	ЗУ	China 4	047	2025-04-05 16:00:00	13.07
7179	QF 2,21	ЗУ	China 5	048	2025-04-05 16:00:00	17.06
7180	QF 2,22	ЗУ	China 6	049	2025-04-05 16:00:00	15.05
7181	QF 2,23	ЗУ	China 7	050	2025-04-05 16:00:00	6.24
7182	QF 2,19	ЗУ	China 8	051	2025-04-05 16:00:00	7.12
7183	Q8	ЗУ	DIG	061	2025-04-05 16:00:00	47.46
7184	Q4	ЗУ	BG 1	062	2025-04-05 16:00:00	17.04
7185	Q9	ЗУ	BG 2	063	2025-04-05 16:00:00	20.14
7186	Q10	ЗУ	SM 2	064	2025-04-05 16:00:00	32.21
7187	Q11	ЗУ	SM 3	065	2025-04-05 16:00:00	10.96
7188	Q12	ЗУ	SM 4	066	2025-04-05 16:00:00	9.62
7189	Q13	ЗУ	SM 5	067	2025-04-05 16:00:00	0
7190	Q14	ЗУ	SM 6	068	2025-04-05 16:00:00	0
7191	Q15	ЗУ	SM 7	069	2025-04-05 16:00:00	0
7192	Q16	ЗУ	SM 8	070	2025-04-05 16:00:00	0
7193	Q17	ЗУ	MO 9	071	2025-04-05 16:00:00	3.31
7194	Q20	ЗУ	MO 10	072	2025-04-05 16:00:00	0
7195	Q21	ЗУ	MO 11	073	2025-04-05 16:00:00	0
7196	Q22	ЗУ	MO 12	074	2025-04-05 16:00:00	30.14
7197	Q23	ЗУ	MO 13	075	2025-04-05 16:00:00	19.7
7198	Q24	ЗУ	MO 14	076	2025-04-05 16:00:00	19.3
7199	Q25	ЗУ	MO 15	077	2025-04-05 16:00:00	17.07
7200	TP3	ЗУ	CP-300 New	078	2025-04-05 16:00:00	29.16
7201	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 16:30:00	0
7202	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 16:30:00	0.0005
7203	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 16:30:00	0.0024
7204	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 16:30:00	0.0032
7205	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 16:30:00	0
7206	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 16:30:00	0
7207	QF 1,20	ЗУ	China 1	044	2025-04-05 16:30:00	9
7208	QF 1,21	ЗУ	China 2	045	2025-04-05 16:30:00	7.44
7209	QF 1,22	ЗУ	China 3	046	2025-04-05 16:30:00	10.47
7210	QF 2,20	ЗУ	China 4	047	2025-04-05 16:30:00	14.2
7211	QF 2,21	ЗУ	China 5	048	2025-04-05 16:30:00	18.59
7212	QF 2,22	ЗУ	China 6	049	2025-04-05 16:30:00	17.22
7213	QF 2,23	ЗУ	China 7	050	2025-04-05 16:30:00	7.02
7214	QF 2,19	ЗУ	China 8	051	2025-04-05 16:30:00	8.14
7215	Q8	ЗУ	DIG	061	2025-04-05 16:30:00	43.33
7216	Q4	ЗУ	BG 1	062	2025-04-05 16:30:00	17.12
7217	Q9	ЗУ	BG 2	063	2025-04-05 16:30:00	20.14
7218	Q10	ЗУ	SM 2	064	2025-04-05 16:30:00	32.23
7219	Q11	ЗУ	SM 3	065	2025-04-05 16:30:00	10.95
7220	Q12	ЗУ	SM 4	066	2025-04-05 16:30:00	9.64
7221	Q13	ЗУ	SM 5	067	2025-04-05 16:30:00	0
7222	Q14	ЗУ	SM 6	068	2025-04-05 16:30:00	0
7223	Q15	ЗУ	SM 7	069	2025-04-05 16:30:00	0
7224	Q16	ЗУ	SM 8	070	2025-04-05 16:30:00	0
7225	Q17	ЗУ	MO 9	071	2025-04-05 16:30:00	3.3
7226	Q20	ЗУ	MO 10	072	2025-04-05 16:30:00	0
7227	Q21	ЗУ	MO 11	073	2025-04-05 16:30:00	0
7228	Q22	ЗУ	MO 12	074	2025-04-05 16:30:00	30.16
7229	Q23	ЗУ	MO 13	075	2025-04-05 16:30:00	19.67
7230	Q24	ЗУ	MO 14	076	2025-04-05 16:30:00	19.31
7231	Q25	ЗУ	MO 15	077	2025-04-05 16:30:00	17.08
7232	TP3	ЗУ	CP-300 New	078	2025-04-05 16:30:00	28.2
7233	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 17:00:00	0
7234	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 17:00:00	0.0011
7235	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 17:00:00	0.0025
7236	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 17:00:00	0.0032
7237	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 17:00:00	0
7238	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 17:00:00	0
7239	QF 1,20	ЗУ	China 1	044	2025-04-05 17:00:00	10.12
7240	QF 1,21	ЗУ	China 2	045	2025-04-05 17:00:00	8.74
7241	QF 1,22	ЗУ	China 3	046	2025-04-05 17:00:00	11.9
7242	QF 2,20	ЗУ	China 4	047	2025-04-05 17:00:00	15.38
7243	QF 2,21	ЗУ	China 5	048	2025-04-05 17:00:00	20.4
7244	QF 2,22	ЗУ	China 6	049	2025-04-05 17:00:00	18.56
7245	QF 2,23	ЗУ	China 7	050	2025-04-05 17:00:00	7.73
7246	QF 2,19	ЗУ	China 8	051	2025-04-05 17:00:00	9.34
7247	Q8	ЗУ	DIG	061	2025-04-05 17:00:00	31.37
7248	Q4	ЗУ	BG 1	062	2025-04-05 17:00:00	17.33
7249	Q9	ЗУ	BG 2	063	2025-04-05 17:00:00	20.24
7250	Q10	ЗУ	SM 2	064	2025-04-05 17:00:00	32.15
7251	Q11	ЗУ	SM 3	065	2025-04-05 17:00:00	11.02
7252	Q12	ЗУ	SM 4	066	2025-04-05 17:00:00	9.58
7253	Q13	ЗУ	SM 5	067	2025-04-05 17:00:00	0
7254	Q14	ЗУ	SM 6	068	2025-04-05 17:00:00	0
7255	Q15	ЗУ	SM 7	069	2025-04-05 17:00:00	0
7256	Q16	ЗУ	SM 8	070	2025-04-05 17:00:00	0
7257	Q17	ЗУ	MO 9	071	2025-04-05 17:00:00	3.3
7258	Q20	ЗУ	MO 10	072	2025-04-05 17:00:00	1.4
7259	Q21	ЗУ	MO 11	073	2025-04-05 17:00:00	0
7260	Q22	ЗУ	MO 12	074	2025-04-05 17:00:00	30.14
7261	Q23	ЗУ	MO 13	075	2025-04-05 17:00:00	19.72
7262	Q24	ЗУ	MO 14	076	2025-04-05 17:00:00	19.3
7263	Q25	ЗУ	MO 15	077	2025-04-05 17:00:00	17.04
7264	TP3	ЗУ	CP-300 New	078	2025-04-05 17:00:00	26.94
7265	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 17:30:00	0
7266	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 17:30:00	0.0008
7267	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 17:30:00	0.0025
7268	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 17:30:00	0.0032
7269	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 17:30:00	0
7270	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 17:30:00	0
7271	QF 1,20	ЗУ	China 1	044	2025-04-05 17:30:00	12.53
7272	QF 1,21	ЗУ	China 2	045	2025-04-05 17:30:00	10.69
7273	QF 1,22	ЗУ	China 3	046	2025-04-05 17:30:00	14.38
7274	QF 2,20	ЗУ	China 4	047	2025-04-05 17:30:00	17.35
7275	QF 2,21	ЗУ	China 5	048	2025-04-05 17:30:00	22.11
7276	QF 2,22	ЗУ	China 6	049	2025-04-05 17:30:00	20
7277	QF 2,23	ЗУ	China 7	050	2025-04-05 17:30:00	8.68
7278	QF 2,19	ЗУ	China 8	051	2025-04-05 17:30:00	12.63
7279	Q8	ЗУ	DIG	061	2025-04-05 17:30:00	27.99
7280	Q4	ЗУ	BG 1	062	2025-04-05 17:30:00	17.89
7281	Q9	ЗУ	BG 2	063	2025-04-05 17:30:00	20.3
7282	Q10	ЗУ	SM 2	064	2025-04-05 17:30:00	32.15
7283	Q11	ЗУ	SM 3	065	2025-04-05 17:30:00	11.03
7284	Q12	ЗУ	SM 4	066	2025-04-05 17:30:00	9.57
7285	Q13	ЗУ	SM 5	067	2025-04-05 17:30:00	0
7286	Q14	ЗУ	SM 6	068	2025-04-05 17:30:00	0
7287	Q15	ЗУ	SM 7	069	2025-04-05 17:30:00	0
7288	Q16	ЗУ	SM 8	070	2025-04-05 17:30:00	0
7289	Q17	ЗУ	MO 9	071	2025-04-05 17:30:00	3.31
7290	Q20	ЗУ	MO 10	072	2025-04-05 17:30:00	1.46
7291	Q21	ЗУ	MO 11	073	2025-04-05 17:30:00	0
7292	Q22	ЗУ	MO 12	074	2025-04-05 17:30:00	30.16
7293	Q23	ЗУ	MO 13	075	2025-04-05 17:30:00	19.68
7294	Q24	ЗУ	MO 14	076	2025-04-05 17:30:00	19.3
7295	Q25	ЗУ	MO 15	077	2025-04-05 17:30:00	17.06
7296	TP3	ЗУ	CP-300 New	078	2025-04-05 17:30:00	23.02
7297	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 18:00:00	0
7298	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 18:00:00	0.0014
7299	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 18:00:00	0.0026
7300	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 18:00:00	0.0035
7301	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 18:00:00	0
7302	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 18:00:00	0
7303	QF 1,20	ЗУ	China 1	044	2025-04-05 18:00:00	10.71
7304	QF 1,21	ЗУ	China 2	045	2025-04-05 18:00:00	8.56
7305	QF 1,22	ЗУ	China 3	046	2025-04-05 18:00:00	12.04
7306	QF 2,20	ЗУ	China 4	047	2025-04-05 18:00:00	14.37
7307	QF 2,21	ЗУ	China 5	048	2025-04-05 18:00:00	17.8
7308	QF 2,22	ЗУ	China 6	049	2025-04-05 18:00:00	17.32
7309	QF 2,23	ЗУ	China 7	050	2025-04-05 18:00:00	7.04
7310	QF 2,19	ЗУ	China 8	051	2025-04-05 18:00:00	10
7311	Q8	ЗУ	DIG	061	2025-04-05 18:00:00	28.13
7312	Q4	ЗУ	BG 1	062	2025-04-05 18:00:00	17.92
7313	Q9	ЗУ	BG 2	063	2025-04-05 18:00:00	20.31
7314	Q10	ЗУ	SM 2	064	2025-04-05 18:00:00	32.15
7315	Q11	ЗУ	SM 3	065	2025-04-05 18:00:00	11.88
7316	Q12	ЗУ	SM 4	066	2025-04-05 18:00:00	9.59
7317	Q13	ЗУ	SM 5	067	2025-04-05 18:00:00	0
7318	Q14	ЗУ	SM 6	068	2025-04-05 18:00:00	0
7319	Q15	ЗУ	SM 7	069	2025-04-05 18:00:00	0
7320	Q16	ЗУ	SM 8	070	2025-04-05 18:00:00	0
7321	Q17	ЗУ	MO 9	071	2025-04-05 18:00:00	3.34
7322	Q20	ЗУ	MO 10	072	2025-04-05 18:00:00	1.46
7323	Q21	ЗУ	MO 11	073	2025-04-05 18:00:00	0
7324	Q22	ЗУ	MO 12	074	2025-04-05 18:00:00	30.17
7325	Q23	ЗУ	MO 13	075	2025-04-05 18:00:00	19.7
7326	Q24	ЗУ	MO 14	076	2025-04-05 18:00:00	19.29
7327	Q25	ЗУ	MO 15	077	2025-04-05 18:00:00	17.07
7328	TP3	ЗУ	CP-300 New	078	2025-04-05 18:00:00	24.42
7329	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 18:30:00	0
7330	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 18:30:00	0.0007
7331	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 18:30:00	0.0024
7332	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 18:30:00	0.0032
7333	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 18:30:00	0
7334	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 18:30:00	0
7335	QF 1,20	ЗУ	China 1	044	2025-04-05 18:30:00	13.11
7336	QF 1,21	ЗУ	China 2	045	2025-04-05 18:30:00	10.69
7337	QF 1,22	ЗУ	China 3	046	2025-04-05 18:30:00	14.11
7338	QF 2,20	ЗУ	China 4	047	2025-04-05 18:30:00	16.61
7339	QF 2,21	ЗУ	China 5	048	2025-04-05 18:30:00	20.46
7340	QF 2,22	ЗУ	China 6	049	2025-04-05 18:30:00	19.31
7341	QF 2,23	ЗУ	China 7	050	2025-04-05 18:30:00	8.26
7342	QF 2,19	ЗУ	China 8	051	2025-04-05 18:30:00	12.48
7343	Q8	ЗУ	DIG	061	2025-04-05 18:30:00	28.07
7344	Q4	ЗУ	BG 1	062	2025-04-05 18:30:00	17.9
7345	Q9	ЗУ	BG 2	063	2025-04-05 18:30:00	20.34
7346	Q10	ЗУ	SM 2	064	2025-04-05 18:30:00	32.13
7347	Q11	ЗУ	SM 3	065	2025-04-05 18:30:00	20.67
7348	Q12	ЗУ	SM 4	066	2025-04-05 18:30:00	9.61
7349	Q13	ЗУ	SM 5	067	2025-04-05 18:30:00	0
7350	Q14	ЗУ	SM 6	068	2025-04-05 18:30:00	0
7351	Q15	ЗУ	SM 7	069	2025-04-05 18:30:00	0
7352	Q16	ЗУ	SM 8	070	2025-04-05 18:30:00	0
7353	Q17	ЗУ	MO 9	071	2025-04-05 18:30:00	3.32
7354	Q20	ЗУ	MO 10	072	2025-04-05 18:30:00	1.47
7355	Q21	ЗУ	MO 11	073	2025-04-05 18:30:00	0
7356	Q22	ЗУ	MO 12	074	2025-04-05 18:30:00	30.13
7357	Q23	ЗУ	MO 13	075	2025-04-05 18:30:00	19.68
7358	Q24	ЗУ	MO 14	076	2025-04-05 18:30:00	19.29
7359	Q25	ЗУ	MO 15	077	2025-04-05 18:30:00	17.06
7360	TP3	ЗУ	CP-300 New	078	2025-04-05 18:30:00	23.16
7361	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 19:00:00	0
7362	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 19:00:00	0.0012
7363	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 19:00:00	0.0028
7364	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 19:00:00	0.0033
7365	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 19:00:00	0
7366	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 19:00:00	0
7367	QF 1,20	ЗУ	China 1	044	2025-04-05 19:00:00	14.08
7368	QF 1,21	ЗУ	China 2	045	2025-04-05 19:00:00	11.9
7369	QF 1,22	ЗУ	China 3	046	2025-04-05 19:00:00	15.34
7370	QF 2,20	ЗУ	China 4	047	2025-04-05 19:00:00	17.32
7371	QF 2,21	ЗУ	China 5	048	2025-04-05 19:00:00	21.58
7372	QF 2,22	ЗУ	China 6	049	2025-04-05 19:00:00	20.32
7373	QF 2,23	ЗУ	China 7	050	2025-04-05 19:00:00	8.79
7374	QF 2,19	ЗУ	China 8	051	2025-04-05 19:00:00	13.91
7375	Q8	ЗУ	DIG	061	2025-04-05 19:00:00	27.44
7376	Q4	ЗУ	BG 1	062	2025-04-05 19:00:00	17.87
7377	Q9	ЗУ	BG 2	063	2025-04-05 19:00:00	20.32
7378	Q10	ЗУ	SM 2	064	2025-04-05 19:00:00	32.23
7379	Q11	ЗУ	SM 3	065	2025-04-05 19:00:00	20.67
7380	Q12	ЗУ	SM 4	066	2025-04-05 19:00:00	9.61
7381	Q13	ЗУ	SM 5	067	2025-04-05 19:00:00	0
7382	Q14	ЗУ	SM 6	068	2025-04-05 19:00:00	0
7383	Q15	ЗУ	SM 7	069	2025-04-05 19:00:00	0
7384	Q16	ЗУ	SM 8	070	2025-04-05 19:00:00	0
7385	Q17	ЗУ	MO 9	071	2025-04-05 19:00:00	3.33
7386	Q20	ЗУ	MO 10	072	2025-04-05 19:00:00	1.47
7387	Q21	ЗУ	MO 11	073	2025-04-05 19:00:00	0
7388	Q22	ЗУ	MO 12	074	2025-04-05 19:00:00	30.17
7389	Q23	ЗУ	MO 13	075	2025-04-05 19:00:00	19.64
7390	Q24	ЗУ	MO 14	076	2025-04-05 19:00:00	19.33
7391	Q25	ЗУ	MO 15	077	2025-04-05 19:00:00	17.12
7392	TP3	ЗУ	CP-300 New	078	2025-04-05 19:00:00	24.5
7393	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 19:30:00	0
7394	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 19:30:00	0.0002
7395	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 19:30:00	0.0024
7396	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 19:30:00	0.0033
7397	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 19:30:00	0
7398	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 19:30:00	0
7399	QF 1,20	ЗУ	China 1	044	2025-04-05 19:30:00	12.87
7400	QF 1,21	ЗУ	China 2	045	2025-04-05 19:30:00	11.13
7401	QF 1,22	ЗУ	China 3	046	2025-04-05 19:30:00	14.18
7402	QF 2,20	ЗУ	China 4	047	2025-04-05 19:30:00	16.02
7403	QF 2,21	ЗУ	China 5	048	2025-04-05 19:30:00	19.42
7404	QF 2,22	ЗУ	China 6	049	2025-04-05 19:30:00	18.3
7405	QF 2,23	ЗУ	China 7	050	2025-04-05 19:30:00	7.89
7406	QF 2,19	ЗУ	China 8	051	2025-04-05 19:30:00	12.4
7407	Q8	ЗУ	DIG	061	2025-04-05 19:30:00	27.44
7408	Q4	ЗУ	BG 1	062	2025-04-05 19:30:00	17.89
7409	Q9	ЗУ	BG 2	063	2025-04-05 19:30:00	20.32
7410	Q10	ЗУ	SM 2	064	2025-04-05 19:30:00	32.2
7411	Q11	ЗУ	SM 3	065	2025-04-05 19:30:00	20.63
7412	Q12	ЗУ	SM 4	066	2025-04-05 19:30:00	10
7413	Q13	ЗУ	SM 5	067	2025-04-05 19:30:00	0
7414	Q14	ЗУ	SM 6	068	2025-04-05 19:30:00	0
7415	Q15	ЗУ	SM 7	069	2025-04-05 19:30:00	0
7416	Q16	ЗУ	SM 8	070	2025-04-05 19:30:00	0
7417	Q17	ЗУ	MO 9	071	2025-04-05 19:30:00	3.33
7418	Q20	ЗУ	MO 10	072	2025-04-05 19:30:00	1.46
7419	Q21	ЗУ	MO 11	073	2025-04-05 19:30:00	0
7420	Q22	ЗУ	MO 12	074	2025-04-05 19:30:00	30.19
7421	Q23	ЗУ	MO 13	075	2025-04-05 19:30:00	19.68
7422	Q24	ЗУ	MO 14	076	2025-04-05 19:30:00	19.31
7423	Q25	ЗУ	MO 15	077	2025-04-05 19:30:00	17.08
7424	TP3	ЗУ	CP-300 New	078	2025-04-05 19:30:00	23.46
7425	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 20:00:00	0
7426	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 20:00:00	0.0013
7427	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 20:00:00	0.0031
7428	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 20:00:00	0.0029
7429	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 20:00:00	0
7430	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 20:00:00	0
7431	QF 1,20	ЗУ	China 1	044	2025-04-05 20:00:00	13.68
7432	QF 1,21	ЗУ	China 2	045	2025-04-05 20:00:00	11.66
7433	QF 1,22	ЗУ	China 3	046	2025-04-05 20:00:00	14.87
7434	QF 2,20	ЗУ	China 4	047	2025-04-05 20:00:00	17.46
7435	QF 2,21	ЗУ	China 5	048	2025-04-05 20:00:00	21.06
7436	QF 2,22	ЗУ	China 6	049	2025-04-05 20:00:00	19.27
7437	QF 2,23	ЗУ	China 7	050	2025-04-05 20:00:00	8.36
7438	QF 2,19	ЗУ	China 8	051	2025-04-05 20:00:00	12.23
7439	Q8	ЗУ	DIG	061	2025-04-05 20:00:00	27.69
7440	Q4	ЗУ	BG 1	062	2025-04-05 20:00:00	17.91
7441	Q9	ЗУ	BG 2	063	2025-04-05 20:00:00	20.38
7442	Q10	ЗУ	SM 2	064	2025-04-05 20:00:00	32.19
7443	Q11	ЗУ	SM 3	065	2025-04-05 20:00:00	20.58
7444	Q12	ЗУ	SM 4	066	2025-04-05 20:00:00	20.9
7445	Q13	ЗУ	SM 5	067	2025-04-05 20:00:00	0
7446	Q14	ЗУ	SM 6	068	2025-04-05 20:00:00	0
7447	Q15	ЗУ	SM 7	069	2025-04-05 20:00:00	0
7448	Q16	ЗУ	SM 8	070	2025-04-05 20:00:00	0
7449	Q17	ЗУ	MO 9	071	2025-04-05 20:00:00	3.32
7450	Q20	ЗУ	MO 10	072	2025-04-05 20:00:00	1.47
7451	Q21	ЗУ	MO 11	073	2025-04-05 20:00:00	0
7452	Q22	ЗУ	MO 12	074	2025-04-05 20:00:00	30.22
7453	Q23	ЗУ	MO 13	075	2025-04-05 20:00:00	19.75
7454	Q24	ЗУ	MO 14	076	2025-04-05 20:00:00	19.3
7455	Q25	ЗУ	MO 15	077	2025-04-05 20:00:00	17.07
7456	TP3	ЗУ	CP-300 New	078	2025-04-05 20:00:00	25.04
7457	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 20:30:00	0
7458	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 20:30:00	0.0009
7459	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 20:30:00	0.0029
7460	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 20:30:00	0.0028
7461	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 20:30:00	0
7462	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 20:30:00	0
7463	QF 1,20	ЗУ	China 1	044	2025-04-05 20:30:00	13.54
7464	QF 1,21	ЗУ	China 2	045	2025-04-05 20:30:00	11.81
7465	QF 1,22	ЗУ	China 3	046	2025-04-05 20:30:00	14.46
7466	QF 2,20	ЗУ	China 4	047	2025-04-05 20:30:00	17.23
7467	QF 2,21	ЗУ	China 5	048	2025-04-05 20:30:00	21.23
7468	QF 2,22	ЗУ	China 6	049	2025-04-05 20:30:00	19.22
7469	QF 2,23	ЗУ	China 7	050	2025-04-05 20:30:00	8.25
7470	QF 2,19	ЗУ	China 8	051	2025-04-05 20:30:00	12.1
7471	Q8	ЗУ	DIG	061	2025-04-05 20:30:00	24.29
7472	Q4	ЗУ	BG 1	062	2025-04-05 20:30:00	17.85
7473	Q9	ЗУ	BG 2	063	2025-04-05 20:30:00	19.76
7474	Q10	ЗУ	SM 2	064	2025-04-05 20:30:00	32.32
7475	Q11	ЗУ	SM 3	065	2025-04-05 20:30:00	17.56
7476	Q12	ЗУ	SM 4	066	2025-04-05 20:30:00	19.03
7477	Q13	ЗУ	SM 5	067	2025-04-05 20:30:00	0
7478	Q14	ЗУ	SM 6	068	2025-04-05 20:30:00	0
7479	Q15	ЗУ	SM 7	069	2025-04-05 20:30:00	0
7480	Q16	ЗУ	SM 8	070	2025-04-05 20:30:00	0
7481	Q17	ЗУ	MO 9	071	2025-04-05 20:30:00	3.32
7482	Q20	ЗУ	MO 10	072	2025-04-05 20:30:00	1.47
7483	Q21	ЗУ	MO 11	073	2025-04-05 20:30:00	0
7484	Q22	ЗУ	MO 12	074	2025-04-05 20:30:00	29.76
7485	Q23	ЗУ	MO 13	075	2025-04-05 20:30:00	19.7
7486	Q24	ЗУ	MO 14	076	2025-04-05 20:30:00	18.71
7487	Q25	ЗУ	MO 15	077	2025-04-05 20:30:00	17.11
7488	TP3	ЗУ	CP-300 New	078	2025-04-05 20:30:00	25.46
7489	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 21:00:00	0
7490	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 21:00:00	0.0005
7491	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 21:00:00	0.0027
7492	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 21:00:00	0.0024
7493	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 21:00:00	0
7494	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 21:00:00	0
7495	QF 1,20	ЗУ	China 1	044	2025-04-05 21:00:00	12.58
7496	QF 1,21	ЗУ	China 2	045	2025-04-05 21:00:00	10.8
7497	QF 1,22	ЗУ	China 3	046	2025-04-05 21:00:00	13.06
7498	QF 2,20	ЗУ	China 4	047	2025-04-05 21:00:00	16.46
7499	QF 2,21	ЗУ	China 5	048	2025-04-05 21:00:00	20.35
7500	QF 2,22	ЗУ	China 6	049	2025-04-05 21:00:00	18.19
7501	QF 2,23	ЗУ	China 7	050	2025-04-05 21:00:00	7.78
7502	QF 2,19	ЗУ	China 8	051	2025-04-05 21:00:00	10.91
7503	Q8	ЗУ	DIG	061	2025-04-05 21:00:00	15.97
7504	Q4	ЗУ	BG 1	062	2025-04-05 21:00:00	17.93
7505	Q9	ЗУ	BG 2	063	2025-04-05 21:00:00	18.09
7506	Q10	ЗУ	SM 2	064	2025-04-05 21:00:00	32.35
7507	Q11	ЗУ	SM 3	065	2025-04-05 21:00:00	9.83
7508	Q12	ЗУ	SM 4	066	2025-04-05 21:00:00	10.06
7509	Q13	ЗУ	SM 5	067	2025-04-05 21:00:00	0
7510	Q14	ЗУ	SM 6	068	2025-04-05 21:00:00	0
7511	Q15	ЗУ	SM 7	069	2025-04-05 21:00:00	0
7512	Q16	ЗУ	SM 8	070	2025-04-05 21:00:00	0
7513	Q17	ЗУ	MO 9	071	2025-04-05 21:00:00	2.77
7514	Q20	ЗУ	MO 10	072	2025-04-05 21:00:00	1.47
7515	Q21	ЗУ	MO 11	073	2025-04-05 21:00:00	0
7516	Q22	ЗУ	MO 12	074	2025-04-05 21:00:00	25.82
7517	Q23	ЗУ	MO 13	075	2025-04-05 21:00:00	19.77
7518	Q24	ЗУ	MO 14	076	2025-04-05 21:00:00	17.99
7519	Q25	ЗУ	MO 15	077	2025-04-05 21:00:00	17.17
7520	TP3	ЗУ	CP-300 New	078	2025-04-05 21:00:00	25.7
7521	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 21:30:00	0
7522	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 21:30:00	0.0002
7523	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 21:30:00	0.0025
7524	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 21:30:00	0.0021
7525	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 21:30:00	0
7526	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 21:30:00	0
7527	QF 1,20	ЗУ	China 1	044	2025-04-05 21:30:00	14.74
7528	QF 1,21	ЗУ	China 2	045	2025-04-05 21:30:00	12.33
7529	QF 1,22	ЗУ	China 3	046	2025-04-05 21:30:00	14.81
7530	QF 2,20	ЗУ	China 4	047	2025-04-05 21:30:00	17.67
7531	QF 2,21	ЗУ	China 5	048	2025-04-05 21:30:00	21.24
7532	QF 2,22	ЗУ	China 6	049	2025-04-05 21:30:00	19.38
7533	QF 2,23	ЗУ	China 7	050	2025-04-05 21:30:00	8.53
7534	QF 2,19	ЗУ	China 8	051	2025-04-05 21:30:00	12.68
7535	Q8	ЗУ	DIG	061	2025-04-05 21:30:00	9.44
7536	Q4	ЗУ	BG 1	062	2025-04-05 21:30:00	17.92
7537	Q9	ЗУ	BG 2	063	2025-04-05 21:30:00	16.67
7538	Q10	ЗУ	SM 2	064	2025-04-05 21:30:00	32.23
7539	Q11	ЗУ	SM 3	065	2025-04-05 21:30:00	15.94
7540	Q12	ЗУ	SM 4	066	2025-04-05 21:30:00	16.85
7541	Q13	ЗУ	SM 5	067	2025-04-05 21:30:00	0
7542	Q14	ЗУ	SM 6	068	2025-04-05 21:30:00	0
7543	Q15	ЗУ	SM 7	069	2025-04-05 21:30:00	0
7544	Q16	ЗУ	SM 8	070	2025-04-05 21:30:00	0
7545	Q17	ЗУ	MO 9	071	2025-04-05 21:30:00	1.17
7546	Q20	ЗУ	MO 10	072	2025-04-05 21:30:00	1.48
7547	Q21	ЗУ	MO 11	073	2025-04-05 21:30:00	0
7548	Q22	ЗУ	MO 12	074	2025-04-05 21:30:00	24.59
7549	Q23	ЗУ	MO 13	075	2025-04-05 21:30:00	19.79
7550	Q24	ЗУ	MO 14	076	2025-04-05 21:30:00	18.18
7551	Q25	ЗУ	MO 15	077	2025-04-05 21:30:00	17.16
7552	TP3	ЗУ	CP-300 New	078	2025-04-05 21:30:00	24.42
7553	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 22:00:00	0
7554	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 22:00:00	0.0013
7555	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 22:00:00	0.0026
7556	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 22:00:00	0.002
7557	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 22:00:00	0
7558	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 22:00:00	0
7559	QF 1,20	ЗУ	China 1	044	2025-04-05 22:00:00	17.53
7560	QF 1,21	ЗУ	China 2	045	2025-04-05 22:00:00	14.58
7561	QF 1,22	ЗУ	China 3	046	2025-04-05 22:00:00	16.95
7562	QF 2,20	ЗУ	China 4	047	2025-04-05 22:00:00	19.64
7563	QF 2,21	ЗУ	China 5	048	2025-04-05 22:00:00	23.41
7564	QF 2,22	ЗУ	China 6	049	2025-04-05 22:00:00	21.71
7565	QF 2,23	ЗУ	China 7	050	2025-04-05 22:00:00	9.41
7566	QF 2,19	ЗУ	China 8	051	2025-04-05 22:00:00	15.19
7567	Q8	ЗУ	DIG	061	2025-04-05 22:00:00	9.76
7568	Q4	ЗУ	BG 1	062	2025-04-05 22:00:00	17.93
7569	Q9	ЗУ	BG 2	063	2025-04-05 22:00:00	16.66
7570	Q10	ЗУ	SM 2	064	2025-04-05 22:00:00	32.23
7571	Q11	ЗУ	SM 3	065	2025-04-05 22:00:00	20.63
7572	Q12	ЗУ	SM 4	066	2025-04-05 22:00:00	20.87
7573	Q13	ЗУ	SM 5	067	2025-04-05 22:00:00	0
7574	Q14	ЗУ	SM 6	068	2025-04-05 22:00:00	0
7575	Q15	ЗУ	SM 7	069	2025-04-05 22:00:00	0
7576	Q16	ЗУ	SM 8	070	2025-04-05 22:00:00	0
7577	Q17	ЗУ	MO 9	071	2025-04-05 22:00:00	1.18
7578	Q20	ЗУ	MO 10	072	2025-04-05 22:00:00	2.64
7579	Q21	ЗУ	MO 11	073	2025-04-05 22:00:00	8.8
7580	Q22	ЗУ	MO 12	074	2025-04-05 22:00:00	24.62
7581	Q23	ЗУ	MO 13	075	2025-04-05 22:00:00	19.76
7582	Q24	ЗУ	MO 14	076	2025-04-05 22:00:00	19.41
7583	Q25	ЗУ	MO 15	077	2025-04-05 22:00:00	17.17
7584	TP3	ЗУ	CP-300 New	078	2025-04-05 22:00:00	24.34
7585	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 22:30:00	0
7586	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 22:30:00	0.0012
7587	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 22:30:00	0.0029
7588	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 22:30:00	0.0026
7589	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 22:30:00	0
7590	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 22:30:00	0
7591	QF 1,20	ЗУ	China 1	044	2025-04-05 22:30:00	18.55
7592	QF 1,21	ЗУ	China 2	045	2025-04-05 22:30:00	16.21
7593	QF 1,22	ЗУ	China 3	046	2025-04-05 22:30:00	18.09
7594	QF 2,20	ЗУ	China 4	047	2025-04-05 22:30:00	20.64
7595	QF 2,21	ЗУ	China 5	048	2025-04-05 22:30:00	24.49
7596	QF 2,22	ЗУ	China 6	049	2025-04-05 22:30:00	22.47
7597	QF 2,23	ЗУ	China 7	050	2025-04-05 22:30:00	9.94
7598	QF 2,19	ЗУ	China 8	051	2025-04-05 22:30:00	16.59
7599	Q8	ЗУ	DIG	061	2025-04-05 22:30:00	9.73
7600	Q4	ЗУ	BG 1	062	2025-04-05 22:30:00	17.88
7601	Q9	ЗУ	BG 2	063	2025-04-05 22:30:00	16.68
7602	Q10	ЗУ	SM 2	064	2025-04-05 22:30:00	32.25
7603	Q11	ЗУ	SM 3	065	2025-04-05 22:30:00	20.61
7604	Q12	ЗУ	SM 4	066	2025-04-05 22:30:00	20.84
7605	Q13	ЗУ	SM 5	067	2025-04-05 22:30:00	0
7606	Q14	ЗУ	SM 6	068	2025-04-05 22:30:00	0
7607	Q15	ЗУ	SM 7	069	2025-04-05 22:30:00	0
7608	Q16	ЗУ	SM 8	070	2025-04-05 22:30:00	0
7609	Q17	ЗУ	MO 9	071	2025-04-05 22:30:00	1.18
7610	Q20	ЗУ	MO 10	072	2025-04-05 22:30:00	2.8
7611	Q21	ЗУ	MO 11	073	2025-04-05 22:30:00	8.99
7612	Q22	ЗУ	MO 12	074	2025-04-05 22:30:00	24.63
7613	Q23	ЗУ	MO 13	075	2025-04-05 22:30:00	19.8
7614	Q24	ЗУ	MO 14	076	2025-04-05 22:30:00	19.44
7615	Q25	ЗУ	MO 15	077	2025-04-05 22:30:00	17.16
7616	TP3	ЗУ	CP-300 New	078	2025-04-05 22:30:00	24.7
7617	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 23:00:00	0
7618	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 23:00:00	0.0017
7619	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 23:00:00	0.0028
7620	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 23:00:00	0.0027
7621	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 23:00:00	0
7622	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 23:00:00	0
7623	QF 1,20	ЗУ	China 1	044	2025-04-05 23:00:00	22.09
7624	QF 1,21	ЗУ	China 2	045	2025-04-05 23:00:00	19.62
7625	QF 1,22	ЗУ	China 3	046	2025-04-05 23:00:00	21.28
7626	QF 2,20	ЗУ	China 4	047	2025-04-05 23:00:00	22.5
7627	QF 2,21	ЗУ	China 5	048	2025-04-05 23:00:00	26.92
7628	QF 2,22	ЗУ	China 6	049	2025-04-05 23:00:00	25.62
7629	QF 2,23	ЗУ	China 7	050	2025-04-05 23:00:00	11.39
7630	QF 2,19	ЗУ	China 8	051	2025-04-05 23:00:00	19.68
7631	Q8	ЗУ	DIG	061	2025-04-05 23:00:00	9.82
7632	Q4	ЗУ	BG 1	062	2025-04-05 23:00:00	17.87
7633	Q9	ЗУ	BG 2	063	2025-04-05 23:00:00	16.69
7634	Q10	ЗУ	SM 2	064	2025-04-05 23:00:00	32.27
7635	Q11	ЗУ	SM 3	065	2025-04-05 23:00:00	20.56
7636	Q12	ЗУ	SM 4	066	2025-04-05 23:00:00	20.88
7637	Q13	ЗУ	SM 5	067	2025-04-05 23:00:00	0
7638	Q14	ЗУ	SM 6	068	2025-04-05 23:00:00	0
7639	Q15	ЗУ	SM 7	069	2025-04-05 23:00:00	0
7640	Q16	ЗУ	SM 8	070	2025-04-05 23:00:00	0
7641	Q17	ЗУ	MO 9	071	2025-04-05 23:00:00	1.19
7642	Q20	ЗУ	MO 10	072	2025-04-05 23:00:00	2.8
7643	Q21	ЗУ	MO 11	073	2025-04-05 23:00:00	8.99
7644	Q22	ЗУ	MO 12	074	2025-04-05 23:00:00	24.63
7645	Q23	ЗУ	MO 13	075	2025-04-05 23:00:00	19.83
7646	Q24	ЗУ	MO 14	076	2025-04-05 23:00:00	19.39
7647	Q25	ЗУ	MO 15	077	2025-04-05 23:00:00	17.2
7648	TP3	ЗУ	CP-300 New	078	2025-04-05 23:00:00	25.32
7649	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-05 23:30:00	0
7650	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-05 23:30:00	0.001
7651	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-05 23:30:00	0.0028
7652	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-05 23:30:00	0.0025
7653	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-05 23:30:00	0
7654	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-05 23:30:00	0
7655	QF 1,20	ЗУ	China 1	044	2025-04-05 23:30:00	22.91
7656	QF 1,21	ЗУ	China 2	045	2025-04-05 23:30:00	19.83
7657	QF 1,22	ЗУ	China 3	046	2025-04-05 23:30:00	21.76
7658	QF 2,20	ЗУ	China 4	047	2025-04-05 23:30:00	23.71
7659	QF 2,21	ЗУ	China 5	048	2025-04-05 23:30:00	28.15
7660	QF 2,22	ЗУ	China 6	049	2025-04-05 23:30:00	25.61
7661	QF 2,23	ЗУ	China 7	050	2025-04-05 23:30:00	11.59
7662	QF 2,19	ЗУ	China 8	051	2025-04-05 23:30:00	20.39
7663	Q8	ЗУ	DIG	061	2025-04-05 23:30:00	10.44
7664	Q4	ЗУ	BG 1	062	2025-04-05 23:30:00	17.89
7665	Q9	ЗУ	BG 2	063	2025-04-05 23:30:00	16.68
7666	Q10	ЗУ	SM 2	064	2025-04-05 23:30:00	32.28
7667	Q11	ЗУ	SM 3	065	2025-04-05 23:30:00	20.55
7668	Q12	ЗУ	SM 4	066	2025-04-05 23:30:00	20.97
7669	Q13	ЗУ	SM 5	067	2025-04-05 23:30:00	0
7670	Q14	ЗУ	SM 6	068	2025-04-05 23:30:00	0
7671	Q15	ЗУ	SM 7	069	2025-04-05 23:30:00	0
7672	Q16	ЗУ	SM 8	070	2025-04-05 23:30:00	0
7673	Q17	ЗУ	MO 9	071	2025-04-05 23:30:00	1.2
7674	Q20	ЗУ	MO 10	072	2025-04-05 23:30:00	2.8
7675	Q21	ЗУ	MO 11	073	2025-04-05 23:30:00	8.98
7676	Q22	ЗУ	MO 12	074	2025-04-05 23:30:00	24.67
7677	Q23	ЗУ	MO 13	075	2025-04-05 23:30:00	19.9
7678	Q24	ЗУ	MO 14	076	2025-04-05 23:30:00	19.4
7679	Q25	ЗУ	MO 15	077	2025-04-05 23:30:00	17.19
7680	TP3	ЗУ	CP-300 New	078	2025-04-05 23:30:00	23.57
7681	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 00:00:00	0
7682	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 00:00:00	0.0013
7683	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 00:00:00	0.0029
7684	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 00:00:00	0.0025
7685	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 00:00:00	0
7686	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 00:00:00	0
7687	QF 1,20	ЗУ	China 1	044	2025-04-06 00:00:00	18.8
7688	QF 1,21	ЗУ	China 2	045	2025-04-06 00:00:00	17.49
7689	QF 1,22	ЗУ	China 3	046	2025-04-06 00:00:00	19.11
7690	QF 2,20	ЗУ	China 4	047	2025-04-06 00:00:00	22.15
7691	QF 2,21	ЗУ	China 5	048	2025-04-06 00:00:00	25.92
7692	QF 2,22	ЗУ	China 6	049	2025-04-06 00:00:00	23.95
7693	QF 2,23	ЗУ	China 7	050	2025-04-06 00:00:00	10.51
7694	QF 2,19	ЗУ	China 8	051	2025-04-06 00:00:00	17.98
7695	Q8	ЗУ	DIG	061	2025-04-06 00:00:00	11.98
7696	Q4	ЗУ	BG 1	062	2025-04-06 00:00:00	17.92
7697	Q9	ЗУ	BG 2	063	2025-04-06 00:00:00	16.7
7698	Q10	ЗУ	SM 2	064	2025-04-06 00:00:00	32.37
7699	Q11	ЗУ	SM 3	065	2025-04-06 00:00:00	20.62
7700	Q12	ЗУ	SM 4	066	2025-04-06 00:00:00	21
7701	Q13	ЗУ	SM 5	067	2025-04-06 00:00:00	0
7702	Q14	ЗУ	SM 6	068	2025-04-06 00:00:00	0
7703	Q15	ЗУ	SM 7	069	2025-04-06 00:00:00	0
7704	Q16	ЗУ	SM 8	070	2025-04-06 00:00:00	0
7705	Q17	ЗУ	MO 9	071	2025-04-06 00:00:00	1.21
7706	Q20	ЗУ	MO 10	072	2025-04-06 00:00:00	2.81
7707	Q21	ЗУ	MO 11	073	2025-04-06 00:00:00	9.04
7708	Q22	ЗУ	MO 12	074	2025-04-06 00:00:00	24.69
7709	Q23	ЗУ	MO 13	075	2025-04-06 00:00:00	19.86
7710	Q24	ЗУ	MO 14	076	2025-04-06 00:00:00	19.42
7711	Q25	ЗУ	MO 15	077	2025-04-06 00:00:00	17.23
7712	TP3	ЗУ	CP-300 New	078	2025-04-06 00:00:00	23.4
7713	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 00:30:00	0
7714	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 00:30:00	0.0013
7715	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 00:30:00	0.0028
7716	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 00:30:00	0.0024
7717	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 00:30:00	0
7718	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 00:30:00	0
7719	QF 1,20	ЗУ	China 1	044	2025-04-06 00:30:00	18.84
7720	QF 1,21	ЗУ	China 2	045	2025-04-06 00:30:00	18.56
7721	QF 1,22	ЗУ	China 3	046	2025-04-06 00:30:00	19.91
7722	QF 2,20	ЗУ	China 4	047	2025-04-06 00:30:00	22.73
7723	QF 2,21	ЗУ	China 5	048	2025-04-06 00:30:00	26.34
7724	QF 2,22	ЗУ	China 6	049	2025-04-06 00:30:00	24.25
7725	QF 2,23	ЗУ	China 7	050	2025-04-06 00:30:00	10.73
7726	QF 2,19	ЗУ	China 8	051	2025-04-06 00:30:00	18.56
7727	Q8	ЗУ	DIG	061	2025-04-06 00:30:00	13.52
7728	Q4	ЗУ	BG 1	062	2025-04-06 00:30:00	17.98
7729	Q9	ЗУ	BG 2	063	2025-04-06 00:30:00	9.13
7730	Q10	ЗУ	SM 2	064	2025-04-06 00:30:00	32.39
7731	Q11	ЗУ	SM 3	065	2025-04-06 00:30:00	20.56
7732	Q12	ЗУ	SM 4	066	2025-04-06 00:30:00	20.96
7733	Q13	ЗУ	SM 5	067	2025-04-06 00:30:00	0
7734	Q14	ЗУ	SM 6	068	2025-04-06 00:30:00	0
7735	Q15	ЗУ	SM 7	069	2025-04-06 00:30:00	0
7736	Q16	ЗУ	SM 8	070	2025-04-06 00:30:00	0
7737	Q17	ЗУ	MO 9	071	2025-04-06 00:30:00	1.21
7738	Q20	ЗУ	MO 10	072	2025-04-06 00:30:00	2.83
7739	Q21	ЗУ	MO 11	073	2025-04-06 00:30:00	9
7740	Q22	ЗУ	MO 12	074	2025-04-06 00:30:00	24.67
7741	Q23	ЗУ	MO 13	075	2025-04-06 00:30:00	19.87
7742	Q24	ЗУ	MO 14	076	2025-04-06 00:30:00	19.43
7743	Q25	ЗУ	MO 15	077	2025-04-06 00:30:00	17.27
7744	TP3	ЗУ	CP-300 New	078	2025-04-06 00:30:00	22.97
7745	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 01:00:00	0
7746	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 01:00:00	0.0013
7747	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 01:00:00	0.0027
7748	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 01:00:00	0.0025
7749	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 01:00:00	0
7750	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 01:00:00	0
7751	QF 1,20	ЗУ	China 1	044	2025-04-06 01:00:00	24.67
7752	QF 1,21	ЗУ	China 2	045	2025-04-06 01:00:00	22.07
7753	QF 1,22	ЗУ	China 3	046	2025-04-06 01:00:00	23.37
7754	QF 2,20	ЗУ	China 4	047	2025-04-06 01:00:00	25.71
7755	QF 2,21	ЗУ	China 5	048	2025-04-06 01:00:00	30.06
7756	QF 2,22	ЗУ	China 6	049	2025-04-06 01:00:00	28.02
7757	QF 2,23	ЗУ	China 7	050	2025-04-06 01:00:00	12.47
7758	QF 2,19	ЗУ	China 8	051	2025-04-06 01:00:00	22.8
7759	Q8	ЗУ	DIG	061	2025-04-06 01:00:00	15.27
7760	Q4	ЗУ	BG 1	062	2025-04-06 01:00:00	17.96
7761	Q9	ЗУ	BG 2	063	2025-04-06 01:00:00	4.76
7762	Q10	ЗУ	SM 2	064	2025-04-06 01:00:00	32.29
7763	Q11	ЗУ	SM 3	065	2025-04-06 01:00:00	20.37
7764	Q12	ЗУ	SM 4	066	2025-04-06 01:00:00	20.85
7765	Q13	ЗУ	SM 5	067	2025-04-06 01:00:00	0
7766	Q14	ЗУ	SM 6	068	2025-04-06 01:00:00	0
7767	Q15	ЗУ	SM 7	069	2025-04-06 01:00:00	0
7768	Q16	ЗУ	SM 8	070	2025-04-06 01:00:00	0
7769	Q17	ЗУ	MO 9	071	2025-04-06 01:00:00	1.19
7770	Q20	ЗУ	MO 10	072	2025-04-06 01:00:00	2.74
7771	Q21	ЗУ	MO 11	073	2025-04-06 01:00:00	9.13
7772	Q22	ЗУ	MO 12	074	2025-04-06 01:00:00	24.61
7773	Q23	ЗУ	MO 13	075	2025-04-06 01:00:00	19.86
7774	Q24	ЗУ	MO 14	076	2025-04-06 01:00:00	19.41
7775	Q25	ЗУ	MO 15	077	2025-04-06 01:00:00	17.22
7776	TP3	ЗУ	CP-300 New	078	2025-04-06 01:00:00	23.59
7777	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 01:30:00	0
7778	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 01:30:00	0.0005
7779	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 01:30:00	0.0029
7780	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 01:30:00	0.0021
7781	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 01:30:00	0
7782	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 01:30:00	0
7783	QF 1,20	ЗУ	China 1	044	2025-04-06 01:30:00	26.52
7784	QF 1,21	ЗУ	China 2	045	2025-04-06 01:30:00	23.91
7785	QF 1,22	ЗУ	China 3	046	2025-04-06 01:30:00	25.37
7786	QF 2,20	ЗУ	China 4	047	2025-04-06 01:30:00	28.33
7787	QF 2,21	ЗУ	China 5	048	2025-04-06 01:30:00	31.61
7788	QF 2,22	ЗУ	China 6	049	2025-04-06 01:30:00	29.43
7789	QF 2,23	ЗУ	China 7	050	2025-04-06 01:30:00	13.34
7790	QF 2,19	ЗУ	China 8	051	2025-04-06 01:30:00	24.18
7791	Q8	ЗУ	DIG	061	2025-04-06 01:30:00	16.71
7792	Q4	ЗУ	BG 1	062	2025-04-06 01:30:00	17.9
7793	Q9	ЗУ	BG 2	063	2025-04-06 01:30:00	4.75
7794	Q10	ЗУ	SM 2	064	2025-04-06 01:30:00	32.22
7795	Q11	ЗУ	SM 3	065	2025-04-06 01:30:00	20.11
7796	Q12	ЗУ	SM 4	066	2025-04-06 01:30:00	20.83
7797	Q13	ЗУ	SM 5	067	2025-04-06 01:30:00	0
7798	Q14	ЗУ	SM 6	068	2025-04-06 01:30:00	0
7799	Q15	ЗУ	SM 7	069	2025-04-06 01:30:00	0
7800	Q16	ЗУ	SM 8	070	2025-04-06 01:30:00	0
7801	Q17	ЗУ	MO 9	071	2025-04-06 01:30:00	1.13
7802	Q20	ЗУ	MO 10	072	2025-04-06 01:30:00	2.69
7803	Q21	ЗУ	MO 11	073	2025-04-06 01:30:00	9.14
7804	Q22	ЗУ	MO 12	074	2025-04-06 01:30:00	24.38
7805	Q23	ЗУ	MO 13	075	2025-04-06 01:30:00	19.69
7806	Q24	ЗУ	MO 14	076	2025-04-06 01:30:00	19.36
7807	Q25	ЗУ	MO 15	077	2025-04-06 01:30:00	17.06
7808	TP3	ЗУ	CP-300 New	078	2025-04-06 01:30:00	23.82
7809	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 02:00:00	0
7810	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 02:00:00	0.0014
7811	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 02:00:00	0.0028
7812	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 02:00:00	0.0021
7813	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 02:00:00	0
7814	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 02:00:00	0
7815	QF 1,20	ЗУ	China 1	044	2025-04-06 02:00:00	24.2
7816	QF 1,21	ЗУ	China 2	045	2025-04-06 02:00:00	21.82
7817	QF 1,22	ЗУ	China 3	046	2025-04-06 02:00:00	24.12
7818	QF 2,20	ЗУ	China 4	047	2025-04-06 02:00:00	27.08
7819	QF 2,21	ЗУ	China 5	048	2025-04-06 02:00:00	28.73
7820	QF 2,22	ЗУ	China 6	049	2025-04-06 02:00:00	27.79
7821	QF 2,23	ЗУ	China 7	050	2025-04-06 02:00:00	12.64
7822	QF 2,19	ЗУ	China 8	051	2025-04-06 02:00:00	22.96
7823	Q8	ЗУ	DIG	061	2025-04-06 02:00:00	17.42
7824	Q4	ЗУ	BG 1	062	2025-04-06 02:00:00	17.98
7825	Q9	ЗУ	BG 2	063	2025-04-06 02:00:00	4.76
7826	Q10	ЗУ	SM 2	064	2025-04-06 02:00:00	32.26
7827	Q11	ЗУ	SM 3	065	2025-04-06 02:00:00	20.25
7828	Q12	ЗУ	SM 4	066	2025-04-06 02:00:00	20.84
7829	Q13	ЗУ	SM 5	067	2025-04-06 02:00:00	0
7830	Q14	ЗУ	SM 6	068	2025-04-06 02:00:00	0
7831	Q15	ЗУ	SM 7	069	2025-04-06 02:00:00	0
7832	Q16	ЗУ	SM 8	070	2025-04-06 02:00:00	0
7833	Q17	ЗУ	MO 9	071	2025-04-06 02:00:00	1.18
7834	Q20	ЗУ	MO 10	072	2025-04-06 02:00:00	2.72
7835	Q21	ЗУ	MO 11	073	2025-04-06 02:00:00	9.16
7836	Q22	ЗУ	MO 12	074	2025-04-06 02:00:00	24.56
7837	Q23	ЗУ	MO 13	075	2025-04-06 02:00:00	19.79
7838	Q24	ЗУ	MO 14	076	2025-04-06 02:00:00	19.4
7839	Q25	ЗУ	MO 15	077	2025-04-06 02:00:00	17.18
7840	TP3	ЗУ	CP-300 New	078	2025-04-06 02:00:00	24.27
7841	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 02:30:00	0
7842	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 02:30:00	0.0001
7843	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 02:30:00	0.0028
7844	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 02:30:00	0.0018
7845	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 02:30:00	0
7846	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 02:30:00	0
7847	QF 1,20	ЗУ	China 1	044	2025-04-06 02:30:00	24.26
7848	QF 1,21	ЗУ	China 2	045	2025-04-06 02:30:00	22.03
7849	QF 1,22	ЗУ	China 3	046	2025-04-06 02:30:00	24.28
7850	QF 2,20	ЗУ	China 4	047	2025-04-06 02:30:00	27.49
7851	QF 2,21	ЗУ	China 5	048	2025-04-06 02:30:00	29.64
7852	QF 2,22	ЗУ	China 6	049	2025-04-06 02:30:00	28.89
7853	QF 2,23	ЗУ	China 7	050	2025-04-06 02:30:00	13.05
7854	QF 2,19	ЗУ	China 8	051	2025-04-06 02:30:00	23.44
7855	Q8	ЗУ	DIG	061	2025-04-06 02:30:00	17.02
7856	Q4	ЗУ	BG 1	062	2025-04-06 02:30:00	17.85
7857	Q9	ЗУ	BG 2	063	2025-04-06 02:30:00	12.66
7858	Q10	ЗУ	SM 2	064	2025-04-06 02:30:00	32.38
7859	Q11	ЗУ	SM 3	065	2025-04-06 02:30:00	20.33
7860	Q12	ЗУ	SM 4	066	2025-04-06 02:30:00	20.78
7861	Q13	ЗУ	SM 5	067	2025-04-06 02:30:00	0
7862	Q14	ЗУ	SM 6	068	2025-04-06 02:30:00	0
7863	Q15	ЗУ	SM 7	069	2025-04-06 02:30:00	0
7864	Q16	ЗУ	SM 8	070	2025-04-06 02:30:00	0
7865	Q17	ЗУ	MO 9	071	2025-04-06 02:30:00	1.17
7866	Q20	ЗУ	MO 10	072	2025-04-06 02:30:00	2.71
7867	Q21	ЗУ	MO 11	073	2025-04-06 02:30:00	9.16
7868	Q22	ЗУ	MO 12	074	2025-04-06 02:30:00	24.62
7869	Q23	ЗУ	MO 13	075	2025-04-06 02:30:00	19.76
7870	Q24	ЗУ	MO 14	076	2025-04-06 02:30:00	19.42
7871	Q25	ЗУ	MO 15	077	2025-04-06 02:30:00	17.2
7872	TP3	ЗУ	CP-300 New	078	2025-04-06 02:30:00	23.48
7873	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 03:00:00	0
7874	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 03:00:00	0.0015
7875	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 03:00:00	0.0028
7876	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 03:00:00	0.0019
7877	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 03:00:00	0
7878	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 03:00:00	0
7879	QF 1,20	ЗУ	China 1	044	2025-04-06 03:00:00	24.32
7880	QF 1,21	ЗУ	China 2	045	2025-04-06 03:00:00	22.31
7881	QF 1,22	ЗУ	China 3	046	2025-04-06 03:00:00	24.62
7882	QF 2,20	ЗУ	China 4	047	2025-04-06 03:00:00	28.09
7883	QF 2,21	ЗУ	China 5	048	2025-04-06 03:00:00	29.79
7884	QF 2,22	ЗУ	China 6	049	2025-04-06 03:00:00	29.03
7885	QF 2,23	ЗУ	China 7	050	2025-04-06 03:00:00	13.3
7886	QF 2,19	ЗУ	China 8	051	2025-04-06 03:00:00	23.82
7887	Q8	ЗУ	DIG	061	2025-04-06 03:00:00	18.32
7888	Q4	ЗУ	BG 1	062	2025-04-06 03:00:00	17.8
7889	Q9	ЗУ	BG 2	063	2025-04-06 03:00:00	20.4
7890	Q10	ЗУ	SM 2	064	2025-04-06 03:00:00	32.29
7891	Q11	ЗУ	SM 3	065	2025-04-06 03:00:00	12.71
7892	Q12	ЗУ	SM 4	066	2025-04-06 03:00:00	14.13
7893	Q13	ЗУ	SM 5	067	2025-04-06 03:00:00	0
7894	Q14	ЗУ	SM 6	068	2025-04-06 03:00:00	0
7895	Q15	ЗУ	SM 7	069	2025-04-06 03:00:00	0
7896	Q16	ЗУ	SM 8	070	2025-04-06 03:00:00	0
7897	Q17	ЗУ	MO 9	071	2025-04-06 03:00:00	1.17
7898	Q20	ЗУ	MO 10	072	2025-04-06 03:00:00	2.69
7899	Q21	ЗУ	MO 11	073	2025-04-06 03:00:00	9.15
7900	Q22	ЗУ	MO 12	074	2025-04-06 03:00:00	24.58
7901	Q23	ЗУ	MO 13	075	2025-04-06 03:00:00	18.83
7902	Q24	ЗУ	MO 14	076	2025-04-06 03:00:00	17.54
7903	Q25	ЗУ	MO 15	077	2025-04-06 03:00:00	17.09
7904	TP3	ЗУ	CP-300 New	078	2025-04-06 03:00:00	24.11
7905	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 03:30:00	0
7906	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 03:30:00	0
7907	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 03:30:00	0.0026
7908	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 03:30:00	0.0017
7909	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 03:30:00	0
7910	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 03:30:00	0
7911	QF 1,20	ЗУ	China 1	044	2025-04-06 03:30:00	23.94
7912	QF 1,21	ЗУ	China 2	045	2025-04-06 03:30:00	21.93
7913	QF 1,22	ЗУ	China 3	046	2025-04-06 03:30:00	24.46
7914	QF 2,20	ЗУ	China 4	047	2025-04-06 03:30:00	27.67
7915	QF 2,21	ЗУ	China 5	048	2025-04-06 03:30:00	29.38
7916	QF 2,22	ЗУ	China 6	049	2025-04-06 03:30:00	28.28
7917	QF 2,23	ЗУ	China 7	050	2025-04-06 03:30:00	13.45
7918	QF 2,19	ЗУ	China 8	051	2025-04-06 03:30:00	23.31
7919	Q8	ЗУ	DIG	061	2025-04-06 03:30:00	21.58
7920	Q4	ЗУ	BG 1	062	2025-04-06 03:30:00	17.78
7921	Q9	ЗУ	BG 2	063	2025-04-06 03:30:00	20.41
7922	Q10	ЗУ	SM 2	064	2025-04-06 03:30:00	32.3
7923	Q11	ЗУ	SM 3	065	2025-04-06 03:30:00	9.93
7924	Q12	ЗУ	SM 4	066	2025-04-06 03:30:00	11.55
7925	Q13	ЗУ	SM 5	067	2025-04-06 03:30:00	0
7926	Q14	ЗУ	SM 6	068	2025-04-06 03:30:00	0
7927	Q15	ЗУ	SM 7	069	2025-04-06 03:30:00	0
7928	Q16	ЗУ	SM 8	070	2025-04-06 03:30:00	0
7929	Q17	ЗУ	MO 9	071	2025-04-06 03:30:00	1.17
7930	Q20	ЗУ	MO 10	072	2025-04-06 03:30:00	2.72
7931	Q21	ЗУ	MO 11	073	2025-04-06 03:30:00	9.12
7932	Q22	ЗУ	MO 12	074	2025-04-06 03:30:00	24.64
7933	Q23	ЗУ	MO 13	075	2025-04-06 03:30:00	17.01
7934	Q24	ЗУ	MO 14	076	2025-04-06 03:30:00	16.95
7935	Q25	ЗУ	MO 15	077	2025-04-06 03:30:00	17.15
7936	TP3	ЗУ	CP-300 New	078	2025-04-06 03:30:00	24.28
7937	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 04:00:00	0
7938	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 04:00:00	0.0009
7939	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 04:00:00	0.0027
7940	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 04:00:00	0.0023
7941	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 04:00:00	0
7942	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 04:00:00	0
7943	QF 1,20	ЗУ	China 1	044	2025-04-06 04:00:00	23.06
7944	QF 1,21	ЗУ	China 2	045	2025-04-06 04:00:00	21.02
7945	QF 1,22	ЗУ	China 3	046	2025-04-06 04:00:00	23.69
7946	QF 2,20	ЗУ	China 4	047	2025-04-06 04:00:00	27.76
7947	QF 2,21	ЗУ	China 5	048	2025-04-06 04:00:00	29.05
7948	QF 2,22	ЗУ	China 6	049	2025-04-06 04:00:00	26.67
7949	QF 2,23	ЗУ	China 7	050	2025-04-06 04:00:00	13.34
7950	QF 2,19	ЗУ	China 8	051	2025-04-06 04:00:00	22.74
7951	Q8	ЗУ	DIG	061	2025-04-06 04:00:00	27.9
7952	Q4	ЗУ	BG 1	062	2025-04-06 04:00:00	17.78
7953	Q9	ЗУ	BG 2	063	2025-04-06 04:00:00	20.4
7954	Q10	ЗУ	SM 2	064	2025-04-06 04:00:00	32.31
7955	Q11	ЗУ	SM 3	065	2025-04-06 04:00:00	9.97
7956	Q12	ЗУ	SM 4	066	2025-04-06 04:00:00	11.53
7957	Q13	ЗУ	SM 5	067	2025-04-06 04:00:00	0
7958	Q14	ЗУ	SM 6	068	2025-04-06 04:00:00	0
7959	Q15	ЗУ	SM 7	069	2025-04-06 04:00:00	0
7960	Q16	ЗУ	SM 8	070	2025-04-06 04:00:00	0
7961	Q17	ЗУ	MO 9	071	2025-04-06 04:00:00	1.16
7962	Q20	ЗУ	MO 10	072	2025-04-06 04:00:00	2.7
7963	Q21	ЗУ	MO 11	073	2025-04-06 04:00:00	9.15
7964	Q22	ЗУ	MO 12	074	2025-04-06 04:00:00	24.63
7965	Q23	ЗУ	MO 13	075	2025-04-06 04:00:00	16.97
7966	Q24	ЗУ	MO 14	076	2025-04-06 04:00:00	16.93
7967	Q25	ЗУ	MO 15	077	2025-04-06 04:00:00	17.12
7968	TP3	ЗУ	CP-300 New	078	2025-04-06 04:00:00	23
7969	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 04:30:00	0
7970	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 04:30:00	0.0016
7971	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 04:30:00	0.0025
7972	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 04:30:00	0.0022
7973	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 04:30:00	0
7974	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 04:30:00	0
7975	QF 1,20	ЗУ	China 1	044	2025-04-06 04:30:00	23.3
7976	QF 1,21	ЗУ	China 2	045	2025-04-06 04:30:00	21.32
7977	QF 1,22	ЗУ	China 3	046	2025-04-06 04:30:00	23.91
7978	QF 2,20	ЗУ	China 4	047	2025-04-06 04:30:00	27.88
7979	QF 2,21	ЗУ	China 5	048	2025-04-06 04:30:00	28.96
7980	QF 2,22	ЗУ	China 6	049	2025-04-06 04:30:00	26.89
7981	QF 2,23	ЗУ	China 7	050	2025-04-06 04:30:00	13.44
7982	QF 2,19	ЗУ	China 8	051	2025-04-06 04:30:00	22.78
7983	Q8	ЗУ	DIG	061	2025-04-06 04:30:00	34.21
7984	Q4	ЗУ	BG 1	062	2025-04-06 04:30:00	17.73
7985	Q9	ЗУ	BG 2	063	2025-04-06 04:30:00	20.34
7986	Q10	ЗУ	SM 2	064	2025-04-06 04:30:00	32.29
7987	Q11	ЗУ	SM 3	065	2025-04-06 04:30:00	9.96
7988	Q12	ЗУ	SM 4	066	2025-04-06 04:30:00	11.49
7989	Q13	ЗУ	SM 5	067	2025-04-06 04:30:00	0
7990	Q14	ЗУ	SM 6	068	2025-04-06 04:30:00	0
7991	Q15	ЗУ	SM 7	069	2025-04-06 04:30:00	0
7992	Q16	ЗУ	SM 8	070	2025-04-06 04:30:00	0
7993	Q17	ЗУ	MO 9	071	2025-04-06 04:30:00	1.15
7994	Q20	ЗУ	MO 10	072	2025-04-06 04:30:00	2.73
7995	Q21	ЗУ	MO 11	073	2025-04-06 04:30:00	9.1
7996	Q22	ЗУ	MO 12	074	2025-04-06 04:30:00	24.52
7997	Q23	ЗУ	MO 13	075	2025-04-06 04:30:00	16.99
7998	Q24	ЗУ	MO 14	076	2025-04-06 04:30:00	16.92
7999	Q25	ЗУ	MO 15	077	2025-04-06 04:30:00	17.13
8000	TP3	ЗУ	CP-300 New	078	2025-04-06 04:30:00	24.35
8001	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 05:00:00	0
8002	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 05:00:00	0.0006
8003	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 05:00:00	0.0025
8004	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 05:00:00	0.0022
8005	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 05:00:00	0
8006	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 05:00:00	0
8007	QF 1,20	ЗУ	China 1	044	2025-04-06 05:00:00	22.35
8008	QF 1,21	ЗУ	China 2	045	2025-04-06 05:00:00	20.83
8009	QF 1,22	ЗУ	China 3	046	2025-04-06 05:00:00	22.75
8010	QF 2,20	ЗУ	China 4	047	2025-04-06 05:00:00	27.82
8011	QF 2,21	ЗУ	China 5	048	2025-04-06 05:00:00	28.08
8012	QF 2,22	ЗУ	China 6	049	2025-04-06 05:00:00	26.64
8013	QF 2,23	ЗУ	China 7	050	2025-04-06 05:00:00	13.13
8014	QF 2,19	ЗУ	China 8	051	2025-04-06 05:00:00	22.1
8015	Q8	ЗУ	DIG	061	2025-04-06 05:00:00	41.02
8016	Q4	ЗУ	BG 1	062	2025-04-06 05:00:00	17.65
8017	Q9	ЗУ	BG 2	063	2025-04-06 05:00:00	20.32
8018	Q10	ЗУ	SM 2	064	2025-04-06 05:00:00	32.36
8019	Q11	ЗУ	SM 3	065	2025-04-06 05:00:00	9.98
8020	Q12	ЗУ	SM 4	066	2025-04-06 05:00:00	11.58
8021	Q13	ЗУ	SM 5	067	2025-04-06 05:00:00	0
8022	Q14	ЗУ	SM 6	068	2025-04-06 05:00:00	0
8023	Q15	ЗУ	SM 7	069	2025-04-06 05:00:00	0
8024	Q16	ЗУ	SM 8	070	2025-04-06 05:00:00	0
8025	Q17	ЗУ	MO 9	071	2025-04-06 05:00:00	1.14
8026	Q20	ЗУ	MO 10	072	2025-04-06 05:00:00	2.71
8027	Q21	ЗУ	MO 11	073	2025-04-06 05:00:00	9.11
8028	Q22	ЗУ	MO 12	074	2025-04-06 05:00:00	24.46
8029	Q23	ЗУ	MO 13	075	2025-04-06 05:00:00	16.92
8030	Q24	ЗУ	MO 14	076	2025-04-06 05:00:00	16.94
8031	Q25	ЗУ	MO 15	077	2025-04-06 05:00:00	17.13
8032	TP3	ЗУ	CP-300 New	078	2025-04-06 05:00:00	26.07
8033	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 05:30:00	0
8034	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 05:30:00	0.0012
8035	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 05:30:00	0.0024
8036	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 05:30:00	0.0022
8037	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 05:30:00	0
8038	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 05:30:00	0
8039	QF 1,20	ЗУ	China 1	044	2025-04-06 05:30:00	19.13
8040	QF 1,21	ЗУ	China 2	045	2025-04-06 05:30:00	17
8041	QF 1,22	ЗУ	China 3	046	2025-04-06 05:30:00	18.22
8042	QF 2,20	ЗУ	China 4	047	2025-04-06 05:30:00	23.58
8043	QF 2,21	ЗУ	China 5	048	2025-04-06 05:30:00	24.67
8044	QF 2,22	ЗУ	China 6	049	2025-04-06 05:30:00	23
8045	QF 2,23	ЗУ	China 7	050	2025-04-06 05:30:00	11.4
8046	QF 2,19	ЗУ	China 8	051	2025-04-06 05:30:00	18.27
8047	Q8	ЗУ	DIG	061	2025-04-06 05:30:00	55.55
8048	Q4	ЗУ	BG 1	062	2025-04-06 05:30:00	17.63
8049	Q9	ЗУ	BG 2	063	2025-04-06 05:30:00	20.3
8050	Q10	ЗУ	SM 2	064	2025-04-06 05:30:00	32.32
8051	Q11	ЗУ	SM 3	065	2025-04-06 05:30:00	9.96
8052	Q12	ЗУ	SM 4	066	2025-04-06 05:30:00	11.53
8053	Q13	ЗУ	SM 5	067	2025-04-06 05:30:00	0
8054	Q14	ЗУ	SM 6	068	2025-04-06 05:30:00	0
8055	Q15	ЗУ	SM 7	069	2025-04-06 05:30:00	0
8056	Q16	ЗУ	SM 8	070	2025-04-06 05:30:00	0
8057	Q17	ЗУ	MO 9	071	2025-04-06 05:30:00	1.14
8058	Q20	ЗУ	MO 10	072	2025-04-06 05:30:00	2.7
8059	Q21	ЗУ	MO 11	073	2025-04-06 05:30:00	9.13
8060	Q22	ЗУ	MO 12	074	2025-04-06 05:30:00	24.45
8061	Q23	ЗУ	MO 13	075	2025-04-06 05:30:00	16.91
8062	Q24	ЗУ	MO 14	076	2025-04-06 05:30:00	16.92
8063	Q25	ЗУ	MO 15	077	2025-04-06 05:30:00	17.09
8064	TP3	ЗУ	CP-300 New	078	2025-04-06 05:30:00	27.17
8065	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 06:00:00	0
8066	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 06:00:00	0.0009
8067	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 06:00:00	0.0022
8068	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 06:00:00	0.002
8069	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 06:00:00	0
8070	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 06:00:00	0
8071	QF 1,20	ЗУ	China 1	044	2025-04-06 06:00:00	17.97
8072	QF 1,21	ЗУ	China 2	045	2025-04-06 06:00:00	16.02
8073	QF 1,22	ЗУ	China 3	046	2025-04-06 06:00:00	17.52
8074	QF 2,20	ЗУ	China 4	047	2025-04-06 06:00:00	22.21
8075	QF 2,21	ЗУ	China 5	048	2025-04-06 06:00:00	23.37
8076	QF 2,22	ЗУ	China 6	049	2025-04-06 06:00:00	21.78
8077	QF 2,23	ЗУ	China 7	050	2025-04-06 06:00:00	10.89
8078	QF 2,19	ЗУ	China 8	051	2025-04-06 06:00:00	17.41
8079	Q8	ЗУ	DIG	061	2025-04-06 06:00:00	67.31
8080	Q4	ЗУ	BG 1	062	2025-04-06 06:00:00	17.62
8081	Q9	ЗУ	BG 2	063	2025-04-06 06:00:00	20.25
8082	Q10	ЗУ	SM 2	064	2025-04-06 06:00:00	32.23
8083	Q11	ЗУ	SM 3	065	2025-04-06 06:00:00	13.86
8084	Q12	ЗУ	SM 4	066	2025-04-06 06:00:00	15.27
8085	Q13	ЗУ	SM 5	067	2025-04-06 06:00:00	0
8086	Q14	ЗУ	SM 6	068	2025-04-06 06:00:00	0
8087	Q15	ЗУ	SM 7	069	2025-04-06 06:00:00	0
8088	Q16	ЗУ	SM 8	070	2025-04-06 06:00:00	0
8089	Q17	ЗУ	MO 9	071	2025-04-06 06:00:00	1.12
8090	Q20	ЗУ	MO 10	072	2025-04-06 06:00:00	2.69
8091	Q21	ЗУ	MO 11	073	2025-04-06 06:00:00	9.13
8092	Q22	ЗУ	MO 12	074	2025-04-06 06:00:00	24.38
8093	Q23	ЗУ	MO 13	075	2025-04-06 06:00:00	16.85
8094	Q24	ЗУ	MO 14	076	2025-04-06 06:00:00	18.31
8095	Q25	ЗУ	MO 15	077	2025-04-06 06:00:00	17.06
8096	TP3	ЗУ	CP-300 New	078	2025-04-06 06:00:00	36.39
8097	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 06:30:00	0
8098	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 06:30:00	0.0012
8099	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 06:30:00	0.0026
8100	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 06:30:00	0.0033
8101	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 06:30:00	0
8102	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 06:30:00	0
8103	QF 1,20	ЗУ	China 1	044	2025-04-06 06:30:00	17.27
8104	QF 1,21	ЗУ	China 2	045	2025-04-06 06:30:00	15.25
8105	QF 1,22	ЗУ	China 3	046	2025-04-06 06:30:00	17.35
8106	QF 2,20	ЗУ	China 4	047	2025-04-06 06:30:00	21.85
8107	QF 2,21	ЗУ	China 5	048	2025-04-06 06:30:00	23.55
8108	QF 2,22	ЗУ	China 6	049	2025-04-06 06:30:00	21.76
8109	QF 2,23	ЗУ	China 7	050	2025-04-06 06:30:00	10.81
8110	QF 2,19	ЗУ	China 8	051	2025-04-06 06:30:00	16.96
8111	Q8	ЗУ	DIG	061	2025-04-06 06:30:00	75.71
8112	Q4	ЗУ	BG 1	062	2025-04-06 06:30:00	17.69
8113	Q9	ЗУ	BG 2	063	2025-04-06 06:30:00	20.27
8114	Q10	ЗУ	SM 2	064	2025-04-06 06:30:00	32.26
8115	Q11	ЗУ	SM 3	065	2025-04-06 06:30:00	20.37
8116	Q12	ЗУ	SM 4	066	2025-04-06 06:30:00	21.45
8117	Q13	ЗУ	SM 5	067	2025-04-06 06:30:00	0
8118	Q14	ЗУ	SM 6	068	2025-04-06 06:30:00	0
8119	Q15	ЗУ	SM 7	069	2025-04-06 06:30:00	0
8120	Q16	ЗУ	SM 8	070	2025-04-06 06:30:00	0
8121	Q17	ЗУ	MO 9	071	2025-04-06 06:30:00	1.18
8122	Q20	ЗУ	MO 10	072	2025-04-06 06:30:00	2.72
8123	Q21	ЗУ	MO 11	073	2025-04-06 06:30:00	9.18
8124	Q22	ЗУ	MO 12	074	2025-04-06 06:30:00	24.54
8125	Q23	ЗУ	MO 13	075	2025-04-06 06:30:00	17.06
8126	Q24	ЗУ	MO 14	076	2025-04-06 06:30:00	19.9
8127	Q25	ЗУ	MO 15	077	2025-04-06 06:30:00	17.17
8128	TP3	ЗУ	CP-300 New	078	2025-04-06 06:30:00	37.14
8129	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 07:00:00	0
8130	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 07:00:00	0.0009
8131	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 07:00:00	0.0023
8132	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 07:00:00	0.003
8133	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 07:00:00	0
8134	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 07:00:00	0
8135	QF 1,20	ЗУ	China 1	044	2025-04-06 07:00:00	17.25
8136	QF 1,21	ЗУ	China 2	045	2025-04-06 07:00:00	15.75
8137	QF 1,22	ЗУ	China 3	046	2025-04-06 07:00:00	17.45
8138	QF 2,20	ЗУ	China 4	047	2025-04-06 07:00:00	22.2
8139	QF 2,21	ЗУ	China 5	048	2025-04-06 07:00:00	23.85
8140	QF 2,22	ЗУ	China 6	049	2025-04-06 07:00:00	21.65
8141	QF 2,23	ЗУ	China 7	050	2025-04-06 07:00:00	10.72
8142	QF 2,19	ЗУ	China 8	051	2025-04-06 07:00:00	16.91
8143	Q8	ЗУ	DIG	061	2025-04-06 07:00:00	80.97
8144	Q4	ЗУ	BG 1	062	2025-04-06 07:00:00	17.62
8145	Q9	ЗУ	BG 2	063	2025-04-06 07:00:00	20.23
8146	Q10	ЗУ	SM 2	064	2025-04-06 07:00:00	32.2
8147	Q11	ЗУ	SM 3	065	2025-04-06 07:00:00	20.17
8148	Q12	ЗУ	SM 4	066	2025-04-06 07:00:00	21.49
8149	Q13	ЗУ	SM 5	067	2025-04-06 07:00:00	0
8150	Q14	ЗУ	SM 6	068	2025-04-06 07:00:00	0
8151	Q15	ЗУ	SM 7	069	2025-04-06 07:00:00	0
8152	Q16	ЗУ	SM 8	070	2025-04-06 07:00:00	0
8153	Q17	ЗУ	MO 9	071	2025-04-06 07:00:00	1.17
8154	Q20	ЗУ	MO 10	072	2025-04-06 07:00:00	2.72
8155	Q21	ЗУ	MO 11	073	2025-04-06 07:00:00	9.18
8156	Q22	ЗУ	MO 12	074	2025-04-06 07:00:00	24.47
8157	Q23	ЗУ	MO 13	075	2025-04-06 07:00:00	17.07
8158	Q24	ЗУ	MO 14	076	2025-04-06 07:00:00	19.88
8159	Q25	ЗУ	MO 15	077	2025-04-06 07:00:00	17.1
8160	TP3	ЗУ	CP-300 New	078	2025-04-06 07:00:00	43.52
8161	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 07:30:00	0
8162	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 07:30:00	0.0015
8163	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 07:30:00	0.0027
8164	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 07:30:00	0.0031
8165	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 07:30:00	0
8166	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 07:30:00	0
8167	QF 1,20	ЗУ	China 1	044	2025-04-06 07:30:00	19.14
8168	QF 1,21	ЗУ	China 2	045	2025-04-06 07:30:00	16.98
8169	QF 1,22	ЗУ	China 3	046	2025-04-06 07:30:00	19.08
8170	QF 2,20	ЗУ	China 4	047	2025-04-06 07:30:00	24.33
8171	QF 2,21	ЗУ	China 5	048	2025-04-06 07:30:00	26.3
8172	QF 2,22	ЗУ	China 6	049	2025-04-06 07:30:00	23.9
8173	QF 2,23	ЗУ	China 7	050	2025-04-06 07:30:00	11.89
8174	QF 2,19	ЗУ	China 8	051	2025-04-06 07:30:00	18.54
8175	Q8	ЗУ	DIG	061	2025-04-06 07:30:00	83.46
8176	Q4	ЗУ	BG 1	062	2025-04-06 07:30:00	17.65
8177	Q9	ЗУ	BG 2	063	2025-04-06 07:30:00	20.2
8178	Q10	ЗУ	SM 2	064	2025-04-06 07:30:00	32.21
8179	Q11	ЗУ	SM 3	065	2025-04-06 07:30:00	20.14
8180	Q12	ЗУ	SM 4	066	2025-04-06 07:30:00	21.49
8181	Q13	ЗУ	SM 5	067	2025-04-06 07:30:00	0
8182	Q14	ЗУ	SM 6	068	2025-04-06 07:30:00	0
8183	Q15	ЗУ	SM 7	069	2025-04-06 07:30:00	0
8184	Q16	ЗУ	SM 8	070	2025-04-06 07:30:00	0
8185	Q17	ЗУ	MO 9	071	2025-04-06 07:30:00	1.17
8186	Q20	ЗУ	MO 10	072	2025-04-06 07:30:00	2.72
8187	Q21	ЗУ	MO 11	073	2025-04-06 07:30:00	9.11
8188	Q22	ЗУ	MO 12	074	2025-04-06 07:30:00	27.33
8189	Q23	ЗУ	MO 13	075	2025-04-06 07:30:00	17.06
8190	Q24	ЗУ	MO 14	076	2025-04-06 07:30:00	19.88
8191	Q25	ЗУ	MO 15	077	2025-04-06 07:30:00	17.06
8192	TP3	ЗУ	CP-300 New	078	2025-04-06 07:30:00	47.47
8193	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 08:00:00	0
8194	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 08:00:00	0.0011
8195	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 08:00:00	0.0021
8196	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 08:00:00	0.0031
8197	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 08:00:00	0
8198	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 08:00:00	0
8199	QF 1,20	ЗУ	China 1	044	2025-04-06 08:00:00	18.83
8200	QF 1,21	ЗУ	China 2	045	2025-04-06 08:00:00	16.55
8201	QF 1,22	ЗУ	China 3	046	2025-04-06 08:00:00	18.93
8202	QF 2,20	ЗУ	China 4	047	2025-04-06 08:00:00	24.12
8203	QF 2,21	ЗУ	China 5	048	2025-04-06 08:00:00	26.6
8204	QF 2,22	ЗУ	China 6	049	2025-04-06 08:00:00	24.23
8205	QF 2,23	ЗУ	China 7	050	2025-04-06 08:00:00	11.36
8206	QF 2,19	ЗУ	China 8	051	2025-04-06 08:00:00	17.89
8207	Q8	ЗУ	DIG	061	2025-04-06 08:00:00	77.99
8208	Q4	ЗУ	BG 1	062	2025-04-06 08:00:00	17.67
8209	Q9	ЗУ	BG 2	063	2025-04-06 08:00:00	20.18
8210	Q10	ЗУ	SM 2	064	2025-04-06 08:00:00	32.25
8211	Q11	ЗУ	SM 3	065	2025-04-06 08:00:00	19.99
8212	Q12	ЗУ	SM 4	066	2025-04-06 08:00:00	21.51
8213	Q13	ЗУ	SM 5	067	2025-04-06 08:00:00	0
8214	Q14	ЗУ	SM 6	068	2025-04-06 08:00:00	0
8215	Q15	ЗУ	SM 7	069	2025-04-06 08:00:00	0
8216	Q16	ЗУ	SM 8	070	2025-04-06 08:00:00	0
8217	Q17	ЗУ	MO 9	071	2025-04-06 08:00:00	1.15
8218	Q20	ЗУ	MO 10	072	2025-04-06 08:00:00	2.7
8219	Q21	ЗУ	MO 11	073	2025-04-06 08:00:00	9.14
8220	Q22	ЗУ	MO 12	074	2025-04-06 08:00:00	30.09
8221	Q23	ЗУ	MO 13	075	2025-04-06 08:00:00	17.06
8222	Q24	ЗУ	MO 14	076	2025-04-06 08:00:00	19.85
8223	Q25	ЗУ	MO 15	077	2025-04-06 08:00:00	17.04
8224	TP3	ЗУ	CP-300 New	078	2025-04-06 08:00:00	52.12
8225	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 08:30:00	0
8226	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 08:30:00	0.0015
8227	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 08:30:00	0.0023
8228	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 08:30:00	0.0031
8229	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 08:30:00	0
8230	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 08:30:00	0
8231	QF 1,20	ЗУ	China 1	044	2025-04-06 08:30:00	23.38
8232	QF 1,21	ЗУ	China 2	045	2025-04-06 08:30:00	21.99
8233	QF 1,22	ЗУ	China 3	046	2025-04-06 08:30:00	23.65
8234	QF 2,20	ЗУ	China 4	047	2025-04-06 08:30:00	29.04
8235	QF 2,21	ЗУ	China 5	048	2025-04-06 08:30:00	32.15
8236	QF 2,22	ЗУ	China 6	049	2025-04-06 08:30:00	30.38
8237	QF 2,23	ЗУ	China 7	050	2025-04-06 08:30:00	14.46
8238	QF 2,19	ЗУ	China 8	051	2025-04-06 08:30:00	22.54
8239	Q8	ЗУ	DIG	061	2025-04-06 08:30:00	73.81
8240	Q4	ЗУ	BG 1	062	2025-04-06 08:30:00	17.63
8241	Q9	ЗУ	BG 2	063	2025-04-06 08:30:00	20.12
8242	Q10	ЗУ	SM 2	064	2025-04-06 08:30:00	32.29
8243	Q11	ЗУ	SM 3	065	2025-04-06 08:30:00	19.98
8244	Q12	ЗУ	SM 4	066	2025-04-06 08:30:00	21.48
8245	Q13	ЗУ	SM 5	067	2025-04-06 08:30:00	0
8246	Q14	ЗУ	SM 6	068	2025-04-06 08:30:00	0
8247	Q15	ЗУ	SM 7	069	2025-04-06 08:30:00	0
8248	Q16	ЗУ	SM 8	070	2025-04-06 08:30:00	0
8249	Q17	ЗУ	MO 9	071	2025-04-06 08:30:00	1.13
8250	Q20	ЗУ	MO 10	072	2025-04-06 08:30:00	2.69
8251	Q21	ЗУ	MO 11	073	2025-04-06 08:30:00	9.18
8252	Q22	ЗУ	MO 12	074	2025-04-06 08:30:00	30.02
8253	Q23	ЗУ	MO 13	075	2025-04-06 08:30:00	9.34
8254	Q24	ЗУ	MO 14	076	2025-04-06 08:30:00	19.89
8255	Q25	ЗУ	MO 15	077	2025-04-06 08:30:00	17.02
8256	TP3	ЗУ	CP-300 New	078	2025-04-06 08:30:00	52.77
8257	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 09:00:00	0
8258	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 09:00:00	0.0012
8259	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 09:00:00	0.0025
8260	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 09:00:00	0.0028
8261	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 09:00:00	0
8262	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 09:00:00	0
8263	QF 1,20	ЗУ	China 1	044	2025-04-06 09:00:00	24.31
8264	QF 1,21	ЗУ	China 2	045	2025-04-06 09:00:00	23.25
8265	QF 1,22	ЗУ	China 3	046	2025-04-06 09:00:00	25.53
8266	QF 2,20	ЗУ	China 4	047	2025-04-06 09:00:00	30.59
8267	QF 2,21	ЗУ	China 5	048	2025-04-06 09:00:00	34.6
8268	QF 2,22	ЗУ	China 6	049	2025-04-06 09:00:00	32.22
8269	QF 2,23	ЗУ	China 7	050	2025-04-06 09:00:00	15.25
8270	QF 2,19	ЗУ	China 8	051	2025-04-06 09:00:00	23.77
8271	Q8	ЗУ	DIG	061	2025-04-06 09:00:00	63.65
8272	Q4	ЗУ	BG 1	062	2025-04-06 09:00:00	17.61
8273	Q9	ЗУ	BG 2	063	2025-04-06 09:00:00	20.15
8274	Q10	ЗУ	SM 2	064	2025-04-06 09:00:00	32.2
8275	Q11	ЗУ	SM 3	065	2025-04-06 09:00:00	19.76
8276	Q12	ЗУ	SM 4	066	2025-04-06 09:00:00	21.54
8277	Q13	ЗУ	SM 5	067	2025-04-06 09:00:00	0
8278	Q14	ЗУ	SM 6	068	2025-04-06 09:00:00	4.12
8279	Q15	ЗУ	SM 7	069	2025-04-06 09:00:00	0
8280	Q16	ЗУ	SM 8	070	2025-04-06 09:00:00	0
8281	Q17	ЗУ	MO 9	071	2025-04-06 09:00:00	1.09
8282	Q20	ЗУ	MO 10	072	2025-04-06 09:00:00	2.65
8283	Q21	ЗУ	MO 11	073	2025-04-06 09:00:00	9.15
8284	Q22	ЗУ	MO 12	074	2025-04-06 09:00:00	29.84
8285	Q23	ЗУ	MO 13	075	2025-04-06 09:00:00	15.32
8286	Q24	ЗУ	MO 14	076	2025-04-06 09:00:00	19.81
8287	Q25	ЗУ	MO 15	077	2025-04-06 09:00:00	16.94
8288	TP3	ЗУ	CP-300 New	078	2025-04-06 09:00:00	61.13
8289	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 09:30:00	0
8290	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 09:30:00	0.0003
8291	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 09:30:00	0.0027
8292	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 09:30:00	0.0028
8293	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 09:30:00	0
8294	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 09:30:00	0
8295	QF 1,20	ЗУ	China 1	044	2025-04-06 09:30:00	27.87
8296	QF 1,21	ЗУ	China 2	045	2025-04-06 09:30:00	25.9
8297	QF 1,22	ЗУ	China 3	046	2025-04-06 09:30:00	28.3
8298	QF 2,20	ЗУ	China 4	047	2025-04-06 09:30:00	32.83
8299	QF 2,21	ЗУ	China 5	048	2025-04-06 09:30:00	37.19
8300	QF 2,22	ЗУ	China 6	049	2025-04-06 09:30:00	35.13
8301	QF 2,23	ЗУ	China 7	050	2025-04-06 09:30:00	16.72
8302	QF 2,19	ЗУ	China 8	051	2025-04-06 09:30:00	26.96
8303	Q8	ЗУ	DIG	061	2025-04-06 09:30:00	66.85
8304	Q4	ЗУ	BG 1	062	2025-04-06 09:30:00	17.58
8305	Q9	ЗУ	BG 2	063	2025-04-06 09:30:00	20.1
8306	Q10	ЗУ	SM 2	064	2025-04-06 09:30:00	32.18
8307	Q11	ЗУ	SM 3	065	2025-04-06 09:30:00	19.66
8308	Q12	ЗУ	SM 4	066	2025-04-06 09:30:00	21.49
8309	Q13	ЗУ	SM 5	067	2025-04-06 09:30:00	0
8310	Q14	ЗУ	SM 6	068	2025-04-06 09:30:00	5.52
8311	Q15	ЗУ	SM 7	069	2025-04-06 09:30:00	0
8312	Q16	ЗУ	SM 8	070	2025-04-06 09:30:00	0
8313	Q17	ЗУ	MO 9	071	2025-04-06 09:30:00	1.09
8314	Q20	ЗУ	MO 10	072	2025-04-06 09:30:00	2.69
8315	Q21	ЗУ	MO 11	073	2025-04-06 09:30:00	9.2
8316	Q22	ЗУ	MO 12	074	2025-04-06 09:30:00	29.81
8317	Q23	ЗУ	MO 13	075	2025-04-06 09:30:00	16.96
8318	Q24	ЗУ	MO 14	076	2025-04-06 09:30:00	19.81
8319	Q25	ЗУ	MO 15	077	2025-04-06 09:30:00	16.91
8320	TP3	ЗУ	CP-300 New	078	2025-04-06 09:30:00	71.59
8321	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 10:00:00	0
8322	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 10:00:00	0.0006
8323	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 10:00:00	0.0029
8324	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 10:00:00	0.0031
8325	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 10:00:00	0
8326	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 10:00:00	0
8327	QF 1,20	ЗУ	China 1	044	2025-04-06 10:00:00	27.82
8328	QF 1,21	ЗУ	China 2	045	2025-04-06 10:00:00	26.07
8329	QF 1,22	ЗУ	China 3	046	2025-04-06 10:00:00	28.56
8330	QF 2,20	ЗУ	China 4	047	2025-04-06 10:00:00	33.59
8331	QF 2,21	ЗУ	China 5	048	2025-04-06 10:00:00	37.12
8332	QF 2,22	ЗУ	China 6	049	2025-04-06 10:00:00	34.84
8333	QF 2,23	ЗУ	China 7	050	2025-04-06 10:00:00	16.87
8334	QF 2,19	ЗУ	China 8	051	2025-04-06 10:00:00	27.06
8335	Q8	ЗУ	DIG	061	2025-04-06 10:00:00	55.09
8336	Q4	ЗУ	BG 1	062	2025-04-06 10:00:00	17.56
8337	Q9	ЗУ	BG 2	063	2025-04-06 10:00:00	20.11
8338	Q10	ЗУ	SM 2	064	2025-04-06 10:00:00	32.15
8339	Q11	ЗУ	SM 3	065	2025-04-06 10:00:00	19.63
8340	Q12	ЗУ	SM 4	066	2025-04-06 10:00:00	21.52
8341	Q13	ЗУ	SM 5	067	2025-04-06 10:00:00	0
8342	Q14	ЗУ	SM 6	068	2025-04-06 10:00:00	5.46
8343	Q15	ЗУ	SM 7	069	2025-04-06 10:00:00	0
8344	Q16	ЗУ	SM 8	070	2025-04-06 10:00:00	0
8345	Q17	ЗУ	MO 9	071	2025-04-06 10:00:00	1.08
8346	Q20	ЗУ	MO 10	072	2025-04-06 10:00:00	2.67
8347	Q21	ЗУ	MO 11	073	2025-04-06 10:00:00	9.18
8348	Q22	ЗУ	MO 12	074	2025-04-06 10:00:00	29.76
8349	Q23	ЗУ	MO 13	075	2025-04-06 10:00:00	16.92
8350	Q24	ЗУ	MO 14	076	2025-04-06 10:00:00	19.82
8351	Q25	ЗУ	MO 15	077	2025-04-06 10:00:00	16.85
8352	TP3	ЗУ	CP-300 New	078	2025-04-06 10:00:00	76.15
8353	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 10:30:00	0
8354	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 10:30:00	0.0009
8355	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 10:30:00	0.0027
8356	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 10:30:00	0.0029
8357	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 10:30:00	0
8358	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 10:30:00	0
8359	QF 1,20	ЗУ	China 1	044	2025-04-06 10:30:00	27.46
8360	QF 1,21	ЗУ	China 2	045	2025-04-06 10:30:00	26.03
8361	QF 1,22	ЗУ	China 3	046	2025-04-06 10:30:00	28.66
8362	QF 2,20	ЗУ	China 4	047	2025-04-06 10:30:00	32.37
8363	QF 2,21	ЗУ	China 5	048	2025-04-06 10:30:00	36.94
8364	QF 2,22	ЗУ	China 6	049	2025-04-06 10:30:00	34.91
8365	QF 2,23	ЗУ	China 7	050	2025-04-06 10:30:00	16.55
8366	QF 2,19	ЗУ	China 8	051	2025-04-06 10:30:00	26.65
8367	Q8	ЗУ	DIG	061	2025-04-06 10:30:00	62.78
8368	Q4	ЗУ	BG 1	062	2025-04-06 10:30:00	17.61
8369	Q9	ЗУ	BG 2	063	2025-04-06 10:30:00	20.08
8370	Q10	ЗУ	SM 2	064	2025-04-06 10:30:00	32.21
8371	Q11	ЗУ	SM 3	065	2025-04-06 10:30:00	19.63
8372	Q12	ЗУ	SM 4	066	2025-04-06 10:30:00	21.49
8373	Q13	ЗУ	SM 5	067	2025-04-06 10:30:00	0
8374	Q14	ЗУ	SM 6	068	2025-04-06 10:30:00	5.48
8375	Q15	ЗУ	SM 7	069	2025-04-06 10:30:00	0
8376	Q16	ЗУ	SM 8	070	2025-04-06 10:30:00	0
8377	Q17	ЗУ	MO 9	071	2025-04-06 10:30:00	1.08
8378	Q20	ЗУ	MO 10	072	2025-04-06 10:30:00	2.67
8379	Q21	ЗУ	MO 11	073	2025-04-06 10:30:00	9.19
8380	Q22	ЗУ	MO 12	074	2025-04-06 10:30:00	29.8
8381	Q23	ЗУ	MO 13	075	2025-04-06 10:30:00	16.88
8382	Q24	ЗУ	MO 14	076	2025-04-06 10:30:00	19.85
8383	Q25	ЗУ	MO 15	077	2025-04-06 10:30:00	16.87
8384	TP3	ЗУ	CP-300 New	078	2025-04-06 10:30:00	82.78
8385	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 11:00:00	0
8386	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 11:00:00	0.0005
8387	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 11:00:00	0.0028
8388	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 11:00:00	0.0028
8389	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 11:00:00	0
8390	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 11:00:00	0
8391	QF 1,20	ЗУ	China 1	044	2025-04-06 11:00:00	27.12
8392	QF 1,21	ЗУ	China 2	045	2025-04-06 11:00:00	25.89
8393	QF 1,22	ЗУ	China 3	046	2025-04-06 11:00:00	28.36
8394	QF 2,20	ЗУ	China 4	047	2025-04-06 11:00:00	32.35
8395	QF 2,21	ЗУ	China 5	048	2025-04-06 11:00:00	36.77
8396	QF 2,22	ЗУ	China 6	049	2025-04-06 11:00:00	34.39
8397	QF 2,23	ЗУ	China 7	050	2025-04-06 11:00:00	16.55
8398	QF 2,19	ЗУ	China 8	051	2025-04-06 11:00:00	27.22
8399	Q8	ЗУ	DIG	061	2025-04-06 11:00:00	56.13
8400	Q4	ЗУ	BG 1	062	2025-04-06 11:00:00	17.64
8401	Q9	ЗУ	BG 2	063	2025-04-06 11:00:00	20.05
8402	Q10	ЗУ	SM 2	064	2025-04-06 11:00:00	32.21
8403	Q11	ЗУ	SM 3	065	2025-04-06 11:00:00	19.64
8404	Q12	ЗУ	SM 4	066	2025-04-06 11:00:00	21.45
8405	Q13	ЗУ	SM 5	067	2025-04-06 11:00:00	0
8406	Q14	ЗУ	SM 6	068	2025-04-06 11:00:00	5.5
8407	Q15	ЗУ	SM 7	069	2025-04-06 11:00:00	0
8408	Q16	ЗУ	SM 8	070	2025-04-06 11:00:00	0
8409	Q17	ЗУ	MO 9	071	2025-04-06 11:00:00	1.09
8410	Q20	ЗУ	MO 10	072	2025-04-06 11:00:00	2.69
8411	Q21	ЗУ	MO 11	073	2025-04-06 11:00:00	9.19
8412	Q22	ЗУ	MO 12	074	2025-04-06 11:00:00	29.89
8413	Q23	ЗУ	MO 13	075	2025-04-06 11:00:00	16.9
8414	Q24	ЗУ	MO 14	076	2025-04-06 11:00:00	19.82
8415	Q25	ЗУ	MO 15	077	2025-04-06 11:00:00	16.91
8416	TP3	ЗУ	CP-300 New	078	2025-04-06 11:00:00	83.45
8417	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 11:30:00	0
8418	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 11:30:00	0.0012
8419	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 11:30:00	0.0028
8420	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 11:30:00	0.0028
8421	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 11:30:00	0
8422	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 11:30:00	0
8423	QF 1,20	ЗУ	China 1	044	2025-04-06 11:30:00	26.11
8424	QF 1,21	ЗУ	China 2	045	2025-04-06 11:30:00	24.59
8425	QF 1,22	ЗУ	China 3	046	2025-04-06 11:30:00	27.35
8426	QF 2,20	ЗУ	China 4	047	2025-04-06 11:30:00	31.32
8427	QF 2,21	ЗУ	China 5	048	2025-04-06 11:30:00	35.24
8428	QF 2,22	ЗУ	China 6	049	2025-04-06 11:30:00	32.3
8429	QF 2,23	ЗУ	China 7	050	2025-04-06 11:30:00	15.78
8430	QF 2,19	ЗУ	China 8	051	2025-04-06 11:30:00	25.68
8431	Q8	ЗУ	DIG	061	2025-04-06 11:30:00	58.27
8432	Q4	ЗУ	BG 1	062	2025-04-06 11:30:00	17.63
8433	Q9	ЗУ	BG 2	063	2025-04-06 11:30:00	20.02
8434	Q10	ЗУ	SM 2	064	2025-04-06 11:30:00	32.22
8435	Q11	ЗУ	SM 3	065	2025-04-06 11:30:00	19.58
8436	Q12	ЗУ	SM 4	066	2025-04-06 11:30:00	21.45
8437	Q13	ЗУ	SM 5	067	2025-04-06 11:30:00	0
8438	Q14	ЗУ	SM 6	068	2025-04-06 11:30:00	5.5
8439	Q15	ЗУ	SM 7	069	2025-04-06 11:30:00	0
8440	Q16	ЗУ	SM 8	070	2025-04-06 11:30:00	0
8441	Q17	ЗУ	MO 9	071	2025-04-06 11:30:00	1.1
8442	Q20	ЗУ	MO 10	072	2025-04-06 11:30:00	2.68
8443	Q21	ЗУ	MO 11	073	2025-04-06 11:30:00	9.21
8444	Q22	ЗУ	MO 12	074	2025-04-06 11:30:00	29.9
8445	Q23	ЗУ	MO 13	075	2025-04-06 11:30:00	16.89
8446	Q24	ЗУ	MO 14	076	2025-04-06 11:30:00	19.81
8447	Q25	ЗУ	MO 15	077	2025-04-06 11:30:00	16.88
8448	TP3	ЗУ	CP-300 New	078	2025-04-06 11:30:00	90.29
8449	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 12:00:00	0
8450	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 12:00:00	0.0014
8451	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 12:00:00	0.0026
8452	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 12:00:00	0.0034
8453	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 12:00:00	0
8454	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 12:00:00	0
8455	QF 1,20	ЗУ	China 1	044	2025-04-06 12:00:00	24.85
8456	QF 1,21	ЗУ	China 2	045	2025-04-06 12:00:00	23.31
8457	QF 1,22	ЗУ	China 3	046	2025-04-06 12:00:00	25.93
8458	QF 2,20	ЗУ	China 4	047	2025-04-06 12:00:00	30.13
8459	QF 2,21	ЗУ	China 5	048	2025-04-06 12:00:00	34.11
8460	QF 2,22	ЗУ	China 6	049	2025-04-06 12:00:00	31.88
8461	QF 2,23	ЗУ	China 7	050	2025-04-06 12:00:00	15.18
8462	QF 2,19	ЗУ	China 8	051	2025-04-06 12:00:00	24.47
8463	Q8	ЗУ	DIG	061	2025-04-06 12:00:00	59.62
8464	Q4	ЗУ	BG 1	062	2025-04-06 12:00:00	17.67
8465	Q9	ЗУ	BG 2	063	2025-04-06 12:00:00	20
8466	Q10	ЗУ	SM 2	064	2025-04-06 12:00:00	32.23
8467	Q11	ЗУ	SM 3	065	2025-04-06 12:00:00	19.63
8468	Q12	ЗУ	SM 4	066	2025-04-06 12:00:00	21.43
8469	Q13	ЗУ	SM 5	067	2025-04-06 12:00:00	0
8470	Q14	ЗУ	SM 6	068	2025-04-06 12:00:00	5.52
8471	Q15	ЗУ	SM 7	069	2025-04-06 12:00:00	0
8472	Q16	ЗУ	SM 8	070	2025-04-06 12:00:00	0
8473	Q17	ЗУ	MO 9	071	2025-04-06 12:00:00	1.1
8474	Q20	ЗУ	MO 10	072	2025-04-06 12:00:00	2.69
8475	Q21	ЗУ	MO 11	073	2025-04-06 12:00:00	9.18
8476	Q22	ЗУ	MO 12	074	2025-04-06 12:00:00	29.92
8477	Q23	ЗУ	MO 13	075	2025-04-06 12:00:00	16.91
8478	Q24	ЗУ	MO 14	076	2025-04-06 12:00:00	19.84
8479	Q25	ЗУ	MO 15	077	2025-04-06 12:00:00	16.86
8480	TP3	ЗУ	CP-300 New	078	2025-04-06 12:00:00	86.52
8481	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 12:30:00	0
8482	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 12:30:00	0.0005
8483	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 12:30:00	0.0026
8484	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 12:30:00	0.003
8485	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 12:30:00	0
8486	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 12:30:00	0
8487	QF 1,20	ЗУ	China 1	044	2025-04-06 12:30:00	21.4
8488	QF 1,21	ЗУ	China 2	045	2025-04-06 12:30:00	19.72
8489	QF 1,22	ЗУ	China 3	046	2025-04-06 12:30:00	22.49
8490	QF 2,20	ЗУ	China 4	047	2025-04-06 12:30:00	26.45
8491	QF 2,21	ЗУ	China 5	048	2025-04-06 12:30:00	29.32
8492	QF 2,22	ЗУ	China 6	049	2025-04-06 12:30:00	28.33
8493	QF 2,23	ЗУ	China 7	050	2025-04-06 12:30:00	13.27
8494	QF 2,19	ЗУ	China 8	051	2025-04-06 12:30:00	20.93
8495	Q8	ЗУ	DIG	061	2025-04-06 12:30:00	58.78
8496	Q4	ЗУ	BG 1	062	2025-04-06 12:30:00	17.7
8497	Q9	ЗУ	BG 2	063	2025-04-06 12:30:00	19.96
8498	Q10	ЗУ	SM 2	064	2025-04-06 12:30:00	32.13
8499	Q11	ЗУ	SM 3	065	2025-04-06 12:30:00	19.59
8500	Q12	ЗУ	SM 4	066	2025-04-06 12:30:00	21.44
8501	Q13	ЗУ	SM 5	067	2025-04-06 12:30:00	0
8502	Q14	ЗУ	SM 6	068	2025-04-06 12:30:00	5.51
8503	Q15	ЗУ	SM 7	069	2025-04-06 12:30:00	0
8504	Q16	ЗУ	SM 8	070	2025-04-06 12:30:00	0
8505	Q17	ЗУ	MO 9	071	2025-04-06 12:30:00	1.09
8506	Q20	ЗУ	MO 10	072	2025-04-06 12:30:00	2.68
8507	Q21	ЗУ	MO 11	073	2025-04-06 12:30:00	9.18
8508	Q22	ЗУ	MO 12	074	2025-04-06 12:30:00	29.87
8509	Q23	ЗУ	MO 13	075	2025-04-06 12:30:00	16.9
8510	Q24	ЗУ	MO 14	076	2025-04-06 12:30:00	19.82
8511	Q25	ЗУ	MO 15	077	2025-04-06 12:30:00	16.87
8512	TP3	ЗУ	CP-300 New	078	2025-04-06 12:30:00	92.74
8513	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 13:00:00	0
8514	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 13:00:00	0.0001
8515	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 13:00:00	0.0026
8516	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 13:00:00	0.0028
8517	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 13:00:00	0
8518	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 13:00:00	0
8519	QF 1,20	ЗУ	China 1	044	2025-04-06 13:00:00	21.45
8520	QF 1,21	ЗУ	China 2	045	2025-04-06 13:00:00	19.79
8521	QF 1,22	ЗУ	China 3	046	2025-04-06 13:00:00	22.95
8522	QF 2,20	ЗУ	China 4	047	2025-04-06 13:00:00	26.69
8523	QF 2,21	ЗУ	China 5	048	2025-04-06 13:00:00	30.21
8524	QF 2,22	ЗУ	China 6	049	2025-04-06 13:00:00	28.54
8525	QF 2,23	ЗУ	China 7	050	2025-04-06 13:00:00	13.48
8526	QF 2,19	ЗУ	China 8	051	2025-04-06 13:00:00	21.1
8527	Q8	ЗУ	DIG	061	2025-04-06 13:00:00	54.19
8528	Q4	ЗУ	BG 1	062	2025-04-06 13:00:00	17.7
8529	Q9	ЗУ	BG 2	063	2025-04-06 13:00:00	19.98
8530	Q10	ЗУ	SM 2	064	2025-04-06 13:00:00	32.17
8531	Q11	ЗУ	SM 3	065	2025-04-06 13:00:00	19.59
8532	Q12	ЗУ	SM 4	066	2025-04-06 13:00:00	21.53
8533	Q13	ЗУ	SM 5	067	2025-04-06 13:00:00	0
8534	Q14	ЗУ	SM 6	068	2025-04-06 13:00:00	5.51
8535	Q15	ЗУ	SM 7	069	2025-04-06 13:00:00	0
8536	Q16	ЗУ	SM 8	070	2025-04-06 13:00:00	0
8537	Q17	ЗУ	MO 9	071	2025-04-06 13:00:00	1.11
8538	Q20	ЗУ	MO 10	072	2025-04-06 13:00:00	2.68
8539	Q21	ЗУ	MO 11	073	2025-04-06 13:00:00	9.18
8540	Q22	ЗУ	MO 12	074	2025-04-06 13:00:00	29.96
8541	Q23	ЗУ	MO 13	075	2025-04-06 13:00:00	16.88
8542	Q24	ЗУ	MO 14	076	2025-04-06 13:00:00	19.86
8543	Q25	ЗУ	MO 15	077	2025-04-06 13:00:00	16.93
8544	TP3	ЗУ	CP-300 New	078	2025-04-06 13:00:00	91.28
8545	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 13:30:00	0
8546	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 13:30:00	0.0013
8547	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 13:30:00	0.0028
8548	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 13:30:00	0.0028
8549	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 13:30:00	0
8550	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 13:30:00	0
8551	QF 1,20	ЗУ	China 1	044	2025-04-06 13:30:00	18.13
8552	QF 1,21	ЗУ	China 2	045	2025-04-06 13:30:00	16.6
8553	QF 1,22	ЗУ	China 3	046	2025-04-06 13:30:00	19.41
8554	QF 2,20	ЗУ	China 4	047	2025-04-06 13:30:00	23.39
8555	QF 2,21	ЗУ	China 5	048	2025-04-06 13:30:00	27.12
8556	QF 2,22	ЗУ	China 6	049	2025-04-06 13:30:00	24.89
8557	QF 2,23	ЗУ	China 7	050	2025-04-06 13:30:00	11.77
8558	QF 2,19	ЗУ	China 8	051	2025-04-06 13:30:00	17.81
8559	Q8	ЗУ	DIG	061	2025-04-06 13:30:00	52.61
8560	Q4	ЗУ	BG 1	062	2025-04-06 13:30:00	17.72
8561	Q9	ЗУ	BG 2	063	2025-04-06 13:30:00	20.03
8562	Q10	ЗУ	SM 2	064	2025-04-06 13:30:00	32.2
8563	Q11	ЗУ	SM 3	065	2025-04-06 13:30:00	19.6
8564	Q12	ЗУ	SM 4	066	2025-04-06 13:30:00	21.46
8565	Q13	ЗУ	SM 5	067	2025-04-06 13:30:00	0
8566	Q14	ЗУ	SM 6	068	2025-04-06 13:30:00	5.49
8567	Q15	ЗУ	SM 7	069	2025-04-06 13:30:00	0
8568	Q16	ЗУ	SM 8	070	2025-04-06 13:30:00	0
8569	Q17	ЗУ	MO 9	071	2025-04-06 13:30:00	1.11
8570	Q20	ЗУ	MO 10	072	2025-04-06 13:30:00	2.69
8571	Q21	ЗУ	MO 11	073	2025-04-06 13:30:00	9.21
8572	Q22	ЗУ	MO 12	074	2025-04-06 13:30:00	29.98
8573	Q23	ЗУ	MO 13	075	2025-04-06 13:30:00	16.91
8574	Q24	ЗУ	MO 14	076	2025-04-06 13:30:00	19.83
8575	Q25	ЗУ	MO 15	077	2025-04-06 13:30:00	16.92
8576	TP3	ЗУ	CP-300 New	078	2025-04-06 13:30:00	101.17
8577	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 14:00:00	0
8578	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 14:00:00	0.0011
8579	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 14:00:00	0.0025
8580	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 14:00:00	0.0029
8581	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 14:00:00	0
8582	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 14:00:00	0
8583	QF 1,20	ЗУ	China 1	044	2025-04-06 14:00:00	16.72
8584	QF 1,21	ЗУ	China 2	045	2025-04-06 14:00:00	14.99
8585	QF 1,22	ЗУ	China 3	046	2025-04-06 14:00:00	17.76
8586	QF 2,20	ЗУ	China 4	047	2025-04-06 14:00:00	21.34
8587	QF 2,21	ЗУ	China 5	048	2025-04-06 14:00:00	25.3
8588	QF 2,22	ЗУ	China 6	049	2025-04-06 14:00:00	23.18
8589	QF 2,23	ЗУ	China 7	050	2025-04-06 14:00:00	10.85
8590	QF 2,19	ЗУ	China 8	051	2025-04-06 14:00:00	16.58
8591	Q8	ЗУ	DIG	061	2025-04-06 14:00:00	51.99
8592	Q4	ЗУ	BG 1	062	2025-04-06 14:00:00	17.68
8593	Q9	ЗУ	BG 2	063	2025-04-06 14:00:00	20.03
8594	Q10	ЗУ	SM 2	064	2025-04-06 14:00:00	32.19
8595	Q11	ЗУ	SM 3	065	2025-04-06 14:00:00	19.61
8596	Q12	ЗУ	SM 4	066	2025-04-06 14:00:00	21.51
8597	Q13	ЗУ	SM 5	067	2025-04-06 14:00:00	0
8598	Q14	ЗУ	SM 6	068	2025-04-06 14:00:00	5.49
8599	Q15	ЗУ	SM 7	069	2025-04-06 14:00:00	0
8600	Q16	ЗУ	SM 8	070	2025-04-06 14:00:00	0
8601	Q17	ЗУ	MO 9	071	2025-04-06 14:00:00	1.11
8602	Q20	ЗУ	MO 10	072	2025-04-06 14:00:00	2.67
8603	Q21	ЗУ	MO 11	073	2025-04-06 14:00:00	9.21
8604	Q22	ЗУ	MO 12	074	2025-04-06 14:00:00	29.94
8605	Q23	ЗУ	MO 13	075	2025-04-06 14:00:00	16.91
8606	Q24	ЗУ	MO 14	076	2025-04-06 14:00:00	19.83
8607	Q25	ЗУ	MO 15	077	2025-04-06 14:00:00	16.88
8608	TP3	ЗУ	CP-300 New	078	2025-04-06 14:00:00	94.31
8609	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 14:30:00	0
8610	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 14:30:00	0.0009
8611	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 14:30:00	0.0028
8612	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 14:30:00	0.0032
8613	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 14:30:00	0
8614	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 14:30:00	0
8615	QF 1,20	ЗУ	China 1	044	2025-04-06 14:30:00	18.08
8616	QF 1,21	ЗУ	China 2	045	2025-04-06 14:30:00	15.86
8617	QF 1,22	ЗУ	China 3	046	2025-04-06 14:30:00	18.82
8618	QF 2,20	ЗУ	China 4	047	2025-04-06 14:30:00	21.83
8619	QF 2,21	ЗУ	China 5	048	2025-04-06 14:30:00	26.14
8620	QF 2,22	ЗУ	China 6	049	2025-04-06 14:30:00	24.58
8621	QF 2,23	ЗУ	China 7	050	2025-04-06 14:30:00	11.45
8622	QF 2,19	ЗУ	China 8	051	2025-04-06 14:30:00	17.64
8623	Q8	ЗУ	DIG	061	2025-04-06 14:30:00	50.07
8624	Q4	ЗУ	BG 1	062	2025-04-06 14:30:00	17.69
8625	Q9	ЗУ	BG 2	063	2025-04-06 14:30:00	20.02
8626	Q10	ЗУ	SM 2	064	2025-04-06 14:30:00	32.21
8627	Q11	ЗУ	SM 3	065	2025-04-06 14:30:00	19.61
8628	Q12	ЗУ	SM 4	066	2025-04-06 14:30:00	21.67
8629	Q13	ЗУ	SM 5	067	2025-04-06 14:30:00	0
8630	Q14	ЗУ	SM 6	068	2025-04-06 14:30:00	5.47
8631	Q15	ЗУ	SM 7	069	2025-04-06 14:30:00	0
8632	Q16	ЗУ	SM 8	070	2025-04-06 14:30:00	0
8633	Q17	ЗУ	MO 9	071	2025-04-06 14:30:00	1.11
8634	Q20	ЗУ	MO 10	072	2025-04-06 14:30:00	2.68
8635	Q21	ЗУ	MO 11	073	2025-04-06 14:30:00	9.22
8636	Q22	ЗУ	MO 12	074	2025-04-06 14:30:00	29.94
8637	Q23	ЗУ	MO 13	075	2025-04-06 14:30:00	16.87
8638	Q24	ЗУ	MO 14	076	2025-04-06 14:30:00	19.87
8639	Q25	ЗУ	MO 15	077	2025-04-06 14:30:00	16.89
8640	TP3	ЗУ	CP-300 New	078	2025-04-06 14:30:00	99.17
8641	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 15:00:00	0
8642	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 15:00:00	0.0013
8643	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 15:00:00	0.0026
8644	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 15:00:00	0.0029
8645	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 15:00:00	0
8646	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 15:00:00	0
8647	QF 1,20	ЗУ	China 1	044	2025-04-06 15:00:00	17.61
8648	QF 1,21	ЗУ	China 2	045	2025-04-06 15:00:00	16.06
8649	QF 1,22	ЗУ	China 3	046	2025-04-06 15:00:00	18.81
8650	QF 2,20	ЗУ	China 4	047	2025-04-06 15:00:00	21.95
8651	QF 2,21	ЗУ	China 5	048	2025-04-06 15:00:00	25.79
8652	QF 2,22	ЗУ	China 6	049	2025-04-06 15:00:00	24.07
8653	QF 2,23	ЗУ	China 7	050	2025-04-06 15:00:00	11.21
8654	QF 2,19	ЗУ	China 8	051	2025-04-06 15:00:00	17.96
8655	Q8	ЗУ	DIG	061	2025-04-06 15:00:00	49.71
8656	Q4	ЗУ	BG 1	062	2025-04-06 15:00:00	17.7
8657	Q9	ЗУ	BG 2	063	2025-04-06 15:00:00	20.01
8658	Q10	ЗУ	SM 2	064	2025-04-06 15:00:00	32.23
8659	Q11	ЗУ	SM 3	065	2025-04-06 15:00:00	19.56
8660	Q12	ЗУ	SM 4	066	2025-04-06 15:00:00	22.01
8661	Q13	ЗУ	SM 5	067	2025-04-06 15:00:00	0
8662	Q14	ЗУ	SM 6	068	2025-04-06 15:00:00	5.47
8663	Q15	ЗУ	SM 7	069	2025-04-06 15:00:00	0
8664	Q16	ЗУ	SM 8	070	2025-04-06 15:00:00	0
8665	Q17	ЗУ	MO 9	071	2025-04-06 15:00:00	1.12
8666	Q20	ЗУ	MO 10	072	2025-04-06 15:00:00	2.67
8667	Q21	ЗУ	MO 11	073	2025-04-06 15:00:00	9.24
8668	Q22	ЗУ	MO 12	074	2025-04-06 15:00:00	29.97
8669	Q23	ЗУ	MO 13	075	2025-04-06 15:00:00	16.94
8670	Q24	ЗУ	MO 14	076	2025-04-06 15:00:00	19.87
8671	Q25	ЗУ	MO 15	077	2025-04-06 15:00:00	16.9
8672	TP3	ЗУ	CP-300 New	078	2025-04-06 15:00:00	96.6
8673	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 15:30:00	0
8674	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 15:30:00	0.0014
8675	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 15:30:00	0.0027
8676	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 15:30:00	0.0033
8677	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 15:30:00	0
8678	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 15:30:00	0
8679	QF 1,20	ЗУ	China 1	044	2025-04-06 15:30:00	15.17
8680	QF 1,21	ЗУ	China 2	045	2025-04-06 15:30:00	13.74
8681	QF 1,22	ЗУ	China 3	046	2025-04-06 15:30:00	16.63
8682	QF 2,20	ЗУ	China 4	047	2025-04-06 15:30:00	19.39
8683	QF 2,21	ЗУ	China 5	048	2025-04-06 15:30:00	22.92
8684	QF 2,22	ЗУ	China 6	049	2025-04-06 15:30:00	21.21
8685	QF 2,23	ЗУ	China 7	050	2025-04-06 15:30:00	9.49
8686	QF 2,19	ЗУ	China 8	051	2025-04-06 15:30:00	15.68
8687	Q8	ЗУ	DIG	061	2025-04-06 15:30:00	49.49
8688	Q4	ЗУ	BG 1	062	2025-04-06 15:30:00	17.73
8689	Q9	ЗУ	BG 2	063	2025-04-06 15:30:00	20.04
8690	Q10	ЗУ	SM 2	064	2025-04-06 15:30:00	32.17
8691	Q11	ЗУ	SM 3	065	2025-04-06 15:30:00	19.54
8692	Q12	ЗУ	SM 4	066	2025-04-06 15:30:00	22.04
8693	Q13	ЗУ	SM 5	067	2025-04-06 15:30:00	0
8694	Q14	ЗУ	SM 6	068	2025-04-06 15:30:00	5.47
8695	Q15	ЗУ	SM 7	069	2025-04-06 15:30:00	0
8696	Q16	ЗУ	SM 8	070	2025-04-06 15:30:00	0
8697	Q17	ЗУ	MO 9	071	2025-04-06 15:30:00	1.12
8698	Q20	ЗУ	MO 10	072	2025-04-06 15:30:00	2.68
8699	Q21	ЗУ	MO 11	073	2025-04-06 15:30:00	9.21
8700	Q22	ЗУ	MO 12	074	2025-04-06 15:30:00	29.98
8701	Q23	ЗУ	MO 13	075	2025-04-06 15:30:00	16.94
8702	Q24	ЗУ	MO 14	076	2025-04-06 15:30:00	19.88
8703	Q25	ЗУ	MO 15	077	2025-04-06 15:30:00	16.9
8704	TP3	ЗУ	CP-300 New	078	2025-04-06 15:30:00	94.85
8705	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 16:00:00	0
8706	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 16:00:00	0.0009
8707	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 16:00:00	0.0029
8708	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 16:00:00	0.003
8709	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 16:00:00	0
8710	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 16:00:00	0
8711	QF 1,20	ЗУ	China 1	044	2025-04-06 16:00:00	13.67
8712	QF 1,21	ЗУ	China 2	045	2025-04-06 16:00:00	12.49
8713	QF 1,22	ЗУ	China 3	046	2025-04-06 16:00:00	15.64
8714	QF 2,20	ЗУ	China 4	047	2025-04-06 16:00:00	18.55
8715	QF 2,21	ЗУ	China 5	048	2025-04-06 16:00:00	22.2
8716	QF 2,22	ЗУ	China 6	049	2025-04-06 16:00:00	20.3
8717	QF 2,23	ЗУ	China 7	050	2025-04-06 16:00:00	9
8718	QF 2,19	ЗУ	China 8	051	2025-04-06 16:00:00	14.86
8719	Q8	ЗУ	DIG	061	2025-04-06 16:00:00	51.22
8720	Q4	ЗУ	BG 1	062	2025-04-06 16:00:00	17.68
8721	Q9	ЗУ	BG 2	063	2025-04-06 16:00:00	20.02
8722	Q10	ЗУ	SM 2	064	2025-04-06 16:00:00	32.19
8723	Q11	ЗУ	SM 3	065	2025-04-06 16:00:00	19.51
8724	Q12	ЗУ	SM 4	066	2025-04-06 16:00:00	21.6
8725	Q13	ЗУ	SM 5	067	2025-04-06 16:00:00	0
8726	Q14	ЗУ	SM 6	068	2025-04-06 16:00:00	5.45
8727	Q15	ЗУ	SM 7	069	2025-04-06 16:00:00	0
8728	Q16	ЗУ	SM 8	070	2025-04-06 16:00:00	0
8729	Q17	ЗУ	MO 9	071	2025-04-06 16:00:00	1.11
8730	Q20	ЗУ	MO 10	072	2025-04-06 16:00:00	2.68
8731	Q21	ЗУ	MO 11	073	2025-04-06 16:00:00	9.18
8732	Q22	ЗУ	MO 12	074	2025-04-06 16:00:00	29.95
8733	Q23	ЗУ	MO 13	075	2025-04-06 16:00:00	16.9
8734	Q24	ЗУ	MO 14	076	2025-04-06 16:00:00	19.91
8735	Q25	ЗУ	MO 15	077	2025-04-06 16:00:00	16.82
8736	TP3	ЗУ	CP-300 New	078	2025-04-06 16:00:00	90.84
8737	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 16:30:00	0
8738	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 16:30:00	0.0008
8739	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 16:30:00	0.0025
8740	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 16:30:00	0.003
8741	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 16:30:00	0
8742	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 16:30:00	0
8743	QF 1,20	ЗУ	China 1	044	2025-04-06 16:30:00	11.95
8744	QF 1,21	ЗУ	China 2	045	2025-04-06 16:30:00	10.78
8745	QF 1,22	ЗУ	China 3	046	2025-04-06 16:30:00	14.15
8746	QF 2,20	ЗУ	China 4	047	2025-04-06 16:30:00	17.2
8747	QF 2,21	ЗУ	China 5	048	2025-04-06 16:30:00	20.88
8748	QF 2,22	ЗУ	China 6	049	2025-04-06 16:30:00	19.08
8749	QF 2,23	ЗУ	China 7	050	2025-04-06 16:30:00	8.29
8750	QF 2,19	ЗУ	China 8	051	2025-04-06 16:30:00	13.49
8751	Q8	ЗУ	DIG	061	2025-04-06 16:30:00	41.75
8752	Q4	ЗУ	BG 1	062	2025-04-06 16:30:00	17.67
8753	Q9	ЗУ	BG 2	063	2025-04-06 16:30:00	20.09
8754	Q10	ЗУ	SM 2	064	2025-04-06 16:30:00	32.2
8755	Q11	ЗУ	SM 3	065	2025-04-06 16:30:00	19.33
8756	Q12	ЗУ	SM 4	066	2025-04-06 16:30:00	22.09
8757	Q13	ЗУ	SM 5	067	2025-04-06 16:30:00	0
8758	Q14	ЗУ	SM 6	068	2025-04-06 16:30:00	5.45
8759	Q15	ЗУ	SM 7	069	2025-04-06 16:30:00	0
8760	Q16	ЗУ	SM 8	070	2025-04-06 16:30:00	0
8761	Q17	ЗУ	MO 9	071	2025-04-06 16:30:00	1.1
8762	Q20	ЗУ	MO 10	072	2025-04-06 16:30:00	2.69
8763	Q21	ЗУ	MO 11	073	2025-04-06 16:30:00	9.22
8764	Q22	ЗУ	MO 12	074	2025-04-06 16:30:00	29.98
8765	Q23	ЗУ	MO 13	075	2025-04-06 16:30:00	16.9
8766	Q24	ЗУ	MO 14	076	2025-04-06 16:30:00	19.96
8767	Q25	ЗУ	MO 15	077	2025-04-06 16:30:00	16.88
8768	TP3	ЗУ	CP-300 New	078	2025-04-06 16:30:00	91.08
8769	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 17:00:00	0
8770	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 17:00:00	0.0009
8771	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 17:00:00	0.0028
8772	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 17:00:00	0.0028
8773	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 17:00:00	0
8774	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 17:00:00	0
8775	QF 1,20	ЗУ	China 1	044	2025-04-06 17:00:00	11.72
8776	QF 1,21	ЗУ	China 2	045	2025-04-06 17:00:00	10.6
8777	QF 1,22	ЗУ	China 3	046	2025-04-06 17:00:00	14.32
8778	QF 2,20	ЗУ	China 4	047	2025-04-06 17:00:00	17.39
8779	QF 2,21	ЗУ	China 5	048	2025-04-06 17:00:00	21.21
8780	QF 2,22	ЗУ	China 6	049	2025-04-06 17:00:00	19.29
8781	QF 2,23	ЗУ	China 7	050	2025-04-06 17:00:00	8.34
8782	QF 2,19	ЗУ	China 8	051	2025-04-06 17:00:00	13.48
8783	Q8	ЗУ	DIG	061	2025-04-06 17:00:00	37.14
8784	Q4	ЗУ	BG 1	062	2025-04-06 17:00:00	17.67
8785	Q9	ЗУ	BG 2	063	2025-04-06 17:00:00	20.1
8786	Q10	ЗУ	SM 2	064	2025-04-06 17:00:00	32.18
8787	Q11	ЗУ	SM 3	065	2025-04-06 17:00:00	19.34
8788	Q12	ЗУ	SM 4	066	2025-04-06 17:00:00	22.05
8789	Q13	ЗУ	SM 5	067	2025-04-06 17:00:00	0
8790	Q14	ЗУ	SM 6	068	2025-04-06 17:00:00	5.45
8791	Q15	ЗУ	SM 7	069	2025-04-06 17:00:00	0
8792	Q16	ЗУ	SM 8	070	2025-04-06 17:00:00	0
8793	Q17	ЗУ	MO 9	071	2025-04-06 17:00:00	1.11
8794	Q20	ЗУ	MO 10	072	2025-04-06 17:00:00	2.68
8795	Q21	ЗУ	MO 11	073	2025-04-06 17:00:00	9.22
8796	Q22	ЗУ	MO 12	074	2025-04-06 17:00:00	30.03
8797	Q23	ЗУ	MO 13	075	2025-04-06 17:00:00	16.89
8798	Q24	ЗУ	MO 14	076	2025-04-06 17:00:00	19.94
8799	Q25	ЗУ	MO 15	077	2025-04-06 17:00:00	16.89
8800	TP3	ЗУ	CP-300 New	078	2025-04-06 17:00:00	93.51
8801	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 17:30:00	0
8802	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 17:30:00	0.0017
8803	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 17:30:00	0.0027
8804	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 17:30:00	0.0029
8805	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 17:30:00	0
8806	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 17:30:00	0
8807	QF 1,20	ЗУ	China 1	044	2025-04-06 17:30:00	11.29
8808	QF 1,21	ЗУ	China 2	045	2025-04-06 17:30:00	10.29
8809	QF 1,22	ЗУ	China 3	046	2025-04-06 17:30:00	13.78
8810	QF 2,20	ЗУ	China 4	047	2025-04-06 17:30:00	17.84
8811	QF 2,21	ЗУ	China 5	048	2025-04-06 17:30:00	21
8812	QF 2,22	ЗУ	China 6	049	2025-04-06 17:30:00	19.3
8813	QF 2,23	ЗУ	China 7	050	2025-04-06 17:30:00	8.33
8814	QF 2,19	ЗУ	China 8	051	2025-04-06 17:30:00	12.93
8815	Q8	ЗУ	DIG	061	2025-04-06 17:30:00	30.34
8816	Q4	ЗУ	BG 1	062	2025-04-06 17:30:00	17.68
8817	Q9	ЗУ	BG 2	063	2025-04-06 17:30:00	20.11
8818	Q10	ЗУ	SM 2	064	2025-04-06 17:30:00	32.21
8819	Q11	ЗУ	SM 3	065	2025-04-06 17:30:00	19.41
8820	Q12	ЗУ	SM 4	066	2025-04-06 17:30:00	21.79
8821	Q13	ЗУ	SM 5	067	2025-04-06 17:30:00	0
8822	Q14	ЗУ	SM 6	068	2025-04-06 17:30:00	5.46
8823	Q15	ЗУ	SM 7	069	2025-04-06 17:30:00	0
8824	Q16	ЗУ	SM 8	070	2025-04-06 17:30:00	0
8825	Q17	ЗУ	MO 9	071	2025-04-06 17:30:00	1.12
8826	Q20	ЗУ	MO 10	072	2025-04-06 17:30:00	2.68
8827	Q21	ЗУ	MO 11	073	2025-04-06 17:30:00	9.24
8828	Q22	ЗУ	MO 12	074	2025-04-06 17:30:00	30.06
8829	Q23	ЗУ	MO 13	075	2025-04-06 17:30:00	16.92
8830	Q24	ЗУ	MO 14	076	2025-04-06 17:30:00	19.96
8831	Q25	ЗУ	MO 15	077	2025-04-06 17:30:00	16.95
8832	TP3	ЗУ	CP-300 New	078	2025-04-06 17:30:00	92.33
8833	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 18:00:00	0
8834	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 18:00:00	0.0009
8835	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 18:00:00	0.0029
8836	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 18:00:00	0.0033
8837	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 18:00:00	0
8838	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 18:00:00	0
8839	QF 1,20	ЗУ	China 1	044	2025-04-06 18:00:00	11.17
8840	QF 1,21	ЗУ	China 2	045	2025-04-06 18:00:00	10.09
8841	QF 1,22	ЗУ	China 3	046	2025-04-06 18:00:00	13.44
8842	QF 2,20	ЗУ	China 4	047	2025-04-06 18:00:00	18.09
8843	QF 2,21	ЗУ	China 5	048	2025-04-06 18:00:00	21.29
8844	QF 2,22	ЗУ	China 6	049	2025-04-06 18:00:00	19.28
8845	QF 2,23	ЗУ	China 7	050	2025-04-06 18:00:00	8.34
8846	QF 2,19	ЗУ	China 8	051	2025-04-06 18:00:00	12.7
8847	Q8	ЗУ	DIG	061	2025-04-06 18:00:00	30.59
8848	Q4	ЗУ	BG 1	062	2025-04-06 18:00:00	17.7
8849	Q9	ЗУ	BG 2	063	2025-04-06 18:00:00	20.09
8850	Q10	ЗУ	SM 2	064	2025-04-06 18:00:00	32.19
8851	Q11	ЗУ	SM 3	065	2025-04-06 18:00:00	19.4
8852	Q12	ЗУ	SM 4	066	2025-04-06 18:00:00	21.7
8853	Q13	ЗУ	SM 5	067	2025-04-06 18:00:00	0
8854	Q14	ЗУ	SM 6	068	2025-04-06 18:00:00	5.46
8855	Q15	ЗУ	SM 7	069	2025-04-06 18:00:00	0
8856	Q16	ЗУ	SM 8	070	2025-04-06 18:00:00	0
8857	Q17	ЗУ	MO 9	071	2025-04-06 18:00:00	1.13
8858	Q20	ЗУ	MO 10	072	2025-04-06 18:00:00	2.68
8859	Q21	ЗУ	MO 11	073	2025-04-06 18:00:00	9.18
8860	Q22	ЗУ	MO 12	074	2025-04-06 18:00:00	30.09
8861	Q23	ЗУ	MO 13	075	2025-04-06 18:00:00	16.98
8862	Q24	ЗУ	MO 14	076	2025-04-06 18:00:00	19.98
8863	Q25	ЗУ	MO 15	077	2025-04-06 18:00:00	16.96
8864	TP3	ЗУ	CP-300 New	078	2025-04-06 18:00:00	87.45
8865	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 18:30:00	0
8866	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 18:30:00	0.0015
8867	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 18:30:00	0.0028
8868	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 18:30:00	0.0031
8869	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 18:30:00	0
8870	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 18:30:00	0
8871	QF 1,20	ЗУ	China 1	044	2025-04-06 18:30:00	12.61
8872	QF 1,21	ЗУ	China 2	045	2025-04-06 18:30:00	11.46
8873	QF 1,22	ЗУ	China 3	046	2025-04-06 18:30:00	15.39
8874	QF 2,20	ЗУ	China 4	047	2025-04-06 18:30:00	20.18
8875	QF 2,21	ЗУ	China 5	048	2025-04-06 18:30:00	22.91
8876	QF 2,22	ЗУ	China 6	049	2025-04-06 18:30:00	21.05
8877	QF 2,23	ЗУ	China 7	050	2025-04-06 18:30:00	9.17
8878	QF 2,19	ЗУ	China 8	051	2025-04-06 18:30:00	14.07
8879	Q8	ЗУ	DIG	061	2025-04-06 18:30:00	26.07
8880	Q4	ЗУ	BG 1	062	2025-04-06 18:30:00	17.7
8881	Q9	ЗУ	BG 2	063	2025-04-06 18:30:00	20.07
8882	Q10	ЗУ	SM 2	064	2025-04-06 18:30:00	32.18
8883	Q11	ЗУ	SM 3	065	2025-04-06 18:30:00	19.36
8884	Q12	ЗУ	SM 4	066	2025-04-06 18:30:00	22.05
8885	Q13	ЗУ	SM 5	067	2025-04-06 18:30:00	0
8886	Q14	ЗУ	SM 6	068	2025-04-06 18:30:00	5.46
8887	Q15	ЗУ	SM 7	069	2025-04-06 18:30:00	0
8888	Q16	ЗУ	SM 8	070	2025-04-06 18:30:00	0
8889	Q17	ЗУ	MO 9	071	2025-04-06 18:30:00	1.13
8890	Q20	ЗУ	MO 10	072	2025-04-06 18:30:00	2.68
8891	Q21	ЗУ	MO 11	073	2025-04-06 18:30:00	9.22
8892	Q22	ЗУ	MO 12	074	2025-04-06 18:30:00	30.06
8893	Q23	ЗУ	MO 13	075	2025-04-06 18:30:00	16.96
8894	Q24	ЗУ	MO 14	076	2025-04-06 18:30:00	20
8895	Q25	ЗУ	MO 15	077	2025-04-06 18:30:00	16.98
8896	TP3	ЗУ	CP-300 New	078	2025-04-06 18:30:00	88.44
8897	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 19:00:00	0
8898	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 19:00:00	0.0003
8899	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 19:00:00	0.0027
8900	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 19:00:00	0.0028
8901	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 19:00:00	0
8902	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 19:00:00	0
8903	QF 1,20	ЗУ	China 1	044	2025-04-06 19:00:00	13.17
8904	QF 1,21	ЗУ	China 2	045	2025-04-06 19:00:00	12.31
8905	QF 1,22	ЗУ	China 3	046	2025-04-06 19:00:00	16.11
8906	QF 2,20	ЗУ	China 4	047	2025-04-06 19:00:00	21.32
8907	QF 2,21	ЗУ	China 5	048	2025-04-06 19:00:00	23.6
8908	QF 2,22	ЗУ	China 6	049	2025-04-06 19:00:00	21.55
8909	QF 2,23	ЗУ	China 7	050	2025-04-06 19:00:00	9.54
8910	QF 2,19	ЗУ	China 8	051	2025-04-06 19:00:00	14.6
8911	Q8	ЗУ	DIG	061	2025-04-06 19:00:00	28.33
8912	Q4	ЗУ	BG 1	062	2025-04-06 19:00:00	17.69
8913	Q9	ЗУ	BG 2	063	2025-04-06 19:00:00	20.14
8914	Q10	ЗУ	SM 2	064	2025-04-06 19:00:00	32.24
8915	Q11	ЗУ	SM 3	065	2025-04-06 19:00:00	19.37
8916	Q12	ЗУ	SM 4	066	2025-04-06 19:00:00	22
8917	Q13	ЗУ	SM 5	067	2025-04-06 19:00:00	0
8918	Q14	ЗУ	SM 6	068	2025-04-06 19:00:00	5.47
8919	Q15	ЗУ	SM 7	069	2025-04-06 19:00:00	0
8920	Q16	ЗУ	SM 8	070	2025-04-06 19:00:00	0
8921	Q17	ЗУ	MO 9	071	2025-04-06 19:00:00	1.13
8922	Q20	ЗУ	MO 10	072	2025-04-06 19:00:00	2.68
8923	Q21	ЗУ	MO 11	073	2025-04-06 19:00:00	9.21
8924	Q22	ЗУ	MO 12	074	2025-04-06 19:00:00	30.1
8925	Q23	ЗУ	MO 13	075	2025-04-06 19:00:00	16.96
8926	Q24	ЗУ	MO 14	076	2025-04-06 19:00:00	20.01
8927	Q25	ЗУ	MO 15	077	2025-04-06 19:00:00	17.01
8928	TP3	ЗУ	CP-300 New	078	2025-04-06 19:00:00	84.25
8929	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 19:30:00	0
8930	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 19:30:00	0.0015
8931	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 19:30:00	0.0029
8932	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 19:30:00	0.003
8933	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 19:30:00	0
8934	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 19:30:00	0
8935	QF 1,20	ЗУ	China 1	044	2025-04-06 19:30:00	13.38
8936	QF 1,21	ЗУ	China 2	045	2025-04-06 19:30:00	12.44
8937	QF 1,22	ЗУ	China 3	046	2025-04-06 19:30:00	16.37
8938	QF 2,20	ЗУ	China 4	047	2025-04-06 19:30:00	21.6
8939	QF 2,21	ЗУ	China 5	048	2025-04-06 19:30:00	24
8940	QF 2,22	ЗУ	China 6	049	2025-04-06 19:30:00	22.32
8941	QF 2,23	ЗУ	China 7	050	2025-04-06 19:30:00	9.92
8942	QF 2,19	ЗУ	China 8	051	2025-04-06 19:30:00	14.79
8943	Q8	ЗУ	DIG	061	2025-04-06 19:30:00	32.23
8944	Q4	ЗУ	BG 1	062	2025-04-06 19:30:00	17.7
8945	Q9	ЗУ	BG 2	063	2025-04-06 19:30:00	20.15
8946	Q10	ЗУ	SM 2	064	2025-04-06 19:30:00	32.13
8947	Q11	ЗУ	SM 3	065	2025-04-06 19:30:00	19.19
8948	Q12	ЗУ	SM 4	066	2025-04-06 19:30:00	22.23
8949	Q13	ЗУ	SM 5	067	2025-04-06 19:30:00	0
8950	Q14	ЗУ	SM 6	068	2025-04-06 19:30:00	5.45
8951	Q15	ЗУ	SM 7	069	2025-04-06 19:30:00	0
8952	Q16	ЗУ	SM 8	070	2025-04-06 19:30:00	0
8953	Q17	ЗУ	MO 9	071	2025-04-06 19:30:00	1.13
8954	Q20	ЗУ	MO 10	072	2025-04-06 19:30:00	2.7
8955	Q21	ЗУ	MO 11	073	2025-04-06 19:30:00	9.22
8956	Q22	ЗУ	MO 12	074	2025-04-06 19:30:00	30.08
8957	Q23	ЗУ	MO 13	075	2025-04-06 19:30:00	16.96
8958	Q24	ЗУ	MO 14	076	2025-04-06 19:30:00	19.97
8959	Q25	ЗУ	MO 15	077	2025-04-06 19:30:00	16.97
8960	TP3	ЗУ	CP-300 New	078	2025-04-06 19:30:00	84.86
8961	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 20:00:00	0
8962	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 20:00:00	0.0012
8963	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 20:00:00	0.003
8964	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 20:00:00	0.0032
8965	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 20:00:00	0
8966	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 20:00:00	0
8967	QF 1,20	ЗУ	China 1	044	2025-04-06 20:00:00	13.79
8968	QF 1,21	ЗУ	China 2	045	2025-04-06 20:00:00	12.8
8969	QF 1,22	ЗУ	China 3	046	2025-04-06 20:00:00	16.58
8970	QF 2,20	ЗУ	China 4	047	2025-04-06 20:00:00	22.34
8971	QF 2,21	ЗУ	China 5	048	2025-04-06 20:00:00	24.01
8972	QF 2,22	ЗУ	China 6	049	2025-04-06 20:00:00	22.8
8973	QF 2,23	ЗУ	China 7	050	2025-04-06 20:00:00	10.35
8974	QF 2,19	ЗУ	China 8	051	2025-04-06 20:00:00	14.97
8975	Q8	ЗУ	DIG	061	2025-04-06 20:00:00	36.84
8976	Q4	ЗУ	BG 1	062	2025-04-06 20:00:00	17.7
8977	Q9	ЗУ	BG 2	063	2025-04-06 20:00:00	20.11
8978	Q10	ЗУ	SM 2	064	2025-04-06 20:00:00	32.07
8979	Q11	ЗУ	SM 3	065	2025-04-06 20:00:00	19.16
8980	Q12	ЗУ	SM 4	066	2025-04-06 20:00:00	22.3
8981	Q13	ЗУ	SM 5	067	2025-04-06 20:00:00	0
8982	Q14	ЗУ	SM 6	068	2025-04-06 20:00:00	5.43
8983	Q15	ЗУ	SM 7	069	2025-04-06 20:00:00	0
8984	Q16	ЗУ	SM 8	070	2025-04-06 20:00:00	0
8985	Q17	ЗУ	MO 9	071	2025-04-06 20:00:00	1.13
8986	Q20	ЗУ	MO 10	072	2025-04-06 20:00:00	2.69
8987	Q21	ЗУ	MO 11	073	2025-04-06 20:00:00	9.21
8988	Q22	ЗУ	MO 12	074	2025-04-06 20:00:00	30.04
8989	Q23	ЗУ	MO 13	075	2025-04-06 20:00:00	16.94
8990	Q24	ЗУ	MO 14	076	2025-04-06 20:00:00	19.93
8991	Q25	ЗУ	MO 15	077	2025-04-06 20:00:00	16.96
8992	TP3	ЗУ	CP-300 New	078	2025-04-06 20:00:00	84.91
8993	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 20:30:00	0
8994	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 20:30:00	0.0008
8995	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 20:30:00	0.0028
8996	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 20:30:00	0.0021
8997	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 20:30:00	0
8998	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 20:30:00	0
8999	QF 1,20	ЗУ	China 1	044	2025-04-06 20:30:00	14.34
9000	QF 1,21	ЗУ	China 2	045	2025-04-06 20:30:00	13.49
9001	QF 1,22	ЗУ	China 3	046	2025-04-06 20:30:00	17.06
9002	QF 2,20	ЗУ	China 4	047	2025-04-06 20:30:00	23.07
9003	QF 2,21	ЗУ	China 5	048	2025-04-06 20:30:00	24.79
9004	QF 2,22	ЗУ	China 6	049	2025-04-06 20:30:00	23.38
9005	QF 2,23	ЗУ	China 7	050	2025-04-06 20:30:00	10.94
9006	QF 2,19	ЗУ	China 8	051	2025-04-06 20:30:00	15.23
9007	Q8	ЗУ	DIG	061	2025-04-06 20:30:00	38.05
9008	Q4	ЗУ	BG 1	062	2025-04-06 20:30:00	17.59
9009	Q9	ЗУ	BG 2	063	2025-04-06 20:30:00	20.12
9010	Q10	ЗУ	SM 2	064	2025-04-06 20:30:00	32.11
9011	Q11	ЗУ	SM 3	065	2025-04-06 20:30:00	19.16
9012	Q12	ЗУ	SM 4	066	2025-04-06 20:30:00	22.32
9013	Q13	ЗУ	SM 5	067	2025-04-06 20:30:00	0
9014	Q14	ЗУ	SM 6	068	2025-04-06 20:30:00	5.42
9015	Q15	ЗУ	SM 7	069	2025-04-06 20:30:00	0
9016	Q16	ЗУ	SM 8	070	2025-04-06 20:30:00	0
9017	Q17	ЗУ	MO 9	071	2025-04-06 20:30:00	1.11
9018	Q20	ЗУ	MO 10	072	2025-04-06 20:30:00	2.68
9019	Q21	ЗУ	MO 11	073	2025-04-06 20:30:00	9.25
9020	Q22	ЗУ	MO 12	074	2025-04-06 20:30:00	30.02
9021	Q23	ЗУ	MO 13	075	2025-04-06 20:30:00	16.91
9022	Q24	ЗУ	MO 14	076	2025-04-06 20:30:00	19.95
9023	Q25	ЗУ	MO 15	077	2025-04-06 20:30:00	16.9
9024	TP3	ЗУ	CP-300 New	078	2025-04-06 20:30:00	79.32
9025	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 21:00:00	0
9026	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 21:00:00	0.0013
9027	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 21:00:00	0.0027
9028	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 21:00:00	0.0018
9029	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 21:00:00	0
9030	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 21:00:00	0
9031	QF 1,20	ЗУ	China 1	044	2025-04-06 21:00:00	16.26
9032	QF 1,21	ЗУ	China 2	045	2025-04-06 21:00:00	15.26
9033	QF 1,22	ЗУ	China 3	046	2025-04-06 21:00:00	18.66
9034	QF 2,20	ЗУ	China 4	047	2025-04-06 21:00:00	25.34
9035	QF 2,21	ЗУ	China 5	048	2025-04-06 21:00:00	27.75
9036	QF 2,22	ЗУ	China 6	049	2025-04-06 21:00:00	25.88
9037	QF 2,23	ЗУ	China 7	050	2025-04-06 21:00:00	12.38
9038	QF 2,19	ЗУ	China 8	051	2025-04-06 21:00:00	17
9039	Q8	ЗУ	DIG	061	2025-04-06 21:00:00	36.42
9040	Q4	ЗУ	BG 1	062	2025-04-06 21:00:00	17.61
9041	Q9	ЗУ	BG 2	063	2025-04-06 21:00:00	20.2
9042	Q10	ЗУ	SM 2	064	2025-04-06 21:00:00	32
9043	Q11	ЗУ	SM 3	065	2025-04-06 21:00:00	19.16
9044	Q12	ЗУ	SM 4	066	2025-04-06 21:00:00	22.55
9045	Q13	ЗУ	SM 5	067	2025-04-06 21:00:00	0
9046	Q14	ЗУ	SM 6	068	2025-04-06 21:00:00	5.42
9047	Q15	ЗУ	SM 7	069	2025-04-06 21:00:00	0
9048	Q16	ЗУ	SM 8	070	2025-04-06 21:00:00	0
9049	Q17	ЗУ	MO 9	071	2025-04-06 21:00:00	1.11
9050	Q20	ЗУ	MO 10	072	2025-04-06 21:00:00	2.68
9051	Q21	ЗУ	MO 11	073	2025-04-06 21:00:00	9.2
9052	Q22	ЗУ	MO 12	074	2025-04-06 21:00:00	30.02
9053	Q23	ЗУ	MO 13	075	2025-04-06 21:00:00	16.91
9054	Q24	ЗУ	MO 14	076	2025-04-06 21:00:00	19.95
9055	Q25	ЗУ	MO 15	077	2025-04-06 21:00:00	16.92
9056	TP3	ЗУ	CP-300 New	078	2025-04-06 21:00:00	79.26
9057	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 21:30:00	0
9058	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 21:30:00	0.0005
9059	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 21:30:00	0.0026
9060	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 21:30:00	0.0019
9061	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 21:30:00	0
9062	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 21:30:00	0
9063	QF 1,20	ЗУ	China 1	044	2025-04-06 21:30:00	16.1
9064	QF 1,21	ЗУ	China 2	045	2025-04-06 21:30:00	14.81
9065	QF 1,22	ЗУ	China 3	046	2025-04-06 21:30:00	18.07
9066	QF 2,20	ЗУ	China 4	047	2025-04-06 21:30:00	25.1
9067	QF 2,21	ЗУ	China 5	048	2025-04-06 21:30:00	27.01
9068	QF 2,22	ЗУ	China 6	049	2025-04-06 21:30:00	25.62
9069	QF 2,23	ЗУ	China 7	050	2025-04-06 21:30:00	12.39
9070	QF 2,19	ЗУ	China 8	051	2025-04-06 21:30:00	16.78
9071	Q8	ЗУ	DIG	061	2025-04-06 21:30:00	39.02
9072	Q4	ЗУ	BG 1	062	2025-04-06 21:30:00	17.64
9073	Q9	ЗУ	BG 2	063	2025-04-06 21:30:00	20.13
9074	Q10	ЗУ	SM 2	064	2025-04-06 21:30:00	31.87
9075	Q11	ЗУ	SM 3	065	2025-04-06 21:30:00	19.16
9076	Q12	ЗУ	SM 4	066	2025-04-06 21:30:00	22.73
9077	Q13	ЗУ	SM 5	067	2025-04-06 21:30:00	0
9078	Q14	ЗУ	SM 6	068	2025-04-06 21:30:00	5.42
9079	Q15	ЗУ	SM 7	069	2025-04-06 21:30:00	0
9080	Q16	ЗУ	SM 8	070	2025-04-06 21:30:00	0
9081	Q17	ЗУ	MO 9	071	2025-04-06 21:30:00	1.12
9082	Q20	ЗУ	MO 10	072	2025-04-06 21:30:00	2.69
9083	Q21	ЗУ	MO 11	073	2025-04-06 21:30:00	9.23
9084	Q22	ЗУ	MO 12	074	2025-04-06 21:30:00	30.11
9085	Q23	ЗУ	MO 13	075	2025-04-06 21:30:00	16.94
9086	Q24	ЗУ	MO 14	076	2025-04-06 21:30:00	19.97
9087	Q25	ЗУ	MO 15	077	2025-04-06 21:30:00	16.95
9088	TP3	ЗУ	CP-300 New	078	2025-04-06 21:30:00	76.28
9089	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 22:00:00	0
9090	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 22:00:00	0.0014
9091	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 22:00:00	0.0027
9092	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 22:00:00	0.0018
9093	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 22:00:00	0
9094	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 22:00:00	0
9095	QF 1,20	ЗУ	China 1	044	2025-04-06 22:00:00	12.02
9096	QF 1,21	ЗУ	China 2	045	2025-04-06 22:00:00	10.92
9097	QF 1,22	ЗУ	China 3	046	2025-04-06 22:00:00	14.56
9098	QF 2,20	ЗУ	China 4	047	2025-04-06 22:00:00	19.98
9099	QF 2,21	ЗУ	China 5	048	2025-04-06 22:00:00	21.26
9100	QF 2,22	ЗУ	China 6	049	2025-04-06 22:00:00	20.81
9101	QF 2,23	ЗУ	China 7	050	2025-04-06 22:00:00	9.95
9102	QF 2,19	ЗУ	China 8	051	2025-04-06 22:00:00	12.64
9103	Q8	ЗУ	DIG	061	2025-04-06 22:00:00	39.12
9104	Q4	ЗУ	BG 1	062	2025-04-06 22:00:00	17.68
9105	Q9	ЗУ	BG 2	063	2025-04-06 22:00:00	20.12
9106	Q10	ЗУ	SM 2	064	2025-04-06 22:00:00	29.22
9107	Q11	ЗУ	SM 3	065	2025-04-06 22:00:00	19.22
9108	Q12	ЗУ	SM 4	066	2025-04-06 22:00:00	22.81
9109	Q13	ЗУ	SM 5	067	2025-04-06 22:00:00	0
9110	Q14	ЗУ	SM 6	068	2025-04-06 22:00:00	5.42
9111	Q15	ЗУ	SM 7	069	2025-04-06 22:00:00	0
9112	Q16	ЗУ	SM 8	070	2025-04-06 22:00:00	0
9113	Q17	ЗУ	MO 9	071	2025-04-06 22:00:00	1.13
9114	Q20	ЗУ	MO 10	072	2025-04-06 22:00:00	2.69
9115	Q21	ЗУ	MO 11	073	2025-04-06 22:00:00	9.21
9116	Q22	ЗУ	MO 12	074	2025-04-06 22:00:00	30.15
9117	Q23	ЗУ	MO 13	075	2025-04-06 22:00:00	16.95
9118	Q24	ЗУ	MO 14	076	2025-04-06 22:00:00	19.97
9119	Q25	ЗУ	MO 15	077	2025-04-06 22:00:00	16.97
9120	TP3	ЗУ	CP-300 New	078	2025-04-06 22:00:00	77.4
9121	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 22:30:00	0
9122	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 22:30:00	0.0007
9123	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 22:30:00	0.0027
9124	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 22:30:00	0.0023
9125	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 22:30:00	0
9126	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 22:30:00	0
9127	QF 1,20	ЗУ	China 1	044	2025-04-06 22:30:00	11.34
9128	QF 1,21	ЗУ	China 2	045	2025-04-06 22:30:00	9.63
9129	QF 1,22	ЗУ	China 3	046	2025-04-06 22:30:00	13.45
9130	QF 2,20	ЗУ	China 4	047	2025-04-06 22:30:00	18.19
9131	QF 2,21	ЗУ	China 5	048	2025-04-06 22:30:00	19.06
9132	QF 2,22	ЗУ	China 6	049	2025-04-06 22:30:00	18.28
9133	QF 2,23	ЗУ	China 7	050	2025-04-06 22:30:00	9.12
9134	QF 2,19	ЗУ	China 8	051	2025-04-06 22:30:00	10.28
9135	Q8	ЗУ	DIG	061	2025-04-06 22:30:00	39.1
9136	Q4	ЗУ	BG 1	062	2025-04-06 22:30:00	17.68
9137	Q9	ЗУ	BG 2	063	2025-04-06 22:30:00	20.08
9138	Q10	ЗУ	SM 2	064	2025-04-06 22:30:00	25.34
9139	Q11	ЗУ	SM 3	065	2025-04-06 22:30:00	19.16
9140	Q12	ЗУ	SM 4	066	2025-04-06 22:30:00	22.85
9141	Q13	ЗУ	SM 5	067	2025-04-06 22:30:00	0
9142	Q14	ЗУ	SM 6	068	2025-04-06 22:30:00	5.43
9143	Q15	ЗУ	SM 7	069	2025-04-06 22:30:00	0
9144	Q16	ЗУ	SM 8	070	2025-04-06 22:30:00	0
9145	Q17	ЗУ	MO 9	071	2025-04-06 22:30:00	1.15
9146	Q20	ЗУ	MO 10	072	2025-04-06 22:30:00	2.69
9147	Q21	ЗУ	MO 11	073	2025-04-06 22:30:00	9.22
9148	Q22	ЗУ	MO 12	074	2025-04-06 22:30:00	30.19
9149	Q23	ЗУ	MO 13	075	2025-04-06 22:30:00	16.98
9150	Q24	ЗУ	MO 14	076	2025-04-06 22:30:00	20.03
9151	Q25	ЗУ	MO 15	077	2025-04-06 22:30:00	17.02
9152	TP3	ЗУ	CP-300 New	078	2025-04-06 22:30:00	77.07
9153	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 23:00:00	0
9154	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 23:00:00	0.0014
9155	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 23:00:00	0.0028
9156	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 23:00:00	0.0019
9157	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 23:00:00	0
9158	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 23:00:00	0
9159	QF 1,20	ЗУ	China 1	044	2025-04-06 23:00:00	12.15
9160	QF 1,21	ЗУ	China 2	045	2025-04-06 23:00:00	10.3
9161	QF 1,22	ЗУ	China 3	046	2025-04-06 23:00:00	13.82
9162	QF 2,20	ЗУ	China 4	047	2025-04-06 23:00:00	18.33
9163	QF 2,21	ЗУ	China 5	048	2025-04-06 23:00:00	19.1
9164	QF 2,22	ЗУ	China 6	049	2025-04-06 23:00:00	17.84
9165	QF 2,23	ЗУ	China 7	050	2025-04-06 23:00:00	9.09
9166	QF 2,19	ЗУ	China 8	051	2025-04-06 23:00:00	10.17
9167	Q8	ЗУ	DIG	061	2025-04-06 23:00:00	38.28
9168	Q4	ЗУ	BG 1	062	2025-04-06 23:00:00	17.62
9169	Q9	ЗУ	BG 2	063	2025-04-06 23:00:00	20.05
9170	Q10	ЗУ	SM 2	064	2025-04-06 23:00:00	16.49
9171	Q11	ЗУ	SM 3	065	2025-04-06 23:00:00	19.05
9172	Q12	ЗУ	SM 4	066	2025-04-06 23:00:00	22.64
9173	Q13	ЗУ	SM 5	067	2025-04-06 23:00:00	0
9174	Q14	ЗУ	SM 6	068	2025-04-06 23:00:00	5.43
9175	Q15	ЗУ	SM 7	069	2025-04-06 23:00:00	0
9176	Q16	ЗУ	SM 8	070	2025-04-06 23:00:00	0
9177	Q17	ЗУ	MO 9	071	2025-04-06 23:00:00	1.12
9178	Q20	ЗУ	MO 10	072	2025-04-06 23:00:00	2.68
9179	Q21	ЗУ	MO 11	073	2025-04-06 23:00:00	9.18
9180	Q22	ЗУ	MO 12	074	2025-04-06 23:00:00	30.06
9181	Q23	ЗУ	MO 13	075	2025-04-06 23:00:00	16.94
9182	Q24	ЗУ	MO 14	076	2025-04-06 23:00:00	20
9183	Q25	ЗУ	MO 15	077	2025-04-06 23:00:00	16.94
9184	TP3	ЗУ	CP-300 New	078	2025-04-06 23:00:00	74.79
9185	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-06 23:30:00	0
9186	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-06 23:30:00	0.0006
9187	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-06 23:30:00	0.0026
9188	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-06 23:30:00	0.0023
9189	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-06 23:30:00	0
9190	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-06 23:30:00	0
9191	QF 1,20	ЗУ	China 1	044	2025-04-06 23:30:00	12.87
9192	QF 1,21	ЗУ	China 2	045	2025-04-06 23:30:00	10.92
9193	QF 1,22	ЗУ	China 3	046	2025-04-06 23:30:00	13.94
9194	QF 2,20	ЗУ	China 4	047	2025-04-06 23:30:00	18.62
9195	QF 2,21	ЗУ	China 5	048	2025-04-06 23:30:00	19.57
9196	QF 2,22	ЗУ	China 6	049	2025-04-06 23:30:00	17.88
9197	QF 2,23	ЗУ	China 7	050	2025-04-06 23:30:00	9.23
9198	QF 2,19	ЗУ	China 8	051	2025-04-06 23:30:00	11.96
9199	Q8	ЗУ	DIG	061	2025-04-06 23:30:00	38.57
9200	Q4	ЗУ	BG 1	062	2025-04-06 23:30:00	17.65
9201	Q9	ЗУ	BG 2	063	2025-04-06 23:30:00	20.04
9202	Q10	ЗУ	SM 2	064	2025-04-06 23:30:00	7.8
9203	Q11	ЗУ	SM 3	065	2025-04-06 23:30:00	18.55
9204	Q12	ЗУ	SM 4	066	2025-04-06 23:30:00	22.45
9205	Q13	ЗУ	SM 5	067	2025-04-06 23:30:00	0
9206	Q14	ЗУ	SM 6	068	2025-04-06 23:30:00	5.4
9207	Q15	ЗУ	SM 7	069	2025-04-06 23:30:00	0
9208	Q16	ЗУ	SM 8	070	2025-04-06 23:30:00	0
9209	Q17	ЗУ	MO 9	071	2025-04-06 23:30:00	1.1
9210	Q20	ЗУ	MO 10	072	2025-04-06 23:30:00	2.68
9211	Q21	ЗУ	MO 11	073	2025-04-06 23:30:00	9.18
9212	Q22	ЗУ	MO 12	074	2025-04-06 23:30:00	29.93
9213	Q23	ЗУ	MO 13	075	2025-04-06 23:30:00	16.9
9214	Q24	ЗУ	MO 14	076	2025-04-06 23:30:00	19.96
9215	Q25	ЗУ	MO 15	077	2025-04-06 23:30:00	16.86
9216	TP3	ЗУ	CP-300 New	078	2025-04-06 23:30:00	74.51
9217	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 00:00:00	0
9218	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 00:00:00	0.0015
9219	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 00:00:00	0.0028
9220	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 00:00:00	0.0026
9221	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 00:00:00	0
9222	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 00:00:00	0
9223	QF 1,20	ЗУ	China 1	044	2025-04-07 00:00:00	13.26
9224	QF 1,21	ЗУ	China 2	045	2025-04-07 00:00:00	10.98
9225	QF 1,22	ЗУ	China 3	046	2025-04-07 00:00:00	13.27
9226	QF 2,20	ЗУ	China 4	047	2025-04-07 00:00:00	18.8
9227	QF 2,21	ЗУ	China 5	048	2025-04-07 00:00:00	19.65
9228	QF 2,22	ЗУ	China 6	049	2025-04-07 00:00:00	17.88
9229	QF 2,23	ЗУ	China 7	050	2025-04-07 00:00:00	9.32
9230	QF 2,19	ЗУ	China 8	051	2025-04-07 00:00:00	11.88
9231	Q8	ЗУ	DIG	061	2025-04-07 00:00:00	29.09
9232	Q4	ЗУ	BG 1	062	2025-04-07 00:00:00	17.62
9233	Q9	ЗУ	BG 2	063	2025-04-07 00:00:00	20.11
9234	Q10	ЗУ	SM 2	064	2025-04-07 00:00:00	1.92
9235	Q11	ЗУ	SM 3	065	2025-04-07 00:00:00	18.15
9236	Q12	ЗУ	SM 4	066	2025-04-07 00:00:00	22.45
9237	Q13	ЗУ	SM 5	067	2025-04-07 00:00:00	0
9238	Q14	ЗУ	SM 6	068	2025-04-07 00:00:00	5.41
9239	Q15	ЗУ	SM 7	069	2025-04-07 00:00:00	0
9240	Q16	ЗУ	SM 8	070	2025-04-07 00:00:00	0
9241	Q17	ЗУ	MO 9	071	2025-04-07 00:00:00	1.11
9242	Q20	ЗУ	MO 10	072	2025-04-07 00:00:00	2.68
9243	Q21	ЗУ	MO 11	073	2025-04-07 00:00:00	9.21
9244	Q22	ЗУ	MO 12	074	2025-04-07 00:00:00	30
9245	Q23	ЗУ	MO 13	075	2025-04-07 00:00:00	16.92
9246	Q24	ЗУ	MO 14	076	2025-04-07 00:00:00	19.98
9247	Q25	ЗУ	MO 15	077	2025-04-07 00:00:00	16.91
9248	TP3	ЗУ	CP-300 New	078	2025-04-07 00:00:00	71.31
9249	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 00:30:00	0
9250	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 00:30:00	0.0005
9251	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 00:30:00	0.0027
9252	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 00:30:00	0.0021
9253	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 00:30:00	0
9254	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 00:30:00	0
9255	QF 1,20	ЗУ	China 1	044	2025-04-07 00:30:00	12.19
9256	QF 1,21	ЗУ	China 2	045	2025-04-07 00:30:00	9.85
9257	QF 1,22	ЗУ	China 3	046	2025-04-07 00:30:00	11.95
9258	QF 2,20	ЗУ	China 4	047	2025-04-07 00:30:00	17.02
9259	QF 2,21	ЗУ	China 5	048	2025-04-07 00:30:00	17.8
9260	QF 2,22	ЗУ	China 6	049	2025-04-07 00:30:00	15.99
9261	QF 2,23	ЗУ	China 7	050	2025-04-07 00:30:00	7.96
9262	QF 2,19	ЗУ	China 8	051	2025-04-07 00:30:00	10.27
9263	Q8	ЗУ	DIG	061	2025-04-07 00:30:00	33.65
9264	Q4	ЗУ	BG 1	062	2025-04-07 00:30:00	17.62
9265	Q9	ЗУ	BG 2	063	2025-04-07 00:30:00	20.07
9266	Q10	ЗУ	SM 2	064	2025-04-07 00:30:00	1.25
9267	Q11	ЗУ	SM 3	065	2025-04-07 00:30:00	18.2
9268	Q12	ЗУ	SM 4	066	2025-04-07 00:30:00	22.65
9269	Q13	ЗУ	SM 5	067	2025-04-07 00:30:00	0
9270	Q14	ЗУ	SM 6	068	2025-04-07 00:30:00	5.42
9271	Q15	ЗУ	SM 7	069	2025-04-07 00:30:00	0
9272	Q16	ЗУ	SM 8	070	2025-04-07 00:30:00	0
9273	Q17	ЗУ	MO 9	071	2025-04-07 00:30:00	1.12
9274	Q20	ЗУ	MO 10	072	2025-04-07 00:30:00	2.68
9275	Q21	ЗУ	MO 11	073	2025-04-07 00:30:00	9.21
9276	Q22	ЗУ	MO 12	074	2025-04-07 00:30:00	30.02
9277	Q23	ЗУ	MO 13	075	2025-04-07 00:30:00	16.93
9278	Q24	ЗУ	MO 14	076	2025-04-07 00:30:00	19.99
9279	Q25	ЗУ	MO 15	077	2025-04-07 00:30:00	16.92
9280	TP3	ЗУ	CP-300 New	078	2025-04-07 00:30:00	72.59
9281	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 01:00:00	0
9282	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 01:00:00	0.0015
9283	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 01:00:00	0.0026
9284	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 01:00:00	0.0022
9285	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 01:00:00	0
9286	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 01:00:00	0
9287	QF 1,20	ЗУ	China 1	044	2025-04-07 01:00:00	14.96
9288	QF 1,21	ЗУ	China 2	045	2025-04-07 01:00:00	12.15
9289	QF 1,22	ЗУ	China 3	046	2025-04-07 01:00:00	14.29
9290	QF 2,20	ЗУ	China 4	047	2025-04-07 01:00:00	19.15
9291	QF 2,21	ЗУ	China 5	048	2025-04-07 01:00:00	19.45
9292	QF 2,22	ЗУ	China 6	049	2025-04-07 01:00:00	18.01
9293	QF 2,23	ЗУ	China 7	050	2025-04-07 01:00:00	9.14
9294	QF 2,19	ЗУ	China 8	051	2025-04-07 01:00:00	12.24
9295	Q8	ЗУ	DIG	061	2025-04-07 01:00:00	45.81
9296	Q4	ЗУ	BG 1	062	2025-04-07 01:00:00	17.62
9297	Q9	ЗУ	BG 2	063	2025-04-07 01:00:00	20.03
9298	Q10	ЗУ	SM 2	064	2025-04-07 01:00:00	1.25
9299	Q11	ЗУ	SM 3	065	2025-04-07 01:00:00	18.22
9300	Q12	ЗУ	SM 4	066	2025-04-07 01:00:00	22.66
9301	Q13	ЗУ	SM 5	067	2025-04-07 01:00:00	0
9302	Q14	ЗУ	SM 6	068	2025-04-07 01:00:00	5.43
9303	Q15	ЗУ	SM 7	069	2025-04-07 01:00:00	0
9304	Q16	ЗУ	SM 8	070	2025-04-07 01:00:00	0
9305	Q17	ЗУ	MO 9	071	2025-04-07 01:00:00	1.12
9306	Q20	ЗУ	MO 10	072	2025-04-07 01:00:00	2.67
9307	Q21	ЗУ	MO 11	073	2025-04-07 01:00:00	9.18
9308	Q22	ЗУ	MO 12	074	2025-04-07 01:00:00	29.99
9309	Q23	ЗУ	MO 13	075	2025-04-07 01:00:00	16.96
9310	Q24	ЗУ	MO 14	076	2025-04-07 01:00:00	19.96
9311	Q25	ЗУ	MO 15	077	2025-04-07 01:00:00	16.9
9312	TP3	ЗУ	CP-300 New	078	2025-04-07 01:00:00	68.84
9313	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 01:30:00	0
9314	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 01:30:00	0.0014
9315	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 01:30:00	0.0025
9316	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 01:30:00	0.0023
9317	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 01:30:00	0
9318	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 01:30:00	0
9319	QF 1,20	ЗУ	China 1	044	2025-04-07 01:30:00	16.6
9320	QF 1,21	ЗУ	China 2	045	2025-04-07 01:30:00	14.1
9321	QF 1,22	ЗУ	China 3	046	2025-04-07 01:30:00	15.86
9322	QF 2,20	ЗУ	China 4	047	2025-04-07 01:30:00	20.43
9323	QF 2,21	ЗУ	China 5	048	2025-04-07 01:30:00	21.3
9324	QF 2,22	ЗУ	China 6	049	2025-04-07 01:30:00	19.41
9325	QF 2,23	ЗУ	China 7	050	2025-04-07 01:30:00	9.79
9326	QF 2,19	ЗУ	China 8	051	2025-04-07 01:30:00	14.53
9327	Q8	ЗУ	DIG	061	2025-04-07 01:30:00	51.43
9328	Q4	ЗУ	BG 1	062	2025-04-07 01:30:00	17.59
9329	Q9	ЗУ	BG 2	063	2025-04-07 01:30:00	20.01
9330	Q10	ЗУ	SM 2	064	2025-04-07 01:30:00	1.26
9331	Q11	ЗУ	SM 3	065	2025-04-07 01:30:00	18.24
9332	Q12	ЗУ	SM 4	066	2025-04-07 01:30:00	22.75
9333	Q13	ЗУ	SM 5	067	2025-04-07 01:30:00	0
9334	Q14	ЗУ	SM 6	068	2025-04-07 01:30:00	5.43
9335	Q15	ЗУ	SM 7	069	2025-04-07 01:30:00	0
9336	Q16	ЗУ	SM 8	070	2025-04-07 01:30:00	0
9337	Q17	ЗУ	MO 9	071	2025-04-07 01:30:00	1.13
9338	Q20	ЗУ	MO 10	072	2025-04-07 01:30:00	2.68
9339	Q21	ЗУ	MO 11	073	2025-04-07 01:30:00	9.2
9340	Q22	ЗУ	MO 12	074	2025-04-07 01:30:00	30.03
9341	Q23	ЗУ	MO 13	075	2025-04-07 01:30:00	16.96
9342	Q24	ЗУ	MO 14	076	2025-04-07 01:30:00	19.97
9343	Q25	ЗУ	MO 15	077	2025-04-07 01:30:00	16.93
9344	TP3	ЗУ	CP-300 New	078	2025-04-07 01:30:00	66.46
9345	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 02:00:00	0
9346	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 02:00:00	0.0007
9347	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 02:00:00	0.0027
9348	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 02:00:00	0.0026
9349	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 02:00:00	0
9350	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 02:00:00	0
9351	QF 1,20	ЗУ	China 1	044	2025-04-07 02:00:00	17.16
9352	QF 1,21	ЗУ	China 2	045	2025-04-07 02:00:00	14.82
9353	QF 1,22	ЗУ	China 3	046	2025-04-07 02:00:00	16.59
9354	QF 2,20	ЗУ	China 4	047	2025-04-07 02:00:00	20.81
9355	QF 2,21	ЗУ	China 5	048	2025-04-07 02:00:00	22.06
9356	QF 2,22	ЗУ	China 6	049	2025-04-07 02:00:00	20.13
9357	QF 2,23	ЗУ	China 7	050	2025-04-07 02:00:00	10.06
9358	QF 2,19	ЗУ	China 8	051	2025-04-07 02:00:00	14.79
9359	Q8	ЗУ	DIG	061	2025-04-07 02:00:00	55.29
9360	Q4	ЗУ	BG 1	062	2025-04-07 02:00:00	17.62
9361	Q9	ЗУ	BG 2	063	2025-04-07 02:00:00	19.97
9362	Q10	ЗУ	SM 2	064	2025-04-07 02:00:00	1.26
9363	Q11	ЗУ	SM 3	065	2025-04-07 02:00:00	18.26
9364	Q12	ЗУ	SM 4	066	2025-04-07 02:00:00	22.77
9365	Q13	ЗУ	SM 5	067	2025-04-07 02:00:00	0
9366	Q14	ЗУ	SM 6	068	2025-04-07 02:00:00	5.44
9367	Q15	ЗУ	SM 7	069	2025-04-07 02:00:00	0
9368	Q16	ЗУ	SM 8	070	2025-04-07 02:00:00	0
9369	Q17	ЗУ	MO 9	071	2025-04-07 02:00:00	1.13
9370	Q20	ЗУ	MO 10	072	2025-04-07 02:00:00	2.69
9371	Q21	ЗУ	MO 11	073	2025-04-07 02:00:00	9.2
9372	Q22	ЗУ	MO 12	074	2025-04-07 02:00:00	30.04
9373	Q23	ЗУ	MO 13	075	2025-04-07 02:00:00	16.95
9374	Q24	ЗУ	MO 14	076	2025-04-07 02:00:00	20
9375	Q25	ЗУ	MO 15	077	2025-04-07 02:00:00	16.91
9376	TP3	ЗУ	CP-300 New	078	2025-04-07 02:00:00	64.58
9377	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 02:30:00	0
9378	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 02:30:00	0.0008
9379	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 02:30:00	0.0023
9380	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 02:30:00	0.0021
9381	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 02:30:00	0
9382	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 02:30:00	0
9383	QF 1,20	ЗУ	China 1	044	2025-04-07 02:30:00	17.41
9384	QF 1,21	ЗУ	China 2	045	2025-04-07 02:30:00	14.92
9385	QF 1,22	ЗУ	China 3	046	2025-04-07 02:30:00	16.65
9386	QF 2,20	ЗУ	China 4	047	2025-04-07 02:30:00	20.95
9387	QF 2,21	ЗУ	China 5	048	2025-04-07 02:30:00	22.15
9388	QF 2,22	ЗУ	China 6	049	2025-04-07 02:30:00	20.25
9389	QF 2,23	ЗУ	China 7	050	2025-04-07 02:30:00	10.15
9390	QF 2,19	ЗУ	China 8	051	2025-04-07 02:30:00	15.01
9391	Q8	ЗУ	DIG	061	2025-04-07 02:30:00	59.72
9392	Q4	ЗУ	BG 1	062	2025-04-07 02:30:00	17.58
9393	Q9	ЗУ	BG 2	063	2025-04-07 02:30:00	19.97
9394	Q10	ЗУ	SM 2	064	2025-04-07 02:30:00	1.41
9395	Q11	ЗУ	SM 3	065	2025-04-07 02:30:00	18.26
9396	Q12	ЗУ	SM 4	066	2025-04-07 02:30:00	22.75
9397	Q13	ЗУ	SM 5	067	2025-04-07 02:30:00	0
9398	Q14	ЗУ	SM 6	068	2025-04-07 02:30:00	5.44
9399	Q15	ЗУ	SM 7	069	2025-04-07 02:30:00	0
9400	Q16	ЗУ	SM 8	070	2025-04-07 02:30:00	0
9401	Q17	ЗУ	MO 9	071	2025-04-07 02:30:00	1.14
9402	Q20	ЗУ	MO 10	072	2025-04-07 02:30:00	2.68
9403	Q21	ЗУ	MO 11	073	2025-04-07 02:30:00	9.23
9404	Q22	ЗУ	MO 12	074	2025-04-07 02:30:00	30.07
9405	Q23	ЗУ	MO 13	075	2025-04-07 02:30:00	16.98
9406	Q24	ЗУ	MO 14	076	2025-04-07 02:30:00	19.97
9407	Q25	ЗУ	MO 15	077	2025-04-07 02:30:00	16.94
9408	TP3	ЗУ	CP-300 New	078	2025-04-07 02:30:00	62.52
9409	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 03:00:00	0
9410	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 03:00:00	0.0009
9411	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 03:00:00	0.0027
9412	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 03:00:00	0.002
9413	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 03:00:00	0
9414	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 03:00:00	0
9415	QF 1,20	ЗУ	China 1	044	2025-04-07 03:00:00	17.31
9416	QF 1,21	ЗУ	China 2	045	2025-04-07 03:00:00	14.99
9417	QF 1,22	ЗУ	China 3	046	2025-04-07 03:00:00	16.91
9418	QF 2,20	ЗУ	China 4	047	2025-04-07 03:00:00	20.96
9419	QF 2,21	ЗУ	China 5	048	2025-04-07 03:00:00	22.23
9420	QF 2,22	ЗУ	China 6	049	2025-04-07 03:00:00	20.65
9421	QF 2,23	ЗУ	China 7	050	2025-04-07 03:00:00	10.2
9422	QF 2,19	ЗУ	China 8	051	2025-04-07 03:00:00	14.9
9423	Q8	ЗУ	DIG	061	2025-04-07 03:00:00	66.67
9424	Q4	ЗУ	BG 1	062	2025-04-07 03:00:00	17.57
9425	Q9	ЗУ	BG 2	063	2025-04-07 03:00:00	20.03
9426	Q10	ЗУ	SM 2	064	2025-04-07 03:00:00	15.34
9427	Q11	ЗУ	SM 3	065	2025-04-07 03:00:00	18.19
9428	Q12	ЗУ	SM 4	066	2025-04-07 03:00:00	22.6
9429	Q13	ЗУ	SM 5	067	2025-04-07 03:00:00	0
9430	Q14	ЗУ	SM 6	068	2025-04-07 03:00:00	5.44
9431	Q15	ЗУ	SM 7	069	2025-04-07 03:00:00	0
9432	Q16	ЗУ	SM 8	070	2025-04-07 03:00:00	0
9433	Q17	ЗУ	MO 9	071	2025-04-07 03:00:00	1.12
9434	Q20	ЗУ	MO 10	072	2025-04-07 03:00:00	2.69
9435	Q21	ЗУ	MO 11	073	2025-04-07 03:00:00	9.23
9436	Q22	ЗУ	MO 12	074	2025-04-07 03:00:00	30.11
9437	Q23	ЗУ	MO 13	075	2025-04-07 03:00:00	16.86
9438	Q24	ЗУ	MO 14	076	2025-04-07 03:00:00	19.97
9439	Q25	ЗУ	MO 15	077	2025-04-07 03:00:00	17
9440	TP3	ЗУ	CP-300 New	078	2025-04-07 03:00:00	59.38
9441	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 03:30:00	0
9442	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 03:30:00	0.0012
9443	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 03:30:00	0.0024
9444	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 03:30:00	0.002
9445	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 03:30:00	0
9446	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 03:30:00	0
9447	QF 1,20	ЗУ	China 1	044	2025-04-07 03:30:00	17.5
9448	QF 1,21	ЗУ	China 2	045	2025-04-07 03:30:00	15.48
9449	QF 1,22	ЗУ	China 3	046	2025-04-07 03:30:00	17.26
9450	QF 2,20	ЗУ	China 4	047	2025-04-07 03:30:00	21.32
9451	QF 2,21	ЗУ	China 5	048	2025-04-07 03:30:00	22.48
9452	QF 2,22	ЗУ	China 6	049	2025-04-07 03:30:00	21.17
9453	QF 2,23	ЗУ	China 7	050	2025-04-07 03:30:00	10.37
9454	QF 2,19	ЗУ	China 8	051	2025-04-07 03:30:00	15.36
9455	Q8	ЗУ	DIG	061	2025-04-07 03:30:00	72.75
9456	Q4	ЗУ	BG 1	062	2025-04-07 03:30:00	17.51
9457	Q9	ЗУ	BG 2	063	2025-04-07 03:30:00	20.01
9458	Q10	ЗУ	SM 2	064	2025-04-07 03:30:00	15.35
9459	Q11	ЗУ	SM 3	065	2025-04-07 03:30:00	18.14
9460	Q12	ЗУ	SM 4	066	2025-04-07 03:30:00	22.57
9461	Q13	ЗУ	SM 5	067	2025-04-07 03:30:00	0
9462	Q14	ЗУ	SM 6	068	2025-04-07 03:30:00	5.46
9463	Q15	ЗУ	SM 7	069	2025-04-07 03:30:00	0
9464	Q16	ЗУ	SM 8	070	2025-04-07 03:30:00	0
9465	Q17	ЗУ	MO 9	071	2025-04-07 03:30:00	1.11
9466	Q20	ЗУ	MO 10	072	2025-04-07 03:30:00	2.7
9467	Q21	ЗУ	MO 11	073	2025-04-07 03:30:00	9.24
9468	Q22	ЗУ	MO 12	074	2025-04-07 03:30:00	30.09
9469	Q23	ЗУ	MO 13	075	2025-04-07 03:30:00	16.9
9470	Q24	ЗУ	MO 14	076	2025-04-07 03:30:00	19.99
9471	Q25	ЗУ	MO 15	077	2025-04-07 03:30:00	16.97
9472	TP3	ЗУ	CP-300 New	078	2025-04-07 03:30:00	57.16
9473	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 04:00:00	0
9474	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 04:00:00	0.0013
9475	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 04:00:00	0.003
9476	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 04:00:00	0.0026
9477	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 04:00:00	0
9478	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 04:00:00	0
9479	QF 1,20	ЗУ	China 1	044	2025-04-07 04:00:00	17.96
9480	QF 1,21	ЗУ	China 2	045	2025-04-07 04:00:00	15.92
9481	QF 1,22	ЗУ	China 3	046	2025-04-07 04:00:00	17.06
9482	QF 2,20	ЗУ	China 4	047	2025-04-07 04:00:00	22.02
9483	QF 2,21	ЗУ	China 5	048	2025-04-07 04:00:00	23.48
9484	QF 2,22	ЗУ	China 6	049	2025-04-07 04:00:00	22.47
9485	QF 2,23	ЗУ	China 7	050	2025-04-07 04:00:00	10.76
9486	QF 2,19	ЗУ	China 8	051	2025-04-07 04:00:00	15.99
9487	Q8	ЗУ	DIG	061	2025-04-07 04:00:00	78.03
9488	Q4	ЗУ	BG 1	062	2025-04-07 04:00:00	17.5
9489	Q9	ЗУ	BG 2	063	2025-04-07 04:00:00	20.02
9490	Q10	ЗУ	SM 2	064	2025-04-07 04:00:00	15.36
9491	Q11	ЗУ	SM 3	065	2025-04-07 04:00:00	18.12
9492	Q12	ЗУ	SM 4	066	2025-04-07 04:00:00	22.57
9493	Q13	ЗУ	SM 5	067	2025-04-07 04:00:00	0
9494	Q14	ЗУ	SM 6	068	2025-04-07 04:00:00	5.46
9495	Q15	ЗУ	SM 7	069	2025-04-07 04:00:00	0
9496	Q16	ЗУ	SM 8	070	2025-04-07 04:00:00	0
9497	Q17	ЗУ	MO 9	071	2025-04-07 04:00:00	1.11
9498	Q20	ЗУ	MO 10	072	2025-04-07 04:00:00	2.68
9499	Q21	ЗУ	MO 11	073	2025-04-07 04:00:00	9.24
9500	Q22	ЗУ	MO 12	074	2025-04-07 04:00:00	30.09
9501	Q23	ЗУ	MO 13	075	2025-04-07 04:00:00	16.85
9502	Q24	ЗУ	MO 14	076	2025-04-07 04:00:00	20
9503	Q25	ЗУ	MO 15	077	2025-04-07 04:00:00	16.96
9504	TP3	ЗУ	CP-300 New	078	2025-04-07 04:00:00	55
9505	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 04:30:00	0
9506	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 04:30:00	0.001
9507	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 04:30:00	0.0028
9508	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 04:30:00	0.0026
9509	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 04:30:00	0
9510	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 04:30:00	0
9511	QF 1,20	ЗУ	China 1	044	2025-04-07 04:30:00	15.79
9512	QF 1,21	ЗУ	China 2	045	2025-04-07 04:30:00	14.72
9513	QF 1,22	ЗУ	China 3	046	2025-04-07 04:30:00	16.12
9514	QF 2,20	ЗУ	China 4	047	2025-04-07 04:30:00	21.27
9515	QF 2,21	ЗУ	China 5	048	2025-04-07 04:30:00	23.7
9516	QF 2,22	ЗУ	China 6	049	2025-04-07 04:30:00	22.34
9517	QF 2,23	ЗУ	China 7	050	2025-04-07 04:30:00	10.56
9518	QF 2,19	ЗУ	China 8	051	2025-04-07 04:30:00	14.81
9519	Q8	ЗУ	DIG	061	2025-04-07 04:30:00	76.64
9520	Q4	ЗУ	BG 1	062	2025-04-07 04:30:00	17.52
9521	Q9	ЗУ	BG 2	063	2025-04-07 04:30:00	19.98
9522	Q10	ЗУ	SM 2	064	2025-04-07 04:30:00	15.38
9523	Q11	ЗУ	SM 3	065	2025-04-07 04:30:00	18.1
9524	Q12	ЗУ	SM 4	066	2025-04-07 04:30:00	22.48
9525	Q13	ЗУ	SM 5	067	2025-04-07 04:30:00	0
9526	Q14	ЗУ	SM 6	068	2025-04-07 04:30:00	5.45
9527	Q15	ЗУ	SM 7	069	2025-04-07 04:30:00	0
9528	Q16	ЗУ	SM 8	070	2025-04-07 04:30:00	0
9529	Q17	ЗУ	MO 9	071	2025-04-07 04:30:00	1.11
9530	Q20	ЗУ	MO 10	072	2025-04-07 04:30:00	2.7
9531	Q21	ЗУ	MO 11	073	2025-04-07 04:30:00	9.16
9532	Q22	ЗУ	MO 12	074	2025-04-07 04:30:00	30.04
9533	Q23	ЗУ	MO 13	075	2025-04-07 04:30:00	16.87
9534	Q24	ЗУ	MO 14	076	2025-04-07 04:30:00	19.98
9535	Q25	ЗУ	MO 15	077	2025-04-07 04:30:00	16.98
9536	TP3	ЗУ	CP-300 New	078	2025-04-07 04:30:00	50.35
9537	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 05:00:00	0
9538	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 05:00:00	0.0014
9539	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 05:00:00	0.0025
9540	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 05:00:00	0.0025
9541	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 05:00:00	0
9542	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 05:00:00	0
9543	QF 1,20	ЗУ	China 1	044	2025-04-07 05:00:00	17.85
9544	QF 1,21	ЗУ	China 2	045	2025-04-07 05:00:00	14.97
9545	QF 1,22	ЗУ	China 3	046	2025-04-07 05:00:00	17.57
9546	QF 2,20	ЗУ	China 4	047	2025-04-07 05:00:00	23.01
9547	QF 2,21	ЗУ	China 5	048	2025-04-07 05:00:00	24.98
9548	QF 2,22	ЗУ	China 6	049	2025-04-07 05:00:00	23.08
9549	QF 2,23	ЗУ	China 7	050	2025-04-07 05:00:00	11.17
9550	QF 2,19	ЗУ	China 8	051	2025-04-07 05:00:00	15.75
9551	Q8	ЗУ	DIG	061	2025-04-07 05:00:00	77.42
9552	Q4	ЗУ	BG 1	062	2025-04-07 05:00:00	17.51
9553	Q9	ЗУ	BG 2	063	2025-04-07 05:00:00	19.95
9554	Q10	ЗУ	SM 2	064	2025-04-07 05:00:00	26.49
9555	Q11	ЗУ	SM 3	065	2025-04-07 05:00:00	18.14
9556	Q12	ЗУ	SM 4	066	2025-04-07 05:00:00	21.9
9557	Q13	ЗУ	SM 5	067	2025-04-07 05:00:00	0
9558	Q14	ЗУ	SM 6	068	2025-04-07 05:00:00	5.44
9559	Q15	ЗУ	SM 7	069	2025-04-07 05:00:00	0
9560	Q16	ЗУ	SM 8	070	2025-04-07 05:00:00	0
9561	Q17	ЗУ	MO 9	071	2025-04-07 05:00:00	1.09
9562	Q20	ЗУ	MO 10	072	2025-04-07 05:00:00	2.68
9563	Q21	ЗУ	MO 11	073	2025-04-07 05:00:00	9.2
9564	Q22	ЗУ	MO 12	074	2025-04-07 05:00:00	30
9565	Q23	ЗУ	MO 13	075	2025-04-07 05:00:00	16.82
9566	Q24	ЗУ	MO 14	076	2025-04-07 05:00:00	19.98
9567	Q25	ЗУ	MO 15	077	2025-04-07 05:00:00	16.93
9568	TP3	ЗУ	CP-300 New	078	2025-04-07 05:00:00	52.68
9569	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 05:30:00	0
9570	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 05:30:00	0.0005
9571	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 05:30:00	0.0027
9572	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 05:30:00	0.002
9573	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 05:30:00	0
9574	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 05:30:00	0
9575	QF 1,20	ЗУ	China 1	044	2025-04-07 05:30:00	21.47
9576	QF 1,21	ЗУ	China 2	045	2025-04-07 05:30:00	19.46
9577	QF 1,22	ЗУ	China 3	046	2025-04-07 05:30:00	21.63
9578	QF 2,20	ЗУ	China 4	047	2025-04-07 05:30:00	26.79
9579	QF 2,21	ЗУ	China 5	048	2025-04-07 05:30:00	29.41
9580	QF 2,22	ЗУ	China 6	049	2025-04-07 05:30:00	28.37
9581	QF 2,23	ЗУ	China 7	050	2025-04-07 05:30:00	13.2
9582	QF 2,19	ЗУ	China 8	051	2025-04-07 05:30:00	19.67
9583	Q8	ЗУ	DIG	061	2025-04-07 05:30:00	79.9
9584	Q4	ЗУ	BG 1	062	2025-04-07 05:30:00	17.51
9585	Q9	ЗУ	BG 2	063	2025-04-07 05:30:00	19.97
9586	Q10	ЗУ	SM 2	064	2025-04-07 05:30:00	26.5
9587	Q11	ЗУ	SM 3	065	2025-04-07 05:30:00	18.23
9588	Q12	ЗУ	SM 4	066	2025-04-07 05:30:00	21.76
9589	Q13	ЗУ	SM 5	067	2025-04-07 05:30:00	0
9590	Q14	ЗУ	SM 6	068	2025-04-07 05:30:00	5.45
9591	Q15	ЗУ	SM 7	069	2025-04-07 05:30:00	0
9592	Q16	ЗУ	SM 8	070	2025-04-07 05:30:00	0
9593	Q17	ЗУ	MO 9	071	2025-04-07 05:30:00	1.11
9594	Q20	ЗУ	MO 10	072	2025-04-07 05:30:00	2.69
9595	Q21	ЗУ	MO 11	073	2025-04-07 05:30:00	9.21
9596	Q22	ЗУ	MO 12	074	2025-04-07 05:30:00	30.09
9597	Q23	ЗУ	MO 13	075	2025-04-07 05:30:00	16.93
9598	Q24	ЗУ	MO 14	076	2025-04-07 05:30:00	19.96
9599	Q25	ЗУ	MO 15	077	2025-04-07 05:30:00	16.98
9600	TP3	ЗУ	CP-300 New	078	2025-04-07 05:30:00	50.09
9601	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 06:00:00	0
9602	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 06:00:00	0.0017
9603	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 06:00:00	0.003
9604	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 06:00:00	0.002
9605	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 06:00:00	0
9606	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 06:00:00	0
9607	QF 1,20	ЗУ	China 1	044	2025-04-07 06:00:00	20.76
9608	QF 1,21	ЗУ	China 2	045	2025-04-07 06:00:00	18.98
9609	QF 1,22	ЗУ	China 3	046	2025-04-07 06:00:00	20.83
9610	QF 2,20	ЗУ	China 4	047	2025-04-07 06:00:00	25.53
9611	QF 2,21	ЗУ	China 5	048	2025-04-07 06:00:00	28.98
9612	QF 2,22	ЗУ	China 6	049	2025-04-07 06:00:00	27.4
9613	QF 2,23	ЗУ	China 7	050	2025-04-07 06:00:00	12.81
9614	QF 2,19	ЗУ	China 8	051	2025-04-07 06:00:00	18.75
9615	Q8	ЗУ	DIG	061	2025-04-07 06:00:00	79.97
9616	Q4	ЗУ	BG 1	062	2025-04-07 06:00:00	17.56
9617	Q9	ЗУ	BG 2	063	2025-04-07 06:00:00	20
9618	Q10	ЗУ	SM 2	064	2025-04-07 06:00:00	26.57
9619	Q11	ЗУ	SM 3	065	2025-04-07 06:00:00	18.29
9620	Q12	ЗУ	SM 4	066	2025-04-07 06:00:00	21.73
9621	Q13	ЗУ	SM 5	067	2025-04-07 06:00:00	0
9622	Q14	ЗУ	SM 6	068	2025-04-07 06:00:00	5.48
9623	Q15	ЗУ	SM 7	069	2025-04-07 06:00:00	0
9624	Q16	ЗУ	SM 8	070	2025-04-07 06:00:00	0
9625	Q17	ЗУ	MO 9	071	2025-04-07 06:00:00	1.15
9626	Q20	ЗУ	MO 10	072	2025-04-07 06:00:00	2.71
9627	Q21	ЗУ	MO 11	073	2025-04-07 06:00:00	9.19
9628	Q22	ЗУ	MO 12	074	2025-04-07 06:00:00	30.26
9629	Q23	ЗУ	MO 13	075	2025-04-07 06:00:00	16.99
9630	Q24	ЗУ	MO 14	076	2025-04-07 06:00:00	19.97
9631	Q25	ЗУ	MO 15	077	2025-04-07 06:00:00	17.04
9632	TP3	ЗУ	CP-300 New	078	2025-04-07 06:00:00	44.78
9633	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 06:30:00	0
9634	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 06:30:00	0.0006
9635	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 06:30:00	0.0026
9636	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 06:30:00	0.0031
9637	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 06:30:00	0
9638	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 06:30:00	0
9639	QF 1,20	ЗУ	China 1	044	2025-04-07 06:30:00	21.14
9640	QF 1,21	ЗУ	China 2	045	2025-04-07 06:30:00	19.13
9641	QF 1,22	ЗУ	China 3	046	2025-04-07 06:30:00	21.57
9642	QF 2,20	ЗУ	China 4	047	2025-04-07 06:30:00	25.25
9643	QF 2,21	ЗУ	China 5	048	2025-04-07 06:30:00	29.54
9644	QF 2,22	ЗУ	China 6	049	2025-04-07 06:30:00	27.98
9645	QF 2,23	ЗУ	China 7	050	2025-04-07 06:30:00	12.93
9646	QF 2,19	ЗУ	China 8	051	2025-04-07 06:30:00	19.14
9647	Q8	ЗУ	DIG	061	2025-04-07 06:30:00	75.02
9648	Q4	ЗУ	BG 1	062	2025-04-07 06:30:00	17.58
9649	Q9	ЗУ	BG 2	063	2025-04-07 06:30:00	20.04
9650	Q10	ЗУ	SM 2	064	2025-04-07 06:30:00	26.56
9651	Q11	ЗУ	SM 3	065	2025-04-07 06:30:00	18.18
9652	Q12	ЗУ	SM 4	066	2025-04-07 06:30:00	21.78
9653	Q13	ЗУ	SM 5	067	2025-04-07 06:30:00	0
9654	Q14	ЗУ	SM 6	068	2025-04-07 06:30:00	5.48
9655	Q15	ЗУ	SM 7	069	2025-04-07 06:30:00	0
9656	Q16	ЗУ	SM 8	070	2025-04-07 06:30:00	0
9657	Q17	ЗУ	MO 9	071	2025-04-07 06:30:00	1.14
9658	Q20	ЗУ	MO 10	072	2025-04-07 06:30:00	2.71
9659	Q21	ЗУ	MO 11	073	2025-04-07 06:30:00	9.19
9660	Q22	ЗУ	MO 12	074	2025-04-07 06:30:00	30.27
9661	Q23	ЗУ	MO 13	075	2025-04-07 06:30:00	16.97
9662	Q24	ЗУ	MO 14	076	2025-04-07 06:30:00	19.98
9663	Q25	ЗУ	MO 15	077	2025-04-07 06:30:00	17.05
9664	TP3	ЗУ	CP-300 New	078	2025-04-07 06:30:00	37.25
9665	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 07:00:00	0
9666	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 07:00:00	0.0011
9667	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 07:00:00	0.0025
9668	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 07:00:00	0.003
9669	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 07:00:00	0
9670	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 07:00:00	0
9671	QF 1,20	ЗУ	China 1	044	2025-04-07 07:00:00	22.4
9672	QF 1,21	ЗУ	China 2	045	2025-04-07 07:00:00	20.96
9673	QF 1,22	ЗУ	China 3	046	2025-04-07 07:00:00	22.84
9674	QF 2,20	ЗУ	China 4	047	2025-04-07 07:00:00	26.51
9675	QF 2,21	ЗУ	China 5	048	2025-04-07 07:00:00	31.15
9676	QF 2,22	ЗУ	China 6	049	2025-04-07 07:00:00	29.41
9677	QF 2,23	ЗУ	China 7	050	2025-04-07 07:00:00	13.63
9678	QF 2,19	ЗУ	China 8	051	2025-04-07 07:00:00	20.96
9679	Q8	ЗУ	DIG	061	2025-04-07 07:00:00	70.46
9680	Q4	ЗУ	BG 1	062	2025-04-07 07:00:00	17.56
9681	Q9	ЗУ	BG 2	063	2025-04-07 07:00:00	20.04
9682	Q10	ЗУ	SM 2	064	2025-04-07 07:00:00	26.51
9683	Q11	ЗУ	SM 3	065	2025-04-07 07:00:00	18.11
9684	Q12	ЗУ	SM 4	066	2025-04-07 07:00:00	22.38
9685	Q13	ЗУ	SM 5	067	2025-04-07 07:00:00	0
9686	Q14	ЗУ	SM 6	068	2025-04-07 07:00:00	5.44
9687	Q15	ЗУ	SM 7	069	2025-04-07 07:00:00	0
9688	Q16	ЗУ	SM 8	070	2025-04-07 07:00:00	0
9689	Q17	ЗУ	MO 9	071	2025-04-07 07:00:00	1.12
9690	Q20	ЗУ	MO 10	072	2025-04-07 07:00:00	2.7
9691	Q21	ЗУ	MO 11	073	2025-04-07 07:00:00	9.2
9692	Q22	ЗУ	MO 12	074	2025-04-07 07:00:00	30.19
9693	Q23	ЗУ	MO 13	075	2025-04-07 07:00:00	16.95
9694	Q24	ЗУ	MO 14	076	2025-04-07 07:00:00	19.96
9695	Q25	ЗУ	MO 15	077	2025-04-07 07:00:00	17.04
9696	TP3	ЗУ	CP-300 New	078	2025-04-07 07:00:00	31.18
9697	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 07:30:00	0
9698	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 07:30:00	0.0014
9699	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 07:30:00	0.0031
9700	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 07:30:00	0.0033
9701	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 07:30:00	0
9702	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 07:30:00	0
9703	QF 1,20	ЗУ	China 1	044	2025-04-07 07:30:00	24.17
9704	QF 1,21	ЗУ	China 2	045	2025-04-07 07:30:00	22.73
9705	QF 1,22	ЗУ	China 3	046	2025-04-07 07:30:00	25.37
9706	QF 2,20	ЗУ	China 4	047	2025-04-07 07:30:00	27.7
9707	QF 2,21	ЗУ	China 5	048	2025-04-07 07:30:00	33.23
9708	QF 2,22	ЗУ	China 6	049	2025-04-07 07:30:00	31.88
9709	QF 2,23	ЗУ	China 7	050	2025-04-07 07:30:00	14.69
9710	QF 2,19	ЗУ	China 8	051	2025-04-07 07:30:00	22.68
9711	Q8	ЗУ	DIG	061	2025-04-07 07:30:00	64.52
9712	Q4	ЗУ	BG 1	062	2025-04-07 07:30:00	17.6
9713	Q9	ЗУ	BG 2	063	2025-04-07 07:30:00	20.04
9714	Q10	ЗУ	SM 2	064	2025-04-07 07:30:00	26.39
9715	Q11	ЗУ	SM 3	065	2025-04-07 07:30:00	18.18
9716	Q12	ЗУ	SM 4	066	2025-04-07 07:30:00	21.72
9717	Q13	ЗУ	SM 5	067	2025-04-07 07:30:00	0
9718	Q14	ЗУ	SM 6	068	2025-04-07 07:30:00	5.43
9719	Q15	ЗУ	SM 7	069	2025-04-07 07:30:00	0
9720	Q16	ЗУ	SM 8	070	2025-04-07 07:30:00	0
9721	Q17	ЗУ	MO 9	071	2025-04-07 07:30:00	1.11
9722	Q20	ЗУ	MO 10	072	2025-04-07 07:30:00	2.68
9723	Q21	ЗУ	MO 11	073	2025-04-07 07:30:00	9.25
9724	Q22	ЗУ	MO 12	074	2025-04-07 07:30:00	30.1
9725	Q23	ЗУ	MO 13	075	2025-04-07 07:30:00	16.86
9726	Q24	ЗУ	MO 14	076	2025-04-07 07:30:00	19.94
9727	Q25	ЗУ	MO 15	077	2025-04-07 07:30:00	16.96
9728	TP3	ЗУ	CP-300 New	078	2025-04-07 07:30:00	30.05
9729	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 08:00:00	0.3245
9730	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 08:00:00	0.2478
9731	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 08:00:00	0.073
9732	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 08:00:00	0.0032
9733	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 08:00:00	0
9734	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 08:00:00	0
9735	QF 1,20	ЗУ	China 1	044	2025-04-07 08:00:00	25.74
9736	QF 1,21	ЗУ	China 2	045	2025-04-07 08:00:00	24.18
9737	QF 1,22	ЗУ	China 3	046	2025-04-07 08:00:00	26.06
9738	QF 2,20	ЗУ	China 4	047	2025-04-07 08:00:00	29.59
9739	QF 2,21	ЗУ	China 5	048	2025-04-07 08:00:00	34.87
9740	QF 2,22	ЗУ	China 6	049	2025-04-07 08:00:00	33.25
9741	QF 2,23	ЗУ	China 7	050	2025-04-07 08:00:00	15.3
9742	QF 2,19	ЗУ	China 8	051	2025-04-07 08:00:00	24.54
9743	Q8	ЗУ	DIG	061	2025-04-07 08:00:00	66.45
9744	Q4	ЗУ	BG 1	062	2025-04-07 08:00:00	17.57
9745	Q9	ЗУ	BG 2	063	2025-04-07 08:00:00	20.02
9746	Q10	ЗУ	SM 2	064	2025-04-07 08:00:00	26.48
9747	Q11	ЗУ	SM 3	065	2025-04-07 08:00:00	18.11
9748	Q12	ЗУ	SM 4	066	2025-04-07 08:00:00	21.63
9749	Q13	ЗУ	SM 5	067	2025-04-07 08:00:00	0
9750	Q14	ЗУ	SM 6	068	2025-04-07 08:00:00	5.42
9751	Q15	ЗУ	SM 7	069	2025-04-07 08:00:00	0
9752	Q16	ЗУ	SM 8	070	2025-04-07 08:00:00	0
9753	Q17	ЗУ	MO 9	071	2025-04-07 08:00:00	1.1
9754	Q20	ЗУ	MO 10	072	2025-04-07 08:00:00	2.69
9755	Q21	ЗУ	MO 11	073	2025-04-07 08:00:00	9.24
9756	Q22	ЗУ	MO 12	074	2025-04-07 08:00:00	30.12
9757	Q23	ЗУ	MO 13	075	2025-04-07 08:00:00	16.77
9758	Q24	ЗУ	MO 14	076	2025-04-07 08:00:00	19.96
9759	Q25	ЗУ	MO 15	077	2025-04-07 08:00:00	16.96
9760	TP3	ЗУ	CP-300 New	078	2025-04-07 08:00:00	31.29
9761	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 08:30:00	1.98
9762	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 08:30:00	1.6
9763	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 08:30:00	0.3464
9764	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 08:30:00	0.0031
9765	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 08:30:00	0
9766	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 08:30:00	0
9767	QF 1,20	ЗУ	China 1	044	2025-04-07 08:30:00	24.61
9768	QF 1,21	ЗУ	China 2	045	2025-04-07 08:30:00	22.72
9769	QF 1,22	ЗУ	China 3	046	2025-04-07 08:30:00	25.78
9770	QF 2,20	ЗУ	China 4	047	2025-04-07 08:30:00	27.7
9771	QF 2,21	ЗУ	China 5	048	2025-04-07 08:30:00	33.38
9772	QF 2,22	ЗУ	China 6	049	2025-04-07 08:30:00	31.92
9773	QF 2,23	ЗУ	China 7	050	2025-04-07 08:30:00	14.15
9774	QF 2,19	ЗУ	China 8	051	2025-04-07 08:30:00	23.39
9775	Q8	ЗУ	DIG	061	2025-04-07 08:30:00	47.66
9776	Q4	ЗУ	BG 1	062	2025-04-07 08:30:00	16.84
9777	Q9	ЗУ	BG 2	063	2025-04-07 08:30:00	19.99
9778	Q10	ЗУ	SM 2	064	2025-04-07 08:30:00	26.38
9779	Q11	ЗУ	SM 3	065	2025-04-07 08:30:00	18.07
9780	Q12	ЗУ	SM 4	066	2025-04-07 08:30:00	21.56
9781	Q13	ЗУ	SM 5	067	2025-04-07 08:30:00	0
9782	Q14	ЗУ	SM 6	068	2025-04-07 08:30:00	5.41
9783	Q15	ЗУ	SM 7	069	2025-04-07 08:30:00	0
9784	Q16	ЗУ	SM 8	070	2025-04-07 08:30:00	0
9785	Q17	ЗУ	MO 9	071	2025-04-07 08:30:00	1.08
9786	Q20	ЗУ	MO 10	072	2025-04-07 08:30:00	2.67
9787	Q21	ЗУ	MO 11	073	2025-04-07 08:30:00	9.27
9788	Q22	ЗУ	MO 12	074	2025-04-07 08:30:00	29.98
9789	Q23	ЗУ	MO 13	075	2025-04-07 08:30:00	16.69
9790	Q24	ЗУ	MO 14	076	2025-04-07 08:30:00	19.93
9791	Q25	ЗУ	MO 15	077	2025-04-07 08:30:00	16.92
9792	TP3	ЗУ	CP-300 New	078	2025-04-07 08:30:00	29.51
9793	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 09:00:00	13.7
9794	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 09:00:00	5.21
9795	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 09:00:00	6.79
9796	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 09:00:00	0.0032
9797	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 09:00:00	0
9798	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 09:00:00	0
9799	QF 1,20	ЗУ	China 1	044	2025-04-07 09:00:00	24.72
9800	QF 1,21	ЗУ	China 2	045	2025-04-07 09:00:00	22.94
9801	QF 1,22	ЗУ	China 3	046	2025-04-07 09:00:00	24.93
9802	QF 2,20	ЗУ	China 4	047	2025-04-07 09:00:00	27.67
9803	QF 2,21	ЗУ	China 5	048	2025-04-07 09:00:00	32.76
9804	QF 2,22	ЗУ	China 6	049	2025-04-07 09:00:00	31.11
9805	QF 2,23	ЗУ	China 7	050	2025-04-07 09:00:00	13.75
9806	QF 2,19	ЗУ	China 8	051	2025-04-07 09:00:00	23.83
9807	Q8	ЗУ	DIG	061	2025-04-07 09:00:00	44.25
9808	Q4	ЗУ	BG 1	062	2025-04-07 09:00:00	15.31
9809	Q9	ЗУ	BG 2	063	2025-04-07 09:00:00	19.98
9810	Q10	ЗУ	SM 2	064	2025-04-07 09:00:00	26.28
9811	Q11	ЗУ	SM 3	065	2025-04-07 09:00:00	17.95
9812	Q12	ЗУ	SM 4	066	2025-04-07 09:00:00	21.62
9813	Q13	ЗУ	SM 5	067	2025-04-07 09:00:00	0
9814	Q14	ЗУ	SM 6	068	2025-04-07 09:00:00	5.42
9815	Q15	ЗУ	SM 7	069	2025-04-07 09:00:00	0
9816	Q16	ЗУ	SM 8	070	2025-04-07 09:00:00	0
9817	Q17	ЗУ	MO 9	071	2025-04-07 09:00:00	1.06
9818	Q20	ЗУ	MO 10	072	2025-04-07 09:00:00	2.68
9819	Q21	ЗУ	MO 11	073	2025-04-07 09:00:00	9.19
9820	Q22	ЗУ	MO 12	074	2025-04-07 09:00:00	29.87
9821	Q23	ЗУ	MO 13	075	2025-04-07 09:00:00	16.66
9822	Q24	ЗУ	MO 14	076	2025-04-07 09:00:00	19.89
9823	Q25	ЗУ	MO 15	077	2025-04-07 09:00:00	16.84
9824	TP3	ЗУ	CP-300 New	078	2025-04-07 09:00:00	23.57
9825	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 09:30:00	26.32
9826	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 09:30:00	8.94
9827	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 09:30:00	15.92
9828	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 09:30:00	0.0033
9829	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 09:30:00	0
9830	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 09:30:00	0
9831	QF 1,20	ЗУ	China 1	044	2025-04-07 09:30:00	25.82
9832	QF 1,21	ЗУ	China 2	045	2025-04-07 09:30:00	24.4
9833	QF 1,22	ЗУ	China 3	046	2025-04-07 09:30:00	27.23
9834	QF 2,20	ЗУ	China 4	047	2025-04-07 09:30:00	29.01
9835	QF 2,21	ЗУ	China 5	048	2025-04-07 09:30:00	33.98
9836	QF 2,22	ЗУ	China 6	049	2025-04-07 09:30:00	32.09
9837	QF 2,23	ЗУ	China 7	050	2025-04-07 09:30:00	14.2
9838	QF 2,19	ЗУ	China 8	051	2025-04-07 09:30:00	25.24
9839	Q8	ЗУ	DIG	061	2025-04-07 09:30:00	51.12
9840	Q4	ЗУ	BG 1	062	2025-04-07 09:30:00	11.96
9841	Q9	ЗУ	BG 2	063	2025-04-07 09:30:00	19.95
9842	Q10	ЗУ	SM 2	064	2025-04-07 09:30:00	26.19
9843	Q11	ЗУ	SM 3	065	2025-04-07 09:30:00	17.92
9844	Q12	ЗУ	SM 4	066	2025-04-07 09:30:00	21.69
9845	Q13	ЗУ	SM 5	067	2025-04-07 09:30:00	0
9846	Q14	ЗУ	SM 6	068	2025-04-07 09:30:00	5.37
9847	Q15	ЗУ	SM 7	069	2025-04-07 09:30:00	0
9848	Q16	ЗУ	SM 8	070	2025-04-07 09:30:00	0
9849	Q17	ЗУ	MO 9	071	2025-04-07 09:30:00	1.04
9850	Q20	ЗУ	MO 10	072	2025-04-07 09:30:00	2.66
9851	Q21	ЗУ	MO 11	073	2025-04-07 09:30:00	9.2
9852	Q22	ЗУ	MO 12	074	2025-04-07 09:30:00	29.82
9853	Q23	ЗУ	MO 13	075	2025-04-07 09:30:00	16.65
9854	Q24	ЗУ	MO 14	076	2025-04-07 09:30:00	19.87
9855	Q25	ЗУ	MO 15	077	2025-04-07 09:30:00	16.79
9856	TP3	ЗУ	CP-300 New	078	2025-04-07 09:30:00	21.75
9857	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 10:00:00	26.71
9858	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 10:00:00	9.14
9859	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 10:00:00	16.03
9860	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 10:00:00	0.0034
9861	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 10:00:00	0
9862	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 10:00:00	0
9863	QF 1,20	ЗУ	China 1	044	2025-04-07 10:00:00	24.14
9864	QF 1,21	ЗУ	China 2	045	2025-04-07 10:00:00	22.38
9865	QF 1,22	ЗУ	China 3	046	2025-04-07 10:00:00	25.75
9866	QF 2,20	ЗУ	China 4	047	2025-04-07 10:00:00	26.52
9867	QF 2,21	ЗУ	China 5	048	2025-04-07 10:00:00	31.49
9868	QF 2,22	ЗУ	China 6	049	2025-04-07 10:00:00	28.65
9869	QF 2,23	ЗУ	China 7	050	2025-04-07 10:00:00	12.94
9870	QF 2,19	ЗУ	China 8	051	2025-04-07 10:00:00	23.44
9871	Q8	ЗУ	DIG	061	2025-04-07 10:00:00	50.02
9872	Q4	ЗУ	BG 1	062	2025-04-07 10:00:00	7.82
9873	Q9	ЗУ	BG 2	063	2025-04-07 10:00:00	19.97
9874	Q10	ЗУ	SM 2	064	2025-04-07 10:00:00	26.2
9875	Q11	ЗУ	SM 3	065	2025-04-07 10:00:00	17.85
9876	Q12	ЗУ	SM 4	066	2025-04-07 10:00:00	21.68
9877	Q13	ЗУ	SM 5	067	2025-04-07 10:00:00	0
9878	Q14	ЗУ	SM 6	068	2025-04-07 10:00:00	5.38
9879	Q15	ЗУ	SM 7	069	2025-04-07 10:00:00	0
9880	Q16	ЗУ	SM 8	070	2025-04-07 10:00:00	0
9881	Q17	ЗУ	MO 9	071	2025-04-07 10:00:00	1.03
9882	Q20	ЗУ	MO 10	072	2025-04-07 10:00:00	2.66
9883	Q21	ЗУ	MO 11	073	2025-04-07 10:00:00	9.2
9884	Q22	ЗУ	MO 12	074	2025-04-07 10:00:00	29.82
9885	Q23	ЗУ	MO 13	075	2025-04-07 10:00:00	16.6
9886	Q24	ЗУ	MO 14	076	2025-04-07 10:00:00	19.85
9887	Q25	ЗУ	MO 15	077	2025-04-07 10:00:00	16.8
9888	TP3	ЗУ	CP-300 New	078	2025-04-07 10:00:00	24.25
9889	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 10:30:00	42.28
9890	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 10:30:00	12.42
9891	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 10:30:00	28.46
9892	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 10:30:00	0.0033
9893	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 10:30:00	0
9894	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 10:30:00	0
9895	QF 1,20	ЗУ	China 1	044	2025-04-07 10:30:00	26.83
9896	QF 1,21	ЗУ	China 2	045	2025-04-07 10:30:00	25.2
9897	QF 1,22	ЗУ	China 3	046	2025-04-07 10:30:00	28.51
9898	QF 2,20	ЗУ	China 4	047	2025-04-07 10:30:00	30.47
9899	QF 2,21	ЗУ	China 5	048	2025-04-07 10:30:00	34.41
9900	QF 2,22	ЗУ	China 6	049	2025-04-07 10:30:00	32.05
9901	QF 2,23	ЗУ	China 7	050	2025-04-07 10:30:00	14.63
9902	QF 2,19	ЗУ	China 8	051	2025-04-07 10:30:00	27.16
9903	Q8	ЗУ	DIG	061	2025-04-07 10:30:00	50.83
9904	Q4	ЗУ	BG 1	062	2025-04-07 10:30:00	3.39
9905	Q9	ЗУ	BG 2	063	2025-04-07 10:30:00	19.96
9906	Q10	ЗУ	SM 2	064	2025-04-07 10:30:00	26.28
9907	Q11	ЗУ	SM 3	065	2025-04-07 10:30:00	17.81
9908	Q12	ЗУ	SM 4	066	2025-04-07 10:30:00	21.5
9909	Q13	ЗУ	SM 5	067	2025-04-07 10:30:00	0
9910	Q14	ЗУ	SM 6	068	2025-04-07 10:30:00	5.37
9911	Q15	ЗУ	SM 7	069	2025-04-07 10:30:00	0
9912	Q16	ЗУ	SM 8	070	2025-04-07 10:30:00	0
9913	Q17	ЗУ	MO 9	071	2025-04-07 10:30:00	1.03
9914	Q20	ЗУ	MO 10	072	2025-04-07 10:30:00	2.66
9915	Q21	ЗУ	MO 11	073	2025-04-07 10:30:00	9.23
9916	Q22	ЗУ	MO 12	074	2025-04-07 10:30:00	29.77
9917	Q23	ЗУ	MO 13	075	2025-04-07 10:30:00	16.63
9918	Q24	ЗУ	MO 14	076	2025-04-07 10:30:00	19.9
9919	Q25	ЗУ	MO 15	077	2025-04-07 10:30:00	16.8
9920	TP3	ЗУ	CP-300 New	078	2025-04-07 10:30:00	27.05
9921	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 11:00:00	42.59
9922	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 11:00:00	11.92
9923	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 11:00:00	29.07
9924	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 11:00:00	0.0035
9925	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 11:00:00	0
9926	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 11:00:00	0
9927	QF 1,20	ЗУ	China 1	044	2025-04-07 11:00:00	26.21
9928	QF 1,21	ЗУ	China 2	045	2025-04-07 11:00:00	24.53
9929	QF 1,22	ЗУ	China 3	046	2025-04-07 11:00:00	27.04
9930	QF 2,20	ЗУ	China 4	047	2025-04-07 11:00:00	29.06
9931	QF 2,21	ЗУ	China 5	048	2025-04-07 11:00:00	32.81
9932	QF 2,22	ЗУ	China 6	049	2025-04-07 11:00:00	31.36
9933	QF 2,23	ЗУ	China 7	050	2025-04-07 11:00:00	14.07
9934	QF 2,19	ЗУ	China 8	051	2025-04-07 11:00:00	26.1
9935	Q8	ЗУ	DIG	061	2025-04-07 11:00:00	52.27
9936	Q4	ЗУ	BG 1	062	2025-04-07 11:00:00	2.11
9937	Q9	ЗУ	BG 2	063	2025-04-07 11:00:00	19.95
9938	Q10	ЗУ	SM 2	064	2025-04-07 11:00:00	26.27
9939	Q11	ЗУ	SM 3	065	2025-04-07 11:00:00	17.78
9940	Q12	ЗУ	SM 4	066	2025-04-07 11:00:00	21.53
9941	Q13	ЗУ	SM 5	067	2025-04-07 11:00:00	0
9942	Q14	ЗУ	SM 6	068	2025-04-07 11:00:00	5.37
9943	Q15	ЗУ	SM 7	069	2025-04-07 11:00:00	0
9944	Q16	ЗУ	SM 8	070	2025-04-07 11:00:00	0
9945	Q17	ЗУ	MO 9	071	2025-04-07 11:00:00	1.04
9946	Q20	ЗУ	MO 10	072	2025-04-07 11:00:00	2.68
9947	Q21	ЗУ	MO 11	073	2025-04-07 11:00:00	9.24
9948	Q22	ЗУ	MO 12	074	2025-04-07 11:00:00	29.84
9949	Q23	ЗУ	MO 13	075	2025-04-07 11:00:00	16.61
9950	Q24	ЗУ	MO 14	076	2025-04-07 11:00:00	19.9
9951	Q25	ЗУ	MO 15	077	2025-04-07 11:00:00	16.77
9952	TP3	ЗУ	CP-300 New	078	2025-04-07 11:00:00	32.7
9953	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 11:30:00	42.47
9954	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 11:30:00	11.02
9955	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 11:30:00	29.61
9956	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 11:30:00	0.0035
9957	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 11:30:00	0
9958	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 11:30:00	0
9959	QF 1,20	ЗУ	China 1	044	2025-04-07 11:30:00	27.14
9960	QF 1,21	ЗУ	China 2	045	2025-04-07 11:30:00	25.35
9961	QF 1,22	ЗУ	China 3	046	2025-04-07 11:30:00	28.77
9962	QF 2,20	ЗУ	China 4	047	2025-04-07 11:30:00	31.56
9963	QF 2,21	ЗУ	China 5	048	2025-04-07 11:30:00	35.53
9964	QF 2,22	ЗУ	China 6	049	2025-04-07 11:30:00	33.11
9965	QF 2,23	ЗУ	China 7	050	2025-04-07 11:30:00	15.05
9966	QF 2,19	ЗУ	China 8	051	2025-04-07 11:30:00	27.46
9967	Q8	ЗУ	DIG	061	2025-04-07 11:30:00	53.5
9968	Q4	ЗУ	BG 1	062	2025-04-07 11:30:00	1.06
9969	Q9	ЗУ	BG 2	063	2025-04-07 11:30:00	19.93
9970	Q10	ЗУ	SM 2	064	2025-04-07 11:30:00	26.31
9971	Q11	ЗУ	SM 3	065	2025-04-07 11:30:00	17.8
9972	Q12	ЗУ	SM 4	066	2025-04-07 11:30:00	21.29
9973	Q13	ЗУ	SM 5	067	2025-04-07 11:30:00	0
9974	Q14	ЗУ	SM 6	068	2025-04-07 11:30:00	5.35
9975	Q15	ЗУ	SM 7	069	2025-04-07 11:30:00	0
9976	Q16	ЗУ	SM 8	070	2025-04-07 11:30:00	0
9977	Q17	ЗУ	MO 9	071	2025-04-07 11:30:00	1.03
9978	Q20	ЗУ	MO 10	072	2025-04-07 11:30:00	2.65
9979	Q21	ЗУ	MO 11	073	2025-04-07 11:30:00	9.23
9980	Q22	ЗУ	MO 12	074	2025-04-07 11:30:00	29.87
9981	Q23	ЗУ	MO 13	075	2025-04-07 11:30:00	16.58
9982	Q24	ЗУ	MO 14	076	2025-04-07 11:30:00	19.92
9983	Q25	ЗУ	MO 15	077	2025-04-07 11:30:00	16.81
9984	TP3	ЗУ	CP-300 New	078	2025-04-07 11:30:00	36.61
9985	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 12:00:00	42.48
9986	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 12:00:00	9.78
9987	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 12:00:00	30.53
9988	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 12:00:00	0.004
9989	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 12:00:00	0
9990	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 12:00:00	0
9991	QF 1,20	ЗУ	China 1	044	2025-04-07 12:00:00	28.37
9992	QF 1,21	ЗУ	China 2	045	2025-04-07 12:00:00	27.36
9993	QF 1,22	ЗУ	China 3	046	2025-04-07 12:00:00	30.81
9994	QF 2,20	ЗУ	China 4	047	2025-04-07 12:00:00	33.25
9995	QF 2,21	ЗУ	China 5	048	2025-04-07 12:00:00	36.18
9996	QF 2,22	ЗУ	China 6	049	2025-04-07 12:00:00	35
9997	QF 2,23	ЗУ	China 7	050	2025-04-07 12:00:00	16
9998	QF 2,19	ЗУ	China 8	051	2025-04-07 12:00:00	29.33
9999	Q8	ЗУ	DIG	061	2025-04-07 12:00:00	61.07
10000	Q4	ЗУ	BG 1	062	2025-04-07 12:00:00	1.02
10001	Q9	ЗУ	BG 2	063	2025-04-07 12:00:00	20.07
10002	Q10	ЗУ	SM 2	064	2025-04-07 12:00:00	26.35
10003	Q11	ЗУ	SM 3	065	2025-04-07 12:00:00	17.88
10004	Q12	ЗУ	SM 4	066	2025-04-07 12:00:00	21.82
10005	Q13	ЗУ	SM 5	067	2025-04-07 12:00:00	0
10006	Q14	ЗУ	SM 6	068	2025-04-07 12:00:00	5.36
10007	Q15	ЗУ	SM 7	069	2025-04-07 12:00:00	0
10008	Q16	ЗУ	SM 8	070	2025-04-07 12:00:00	0
10009	Q17	ЗУ	MO 9	071	2025-04-07 12:00:00	1.06
10010	Q20	ЗУ	MO 10	072	2025-04-07 12:00:00	2.68
10011	Q21	ЗУ	MO 11	073	2025-04-07 12:00:00	9.25
10012	Q22	ЗУ	MO 12	074	2025-04-07 12:00:00	30.05
10013	Q23	ЗУ	MO 13	075	2025-04-07 12:00:00	16.7
10014	Q24	ЗУ	MO 14	076	2025-04-07 12:00:00	19.94
10015	Q25	ЗУ	MO 15	077	2025-04-07 12:00:00	16.87
10016	TP3	ЗУ	CP-300 New	078	2025-04-07 12:00:00	40.26
10017	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 12:30:00	33.17
10018	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 12:30:00	6.7
10019	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 12:30:00	23.9
10020	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 12:30:00	0.0037
10021	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 12:30:00	0
10022	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 12:30:00	0
10023	QF 1,20	ЗУ	China 1	044	2025-04-07 12:30:00	25.23
10024	QF 1,21	ЗУ	China 2	045	2025-04-07 12:30:00	24.63
10025	QF 1,22	ЗУ	China 3	046	2025-04-07 12:30:00	27.84
10026	QF 2,20	ЗУ	China 4	047	2025-04-07 12:30:00	31.52
10027	QF 2,21	ЗУ	China 5	048	2025-04-07 12:30:00	33.97
10028	QF 2,22	ЗУ	China 6	049	2025-04-07 12:30:00	31.75
10029	QF 2,23	ЗУ	China 7	050	2025-04-07 12:30:00	14.45
10030	QF 2,19	ЗУ	China 8	051	2025-04-07 12:30:00	26.27
10031	Q8	ЗУ	DIG	061	2025-04-07 12:30:00	66.67
10032	Q4	ЗУ	BG 1	062	2025-04-07 12:30:00	0.9833
10033	Q9	ЗУ	BG 2	063	2025-04-07 12:30:00	20.03
10034	Q10	ЗУ	SM 2	064	2025-04-07 12:30:00	26.26
10035	Q11	ЗУ	SM 3	065	2025-04-07 12:30:00	17.78
10036	Q12	ЗУ	SM 4	066	2025-04-07 12:30:00	21.36
10037	Q13	ЗУ	SM 5	067	2025-04-07 12:30:00	0
10038	Q14	ЗУ	SM 6	068	2025-04-07 12:30:00	5.35
10039	Q15	ЗУ	SM 7	069	2025-04-07 12:30:00	0
10040	Q16	ЗУ	SM 8	070	2025-04-07 12:30:00	0
10041	Q17	ЗУ	MO 9	071	2025-04-07 12:30:00	1.04
10042	Q20	ЗУ	MO 10	072	2025-04-07 12:30:00	2.66
10043	Q21	ЗУ	MO 11	073	2025-04-07 12:30:00	9.22
10044	Q22	ЗУ	MO 12	074	2025-04-07 12:30:00	29.89
10045	Q23	ЗУ	MO 13	075	2025-04-07 12:30:00	16.65
10046	Q24	ЗУ	MO 14	076	2025-04-07 12:30:00	19.91
10047	Q25	ЗУ	MO 15	077	2025-04-07 12:30:00	16.77
10048	TP3	ЗУ	CP-300 New	078	2025-04-07 12:30:00	41.63
10049	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 13:00:00	40.22
10050	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 13:00:00	3.9
10051	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 13:00:00	32.72
10052	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 13:00:00	0.0035
10053	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 13:00:00	0
10054	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 13:00:00	0
10055	QF 1,20	ЗУ	China 1	044	2025-04-07 13:00:00	19.72
10056	QF 1,21	ЗУ	China 2	045	2025-04-07 13:00:00	18.87
10057	QF 1,22	ЗУ	China 3	046	2025-04-07 13:00:00	21.24
10058	QF 2,20	ЗУ	China 4	047	2025-04-07 13:00:00	25.72
10059	QF 2,21	ЗУ	China 5	048	2025-04-07 13:00:00	27.92
10060	QF 2,22	ЗУ	China 6	049	2025-04-07 13:00:00	25.72
10061	QF 2,23	ЗУ	China 7	050	2025-04-07 13:00:00	11.71
10062	QF 2,19	ЗУ	China 8	051	2025-04-07 13:00:00	20.79
10063	Q8	ЗУ	DIG	061	2025-04-07 13:00:00	72.55
10064	Q4	ЗУ	BG 1	062	2025-04-07 13:00:00	0.9586
10065	Q9	ЗУ	BG 2	063	2025-04-07 13:00:00	20
10066	Q10	ЗУ	SM 2	064	2025-04-07 13:00:00	26.23
10067	Q11	ЗУ	SM 3	065	2025-04-07 13:00:00	17.67
10068	Q12	ЗУ	SM 4	066	2025-04-07 13:00:00	20.89
10069	Q13	ЗУ	SM 5	067	2025-04-07 13:00:00	0
10070	Q14	ЗУ	SM 6	068	2025-04-07 13:00:00	5.34
10071	Q15	ЗУ	SM 7	069	2025-04-07 13:00:00	0
10072	Q16	ЗУ	SM 8	070	2025-04-07 13:00:00	0
10073	Q17	ЗУ	MO 9	071	2025-04-07 13:00:00	1.03
10074	Q20	ЗУ	MO 10	072	2025-04-07 13:00:00	2.65
10075	Q21	ЗУ	MO 11	073	2025-04-07 13:00:00	9.2
10076	Q22	ЗУ	MO 12	074	2025-04-07 13:00:00	29.86
10077	Q23	ЗУ	MO 13	075	2025-04-07 13:00:00	16.66
10078	Q24	ЗУ	MO 14	076	2025-04-07 13:00:00	19.9
10079	Q25	ЗУ	MO 15	077	2025-04-07 13:00:00	16.75
10080	TP3	ЗУ	CP-300 New	078	2025-04-07 13:00:00	44.92
10081	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 13:30:00	40.17
10082	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 13:30:00	3.61
10083	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 13:30:00	32.99
10084	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 13:30:00	1.08
10085	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 13:30:00	0.8564
10086	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 13:30:00	0.8761
10087	QF 1,20	ЗУ	China 1	044	2025-04-07 13:30:00	15.89
10088	QF 1,21	ЗУ	China 2	045	2025-04-07 13:30:00	15.45
10089	QF 1,22	ЗУ	China 3	046	2025-04-07 13:30:00	18.42
10090	QF 2,20	ЗУ	China 4	047	2025-04-07 13:30:00	22.75
10091	QF 2,21	ЗУ	China 5	048	2025-04-07 13:30:00	24.4
10092	QF 2,22	ЗУ	China 6	049	2025-04-07 13:30:00	22.22
10093	QF 2,23	ЗУ	China 7	050	2025-04-07 13:30:00	10.29
10094	QF 2,19	ЗУ	China 8	051	2025-04-07 13:30:00	17.45
10095	Q8	ЗУ	DIG	061	2025-04-07 13:30:00	77.88
10096	Q4	ЗУ	BG 1	062	2025-04-07 13:30:00	0.955
10097	Q9	ЗУ	BG 2	063	2025-04-07 13:30:00	19.95
10098	Q10	ЗУ	SM 2	064	2025-04-07 13:30:00	26.31
10099	Q11	ЗУ	SM 3	065	2025-04-07 13:30:00	17.74
10100	Q12	ЗУ	SM 4	066	2025-04-07 13:30:00	21.19
10101	Q13	ЗУ	SM 5	067	2025-04-07 13:30:00	0
10102	Q14	ЗУ	SM 6	068	2025-04-07 13:30:00	5.33
10103	Q15	ЗУ	SM 7	069	2025-04-07 13:30:00	0
10104	Q16	ЗУ	SM 8	070	2025-04-07 13:30:00	0
10105	Q17	ЗУ	MO 9	071	2025-04-07 13:30:00	1.03
10106	Q20	ЗУ	MO 10	072	2025-04-07 13:30:00	2.67
10107	Q21	ЗУ	MO 11	073	2025-04-07 13:30:00	9.25
10108	Q22	ЗУ	MO 12	074	2025-04-07 13:30:00	29.99
10109	Q23	ЗУ	MO 13	075	2025-04-07 13:30:00	16.61
10110	Q24	ЗУ	MO 14	076	2025-04-07 13:30:00	19.91
10111	Q25	ЗУ	MO 15	077	2025-04-07 13:30:00	16.78
10112	TP3	ЗУ	CP-300 New	078	2025-04-07 13:30:00	50.42
10113	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 14:00:00	40.17
10114	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 14:00:00	3.69
10115	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 14:00:00	32.97
10116	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 14:00:00	4.07
10117	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 14:00:00	8.56
10118	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 14:00:00	8.44
10119	QF 1,20	ЗУ	China 1	044	2025-04-07 14:00:00	16.43
10120	QF 1,21	ЗУ	China 2	045	2025-04-07 14:00:00	15.44
10121	QF 1,22	ЗУ	China 3	046	2025-04-07 14:00:00	19.13
10122	QF 2,20	ЗУ	China 4	047	2025-04-07 14:00:00	24.07
10123	QF 2,21	ЗУ	China 5	048	2025-04-07 14:00:00	25.77
10124	QF 2,22	ЗУ	China 6	049	2025-04-07 14:00:00	24.13
10125	QF 2,23	ЗУ	China 7	050	2025-04-07 14:00:00	11.25
10126	QF 2,19	ЗУ	China 8	051	2025-04-07 14:00:00	18.03
10127	Q8	ЗУ	DIG	061	2025-04-07 14:00:00	77.2
10128	Q4	ЗУ	BG 1	062	2025-04-07 14:00:00	0.9664
10129	Q9	ЗУ	BG 2	063	2025-04-07 14:00:00	20.01
10130	Q10	ЗУ	SM 2	064	2025-04-07 14:00:00	26.26
10131	Q11	ЗУ	SM 3	065	2025-04-07 14:00:00	17.74
10132	Q12	ЗУ	SM 4	066	2025-04-07 14:00:00	21.17
10133	Q13	ЗУ	SM 5	067	2025-04-07 14:00:00	0
10134	Q14	ЗУ	SM 6	068	2025-04-07 14:00:00	5.32
10135	Q15	ЗУ	SM 7	069	2025-04-07 14:00:00	0
10136	Q16	ЗУ	SM 8	070	2025-04-07 14:00:00	0
10137	Q17	ЗУ	MO 9	071	2025-04-07 14:00:00	1.04
10138	Q20	ЗУ	MO 10	072	2025-04-07 14:00:00	2.68
10139	Q21	ЗУ	MO 11	073	2025-04-07 14:00:00	9.28
10140	Q22	ЗУ	MO 12	074	2025-04-07 14:00:00	30.34
10141	Q23	ЗУ	MO 13	075	2025-04-07 14:00:00	16.68
10142	Q24	ЗУ	MO 14	076	2025-04-07 14:00:00	19.96
10143	Q25	ЗУ	MO 15	077	2025-04-07 14:00:00	16.78
10144	TP3	ЗУ	CP-300 New	078	2025-04-07 14:00:00	54.53
10145	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 14:30:00	28.17
10146	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 14:30:00	4.09
10147	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 14:30:00	21.72
10148	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 14:30:00	8.3
10149	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 14:30:00	21.11
10150	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 14:30:00	20.65
10151	QF 1,20	ЗУ	China 1	044	2025-04-07 14:30:00	15.68
10152	QF 1,21	ЗУ	China 2	045	2025-04-07 14:30:00	14.84
10153	QF 1,22	ЗУ	China 3	046	2025-04-07 14:30:00	18.14
10154	QF 2,20	ЗУ	China 4	047	2025-04-07 14:30:00	23.68
10155	QF 2,21	ЗУ	China 5	048	2025-04-07 14:30:00	25.17
10156	QF 2,22	ЗУ	China 6	049	2025-04-07 14:30:00	23.2
10157	QF 2,23	ЗУ	China 7	050	2025-04-07 14:30:00	11.13
10158	QF 2,19	ЗУ	China 8	051	2025-04-07 14:30:00	17.2
10159	Q8	ЗУ	DIG	061	2025-04-07 14:30:00	77.3
10160	Q4	ЗУ	BG 1	062	2025-04-07 14:30:00	0.9723
10161	Q9	ЗУ	BG 2	063	2025-04-07 14:30:00	20
10162	Q10	ЗУ	SM 2	064	2025-04-07 14:30:00	26.17
10163	Q11	ЗУ	SM 3	065	2025-04-07 14:30:00	17.73
10164	Q12	ЗУ	SM 4	066	2025-04-07 14:30:00	20.88
10165	Q13	ЗУ	SM 5	067	2025-04-07 14:30:00	0
10166	Q14	ЗУ	SM 6	068	2025-04-07 14:30:00	5.33
10167	Q15	ЗУ	SM 7	069	2025-04-07 14:30:00	0
10168	Q16	ЗУ	SM 8	070	2025-04-07 14:30:00	0
10169	Q17	ЗУ	MO 9	071	2025-04-07 14:30:00	1.05
10170	Q20	ЗУ	MO 10	072	2025-04-07 14:30:00	2.66
10171	Q21	ЗУ	MO 11	073	2025-04-07 14:30:00	9.25
10172	Q22	ЗУ	MO 12	074	2025-04-07 14:30:00	30.43
10173	Q23	ЗУ	MO 13	075	2025-04-07 14:30:00	16.69
10174	Q24	ЗУ	MO 14	076	2025-04-07 14:30:00	20
10175	Q25	ЗУ	MO 15	077	2025-04-07 14:30:00	16.86
10176	TP3	ЗУ	CP-300 New	078	2025-04-07 14:30:00	63.29
10177	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 15:00:00	25.6
10178	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 15:00:00	4.29
10179	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 15:00:00	19.18
10180	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 15:00:00	10.25
10181	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 15:00:00	26.49
10182	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 15:00:00	26.01
10183	QF 1,20	ЗУ	China 1	044	2025-04-07 15:00:00	15.97
10184	QF 1,21	ЗУ	China 2	045	2025-04-07 15:00:00	14.97
10185	QF 1,22	ЗУ	China 3	046	2025-04-07 15:00:00	18.39
10186	QF 2,20	ЗУ	China 4	047	2025-04-07 15:00:00	23.13
10187	QF 2,21	ЗУ	China 5	048	2025-04-07 15:00:00	25.44
10188	QF 2,22	ЗУ	China 6	049	2025-04-07 15:00:00	23.66
10189	QF 2,23	ЗУ	China 7	050	2025-04-07 15:00:00	11.68
10190	QF 2,19	ЗУ	China 8	051	2025-04-07 15:00:00	17.37
10191	Q8	ЗУ	DIG	061	2025-04-07 15:00:00	77.29
10192	Q4	ЗУ	BG 1	062	2025-04-07 15:00:00	0.9759
10193	Q9	ЗУ	BG 2	063	2025-04-07 15:00:00	19.95
10194	Q10	ЗУ	SM 2	064	2025-04-07 15:00:00	26.23
10195	Q11	ЗУ	SM 3	065	2025-04-07 15:00:00	17.72
10196	Q12	ЗУ	SM 4	066	2025-04-07 15:00:00	20.66
10197	Q13	ЗУ	SM 5	067	2025-04-07 15:00:00	0
10198	Q14	ЗУ	SM 6	068	2025-04-07 15:00:00	5.31
10199	Q15	ЗУ	SM 7	069	2025-04-07 15:00:00	0
10200	Q16	ЗУ	SM 8	070	2025-04-07 15:00:00	0
10201	Q17	ЗУ	MO 9	071	2025-04-07 15:00:00	1.05
10202	Q20	ЗУ	MO 10	072	2025-04-07 15:00:00	2.66
10203	Q21	ЗУ	MO 11	073	2025-04-07 15:00:00	9.24
10204	Q22	ЗУ	MO 12	074	2025-04-07 15:00:00	30.42
10205	Q23	ЗУ	MO 13	075	2025-04-07 15:00:00	16.74
10206	Q24	ЗУ	MO 14	076	2025-04-07 15:00:00	19.95
10207	Q25	ЗУ	MO 15	077	2025-04-07 15:00:00	16.82
10208	TP3	ЗУ	CP-300 New	078	2025-04-07 15:00:00	68.22
10209	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 15:30:00	25.69
10210	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 15:30:00	4.44
10211	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 15:30:00	19.18
10212	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 15:30:00	12.85
10213	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 15:30:00	36.6
10214	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 15:30:00	35.97
10215	QF 1,20	ЗУ	China 1	044	2025-04-07 15:30:00	17.09
10216	QF 1,21	ЗУ	China 2	045	2025-04-07 15:30:00	15.81
10217	QF 1,22	ЗУ	China 3	046	2025-04-07 15:30:00	19.31
10218	QF 2,20	ЗУ	China 4	047	2025-04-07 15:30:00	24.02
10219	QF 2,21	ЗУ	China 5	048	2025-04-07 15:30:00	26.83
10220	QF 2,22	ЗУ	China 6	049	2025-04-07 15:30:00	24.8
10221	QF 2,23	ЗУ	China 7	050	2025-04-07 15:30:00	12.25
10222	QF 2,19	ЗУ	China 8	051	2025-04-07 15:30:00	18.57
10223	Q8	ЗУ	DIG	061	2025-04-07 15:30:00	67.78
10224	Q4	ЗУ	BG 1	062	2025-04-07 15:30:00	1.01
10225	Q9	ЗУ	BG 2	063	2025-04-07 15:30:00	19.95
10226	Q10	ЗУ	SM 2	064	2025-04-07 15:30:00	26.39
10227	Q11	ЗУ	SM 3	065	2025-04-07 15:30:00	17.69
10228	Q12	ЗУ	SM 4	066	2025-04-07 15:30:00	20.78
10229	Q13	ЗУ	SM 5	067	2025-04-07 15:30:00	0
10230	Q14	ЗУ	SM 6	068	2025-04-07 15:30:00	5.29
10231	Q15	ЗУ	SM 7	069	2025-04-07 15:30:00	0
10232	Q16	ЗУ	SM 8	070	2025-04-07 15:30:00	0
10233	Q17	ЗУ	MO 9	071	2025-04-07 15:30:00	1.07
10234	Q20	ЗУ	MO 10	072	2025-04-07 15:30:00	2.67
10235	Q21	ЗУ	MO 11	073	2025-04-07 15:30:00	8.82
10236	Q22	ЗУ	MO 12	074	2025-04-07 15:30:00	30.18
10237	Q23	ЗУ	MO 13	075	2025-04-07 15:30:00	16.76
10238	Q24	ЗУ	MO 14	076	2025-04-07 15:30:00	19.99
10239	Q25	ЗУ	MO 15	077	2025-04-07 15:30:00	16.87
10240	TP3	ЗУ	CP-300 New	078	2025-04-07 15:30:00	67.09
10241	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 16:00:00	25.56
10242	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 16:00:00	4.4
10243	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 16:00:00	19.19
10244	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 16:00:00	14.37
10245	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 16:00:00	43.64
10246	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 16:00:00	42.87
10247	QF 1,20	ЗУ	China 1	044	2025-04-07 16:00:00	19.79
10248	QF 1,21	ЗУ	China 2	045	2025-04-07 16:00:00	18.19
10249	QF 1,22	ЗУ	China 3	046	2025-04-07 16:00:00	21.45
10250	QF 2,20	ЗУ	China 4	047	2025-04-07 16:00:00	26.21
10251	QF 2,21	ЗУ	China 5	048	2025-04-07 16:00:00	29.46
10252	QF 2,22	ЗУ	China 6	049	2025-04-07 16:00:00	27.37
10253	QF 2,23	ЗУ	China 7	050	2025-04-07 16:00:00	13.59
10254	QF 2,19	ЗУ	China 8	051	2025-04-07 16:00:00	20.65
10255	Q8	ЗУ	DIG	061	2025-04-07 16:00:00	57.05
10256	Q4	ЗУ	BG 1	062	2025-04-07 16:00:00	1.03
10257	Q9	ЗУ	BG 2	063	2025-04-07 16:00:00	19.98
10258	Q10	ЗУ	SM 2	064	2025-04-07 16:00:00	26.44
10259	Q11	ЗУ	SM 3	065	2025-04-07 16:00:00	16.76
10260	Q12	ЗУ	SM 4	066	2025-04-07 16:00:00	20.84
10261	Q13	ЗУ	SM 5	067	2025-04-07 16:00:00	0
10262	Q14	ЗУ	SM 6	068	2025-04-07 16:00:00	5.29
10263	Q15	ЗУ	SM 7	069	2025-04-07 16:00:00	0
10264	Q16	ЗУ	SM 8	070	2025-04-07 16:00:00	0
10265	Q17	ЗУ	MO 9	071	2025-04-07 16:00:00	1.08
10266	Q20	ЗУ	MO 10	072	2025-04-07 16:00:00	2.68
10267	Q21	ЗУ	MO 11	073	2025-04-07 16:00:00	6.93
10268	Q22	ЗУ	MO 12	074	2025-04-07 16:00:00	30.06
10269	Q23	ЗУ	MO 13	075	2025-04-07 16:00:00	16.82
10270	Q24	ЗУ	MO 14	076	2025-04-07 16:00:00	19.98
10271	Q25	ЗУ	MO 15	077	2025-04-07 16:00:00	16.85
10272	TP3	ЗУ	CP-300 New	078	2025-04-07 16:00:00	69
10273	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 16:30:00	25.7
10274	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 16:30:00	4.51
10275	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 16:30:00	19.23
10276	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 16:30:00	13.89
10277	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 16:30:00	43.64
10278	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 16:30:00	42.81
10279	QF 1,20	ЗУ	China 1	044	2025-04-07 16:30:00	21.78
10280	QF 1,21	ЗУ	China 2	045	2025-04-07 16:30:00	19.8
10281	QF 1,22	ЗУ	China 3	046	2025-04-07 16:30:00	23.11
10282	QF 2,20	ЗУ	China 4	047	2025-04-07 16:30:00	28.21
10283	QF 2,21	ЗУ	China 5	048	2025-04-07 16:30:00	30.62
10284	QF 2,22	ЗУ	China 6	049	2025-04-07 16:30:00	29.34
10285	QF 2,23	ЗУ	China 7	050	2025-04-07 16:30:00	14.64
10286	QF 2,19	ЗУ	China 8	051	2025-04-07 16:30:00	21.99
10287	Q8	ЗУ	DIG	061	2025-04-07 16:30:00	55.06
10288	Q4	ЗУ	BG 1	062	2025-04-07 16:30:00	1.06
10289	Q9	ЗУ	BG 2	063	2025-04-07 16:30:00	19.45
10290	Q10	ЗУ	SM 2	064	2025-04-07 16:30:00	26.28
10291	Q11	ЗУ	SM 3	065	2025-04-07 16:30:00	16.8
10292	Q12	ЗУ	SM 4	066	2025-04-07 16:30:00	21.04
10293	Q13	ЗУ	SM 5	067	2025-04-07 16:30:00	0
10294	Q14	ЗУ	SM 6	068	2025-04-07 16:30:00	5.3
10295	Q15	ЗУ	SM 7	069	2025-04-07 16:30:00	0
10296	Q16	ЗУ	SM 8	070	2025-04-07 16:30:00	0
10297	Q17	ЗУ	MO 9	071	2025-04-07 16:30:00	1.11
10298	Q20	ЗУ	MO 10	072	2025-04-07 16:30:00	2.68
10299	Q21	ЗУ	MO 11	073	2025-04-07 16:30:00	6.92
10300	Q22	ЗУ	MO 12	074	2025-04-07 16:30:00	27
10301	Q23	ЗУ	MO 13	075	2025-04-07 16:30:00	16.9
10302	Q24	ЗУ	MO 14	076	2025-04-07 16:30:00	20
10303	Q25	ЗУ	MO 15	077	2025-04-07 16:30:00	16.97
10304	TP3	ЗУ	CP-300 New	078	2025-04-07 16:30:00	67.13
10305	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 17:00:00	25.51
10306	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 17:00:00	4.4
10307	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 17:00:00	19.28
10308	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 17:00:00	12.91
10309	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 17:00:00	43.48
10310	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 17:00:00	42.56
10311	QF 1,20	ЗУ	China 1	044	2025-04-07 17:00:00	24.03
10312	QF 1,21	ЗУ	China 2	045	2025-04-07 17:00:00	22.22
10313	QF 1,22	ЗУ	China 3	046	2025-04-07 17:00:00	25.21
10314	QF 2,20	ЗУ	China 4	047	2025-04-07 17:00:00	29.96
10315	QF 2,21	ЗУ	China 5	048	2025-04-07 17:00:00	33.41
10316	QF 2,22	ЗУ	China 6	049	2025-04-07 17:00:00	31.24
10317	QF 2,23	ЗУ	China 7	050	2025-04-07 17:00:00	15.71
10318	QF 2,19	ЗУ	China 8	051	2025-04-07 17:00:00	24.24
10319	Q8	ЗУ	DIG	061	2025-04-07 17:00:00	34.15
10320	Q4	ЗУ	BG 1	062	2025-04-07 17:00:00	1.1
10321	Q9	ЗУ	BG 2	063	2025-04-07 17:00:00	14.77
10322	Q10	ЗУ	SM 2	064	2025-04-07 17:00:00	24.55
10323	Q11	ЗУ	SM 3	065	2025-04-07 17:00:00	16.79
10324	Q12	ЗУ	SM 4	066	2025-04-07 17:00:00	21.06
10325	Q13	ЗУ	SM 5	067	2025-04-07 17:00:00	0
10326	Q14	ЗУ	SM 6	068	2025-04-07 17:00:00	5.32
10327	Q15	ЗУ	SM 7	069	2025-04-07 17:00:00	0
10328	Q16	ЗУ	SM 8	070	2025-04-07 17:00:00	0
10329	Q17	ЗУ	MO 9	071	2025-04-07 17:00:00	1.12
10330	Q20	ЗУ	MO 10	072	2025-04-07 17:00:00	2.69
10331	Q21	ЗУ	MO 11	073	2025-04-07 17:00:00	6.92
10332	Q22	ЗУ	MO 12	074	2025-04-07 17:00:00	24.95
10333	Q23	ЗУ	MO 13	075	2025-04-07 17:00:00	16.94
10334	Q24	ЗУ	MO 14	076	2025-04-07 17:00:00	20.01
10335	Q25	ЗУ	MO 15	077	2025-04-07 17:00:00	16.96
10336	TP3	ЗУ	CP-300 New	078	2025-04-07 17:00:00	69.31
10337	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 17:30:00	25.57
10338	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 17:30:00	4.33
10339	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 17:30:00	19.31
10340	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 17:30:00	10.44
10341	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 17:30:00	34.55
10342	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 17:30:00	33.95
10343	QF 1,20	ЗУ	China 1	044	2025-04-07 17:30:00	24.72
10344	QF 1,21	ЗУ	China 2	045	2025-04-07 17:30:00	23.24
10345	QF 1,22	ЗУ	China 3	046	2025-04-07 17:30:00	25.97
10346	QF 2,20	ЗУ	China 4	047	2025-04-07 17:30:00	30.62
10347	QF 2,21	ЗУ	China 5	048	2025-04-07 17:30:00	34.08
10348	QF 2,22	ЗУ	China 6	049	2025-04-07 17:30:00	31.76
10349	QF 2,23	ЗУ	China 7	050	2025-04-07 17:30:00	16.08
10350	QF 2,19	ЗУ	China 8	051	2025-04-07 17:30:00	24.73
10351	Q8	ЗУ	DIG	061	2025-04-07 17:30:00	49.1
10352	Q4	ЗУ	BG 1	062	2025-04-07 17:30:00	1.06
10353	Q9	ЗУ	BG 2	063	2025-04-07 17:30:00	14.72
10354	Q10	ЗУ	SM 2	064	2025-04-07 17:30:00	23.18
10355	Q11	ЗУ	SM 3	065	2025-04-07 17:30:00	16.7
10356	Q12	ЗУ	SM 4	066	2025-04-07 17:30:00	20.9
10357	Q13	ЗУ	SM 5	067	2025-04-07 17:30:00	0
10358	Q14	ЗУ	SM 6	068	2025-04-07 17:30:00	5.32
10359	Q15	ЗУ	SM 7	069	2025-04-07 17:30:00	0
10360	Q16	ЗУ	SM 8	070	2025-04-07 17:30:00	0
10361	Q17	ЗУ	MO 9	071	2025-04-07 17:30:00	1.11
10362	Q20	ЗУ	MO 10	072	2025-04-07 17:30:00	2.68
10363	Q21	ЗУ	MO 11	073	2025-04-07 17:30:00	5.77
10364	Q22	ЗУ	MO 12	074	2025-04-07 17:30:00	24.88
10365	Q23	ЗУ	MO 13	075	2025-04-07 17:30:00	16.92
10366	Q24	ЗУ	MO 14	076	2025-04-07 17:30:00	19.97
10367	Q25	ЗУ	MO 15	077	2025-04-07 17:30:00	16.96
10368	TP3	ЗУ	CP-300 New	078	2025-04-07 17:30:00	67.41
10369	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 18:00:00	6.11
10370	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 18:00:00	1.36
10371	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 18:00:00	4.17
10372	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 18:00:00	8.62
10373	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 18:00:00	42.07
10374	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 18:00:00	40.61
10375	QF 1,20	ЗУ	China 1	044	2025-04-07 18:00:00	26.96
10376	QF 1,21	ЗУ	China 2	045	2025-04-07 18:00:00	24.95
10377	QF 1,22	ЗУ	China 3	046	2025-04-07 18:00:00	27.33
10378	QF 2,20	ЗУ	China 4	047	2025-04-07 18:00:00	31.82
10379	QF 2,21	ЗУ	China 5	048	2025-04-07 18:00:00	35.5
10380	QF 2,22	ЗУ	China 6	049	2025-04-07 18:00:00	32.96
10381	QF 2,23	ЗУ	China 7	050	2025-04-07 18:00:00	16.54
10382	QF 2,19	ЗУ	China 8	051	2025-04-07 18:00:00	26.46
10383	Q8	ЗУ	DIG	061	2025-04-07 18:00:00	49.12
10384	Q4	ЗУ	BG 1	062	2025-04-07 18:00:00	1.06
10385	Q9	ЗУ	BG 2	063	2025-04-07 18:00:00	14.63
10386	Q10	ЗУ	SM 2	064	2025-04-07 18:00:00	24.05
10387	Q11	ЗУ	SM 3	065	2025-04-07 18:00:00	16.41
10388	Q12	ЗУ	SM 4	066	2025-04-07 18:00:00	21
10389	Q13	ЗУ	SM 5	067	2025-04-07 18:00:00	0
10390	Q14	ЗУ	SM 6	068	2025-04-07 18:00:00	5.32
10391	Q15	ЗУ	SM 7	069	2025-04-07 18:00:00	0
10392	Q16	ЗУ	SM 8	070	2025-04-07 18:00:00	0
10393	Q17	ЗУ	MO 9	071	2025-04-07 18:00:00	0.9315
10394	Q20	ЗУ	MO 10	072	2025-04-07 18:00:00	2.68
10395	Q21	ЗУ	MO 11	073	2025-04-07 18:00:00	0
10396	Q22	ЗУ	MO 12	074	2025-04-07 18:00:00	24.86
10397	Q23	ЗУ	MO 13	075	2025-04-07 18:00:00	16.94
10398	Q24	ЗУ	MO 14	076	2025-04-07 18:00:00	19.97
10399	Q25	ЗУ	MO 15	077	2025-04-07 18:00:00	16.94
10400	TP3	ЗУ	CP-300 New	078	2025-04-07 18:00:00	67.13
10401	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 18:30:00	0
10402	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 18:30:00	0.0013
10403	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 18:30:00	0.0025
10404	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 18:30:00	6.45
10405	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 18:30:00	42.14
10406	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 18:30:00	40.42
10407	QF 1,20	ЗУ	China 1	044	2025-04-07 18:30:00	25.92
10408	QF 1,21	ЗУ	China 2	045	2025-04-07 18:30:00	22.81
10409	QF 1,22	ЗУ	China 3	046	2025-04-07 18:30:00	26.4
10410	QF 2,20	ЗУ	China 4	047	2025-04-07 18:30:00	30.29
10411	QF 2,21	ЗУ	China 5	048	2025-04-07 18:30:00	33.64
10412	QF 2,22	ЗУ	China 6	049	2025-04-07 18:30:00	30.51
10413	QF 2,23	ЗУ	China 7	050	2025-04-07 18:30:00	15.07
10414	QF 2,19	ЗУ	China 8	051	2025-04-07 18:30:00	25.31
10415	Q8	ЗУ	DIG	061	2025-04-07 18:30:00	32.93
10416	Q4	ЗУ	BG 1	062	2025-04-07 18:30:00	1.08
10417	Q9	ЗУ	BG 2	063	2025-04-07 18:30:00	12.42
10418	Q10	ЗУ	SM 2	064	2025-04-07 18:30:00	24.53
10419	Q11	ЗУ	SM 3	065	2025-04-07 18:30:00	16.85
10420	Q12	ЗУ	SM 4	066	2025-04-07 18:30:00	21
10421	Q13	ЗУ	SM 5	067	2025-04-07 18:30:00	0
10422	Q14	ЗУ	SM 6	068	2025-04-07 18:30:00	5.32
10423	Q15	ЗУ	SM 7	069	2025-04-07 18:30:00	0
10424	Q16	ЗУ	SM 8	070	2025-04-07 18:30:00	0
10425	Q17	ЗУ	MO 9	071	2025-04-07 18:30:00	0
10426	Q20	ЗУ	MO 10	072	2025-04-07 18:30:00	2.68
10427	Q21	ЗУ	MO 11	073	2025-04-07 18:30:00	0
10428	Q22	ЗУ	MO 12	074	2025-04-07 18:30:00	14.91
10429	Q23	ЗУ	MO 13	075	2025-04-07 18:30:00	16.91
10430	Q24	ЗУ	MO 14	076	2025-04-07 18:30:00	19.98
10431	Q25	ЗУ	MO 15	077	2025-04-07 18:30:00	17.01
10432	TP3	ЗУ	CP-300 New	078	2025-04-07 18:30:00	68.41
10433	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 19:00:00	0
10434	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 19:00:00	0.0013
10435	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 19:00:00	0.0029
10436	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 19:00:00	6.68
10437	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 19:00:00	42.19
10438	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 19:00:00	40.5
10439	QF 1,20	ЗУ	China 1	044	2025-04-07 19:00:00	28.83
10440	QF 1,21	ЗУ	China 2	045	2025-04-07 19:00:00	25.72
10441	QF 1,22	ЗУ	China 3	046	2025-04-07 19:00:00	29.15
10442	QF 2,20	ЗУ	China 4	047	2025-04-07 19:00:00	31.56
10443	QF 2,21	ЗУ	China 5	048	2025-04-07 19:00:00	36.06
10444	QF 2,22	ЗУ	China 6	049	2025-04-07 19:00:00	34.23
10445	QF 2,23	ЗУ	China 7	050	2025-04-07 19:00:00	16.84
10446	QF 2,19	ЗУ	China 8	051	2025-04-07 19:00:00	28.25
10447	Q8	ЗУ	DIG	061	2025-04-07 19:00:00	38.43
10448	Q4	ЗУ	BG 1	062	2025-04-07 19:00:00	1.11
10449	Q9	ЗУ	BG 2	063	2025-04-07 19:00:00	3.17
10450	Q10	ЗУ	SM 2	064	2025-04-07 19:00:00	24.38
10451	Q11	ЗУ	SM 3	065	2025-04-07 19:00:00	16.81
10452	Q12	ЗУ	SM 4	066	2025-04-07 19:00:00	20.91
10453	Q13	ЗУ	SM 5	067	2025-04-07 19:00:00	0
10454	Q14	ЗУ	SM 6	068	2025-04-07 19:00:00	5.35
10455	Q15	ЗУ	SM 7	069	2025-04-07 19:00:00	0
10456	Q16	ЗУ	SM 8	070	2025-04-07 19:00:00	0
10457	Q17	ЗУ	MO 9	071	2025-04-07 19:00:00	0
10458	Q20	ЗУ	MO 10	072	2025-04-07 19:00:00	2.69
10459	Q21	ЗУ	MO 11	073	2025-04-07 19:00:00	0
10460	Q22	ЗУ	MO 12	074	2025-04-07 19:00:00	0
10461	Q23	ЗУ	MO 13	075	2025-04-07 19:00:00	16.95
10462	Q24	ЗУ	MO 14	076	2025-04-07 19:00:00	20.04
10463	Q25	ЗУ	MO 15	077	2025-04-07 19:00:00	17.16
10464	TP3	ЗУ	CP-300 New	078	2025-04-07 19:00:00	72.52
10465	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 19:30:00	0
10466	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 19:30:00	0.0014
10467	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 19:30:00	0.0027
10468	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 19:30:00	6.5
10469	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 19:30:00	36.08
10470	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 19:30:00	34.7
10471	QF 1,20	ЗУ	China 1	044	2025-04-07 19:30:00	29.48
10472	QF 1,21	ЗУ	China 2	045	2025-04-07 19:30:00	26.3
10473	QF 1,22	ЗУ	China 3	046	2025-04-07 19:30:00	29.6
10474	QF 2,20	ЗУ	China 4	047	2025-04-07 19:30:00	33.41
10475	QF 2,21	ЗУ	China 5	048	2025-04-07 19:30:00	37.46
10476	QF 2,22	ЗУ	China 6	049	2025-04-07 19:30:00	35.36
10477	QF 2,23	ЗУ	China 7	050	2025-04-07 19:30:00	17.16
10478	QF 2,19	ЗУ	China 8	051	2025-04-07 19:30:00	28.96
10479	Q8	ЗУ	DIG	061	2025-04-07 19:30:00	44.51
10480	Q4	ЗУ	BG 1	062	2025-04-07 19:30:00	1.1
10481	Q9	ЗУ	BG 2	063	2025-04-07 19:30:00	3.17
10482	Q10	ЗУ	SM 2	064	2025-04-07 19:30:00	22.91
10483	Q11	ЗУ	SM 3	065	2025-04-07 19:30:00	16.81
10484	Q12	ЗУ	SM 4	066	2025-04-07 19:30:00	20.87
10485	Q13	ЗУ	SM 5	067	2025-04-07 19:30:00	0
10486	Q14	ЗУ	SM 6	068	2025-04-07 19:30:00	5.37
10487	Q15	ЗУ	SM 7	069	2025-04-07 19:30:00	0
10488	Q16	ЗУ	SM 8	070	2025-04-07 19:30:00	0
10489	Q17	ЗУ	MO 9	071	2025-04-07 19:30:00	0
10490	Q20	ЗУ	MO 10	072	2025-04-07 19:30:00	2.71
10491	Q21	ЗУ	MO 11	073	2025-04-07 19:30:00	0
10492	Q22	ЗУ	MO 12	074	2025-04-07 19:30:00	0
10493	Q23	ЗУ	MO 13	075	2025-04-07 19:30:00	16.96
10494	Q24	ЗУ	MO 14	076	2025-04-07 19:30:00	20.03
10495	Q25	ЗУ	MO 15	077	2025-04-07 19:30:00	17.15
10496	TP3	ЗУ	CP-300 New	078	2025-04-07 19:30:00	77.4
10497	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 20:00:00	0
10498	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 20:00:00	0.0012
10499	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 20:00:00	0.0029
10500	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 20:00:00	6.01
10501	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 20:00:00	26.28
10502	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 20:00:00	25.42
10503	QF 1,20	ЗУ	China 1	044	2025-04-07 20:00:00	27.25
10504	QF 1,21	ЗУ	China 2	045	2025-04-07 20:00:00	26
10505	QF 1,22	ЗУ	China 3	046	2025-04-07 20:00:00	28.65
10506	QF 2,20	ЗУ	China 4	047	2025-04-07 20:00:00	31.73
10507	QF 2,21	ЗУ	China 5	048	2025-04-07 20:00:00	34.57
10508	QF 2,22	ЗУ	China 6	049	2025-04-07 20:00:00	32.27
10509	QF 2,23	ЗУ	China 7	050	2025-04-07 20:00:00	16.07
10510	QF 2,19	ЗУ	China 8	051	2025-04-07 20:00:00	27.27
10511	Q8	ЗУ	DIG	061	2025-04-07 20:00:00	50.83
10512	Q4	ЗУ	BG 1	062	2025-04-07 20:00:00	1.1
10513	Q9	ЗУ	BG 2	063	2025-04-07 20:00:00	3.07
10514	Q10	ЗУ	SM 2	064	2025-04-07 20:00:00	24.89
10515	Q11	ЗУ	SM 3	065	2025-04-07 20:00:00	15.86
10516	Q12	ЗУ	SM 4	066	2025-04-07 20:00:00	20.55
10517	Q13	ЗУ	SM 5	067	2025-04-07 20:00:00	0
10518	Q14	ЗУ	SM 6	068	2025-04-07 20:00:00	5.36
10519	Q15	ЗУ	SM 7	069	2025-04-07 20:00:00	0
10520	Q16	ЗУ	SM 8	070	2025-04-07 20:00:00	0
10521	Q17	ЗУ	MO 9	071	2025-04-07 20:00:00	0
10522	Q20	ЗУ	MO 10	072	2025-04-07 20:00:00	2.69
10523	Q21	ЗУ	MO 11	073	2025-04-07 20:00:00	0
10524	Q22	ЗУ	MO 12	074	2025-04-07 20:00:00	0
10525	Q23	ЗУ	MO 13	075	2025-04-07 20:00:00	16.95
10526	Q24	ЗУ	MO 14	076	2025-04-07 20:00:00	19.99
10527	Q25	ЗУ	MO 15	077	2025-04-07 20:00:00	17.12
10528	TP3	ЗУ	CP-300 New	078	2025-04-07 20:00:00	70.45
10529	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 20:30:00	0
10530	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 20:30:00	0.0015
10531	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 20:30:00	0.003
10532	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 20:30:00	5.98
10533	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 20:30:00	26.28
10534	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 20:30:00	25.41
10535	QF 1,20	ЗУ	China 1	044	2025-04-07 20:30:00	27.72
10536	QF 1,21	ЗУ	China 2	045	2025-04-07 20:30:00	25.44
10537	QF 1,22	ЗУ	China 3	046	2025-04-07 20:30:00	28.36
10538	QF 2,20	ЗУ	China 4	047	2025-04-07 20:30:00	31.4
10539	QF 2,21	ЗУ	China 5	048	2025-04-07 20:30:00	34.83
10540	QF 2,22	ЗУ	China 6	049	2025-04-07 20:30:00	32.35
10541	QF 2,23	ЗУ	China 7	050	2025-04-07 20:30:00	16.02
10542	QF 2,19	ЗУ	China 8	051	2025-04-07 20:30:00	26.51
10543	Q8	ЗУ	DIG	061	2025-04-07 20:30:00	50.73
10544	Q4	ЗУ	BG 1	062	2025-04-07 20:30:00	1.08
10545	Q9	ЗУ	BG 2	063	2025-04-07 20:30:00	0.6072
10546	Q10	ЗУ	SM 2	064	2025-04-07 20:30:00	25.35
10547	Q11	ЗУ	SM 3	065	2025-04-07 20:30:00	15.8
10548	Q12	ЗУ	SM 4	066	2025-04-07 20:30:00	18.81
10549	Q13	ЗУ	SM 5	067	2025-04-07 20:30:00	0
10550	Q14	ЗУ	SM 6	068	2025-04-07 20:30:00	5.37
10551	Q15	ЗУ	SM 7	069	2025-04-07 20:30:00	0
10552	Q16	ЗУ	SM 8	070	2025-04-07 20:30:00	0
10553	Q17	ЗУ	MO 9	071	2025-04-07 20:30:00	0
10554	Q20	ЗУ	MO 10	072	2025-04-07 20:30:00	2.7
10555	Q21	ЗУ	MO 11	073	2025-04-07 20:30:00	0
10556	Q22	ЗУ	MO 12	074	2025-04-07 20:30:00	0
10557	Q23	ЗУ	MO 13	075	2025-04-07 20:30:00	16.94
10558	Q24	ЗУ	MO 14	076	2025-04-07 20:30:00	20.05
10559	Q25	ЗУ	MO 15	077	2025-04-07 20:30:00	17.1
10560	TP3	ЗУ	CP-300 New	078	2025-04-07 20:30:00	73.49
10561	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 21:00:00	0
10562	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 21:00:00	0.0009
10563	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 21:00:00	0.0029
10564	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 21:00:00	5.87
10565	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 21:00:00	26.16
10566	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 21:00:00	25.28
10567	QF 1,20	ЗУ	China 1	044	2025-04-07 21:00:00	28.47
10568	QF 1,21	ЗУ	China 2	045	2025-04-07 21:00:00	26.82
10569	QF 1,22	ЗУ	China 3	046	2025-04-07 21:00:00	29.12
10570	QF 2,20	ЗУ	China 4	047	2025-04-07 21:00:00	31.99
10571	QF 2,21	ЗУ	China 5	048	2025-04-07 21:00:00	35.63
10572	QF 2,22	ЗУ	China 6	049	2025-04-07 21:00:00	32.44
10573	QF 2,23	ЗУ	China 7	050	2025-04-07 21:00:00	16.5
10574	QF 2,19	ЗУ	China 8	051	2025-04-07 21:00:00	28.21
10575	Q8	ЗУ	DIG	061	2025-04-07 21:00:00	55
10576	Q4	ЗУ	BG 1	062	2025-04-07 21:00:00	3.91
10577	Q9	ЗУ	BG 2	063	2025-04-07 21:00:00	0.0996
10578	Q10	ЗУ	SM 2	064	2025-04-07 21:00:00	25.22
10579	Q11	ЗУ	SM 3	065	2025-04-07 21:00:00	13.32
10580	Q12	ЗУ	SM 4	066	2025-04-07 21:00:00	15.27
10581	Q13	ЗУ	SM 5	067	2025-04-07 21:00:00	0
10582	Q14	ЗУ	SM 6	068	2025-04-07 21:00:00	5.36
10583	Q15	ЗУ	SM 7	069	2025-04-07 21:00:00	0
10584	Q16	ЗУ	SM 8	070	2025-04-07 21:00:00	0
10585	Q17	ЗУ	MO 9	071	2025-04-07 21:00:00	0
10586	Q20	ЗУ	MO 10	072	2025-04-07 21:00:00	2.67
10587	Q21	ЗУ	MO 11	073	2025-04-07 21:00:00	0
10588	Q22	ЗУ	MO 12	074	2025-04-07 21:00:00	0
10589	Q23	ЗУ	MO 13	075	2025-04-07 21:00:00	16.92
10590	Q24	ЗУ	MO 14	076	2025-04-07 21:00:00	19.98
10591	Q25	ЗУ	MO 15	077	2025-04-07 21:00:00	17.09
10592	TP3	ЗУ	CP-300 New	078	2025-04-07 21:00:00	77.38
10593	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 21:30:00	0
10594	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 21:30:00	0.0014
10595	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 21:30:00	0.0029
10596	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 21:30:00	5.83
10597	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 21:30:00	26.31
10598	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 21:30:00	25.34
10599	QF 1,20	ЗУ	China 1	044	2025-04-07 21:30:00	22.32
10600	QF 1,21	ЗУ	China 2	045	2025-04-07 21:30:00	21.3
10601	QF 1,22	ЗУ	China 3	046	2025-04-07 21:30:00	23.92
10602	QF 2,20	ЗУ	China 4	047	2025-04-07 21:30:00	27.11
10603	QF 2,21	ЗУ	China 5	048	2025-04-07 21:30:00	29.27
10604	QF 2,22	ЗУ	China 6	049	2025-04-07 21:30:00	27.9
10605	QF 2,23	ЗУ	China 7	050	2025-04-07 21:30:00	13.66
10606	QF 2,19	ЗУ	China 8	051	2025-04-07 21:30:00	22.57
10607	Q8	ЗУ	DIG	061	2025-04-07 21:30:00	55.89
10608	Q4	ЗУ	BG 1	062	2025-04-07 21:30:00	10.1
10609	Q9	ЗУ	BG 2	063	2025-04-07 21:30:00	0
10610	Q10	ЗУ	SM 2	064	2025-04-07 21:30:00	23.73
10611	Q11	ЗУ	SM 3	065	2025-04-07 21:30:00	12.81
10612	Q12	ЗУ	SM 4	066	2025-04-07 21:30:00	14.49
10613	Q13	ЗУ	SM 5	067	2025-04-07 21:30:00	0
10614	Q14	ЗУ	SM 6	068	2025-04-07 21:30:00	5.39
10615	Q15	ЗУ	SM 7	069	2025-04-07 21:30:00	0
10616	Q16	ЗУ	SM 8	070	2025-04-07 21:30:00	0
10617	Q17	ЗУ	MO 9	071	2025-04-07 21:30:00	0
10618	Q20	ЗУ	MO 10	072	2025-04-07 21:30:00	2.7
10619	Q21	ЗУ	MO 11	073	2025-04-07 21:30:00	0
10620	Q22	ЗУ	MO 12	074	2025-04-07 21:30:00	0
10621	Q23	ЗУ	MO 13	075	2025-04-07 21:30:00	16.96
10622	Q24	ЗУ	MO 14	076	2025-04-07 21:30:00	20
10623	Q25	ЗУ	MO 15	077	2025-04-07 21:30:00	17.11
10624	TP3	ЗУ	CP-300 New	078	2025-04-07 21:30:00	70.78
10625	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 22:00:00	0
10626	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 22:00:00	0.0015
10627	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 22:00:00	0.0027
10628	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 22:00:00	5.8
10629	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 22:00:00	26.34
10630	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 22:00:00	25.37
10631	QF 1,20	ЗУ	China 1	044	2025-04-07 22:00:00	21.06
10632	QF 1,21	ЗУ	China 2	045	2025-04-07 22:00:00	19.99
10633	QF 1,22	ЗУ	China 3	046	2025-04-07 22:00:00	22.92
10634	QF 2,20	ЗУ	China 4	047	2025-04-07 22:00:00	25.43
10635	QF 2,21	ЗУ	China 5	048	2025-04-07 22:00:00	28.18
10636	QF 2,22	ЗУ	China 6	049	2025-04-07 22:00:00	25.64
10637	QF 2,23	ЗУ	China 7	050	2025-04-07 22:00:00	12.79
10638	QF 2,19	ЗУ	China 8	051	2025-04-07 22:00:00	21.85
10639	Q8	ЗУ	DIG	061	2025-04-07 22:00:00	55.88
10640	Q4	ЗУ	BG 1	062	2025-04-07 22:00:00	10.33
10641	Q9	ЗУ	BG 2	063	2025-04-07 22:00:00	0
10642	Q10	ЗУ	SM 2	064	2025-04-07 22:00:00	23.47
10643	Q11	ЗУ	SM 3	065	2025-04-07 22:00:00	10.19
10644	Q12	ЗУ	SM 4	066	2025-04-07 22:00:00	13.79
10645	Q13	ЗУ	SM 5	067	2025-04-07 22:00:00	0
10646	Q14	ЗУ	SM 6	068	2025-04-07 22:00:00	5.36
10647	Q15	ЗУ	SM 7	069	2025-04-07 22:00:00	0
10648	Q16	ЗУ	SM 8	070	2025-04-07 22:00:00	0
10649	Q17	ЗУ	MO 9	071	2025-04-07 22:00:00	0
10650	Q20	ЗУ	MO 10	072	2025-04-07 22:00:00	2.69
10651	Q21	ЗУ	MO 11	073	2025-04-07 22:00:00	0
10652	Q22	ЗУ	MO 12	074	2025-04-07 22:00:00	0
10653	Q23	ЗУ	MO 13	075	2025-04-07 22:00:00	16.78
10654	Q24	ЗУ	MO 14	076	2025-04-07 22:00:00	20.04
10655	Q25	ЗУ	MO 15	077	2025-04-07 22:00:00	17.13
10656	TP3	ЗУ	CP-300 New	078	2025-04-07 22:00:00	73.26
10657	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 22:30:00	0
10658	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 22:30:00	0.001
10659	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 22:30:00	0.0027
10660	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 22:30:00	5.93
10661	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 22:30:00	26.38
10662	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 22:30:00	25.47
10663	QF 1,20	ЗУ	China 1	044	2025-04-07 22:30:00	18.73
10664	QF 1,21	ЗУ	China 2	045	2025-04-07 22:30:00	15.96
10665	QF 1,22	ЗУ	China 3	046	2025-04-07 22:30:00	19.44
10666	QF 2,20	ЗУ	China 4	047	2025-04-07 22:30:00	22.44
10667	QF 2,21	ЗУ	China 5	048	2025-04-07 22:30:00	25.09
10668	QF 2,22	ЗУ	China 6	049	2025-04-07 22:30:00	22.43
10669	QF 2,23	ЗУ	China 7	050	2025-04-07 22:30:00	11.09
10670	QF 2,19	ЗУ	China 8	051	2025-04-07 22:30:00	18.75
10671	Q8	ЗУ	DIG	061	2025-04-07 22:30:00	56.22
10672	Q4	ЗУ	BG 1	062	2025-04-07 22:30:00	11.13
10673	Q9	ЗУ	BG 2	063	2025-04-07 22:30:00	0
10674	Q10	ЗУ	SM 2	064	2025-04-07 22:30:00	23.6
10675	Q11	ЗУ	SM 3	065	2025-04-07 22:30:00	11.62
10676	Q12	ЗУ	SM 4	066	2025-04-07 22:30:00	9.85
10677	Q13	ЗУ	SM 5	067	2025-04-07 22:30:00	0
10678	Q14	ЗУ	SM 6	068	2025-04-07 22:30:00	5.33
10679	Q15	ЗУ	SM 7	069	2025-04-07 22:30:00	0
10680	Q16	ЗУ	SM 8	070	2025-04-07 22:30:00	0
10681	Q17	ЗУ	MO 9	071	2025-04-07 22:30:00	0
10682	Q20	ЗУ	MO 10	072	2025-04-07 22:30:00	2.71
10683	Q21	ЗУ	MO 11	073	2025-04-07 22:30:00	0
10684	Q22	ЗУ	MO 12	074	2025-04-07 22:30:00	0
10685	Q23	ЗУ	MO 13	075	2025-04-07 22:30:00	10.53
10686	Q24	ЗУ	MO 14	076	2025-04-07 22:30:00	20.04
10687	Q25	ЗУ	MO 15	077	2025-04-07 22:30:00	17.18
10688	TP3	ЗУ	CP-300 New	078	2025-04-07 22:30:00	70.94
10689	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 23:00:00	0
10690	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 23:00:00	0.0014
10691	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 23:00:00	0.0026
10692	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 23:00:00	4.29
10693	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 23:00:00	16.32
10694	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 23:00:00	15.95
10695	QF 1,20	ЗУ	China 1	044	2025-04-07 23:00:00	18.48
10696	QF 1,21	ЗУ	China 2	045	2025-04-07 23:00:00	16.27
10697	QF 1,22	ЗУ	China 3	046	2025-04-07 23:00:00	19.49
10698	QF 2,20	ЗУ	China 4	047	2025-04-07 23:00:00	21.86
10699	QF 2,21	ЗУ	China 5	048	2025-04-07 23:00:00	24.51
10700	QF 2,22	ЗУ	China 6	049	2025-04-07 23:00:00	22
10701	QF 2,23	ЗУ	China 7	050	2025-04-07 23:00:00	11.02
10702	QF 2,19	ЗУ	China 8	051	2025-04-07 23:00:00	18.65
10703	Q8	ЗУ	DIG	061	2025-04-07 23:00:00	58.13
10704	Q4	ЗУ	BG 1	062	2025-04-07 23:00:00	11.15
10705	Q9	ЗУ	BG 2	063	2025-04-07 23:00:00	0
10706	Q10	ЗУ	SM 2	064	2025-04-07 23:00:00	24.71
10707	Q11	ЗУ	SM 3	065	2025-04-07 23:00:00	11.88
10708	Q12	ЗУ	SM 4	066	2025-04-07 23:00:00	6.22
10709	Q13	ЗУ	SM 5	067	2025-04-07 23:00:00	0
10710	Q14	ЗУ	SM 6	068	2025-04-07 23:00:00	5.35
10711	Q15	ЗУ	SM 7	069	2025-04-07 23:00:00	0
10712	Q16	ЗУ	SM 8	070	2025-04-07 23:00:00	0
10713	Q17	ЗУ	MO 9	071	2025-04-07 23:00:00	0
10714	Q20	ЗУ	MO 10	072	2025-04-07 23:00:00	2.71
10715	Q21	ЗУ	MO 11	073	2025-04-07 23:00:00	0
10716	Q22	ЗУ	MO 12	074	2025-04-07 23:00:00	0.2861
10717	Q23	ЗУ	MO 13	075	2025-04-07 23:00:00	10.55
10718	Q24	ЗУ	MO 14	076	2025-04-07 23:00:00	20.05
10719	Q25	ЗУ	MO 15	077	2025-04-07 23:00:00	17.26
10720	TP3	ЗУ	CP-300 New	078	2025-04-07 23:00:00	69.49
10721	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-07 23:30:00	0.6575
10722	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-07 23:30:00	0.5057
10723	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-07 23:30:00	0.1056
10724	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-07 23:30:00	0.0025
10725	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-07 23:30:00	0
10726	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-07 23:30:00	0
10727	QF 1,20	ЗУ	China 1	044	2025-04-07 23:30:00	17.35
10728	QF 1,21	ЗУ	China 2	045	2025-04-07 23:30:00	15.47
10729	QF 1,22	ЗУ	China 3	046	2025-04-07 23:30:00	17.87
10730	QF 2,20	ЗУ	China 4	047	2025-04-07 23:30:00	19.61
10731	QF 2,21	ЗУ	China 5	048	2025-04-07 23:30:00	22.07
10732	QF 2,22	ЗУ	China 6	049	2025-04-07 23:30:00	19.92
10733	QF 2,23	ЗУ	China 7	050	2025-04-07 23:30:00	9.89
10734	QF 2,19	ЗУ	China 8	051	2025-04-07 23:30:00	17.42
10735	Q8	ЗУ	DIG	061	2025-04-07 23:30:00	60.66
10736	Q4	ЗУ	BG 1	062	2025-04-07 23:30:00	11.98
10737	Q9	ЗУ	BG 2	063	2025-04-07 23:30:00	0
10738	Q10	ЗУ	SM 2	064	2025-04-07 23:30:00	23.58
10739	Q11	ЗУ	SM 3	065	2025-04-07 23:30:00	12.12
10740	Q12	ЗУ	SM 4	066	2025-04-07 23:30:00	0
10741	Q13	ЗУ	SM 5	067	2025-04-07 23:30:00	0
10742	Q14	ЗУ	SM 6	068	2025-04-07 23:30:00	5.39
10743	Q15	ЗУ	SM 7	069	2025-04-07 23:30:00	0
10744	Q16	ЗУ	SM 8	070	2025-04-07 23:30:00	0
10745	Q17	ЗУ	MO 9	071	2025-04-07 23:30:00	0
10746	Q20	ЗУ	MO 10	072	2025-04-07 23:30:00	2.71
10747	Q21	ЗУ	MO 11	073	2025-04-07 23:30:00	0
10748	Q22	ЗУ	MO 12	074	2025-04-07 23:30:00	1.25
10749	Q23	ЗУ	MO 13	075	2025-04-07 23:30:00	10.53
10750	Q24	ЗУ	MO 14	076	2025-04-07 23:30:00	20
10751	Q25	ЗУ	MO 15	077	2025-04-07 23:30:00	17.18
10752	TP3	ЗУ	CP-300 New	078	2025-04-07 23:30:00	77.76
10753	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 00:00:00	0
10754	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 00:00:00	0.0011
10755	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 00:00:00	0.0025
10756	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 00:00:00	0.0025
10757	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 00:00:00	0
10758	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 00:00:00	0
10759	QF 1,20	ЗУ	China 1	044	2025-04-08 00:00:00	15.89
10760	QF 1,21	ЗУ	China 2	045	2025-04-08 00:00:00	13.77
10761	QF 1,22	ЗУ	China 3	046	2025-04-08 00:00:00	16.82
10762	QF 2,20	ЗУ	China 4	047	2025-04-08 00:00:00	17.93
10763	QF 2,21	ЗУ	China 5	048	2025-04-08 00:00:00	20.5
10764	QF 2,22	ЗУ	China 6	049	2025-04-08 00:00:00	18.24
10765	QF 2,23	ЗУ	China 7	050	2025-04-08 00:00:00	9.17
10766	QF 2,19	ЗУ	China 8	051	2025-04-08 00:00:00	15.96
10767	Q8	ЗУ	DIG	061	2025-04-08 00:00:00	65.25
10768	Q4	ЗУ	BG 1	062	2025-04-08 00:00:00	13.34
10769	Q9	ЗУ	BG 2	063	2025-04-08 00:00:00	0
10770	Q10	ЗУ	SM 2	064	2025-04-08 00:00:00	23.08
10771	Q11	ЗУ	SM 3	065	2025-04-08 00:00:00	10.8
10772	Q12	ЗУ	SM 4	066	2025-04-08 00:00:00	0
10773	Q13	ЗУ	SM 5	067	2025-04-08 00:00:00	0
10774	Q14	ЗУ	SM 6	068	2025-04-08 00:00:00	5.47
10775	Q15	ЗУ	SM 7	069	2025-04-08 00:00:00	0
10776	Q16	ЗУ	SM 8	070	2025-04-08 00:00:00	0
10777	Q17	ЗУ	MO 9	071	2025-04-08 00:00:00	0
10778	Q20	ЗУ	MO 10	072	2025-04-08 00:00:00	2.71
10779	Q21	ЗУ	MO 11	073	2025-04-08 00:00:00	0
10780	Q22	ЗУ	MO 12	074	2025-04-08 00:00:00	0.334
10781	Q23	ЗУ	MO 13	075	2025-04-08 00:00:00	10.14
10782	Q24	ЗУ	MO 14	076	2025-04-08 00:00:00	20.01
10783	Q25	ЗУ	MO 15	077	2025-04-08 00:00:00	17.19
10784	TP3	ЗУ	CP-300 New	078	2025-04-08 00:00:00	74.38
10785	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 00:30:00	0
10786	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 00:30:00	0.0011
10787	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 00:30:00	0.0028
10788	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 00:30:00	0.0029
10789	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 00:30:00	0
10790	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 00:30:00	0
10791	QF 1,20	ЗУ	China 1	044	2025-04-08 00:30:00	18.06
10792	QF 1,21	ЗУ	China 2	045	2025-04-08 00:30:00	15.89
10793	QF 1,22	ЗУ	China 3	046	2025-04-08 00:30:00	18.56
10794	QF 2,20	ЗУ	China 4	047	2025-04-08 00:30:00	19.36
10795	QF 2,21	ЗУ	China 5	048	2025-04-08 00:30:00	21.52
10796	QF 2,22	ЗУ	China 6	049	2025-04-08 00:30:00	20.01
10797	QF 2,23	ЗУ	China 7	050	2025-04-08 00:30:00	10.08
10798	QF 2,19	ЗУ	China 8	051	2025-04-08 00:30:00	17.48
10799	Q8	ЗУ	DIG	061	2025-04-08 00:30:00	71.11
10800	Q4	ЗУ	BG 1	062	2025-04-08 00:30:00	14.47
10801	Q9	ЗУ	BG 2	063	2025-04-08 00:30:00	0
10802	Q10	ЗУ	SM 2	064	2025-04-08 00:30:00	24.89
10803	Q11	ЗУ	SM 3	065	2025-04-08 00:30:00	10.45
10804	Q12	ЗУ	SM 4	066	2025-04-08 00:30:00	0
10805	Q13	ЗУ	SM 5	067	2025-04-08 00:30:00	0
10806	Q14	ЗУ	SM 6	068	2025-04-08 00:30:00	5.46
10807	Q15	ЗУ	SM 7	069	2025-04-08 00:30:00	0
10808	Q16	ЗУ	SM 8	070	2025-04-08 00:30:00	0
10809	Q17	ЗУ	MO 9	071	2025-04-08 00:30:00	0
10810	Q20	ЗУ	MO 10	072	2025-04-08 00:30:00	2.72
10811	Q21	ЗУ	MO 11	073	2025-04-08 00:30:00	0
10812	Q22	ЗУ	MO 12	074	2025-04-08 00:30:00	6.49
10813	Q23	ЗУ	MO 13	075	2025-04-08 00:30:00	1.04
10814	Q24	ЗУ	MO 14	076	2025-04-08 00:30:00	19.98
10815	Q25	ЗУ	MO 15	077	2025-04-08 00:30:00	17.26
10816	TP3	ЗУ	CP-300 New	078	2025-04-08 00:30:00	70.09
10817	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 01:00:00	0
10818	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 01:00:00	0.0014
10819	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 01:00:00	0.0025
10820	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 01:00:00	0.0031
10821	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 01:00:00	0
10822	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 01:00:00	0
10823	QF 1,20	ЗУ	China 1	044	2025-04-08 01:00:00	15.14
10824	QF 1,21	ЗУ	China 2	045	2025-04-08 01:00:00	12.89
10825	QF 1,22	ЗУ	China 3	046	2025-04-08 01:00:00	15.58
10826	QF 2,20	ЗУ	China 4	047	2025-04-08 01:00:00	16.73
10827	QF 2,21	ЗУ	China 5	048	2025-04-08 01:00:00	18.99
10828	QF 2,22	ЗУ	China 6	049	2025-04-08 01:00:00	17.21
10829	QF 2,23	ЗУ	China 7	050	2025-04-08 01:00:00	8.84
10830	QF 2,19	ЗУ	China 8	051	2025-04-08 01:00:00	15.18
10831	Q8	ЗУ	DIG	061	2025-04-08 01:00:00	62.24
10832	Q4	ЗУ	BG 1	062	2025-04-08 01:00:00	15.15
10833	Q9	ЗУ	BG 2	063	2025-04-08 01:00:00	0
10834	Q10	ЗУ	SM 2	064	2025-04-08 01:00:00	23.48
10835	Q11	ЗУ	SM 3	065	2025-04-08 01:00:00	2.03
10836	Q12	ЗУ	SM 4	066	2025-04-08 01:00:00	0
10837	Q13	ЗУ	SM 5	067	2025-04-08 01:00:00	0
10838	Q14	ЗУ	SM 6	068	2025-04-08 01:00:00	5.47
10839	Q15	ЗУ	SM 7	069	2025-04-08 01:00:00	0
10840	Q16	ЗУ	SM 8	070	2025-04-08 01:00:00	0
10841	Q17	ЗУ	MO 9	071	2025-04-08 01:00:00	0
10842	Q20	ЗУ	MO 10	072	2025-04-08 01:00:00	2.68
10843	Q21	ЗУ	MO 11	073	2025-04-08 01:00:00	0
10844	Q22	ЗУ	MO 12	074	2025-04-08 01:00:00	16.27
10845	Q23	ЗУ	MO 13	075	2025-04-08 01:00:00	10.99
10846	Q24	ЗУ	MO 14	076	2025-04-08 01:00:00	20.03
10847	Q25	ЗУ	MO 15	077	2025-04-08 01:00:00	17.21
10848	TP3	ЗУ	CP-300 New	078	2025-04-08 01:00:00	68.76
10849	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 01:30:00	0
10850	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 01:30:00	0.0013
10851	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 01:30:00	0.0026
10852	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 01:30:00	0.0031
10853	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 01:30:00	0
10854	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 01:30:00	0
10855	QF 1,20	ЗУ	China 1	044	2025-04-08 01:30:00	15.07
10856	QF 1,21	ЗУ	China 2	045	2025-04-08 01:30:00	12.58
10857	QF 1,22	ЗУ	China 3	046	2025-04-08 01:30:00	15.32
10858	QF 2,20	ЗУ	China 4	047	2025-04-08 01:30:00	16.86
10859	QF 2,21	ЗУ	China 5	048	2025-04-08 01:30:00	19.12
10860	QF 2,22	ЗУ	China 6	049	2025-04-08 01:30:00	17.39
10861	QF 2,23	ЗУ	China 7	050	2025-04-08 01:30:00	8.85
10862	QF 2,19	ЗУ	China 8	051	2025-04-08 01:30:00	15
10863	Q8	ЗУ	DIG	061	2025-04-08 01:30:00	61.54
10864	Q4	ЗУ	BG 1	062	2025-04-08 01:30:00	16.4
10865	Q9	ЗУ	BG 2	063	2025-04-08 01:30:00	0
10866	Q10	ЗУ	SM 2	064	2025-04-08 01:30:00	22.23
10867	Q11	ЗУ	SM 3	065	2025-04-08 01:30:00	0
10868	Q12	ЗУ	SM 4	066	2025-04-08 01:30:00	0
10869	Q13	ЗУ	SM 5	067	2025-04-08 01:30:00	0
10870	Q14	ЗУ	SM 6	068	2025-04-08 01:30:00	5.49
10871	Q15	ЗУ	SM 7	069	2025-04-08 01:30:00	0
10872	Q16	ЗУ	SM 8	070	2025-04-08 01:30:00	0
10873	Q17	ЗУ	MO 9	071	2025-04-08 01:30:00	0
10874	Q20	ЗУ	MO 10	072	2025-04-08 01:30:00	2.7
10875	Q21	ЗУ	MO 11	073	2025-04-08 01:30:00	0
10876	Q22	ЗУ	MO 12	074	2025-04-08 01:30:00	16.3
10877	Q23	ЗУ	MO 13	075	2025-04-08 01:30:00	11.06
10878	Q24	ЗУ	MO 14	076	2025-04-08 01:30:00	19.82
10879	Q25	ЗУ	MO 15	077	2025-04-08 01:30:00	17.18
10880	TP3	ЗУ	CP-300 New	078	2025-04-08 01:30:00	70.97
10881	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 02:00:00	0
10882	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 02:00:00	0.0011
10883	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 02:00:00	0.0028
10884	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 02:00:00	0.003
10885	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 02:00:00	0
10886	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 02:00:00	0
10887	QF 1,20	ЗУ	China 1	044	2025-04-08 02:00:00	14.53
10888	QF 1,21	ЗУ	China 2	045	2025-04-08 02:00:00	12.08
10889	QF 1,22	ЗУ	China 3	046	2025-04-08 02:00:00	14.54
10890	QF 2,20	ЗУ	China 4	047	2025-04-08 02:00:00	16.39
10891	QF 2,21	ЗУ	China 5	048	2025-04-08 02:00:00	18.62
10892	QF 2,22	ЗУ	China 6	049	2025-04-08 02:00:00	16.75
10893	QF 2,23	ЗУ	China 7	050	2025-04-08 02:00:00	8.55
10894	QF 2,19	ЗУ	China 8	051	2025-04-08 02:00:00	14.33
10895	Q8	ЗУ	DIG	061	2025-04-08 02:00:00	63.74
10896	Q4	ЗУ	BG 1	062	2025-04-08 02:00:00	17.16
10897	Q9	ЗУ	BG 2	063	2025-04-08 02:00:00	0
10898	Q10	ЗУ	SM 2	064	2025-04-08 02:00:00	19.93
10899	Q11	ЗУ	SM 3	065	2025-04-08 02:00:00	0
10900	Q12	ЗУ	SM 4	066	2025-04-08 02:00:00	0
10901	Q13	ЗУ	SM 5	067	2025-04-08 02:00:00	0
10902	Q14	ЗУ	SM 6	068	2025-04-08 02:00:00	5.53
10903	Q15	ЗУ	SM 7	069	2025-04-08 02:00:00	0
10904	Q16	ЗУ	SM 8	070	2025-04-08 02:00:00	0
10905	Q17	ЗУ	MO 9	071	2025-04-08 02:00:00	0
10906	Q20	ЗУ	MO 10	072	2025-04-08 02:00:00	2.7
10907	Q21	ЗУ	MO 11	073	2025-04-08 02:00:00	0
10908	Q22	ЗУ	MO 12	074	2025-04-08 02:00:00	16.35
10909	Q23	ЗУ	MO 13	075	2025-04-08 02:00:00	11.09
10910	Q24	ЗУ	MO 14	076	2025-04-08 02:00:00	18.58
10911	Q25	ЗУ	MO 15	077	2025-04-08 02:00:00	17.25
10912	TP3	ЗУ	CP-300 New	078	2025-04-08 02:00:00	71.24
10913	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 02:30:00	0
10914	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 02:30:00	0.0011
10915	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 02:30:00	0.0025
10916	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 02:30:00	0.0031
10917	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 02:30:00	0
10918	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 02:30:00	0
10919	QF 1,20	ЗУ	China 1	044	2025-04-08 02:30:00	13.06
10920	QF 1,21	ЗУ	China 2	045	2025-04-08 02:30:00	10.65
10921	QF 1,22	ЗУ	China 3	046	2025-04-08 02:30:00	13.07
10922	QF 2,20	ЗУ	China 4	047	2025-04-08 02:30:00	15.09
10923	QF 2,21	ЗУ	China 5	048	2025-04-08 02:30:00	17.11
10924	QF 2,22	ЗУ	China 6	049	2025-04-08 02:30:00	15.53
10925	QF 2,23	ЗУ	China 7	050	2025-04-08 02:30:00	7.75
10926	QF 2,19	ЗУ	China 8	051	2025-04-08 02:30:00	12.7
10927	Q8	ЗУ	DIG	061	2025-04-08 02:30:00	50.43
10928	Q4	ЗУ	BG 1	062	2025-04-08 02:30:00	17.99
10929	Q9	ЗУ	BG 2	063	2025-04-08 02:30:00	1.59
10930	Q10	ЗУ	SM 2	064	2025-04-08 02:30:00	19.87
10931	Q11	ЗУ	SM 3	065	2025-04-08 02:30:00	0
10932	Q12	ЗУ	SM 4	066	2025-04-08 02:30:00	0
10933	Q13	ЗУ	SM 5	067	2025-04-08 02:30:00	0
10934	Q14	ЗУ	SM 6	068	2025-04-08 02:30:00	5.55
10935	Q15	ЗУ	SM 7	069	2025-04-08 02:30:00	0
10936	Q16	ЗУ	SM 8	070	2025-04-08 02:30:00	0
10937	Q17	ЗУ	MO 9	071	2025-04-08 02:30:00	0
10938	Q20	ЗУ	MO 10	072	2025-04-08 02:30:00	2.72
10939	Q21	ЗУ	MO 11	073	2025-04-08 02:30:00	0
10940	Q22	ЗУ	MO 12	074	2025-04-08 02:30:00	16.38
10941	Q23	ЗУ	MO 13	075	2025-04-08 02:30:00	10.68
10942	Q24	ЗУ	MO 14	076	2025-04-08 02:30:00	18.57
10943	Q25	ЗУ	MO 15	077	2025-04-08 02:30:00	17.23
10944	TP3	ЗУ	CP-300 New	078	2025-04-08 02:30:00	68.16
10945	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 03:00:00	0
10946	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 03:00:00	0.0016
10947	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 03:00:00	0.0027
10948	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 03:00:00	0.003
10949	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 03:00:00	0
10950	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 03:00:00	0
10951	QF 1,20	ЗУ	China 1	044	2025-04-08 03:00:00	11.55
10952	QF 1,21	ЗУ	China 2	045	2025-04-08 03:00:00	9.3
10953	QF 1,22	ЗУ	China 3	046	2025-04-08 03:00:00	11.23
10954	QF 2,20	ЗУ	China 4	047	2025-04-08 03:00:00	13.56
10955	QF 2,21	ЗУ	China 5	048	2025-04-08 03:00:00	15.13
10956	QF 2,22	ЗУ	China 6	049	2025-04-08 03:00:00	13.68
10957	QF 2,23	ЗУ	China 7	050	2025-04-08 03:00:00	6.32
10958	QF 2,19	ЗУ	China 8	051	2025-04-08 03:00:00	9.91
10959	Q8	ЗУ	DIG	061	2025-04-08 03:00:00	61.7
10960	Q4	ЗУ	BG 1	062	2025-04-08 03:00:00	18.02
10961	Q9	ЗУ	BG 2	063	2025-04-08 03:00:00	9.61
10962	Q10	ЗУ	SM 2	064	2025-04-08 03:00:00	9.77
10963	Q11	ЗУ	SM 3	065	2025-04-08 03:00:00	0
10964	Q12	ЗУ	SM 4	066	2025-04-08 03:00:00	0
10965	Q13	ЗУ	SM 5	067	2025-04-08 03:00:00	0
10966	Q14	ЗУ	SM 6	068	2025-04-08 03:00:00	2.56
10967	Q15	ЗУ	SM 7	069	2025-04-08 03:00:00	0
10968	Q16	ЗУ	SM 8	070	2025-04-08 03:00:00	0
10969	Q17	ЗУ	MO 9	071	2025-04-08 03:00:00	0
10970	Q20	ЗУ	MO 10	072	2025-04-08 03:00:00	2.71
10971	Q21	ЗУ	MO 11	073	2025-04-08 03:00:00	0
10972	Q22	ЗУ	MO 12	074	2025-04-08 03:00:00	16.4
10973	Q23	ЗУ	MO 13	075	2025-04-08 03:00:00	0.4133
10974	Q24	ЗУ	MO 14	076	2025-04-08 03:00:00	18.54
10975	Q25	ЗУ	MO 15	077	2025-04-08 03:00:00	16.07
10976	TP3	ЗУ	CP-300 New	078	2025-04-08 03:00:00	63.82
10977	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 03:30:00	0
10978	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 03:30:00	0.0014
10979	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 03:30:00	0.0022
10980	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 03:30:00	0.003
10981	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 03:30:00	0
10982	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 03:30:00	0
10983	QF 1,20	ЗУ	China 1	044	2025-04-08 03:30:00	10.65
10984	QF 1,21	ЗУ	China 2	045	2025-04-08 03:30:00	7.38
10985	QF 1,22	ЗУ	China 3	046	2025-04-08 03:30:00	9.65
10986	QF 2,20	ЗУ	China 4	047	2025-04-08 03:30:00	13.02
10987	QF 2,21	ЗУ	China 5	048	2025-04-08 03:30:00	14.5
10988	QF 2,22	ЗУ	China 6	049	2025-04-08 03:30:00	12.87
10989	QF 2,23	ЗУ	China 7	050	2025-04-08 03:30:00	5.55
10990	QF 2,19	ЗУ	China 8	051	2025-04-08 03:30:00	8.18
10991	Q8	ЗУ	DIG	061	2025-04-08 03:30:00	63.48
10992	Q4	ЗУ	BG 1	062	2025-04-08 03:30:00	18
10993	Q9	ЗУ	BG 2	063	2025-04-08 03:30:00	9.63
10994	Q10	ЗУ	SM 2	064	2025-04-08 03:30:00	9.83
10995	Q11	ЗУ	SM 3	065	2025-04-08 03:30:00	0
10996	Q12	ЗУ	SM 4	066	2025-04-08 03:30:00	0
10997	Q13	ЗУ	SM 5	067	2025-04-08 03:30:00	0
10998	Q14	ЗУ	SM 6	068	2025-04-08 03:30:00	1.37
10999	Q15	ЗУ	SM 7	069	2025-04-08 03:30:00	0
11000	Q16	ЗУ	SM 8	070	2025-04-08 03:30:00	0
11001	Q17	ЗУ	MO 9	071	2025-04-08 03:30:00	0
11002	Q20	ЗУ	MO 10	072	2025-04-08 03:30:00	2.72
11003	Q21	ЗУ	MO 11	073	2025-04-08 03:30:00	0
11004	Q22	ЗУ	MO 12	074	2025-04-08 03:30:00	16.44
11005	Q23	ЗУ	MO 13	075	2025-04-08 03:30:00	0.4123
11006	Q24	ЗУ	MO 14	076	2025-04-08 03:30:00	16.62
11007	Q25	ЗУ	MO 15	077	2025-04-08 03:30:00	16.11
11008	TP3	ЗУ	CP-300 New	078	2025-04-08 03:30:00	69.52
11009	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 04:00:00	0
11010	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 04:00:00	0.0013
11011	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 04:00:00	0.0028
11012	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 04:00:00	0.0027
11013	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 04:00:00	0
11014	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 04:00:00	0
11015	QF 1,20	ЗУ	China 1	044	2025-04-08 04:00:00	12.21
11016	QF 1,21	ЗУ	China 2	045	2025-04-08 04:00:00	9.87
11017	QF 1,22	ЗУ	China 3	046	2025-04-08 04:00:00	11.32
11018	QF 2,20	ЗУ	China 4	047	2025-04-08 04:00:00	15.76
11019	QF 2,21	ЗУ	China 5	048	2025-04-08 04:00:00	16.56
11020	QF 2,22	ЗУ	China 6	049	2025-04-08 04:00:00	15.31
11021	QF 2,23	ЗУ	China 7	050	2025-04-08 04:00:00	6.66
11022	QF 2,19	ЗУ	China 8	051	2025-04-08 04:00:00	9.5
11023	Q8	ЗУ	DIG	061	2025-04-08 04:00:00	67.48
11024	Q4	ЗУ	BG 1	062	2025-04-08 04:00:00	18.05
11025	Q9	ЗУ	BG 2	063	2025-04-08 04:00:00	9.63
11026	Q10	ЗУ	SM 2	064	2025-04-08 04:00:00	9.66
11027	Q11	ЗУ	SM 3	065	2025-04-08 04:00:00	0
11028	Q12	ЗУ	SM 4	066	2025-04-08 04:00:00	0
11029	Q13	ЗУ	SM 5	067	2025-04-08 04:00:00	0
11030	Q14	ЗУ	SM 6	068	2025-04-08 04:00:00	1.38
11031	Q15	ЗУ	SM 7	069	2025-04-08 04:00:00	0
11032	Q16	ЗУ	SM 8	070	2025-04-08 04:00:00	0
11033	Q17	ЗУ	MO 9	071	2025-04-08 04:00:00	0
11034	Q20	ЗУ	MO 10	072	2025-04-08 04:00:00	2.72
11035	Q21	ЗУ	MO 11	073	2025-04-08 04:00:00	0
11036	Q22	ЗУ	MO 12	074	2025-04-08 04:00:00	16.53
11037	Q23	ЗУ	MO 13	075	2025-04-08 04:00:00	0.4008
11038	Q24	ЗУ	MO 14	076	2025-04-08 04:00:00	3.36
11039	Q25	ЗУ	MO 15	077	2025-04-08 04:00:00	16.15
11040	TP3	ЗУ	CP-300 New	078	2025-04-08 04:00:00	64.77
11041	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 04:30:00	0
11042	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 04:30:00	0.001
11043	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 04:30:00	0.003
11044	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 04:30:00	0.0029
11045	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 04:30:00	0
11046	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 04:30:00	0
11047	QF 1,20	ЗУ	China 1	044	2025-04-08 04:30:00	13.25
11048	QF 1,21	ЗУ	China 2	045	2025-04-08 04:30:00	11.25
11049	QF 1,22	ЗУ	China 3	046	2025-04-08 04:30:00	12.64
11050	QF 2,20	ЗУ	China 4	047	2025-04-08 04:30:00	17.69
11051	QF 2,21	ЗУ	China 5	048	2025-04-08 04:30:00	18.37
11052	QF 2,22	ЗУ	China 6	049	2025-04-08 04:30:00	17.35
11053	QF 2,23	ЗУ	China 7	050	2025-04-08 04:30:00	7.63
11054	QF 2,19	ЗУ	China 8	051	2025-04-08 04:30:00	10.81
11055	Q8	ЗУ	DIG	061	2025-04-08 04:30:00	68.97
11056	Q4	ЗУ	BG 1	062	2025-04-08 04:30:00	17.99
11057	Q9	ЗУ	BG 2	063	2025-04-08 04:30:00	9.6
11058	Q10	ЗУ	SM 2	064	2025-04-08 04:30:00	8.77
11059	Q11	ЗУ	SM 3	065	2025-04-08 04:30:00	0
11060	Q12	ЗУ	SM 4	066	2025-04-08 04:30:00	0
11061	Q13	ЗУ	SM 5	067	2025-04-08 04:30:00	0
11062	Q14	ЗУ	SM 6	068	2025-04-08 04:30:00	1.37
11063	Q15	ЗУ	SM 7	069	2025-04-08 04:30:00	0
11064	Q16	ЗУ	SM 8	070	2025-04-08 04:30:00	0
11065	Q17	ЗУ	MO 9	071	2025-04-08 04:30:00	0
11066	Q20	ЗУ	MO 10	072	2025-04-08 04:30:00	2.72
11067	Q21	ЗУ	MO 11	073	2025-04-08 04:30:00	0
11068	Q22	ЗУ	MO 12	074	2025-04-08 04:30:00	16.5
11069	Q23	ЗУ	MO 13	075	2025-04-08 04:30:00	0.4012
11070	Q24	ЗУ	MO 14	076	2025-04-08 04:30:00	3.36
11071	Q25	ЗУ	MO 15	077	2025-04-08 04:30:00	16.16
11072	TP3	ЗУ	CP-300 New	078	2025-04-08 04:30:00	61.54
11073	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 05:00:00	0
11074	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 05:00:00	0.0014
11075	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 05:00:00	0.0027
11076	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 05:00:00	0.0028
11077	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 05:00:00	0
11078	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 05:00:00	0
11079	QF 1,20	ЗУ	China 1	044	2025-04-08 05:00:00	14.39
11080	QF 1,21	ЗУ	China 2	045	2025-04-08 05:00:00	12.48
11081	QF 1,22	ЗУ	China 3	046	2025-04-08 05:00:00	14.26
11082	QF 2,20	ЗУ	China 4	047	2025-04-08 05:00:00	19.61
11083	QF 2,21	ЗУ	China 5	048	2025-04-08 05:00:00	19.9
11084	QF 2,22	ЗУ	China 6	049	2025-04-08 05:00:00	19.89
11085	QF 2,23	ЗУ	China 7	050	2025-04-08 05:00:00	8.6
11086	QF 2,19	ЗУ	China 8	051	2025-04-08 05:00:00	13.15
11087	Q8	ЗУ	DIG	061	2025-04-08 05:00:00	71.5
11088	Q4	ЗУ	BG 1	062	2025-04-08 05:00:00	17.96
11089	Q9	ЗУ	BG 2	063	2025-04-08 05:00:00	9.64
11090	Q10	ЗУ	SM 2	064	2025-04-08 05:00:00	5.67
11091	Q11	ЗУ	SM 3	065	2025-04-08 05:00:00	0
11092	Q12	ЗУ	SM 4	066	2025-04-08 05:00:00	0
11093	Q13	ЗУ	SM 5	067	2025-04-08 05:00:00	0
11094	Q14	ЗУ	SM 6	068	2025-04-08 05:00:00	1.37
11095	Q15	ЗУ	SM 7	069	2025-04-08 05:00:00	0
11096	Q16	ЗУ	SM 8	070	2025-04-08 05:00:00	0
11097	Q17	ЗУ	MO 9	071	2025-04-08 05:00:00	0
11098	Q20	ЗУ	MO 10	072	2025-04-08 05:00:00	2.72
11099	Q21	ЗУ	MO 11	073	2025-04-08 05:00:00	0
11100	Q22	ЗУ	MO 12	074	2025-04-08 05:00:00	16.55
11101	Q23	ЗУ	MO 13	075	2025-04-08 05:00:00	0.2537
11102	Q24	ЗУ	MO 14	076	2025-04-08 05:00:00	2.09
11103	Q25	ЗУ	MO 15	077	2025-04-08 05:00:00	0.2258
11104	TP3	ЗУ	CP-300 New	078	2025-04-08 05:00:00	59.32
11105	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 05:30:00	0
11106	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 05:30:00	0.0021
11107	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 05:30:00	0.0029
11108	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 05:30:00	0.0029
11109	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 05:30:00	0
11110	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 05:30:00	0
11111	QF 1,20	ЗУ	China 1	044	2025-04-08 05:30:00	14.9
11112	QF 1,21	ЗУ	China 2	045	2025-04-08 05:30:00	13.05
11113	QF 1,22	ЗУ	China 3	046	2025-04-08 05:30:00	14.87
11114	QF 2,20	ЗУ	China 4	047	2025-04-08 05:30:00	20.39
11115	QF 2,21	ЗУ	China 5	048	2025-04-08 05:30:00	21.01
11116	QF 2,22	ЗУ	China 6	049	2025-04-08 05:30:00	20.78
11117	QF 2,23	ЗУ	China 7	050	2025-04-08 05:30:00	9.03
11118	QF 2,19	ЗУ	China 8	051	2025-04-08 05:30:00	13.65
11119	Q8	ЗУ	DIG	061	2025-04-08 05:30:00	70.09
11120	Q4	ЗУ	BG 1	062	2025-04-08 05:30:00	17.97
11121	Q9	ЗУ	BG 2	063	2025-04-08 05:30:00	9.67
11122	Q10	ЗУ	SM 2	064	2025-04-08 05:30:00	3.77
11123	Q11	ЗУ	SM 3	065	2025-04-08 05:30:00	0
11124	Q12	ЗУ	SM 4	066	2025-04-08 05:30:00	0
11125	Q13	ЗУ	SM 5	067	2025-04-08 05:30:00	0
11126	Q14	ЗУ	SM 6	068	2025-04-08 05:30:00	1.33
11127	Q15	ЗУ	SM 7	069	2025-04-08 05:30:00	0
11128	Q16	ЗУ	SM 8	070	2025-04-08 05:30:00	0
11129	Q17	ЗУ	MO 9	071	2025-04-08 05:30:00	0
11130	Q20	ЗУ	MO 10	072	2025-04-08 05:30:00	2.74
11131	Q21	ЗУ	MO 11	073	2025-04-08 05:30:00	0
11132	Q22	ЗУ	MO 12	074	2025-04-08 05:30:00	21.99
11133	Q23	ЗУ	MO 13	075	2025-04-08 05:30:00	0
11134	Q24	ЗУ	MO 14	076	2025-04-08 05:30:00	0
11135	Q25	ЗУ	MO 15	077	2025-04-08 05:30:00	0
11136	TP3	ЗУ	CP-300 New	078	2025-04-08 05:30:00	51.5
11137	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 06:00:00	0
11138	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 06:00:00	0.0017
11139	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 06:00:00	0.0031
11140	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 06:00:00	0.0029
11141	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 06:00:00	0
11142	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 06:00:00	0
11143	QF 1,20	ЗУ	China 1	044	2025-04-08 06:00:00	14.75
11144	QF 1,21	ЗУ	China 2	045	2025-04-08 06:00:00	13.22
11145	QF 1,22	ЗУ	China 3	046	2025-04-08 06:00:00	14.83
11146	QF 2,20	ЗУ	China 4	047	2025-04-08 06:00:00	20.64
11147	QF 2,21	ЗУ	China 5	048	2025-04-08 06:00:00	21.61
11148	QF 2,22	ЗУ	China 6	049	2025-04-08 06:00:00	21.24
11149	QF 2,23	ЗУ	China 7	050	2025-04-08 06:00:00	9.14
11150	QF 2,19	ЗУ	China 8	051	2025-04-08 06:00:00	13.73
11151	Q8	ЗУ	DIG	061	2025-04-08 06:00:00	78.36
11152	Q4	ЗУ	BG 1	062	2025-04-08 06:00:00	17.98
11153	Q9	ЗУ	BG 2	063	2025-04-08 06:00:00	9.65
11154	Q10	ЗУ	SM 2	064	2025-04-08 06:00:00	1.41
11155	Q11	ЗУ	SM 3	065	2025-04-08 06:00:00	0
11156	Q12	ЗУ	SM 4	066	2025-04-08 06:00:00	0
11157	Q13	ЗУ	SM 5	067	2025-04-08 06:00:00	0
11158	Q14	ЗУ	SM 6	068	2025-04-08 06:00:00	1.3
11159	Q15	ЗУ	SM 7	069	2025-04-08 06:00:00	0
11160	Q16	ЗУ	SM 8	070	2025-04-08 06:00:00	0
11161	Q17	ЗУ	MO 9	071	2025-04-08 06:00:00	0
11162	Q20	ЗУ	MO 10	072	2025-04-08 06:00:00	2.73
11163	Q21	ЗУ	MO 11	073	2025-04-08 06:00:00	0
11164	Q22	ЗУ	MO 12	074	2025-04-08 06:00:00	30.69
11165	Q23	ЗУ	MO 13	075	2025-04-08 06:00:00	0
11166	Q24	ЗУ	MO 14	076	2025-04-08 06:00:00	0
11167	Q25	ЗУ	MO 15	077	2025-04-08 06:00:00	0
11168	TP3	ЗУ	CP-300 New	078	2025-04-08 06:00:00	47.79
11169	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 06:30:00	0
11170	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 06:30:00	0.0011
11171	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 06:30:00	0.0027
11172	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 06:30:00	0.0036
11173	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 06:30:00	0
11174	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 06:30:00	0
11175	QF 1,20	ЗУ	China 1	044	2025-04-08 06:30:00	14.62
11176	QF 1,21	ЗУ	China 2	045	2025-04-08 06:30:00	13.14
11177	QF 1,22	ЗУ	China 3	046	2025-04-08 06:30:00	14.72
11178	QF 2,20	ЗУ	China 4	047	2025-04-08 06:30:00	20.91
11179	QF 2,21	ЗУ	China 5	048	2025-04-08 06:30:00	22.39
11180	QF 2,22	ЗУ	China 6	049	2025-04-08 06:30:00	21.96
11181	QF 2,23	ЗУ	China 7	050	2025-04-08 06:30:00	9.25
11182	QF 2,19	ЗУ	China 8	051	2025-04-08 06:30:00	13.73
11183	Q8	ЗУ	DIG	061	2025-04-08 06:30:00	86.77
11184	Q4	ЗУ	BG 1	062	2025-04-08 06:30:00	17.93
11185	Q9	ЗУ	BG 2	063	2025-04-08 06:30:00	9.61
11186	Q10	ЗУ	SM 2	064	2025-04-08 06:30:00	1.39
11187	Q11	ЗУ	SM 3	065	2025-04-08 06:30:00	0
11188	Q12	ЗУ	SM 4	066	2025-04-08 06:30:00	0
11189	Q13	ЗУ	SM 5	067	2025-04-08 06:30:00	0
11190	Q14	ЗУ	SM 6	068	2025-04-08 06:30:00	1.29
11191	Q15	ЗУ	SM 7	069	2025-04-08 06:30:00	0
11192	Q16	ЗУ	SM 8	070	2025-04-08 06:30:00	0
11193	Q17	ЗУ	MO 9	071	2025-04-08 06:30:00	0
11194	Q20	ЗУ	MO 10	072	2025-04-08 06:30:00	2.73
11195	Q21	ЗУ	MO 11	073	2025-04-08 06:30:00	0
11196	Q22	ЗУ	MO 12	074	2025-04-08 06:30:00	30.81
11197	Q23	ЗУ	MO 13	075	2025-04-08 06:30:00	0
11198	Q24	ЗУ	MO 14	076	2025-04-08 06:30:00	0
11199	Q25	ЗУ	MO 15	077	2025-04-08 06:30:00	0
11200	TP3	ЗУ	CP-300 New	078	2025-04-08 06:30:00	45.72
11201	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 07:00:00	0
11202	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 07:00:00	0.0012
11203	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 07:00:00	0.0027
11204	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 07:00:00	0.0036
11205	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 07:00:00	0
11206	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 07:00:00	0
11207	QF 1,20	ЗУ	China 1	044	2025-04-08 07:00:00	15.49
11208	QF 1,21	ЗУ	China 2	045	2025-04-08 07:00:00	14.04
11209	QF 1,22	ЗУ	China 3	046	2025-04-08 07:00:00	16.28
11210	QF 2,20	ЗУ	China 4	047	2025-04-08 07:00:00	22.11
11211	QF 2,21	ЗУ	China 5	048	2025-04-08 07:00:00	24.55
11212	QF 2,22	ЗУ	China 6	049	2025-04-08 07:00:00	23.2
11213	QF 2,23	ЗУ	China 7	050	2025-04-08 07:00:00	10.23
11214	QF 2,19	ЗУ	China 8	051	2025-04-08 07:00:00	14.93
11215	Q8	ЗУ	DIG	061	2025-04-08 07:00:00	76.15
11216	Q4	ЗУ	BG 1	062	2025-04-08 07:00:00	17.86
11217	Q9	ЗУ	BG 2	063	2025-04-08 07:00:00	9.62
11218	Q10	ЗУ	SM 2	064	2025-04-08 07:00:00	1.35
11219	Q11	ЗУ	SM 3	065	2025-04-08 07:00:00	0
11220	Q12	ЗУ	SM 4	066	2025-04-08 07:00:00	0
11221	Q13	ЗУ	SM 5	067	2025-04-08 07:00:00	0
11222	Q14	ЗУ	SM 6	068	2025-04-08 07:00:00	1.24
11223	Q15	ЗУ	SM 7	069	2025-04-08 07:00:00	0
11224	Q16	ЗУ	SM 8	070	2025-04-08 07:00:00	0
11225	Q17	ЗУ	MO 9	071	2025-04-08 07:00:00	0
11226	Q20	ЗУ	MO 10	072	2025-04-08 07:00:00	2.71
11227	Q21	ЗУ	MO 11	073	2025-04-08 07:00:00	0
11228	Q22	ЗУ	MO 12	074	2025-04-08 07:00:00	30.66
11229	Q23	ЗУ	MO 13	075	2025-04-08 07:00:00	0
11230	Q24	ЗУ	MO 14	076	2025-04-08 07:00:00	0
11231	Q25	ЗУ	MO 15	077	2025-04-08 07:00:00	0
11232	TP3	ЗУ	CP-300 New	078	2025-04-08 07:00:00	41.84
11233	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 07:30:00	0
11234	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 07:30:00	0.0012
11235	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 07:30:00	0.003
11236	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 07:30:00	0.0034
11237	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 07:30:00	0
11238	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 07:30:00	0
11239	QF 1,20	ЗУ	China 1	044	2025-04-08 07:30:00	13.78
11240	QF 1,21	ЗУ	China 2	045	2025-04-08 07:30:00	12.35
11241	QF 1,22	ЗУ	China 3	046	2025-04-08 07:30:00	14.62
11242	QF 2,20	ЗУ	China 4	047	2025-04-08 07:30:00	20.98
11243	QF 2,21	ЗУ	China 5	048	2025-04-08 07:30:00	23.62
11244	QF 2,22	ЗУ	China 6	049	2025-04-08 07:30:00	22.54
11245	QF 2,23	ЗУ	China 7	050	2025-04-08 07:30:00	9.9
11246	QF 2,19	ЗУ	China 8	051	2025-04-08 07:30:00	13.41
11247	Q8	ЗУ	DIG	061	2025-04-08 07:30:00	86.4
11248	Q4	ЗУ	BG 1	062	2025-04-08 07:30:00	17.84
11249	Q9	ЗУ	BG 2	063	2025-04-08 07:30:00	11.37
11250	Q10	ЗУ	SM 2	064	2025-04-08 07:30:00	1.33
11251	Q11	ЗУ	SM 3	065	2025-04-08 07:30:00	0
11252	Q12	ЗУ	SM 4	066	2025-04-08 07:30:00	0
11253	Q13	ЗУ	SM 5	067	2025-04-08 07:30:00	0
11254	Q14	ЗУ	SM 6	068	2025-04-08 07:30:00	1.23
11255	Q15	ЗУ	SM 7	069	2025-04-08 07:30:00	0
11256	Q16	ЗУ	SM 8	070	2025-04-08 07:30:00	0
11257	Q17	ЗУ	MO 9	071	2025-04-08 07:30:00	0
11258	Q20	ЗУ	MO 10	072	2025-04-08 07:30:00	2.71
11259	Q21	ЗУ	MO 11	073	2025-04-08 07:30:00	0
11260	Q22	ЗУ	MO 12	074	2025-04-08 07:30:00	30.58
11261	Q23	ЗУ	MO 13	075	2025-04-08 07:30:00	0
11262	Q24	ЗУ	MO 14	076	2025-04-08 07:30:00	0
11263	Q25	ЗУ	MO 15	077	2025-04-08 07:30:00	0
11264	TP3	ЗУ	CP-300 New	078	2025-04-08 07:30:00	38.77
11265	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 08:00:00	1.12
11266	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 08:00:00	0.9302
11267	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 08:00:00	0.1938
11268	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 08:00:00	1
11269	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 08:00:00	0.7519
11270	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 08:00:00	0.8417
11271	QF 1,20	ЗУ	China 1	044	2025-04-08 08:00:00	14.06
11272	QF 1,21	ЗУ	China 2	045	2025-04-08 08:00:00	12.78
11273	QF 1,22	ЗУ	China 3	046	2025-04-08 08:00:00	15.92
11274	QF 2,20	ЗУ	China 4	047	2025-04-08 08:00:00	21.98
11275	QF 2,21	ЗУ	China 5	048	2025-04-08 08:00:00	24.99
11276	QF 2,22	ЗУ	China 6	049	2025-04-08 08:00:00	23.05
11277	QF 2,23	ЗУ	China 7	050	2025-04-08 08:00:00	10.67
11278	QF 2,19	ЗУ	China 8	051	2025-04-08 08:00:00	14.16
11279	Q8	ЗУ	DIG	061	2025-04-08 08:00:00	85.88
11280	Q4	ЗУ	BG 1	062	2025-04-08 08:00:00	17.79
11281	Q9	ЗУ	BG 2	063	2025-04-08 08:00:00	20.29
11282	Q10	ЗУ	SM 2	064	2025-04-08 08:00:00	1.31
11283	Q11	ЗУ	SM 3	065	2025-04-08 08:00:00	0
11284	Q12	ЗУ	SM 4	066	2025-04-08 08:00:00	0
11285	Q13	ЗУ	SM 5	067	2025-04-08 08:00:00	0
11286	Q14	ЗУ	SM 6	068	2025-04-08 08:00:00	1.2
11287	Q15	ЗУ	SM 7	069	2025-04-08 08:00:00	0
11288	Q16	ЗУ	SM 8	070	2025-04-08 08:00:00	0
11289	Q17	ЗУ	MO 9	071	2025-04-08 08:00:00	0
11290	Q20	ЗУ	MO 10	072	2025-04-08 08:00:00	2.68
11291	Q21	ЗУ	MO 11	073	2025-04-08 08:00:00	0
11292	Q22	ЗУ	MO 12	074	2025-04-08 08:00:00	30.68
11293	Q23	ЗУ	MO 13	075	2025-04-08 08:00:00	0
11294	Q24	ЗУ	MO 14	076	2025-04-08 08:00:00	0
11295	Q25	ЗУ	MO 15	077	2025-04-08 08:00:00	0
11296	TP3	ЗУ	CP-300 New	078	2025-04-08 08:00:00	32.06
11297	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 08:30:00	7.99
11298	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 08:30:00	3.37
11299	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 08:30:00	3.1
11300	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 08:30:00	3.58
11301	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 08:30:00	7.2
11302	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 08:30:00	7.05
11303	QF 1,20	ЗУ	China 1	044	2025-04-08 08:30:00	14.71
11304	QF 1,21	ЗУ	China 2	045	2025-04-08 08:30:00	12.88
11305	QF 1,22	ЗУ	China 3	046	2025-04-08 08:30:00	16.33
11306	QF 2,20	ЗУ	China 4	047	2025-04-08 08:30:00	22.08
11307	QF 2,21	ЗУ	China 5	048	2025-04-08 08:30:00	25.01
11308	QF 2,22	ЗУ	China 6	049	2025-04-08 08:30:00	23.42
11309	QF 2,23	ЗУ	China 7	050	2025-04-08 08:30:00	11.25
11310	QF 2,19	ЗУ	China 8	051	2025-04-08 08:30:00	14.63
11311	Q8	ЗУ	DIG	061	2025-04-08 08:30:00	81.21
11312	Q4	ЗУ	BG 1	062	2025-04-08 08:30:00	17.76
11313	Q9	ЗУ	BG 2	063	2025-04-08 08:30:00	20.23
11314	Q10	ЗУ	SM 2	064	2025-04-08 08:30:00	1.26
11315	Q11	ЗУ	SM 3	065	2025-04-08 08:30:00	0
11316	Q12	ЗУ	SM 4	066	2025-04-08 08:30:00	0
11317	Q13	ЗУ	SM 5	067	2025-04-08 08:30:00	0
11318	Q14	ЗУ	SM 6	068	2025-04-08 08:30:00	1.17
11319	Q15	ЗУ	SM 7	069	2025-04-08 08:30:00	0
11320	Q16	ЗУ	SM 8	070	2025-04-08 08:30:00	0
11321	Q17	ЗУ	MO 9	071	2025-04-08 08:30:00	0
11322	Q20	ЗУ	MO 10	072	2025-04-08 08:30:00	2.68
11323	Q21	ЗУ	MO 11	073	2025-04-08 08:30:00	0
11324	Q22	ЗУ	MO 12	074	2025-04-08 08:30:00	30.12
11325	Q23	ЗУ	MO 13	075	2025-04-08 08:30:00	0
11326	Q24	ЗУ	MO 14	076	2025-04-08 08:30:00	0
11327	Q25	ЗУ	MO 15	077	2025-04-08 08:30:00	0
11328	TP3	ЗУ	CP-300 New	078	2025-04-08 08:30:00	29.96
11329	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 09:00:00	18.83
11330	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 09:00:00	6.98
11331	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 09:00:00	8.74
11332	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 09:00:00	7.35
11333	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 09:00:00	17.74
11334	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 09:00:00	17.39
11335	QF 1,20	ЗУ	China 1	044	2025-04-08 09:00:00	15.84
11336	QF 1,21	ЗУ	China 2	045	2025-04-08 09:00:00	14.34
11337	QF 1,22	ЗУ	China 3	046	2025-04-08 09:00:00	18.03
11338	QF 2,20	ЗУ	China 4	047	2025-04-08 09:00:00	23.37
11339	QF 2,21	ЗУ	China 5	048	2025-04-08 09:00:00	26.83
11340	QF 2,22	ЗУ	China 6	049	2025-04-08 09:00:00	24.64
11341	QF 2,23	ЗУ	China 7	050	2025-04-08 09:00:00	12.07
11342	QF 2,19	ЗУ	China 8	051	2025-04-08 09:00:00	15.87
11343	Q8	ЗУ	DIG	061	2025-04-08 09:00:00	80.86
11344	Q4	ЗУ	BG 1	062	2025-04-08 09:00:00	17.75
11345	Q9	ЗУ	BG 2	063	2025-04-08 09:00:00	20.2
11346	Q10	ЗУ	SM 2	064	2025-04-08 09:00:00	1.26
11347	Q11	ЗУ	SM 3	065	2025-04-08 09:00:00	0
11348	Q12	ЗУ	SM 4	066	2025-04-08 09:00:00	0
11349	Q13	ЗУ	SM 5	067	2025-04-08 09:00:00	0
11350	Q14	ЗУ	SM 6	068	2025-04-08 09:00:00	1.16
11351	Q15	ЗУ	SM 7	069	2025-04-08 09:00:00	0
11352	Q16	ЗУ	SM 8	070	2025-04-08 09:00:00	0
11353	Q17	ЗУ	MO 9	071	2025-04-08 09:00:00	0
11354	Q20	ЗУ	MO 10	072	2025-04-08 09:00:00	2.67
11355	Q21	ЗУ	MO 11	073	2025-04-08 09:00:00	0
11356	Q22	ЗУ	MO 12	074	2025-04-08 09:00:00	30.04
11357	Q23	ЗУ	MO 13	075	2025-04-08 09:00:00	0
11358	Q24	ЗУ	MO 14	076	2025-04-08 09:00:00	0
11359	Q25	ЗУ	MO 15	077	2025-04-08 09:00:00	0.2956
11360	TP3	ЗУ	CP-300 New	078	2025-04-08 09:00:00	25.78
11361	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 09:30:00	23.55
11362	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 09:30:00	8.5
11363	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 09:30:00	11.49
11364	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 09:30:00	9.03
11365	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 09:30:00	22.25
11366	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 09:30:00	21.88
11367	QF 1,20	ЗУ	China 1	044	2025-04-08 09:30:00	15.72
11368	QF 1,21	ЗУ	China 2	045	2025-04-08 09:30:00	14.29
11369	QF 1,22	ЗУ	China 3	046	2025-04-08 09:30:00	17.85
11370	QF 2,20	ЗУ	China 4	047	2025-04-08 09:30:00	23.36
11371	QF 2,21	ЗУ	China 5	048	2025-04-08 09:30:00	26.65
11372	QF 2,22	ЗУ	China 6	049	2025-04-08 09:30:00	23.41
11373	QF 2,23	ЗУ	China 7	050	2025-04-08 09:30:00	11.88
11374	QF 2,19	ЗУ	China 8	051	2025-04-08 09:30:00	15.83
11375	Q8	ЗУ	DIG	061	2025-04-08 09:30:00	78.09
11376	Q4	ЗУ	BG 1	062	2025-04-08 09:30:00	17.76
11377	Q9	ЗУ	BG 2	063	2025-04-08 09:30:00	20.17
11378	Q10	ЗУ	SM 2	064	2025-04-08 09:30:00	1.25
11379	Q11	ЗУ	SM 3	065	2025-04-08 09:30:00	0
11380	Q12	ЗУ	SM 4	066	2025-04-08 09:30:00	0
11381	Q13	ЗУ	SM 5	067	2025-04-08 09:30:00	0
11382	Q14	ЗУ	SM 6	068	2025-04-08 09:30:00	1.15
11383	Q15	ЗУ	SM 7	069	2025-04-08 09:30:00	0
11384	Q16	ЗУ	SM 8	070	2025-04-08 09:30:00	0
11385	Q17	ЗУ	MO 9	071	2025-04-08 09:30:00	0
11386	Q20	ЗУ	MO 10	072	2025-04-08 09:30:00	2.68
11387	Q21	ЗУ	MO 11	073	2025-04-08 09:30:00	0
11388	Q22	ЗУ	MO 12	074	2025-04-08 09:30:00	29.99
11389	Q23	ЗУ	MO 13	075	2025-04-08 09:30:00	0
11390	Q24	ЗУ	MO 14	076	2025-04-08 09:30:00	0
11391	Q25	ЗУ	MO 15	077	2025-04-08 09:30:00	1.11
11392	TP3	ЗУ	CP-300 New	078	2025-04-08 09:30:00	20.38
11393	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 10:00:00	30.99
11394	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 10:00:00	9.92
11395	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 10:00:00	16.74
11396	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 10:00:00	10.95
11397	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 10:00:00	29.73
11398	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 10:00:00	29.14
11399	QF 1,20	ЗУ	China 1	044	2025-04-08 10:00:00	15.82
11400	QF 1,21	ЗУ	China 2	045	2025-04-08 10:00:00	15
11401	QF 1,22	ЗУ	China 3	046	2025-04-08 10:00:00	18.62
11402	QF 2,20	ЗУ	China 4	047	2025-04-08 10:00:00	24.44
11403	QF 2,21	ЗУ	China 5	048	2025-04-08 10:00:00	27.25
11404	QF 2,22	ЗУ	China 6	049	2025-04-08 10:00:00	25.31
11405	QF 2,23	ЗУ	China 7	050	2025-04-08 10:00:00	12.49
11406	QF 2,19	ЗУ	China 8	051	2025-04-08 10:00:00	17
11407	Q8	ЗУ	DIG	061	2025-04-08 10:00:00	56.05
11408	Q4	ЗУ	BG 1	062	2025-04-08 10:00:00	17.75
11409	Q9	ЗУ	BG 2	063	2025-04-08 10:00:00	20.16
11410	Q10	ЗУ	SM 2	064	2025-04-08 10:00:00	1.26
11411	Q11	ЗУ	SM 3	065	2025-04-08 10:00:00	0
11412	Q12	ЗУ	SM 4	066	2025-04-08 10:00:00	0
11413	Q13	ЗУ	SM 5	067	2025-04-08 10:00:00	0
11414	Q14	ЗУ	SM 6	068	2025-04-08 10:00:00	1.16
11415	Q15	ЗУ	SM 7	069	2025-04-08 10:00:00	0
11416	Q16	ЗУ	SM 8	070	2025-04-08 10:00:00	0
11417	Q17	ЗУ	MO 9	071	2025-04-08 10:00:00	0
11418	Q20	ЗУ	MO 10	072	2025-04-08 10:00:00	2.69
11419	Q21	ЗУ	MO 11	073	2025-04-08 10:00:00	0
11420	Q22	ЗУ	MO 12	074	2025-04-08 10:00:00	29.88
11421	Q23	ЗУ	MO 13	075	2025-04-08 10:00:00	0
11422	Q24	ЗУ	MO 14	076	2025-04-08 10:00:00	0
11423	Q25	ЗУ	MO 15	077	2025-04-08 10:00:00	9.11
11424	TP3	ЗУ	CP-300 New	078	2025-04-08 10:00:00	18.8
11425	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 10:30:00	36.67
11426	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 10:30:00	10.83
11427	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 10:30:00	20.76
11428	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 10:30:00	12.21
11429	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 10:30:00	35.49
11430	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 10:30:00	34.76
11431	QF 1,20	ЗУ	China 1	044	2025-04-08 10:30:00	16.98
11432	QF 1,21	ЗУ	China 2	045	2025-04-08 10:30:00	15.73
11433	QF 1,22	ЗУ	China 3	046	2025-04-08 10:30:00	19.63
11434	QF 2,20	ЗУ	China 4	047	2025-04-08 10:30:00	24.97
11435	QF 2,21	ЗУ	China 5	048	2025-04-08 10:30:00	28.02
11436	QF 2,22	ЗУ	China 6	049	2025-04-08 10:30:00	25.85
11437	QF 2,23	ЗУ	China 7	050	2025-04-08 10:30:00	12.83
11438	QF 2,19	ЗУ	China 8	051	2025-04-08 10:30:00	18.35
11439	Q8	ЗУ	DIG	061	2025-04-08 10:30:00	53.9
11440	Q4	ЗУ	BG 1	062	2025-04-08 10:30:00	17.74
11441	Q9	ЗУ	BG 2	063	2025-04-08 10:30:00	20.12
11442	Q10	ЗУ	SM 2	064	2025-04-08 10:30:00	1.26
11443	Q11	ЗУ	SM 3	065	2025-04-08 10:30:00	0
11444	Q12	ЗУ	SM 4	066	2025-04-08 10:30:00	0
11445	Q13	ЗУ	SM 5	067	2025-04-08 10:30:00	0
11446	Q14	ЗУ	SM 6	068	2025-04-08 10:30:00	1.16
11447	Q15	ЗУ	SM 7	069	2025-04-08 10:30:00	0
11448	Q16	ЗУ	SM 8	070	2025-04-08 10:30:00	0
11449	Q17	ЗУ	MO 9	071	2025-04-08 10:30:00	0
11450	Q20	ЗУ	MO 10	072	2025-04-08 10:30:00	2.69
11451	Q21	ЗУ	MO 11	073	2025-04-08 10:30:00	0
11452	Q22	ЗУ	MO 12	074	2025-04-08 10:30:00	29.79
11453	Q23	ЗУ	MO 13	075	2025-04-08 10:30:00	0
11454	Q24	ЗУ	MO 14	076	2025-04-08 10:30:00	0
11455	Q25	ЗУ	MO 15	077	2025-04-08 10:30:00	10.04
11456	TP3	ЗУ	CP-300 New	078	2025-04-08 10:30:00	16.9
11457	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 11:00:00	36.45
11458	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 11:00:00	9.89
11459	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 11:00:00	21.22
11460	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 11:00:00	11.6
11461	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 11:00:00	35.34
11462	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 11:00:00	34.56
11463	QF 1,20	ЗУ	China 1	044	2025-04-08 11:00:00	18.19
11464	QF 1,21	ЗУ	China 2	045	2025-04-08 11:00:00	17.36
11465	QF 1,22	ЗУ	China 3	046	2025-04-08 11:00:00	21
11466	QF 2,20	ЗУ	China 4	047	2025-04-08 11:00:00	25.96
11467	QF 2,21	ЗУ	China 5	048	2025-04-08 11:00:00	29.36
11468	QF 2,22	ЗУ	China 6	049	2025-04-08 11:00:00	27.47
11469	QF 2,23	ЗУ	China 7	050	2025-04-08 11:00:00	13.58
11470	QF 2,19	ЗУ	China 8	051	2025-04-08 11:00:00	20.13
11471	Q8	ЗУ	DIG	061	2025-04-08 11:00:00	42.68
11472	Q4	ЗУ	BG 1	062	2025-04-08 11:00:00	17.72
11473	Q9	ЗУ	BG 2	063	2025-04-08 11:00:00	20.14
11474	Q10	ЗУ	SM 2	064	2025-04-08 11:00:00	1.25
11475	Q11	ЗУ	SM 3	065	2025-04-08 11:00:00	0
11476	Q12	ЗУ	SM 4	066	2025-04-08 11:00:00	0
11477	Q13	ЗУ	SM 5	067	2025-04-08 11:00:00	0
11478	Q14	ЗУ	SM 6	068	2025-04-08 11:00:00	1.15
11479	Q15	ЗУ	SM 7	069	2025-04-08 11:00:00	0
11480	Q16	ЗУ	SM 8	070	2025-04-08 11:00:00	0
11481	Q17	ЗУ	MO 9	071	2025-04-08 11:00:00	0
11482	Q20	ЗУ	MO 10	072	2025-04-08 11:00:00	2.67
11483	Q21	ЗУ	MO 11	073	2025-04-08 11:00:00	0.4136
11484	Q22	ЗУ	MO 12	074	2025-04-08 11:00:00	29.67
11485	Q23	ЗУ	MO 13	075	2025-04-08 11:00:00	0
11486	Q24	ЗУ	MO 14	076	2025-04-08 11:00:00	0
11487	Q25	ЗУ	MO 15	077	2025-04-08 11:00:00	9.95
11488	TP3	ЗУ	CP-300 New	078	2025-04-08 11:00:00	15.29
11489	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 11:30:00	36.37
11490	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 11:30:00	8.66
11491	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 11:30:00	22.01
11492	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 11:30:00	10.29
11493	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 11:30:00	35.16
11494	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 11:30:00	34.36
11495	QF 1,20	ЗУ	China 1	044	2025-04-08 11:30:00	17.4
11496	QF 1,21	ЗУ	China 2	045	2025-04-08 11:30:00	16.31
11497	QF 1,22	ЗУ	China 3	046	2025-04-08 11:30:00	20.25
11498	QF 2,20	ЗУ	China 4	047	2025-04-08 11:30:00	24.84
11499	QF 2,21	ЗУ	China 5	048	2025-04-08 11:30:00	27.4
11500	QF 2,22	ЗУ	China 6	049	2025-04-08 11:30:00	25.81
11501	QF 2,23	ЗУ	China 7	050	2025-04-08 11:30:00	12.55
11502	QF 2,19	ЗУ	China 8	051	2025-04-08 11:30:00	19.37
11503	Q8	ЗУ	DIG	061	2025-04-08 11:30:00	51.58
11504	Q4	ЗУ	BG 1	062	2025-04-08 11:30:00	17.73
11505	Q9	ЗУ	BG 2	063	2025-04-08 11:30:00	20.13
11506	Q10	ЗУ	SM 2	064	2025-04-08 11:30:00	1.26
11507	Q11	ЗУ	SM 3	065	2025-04-08 11:30:00	0
11508	Q12	ЗУ	SM 4	066	2025-04-08 11:30:00	0
11509	Q13	ЗУ	SM 5	067	2025-04-08 11:30:00	0
11510	Q14	ЗУ	SM 6	068	2025-04-08 11:30:00	1.16
11511	Q15	ЗУ	SM 7	069	2025-04-08 11:30:00	0
11512	Q16	ЗУ	SM 8	070	2025-04-08 11:30:00	0
11513	Q17	ЗУ	MO 9	071	2025-04-08 11:30:00	0
11514	Q20	ЗУ	MO 10	072	2025-04-08 11:30:00	2.68
11515	Q21	ЗУ	MO 11	073	2025-04-08 11:30:00	2.78
11516	Q22	ЗУ	MO 12	074	2025-04-08 11:30:00	29.73
11517	Q23	ЗУ	MO 13	075	2025-04-08 11:30:00	0
11518	Q24	ЗУ	MO 14	076	2025-04-08 11:30:00	0
11519	Q25	ЗУ	MO 15	077	2025-04-08 11:30:00	10
11520	TP3	ЗУ	CP-300 New	078	2025-04-08 11:30:00	15.24
11521	QF 1,26	ЗУ	PzS 12V 1	038	2025-04-08 12:00:00	29.16
11522	QF 1,27	ЗУ	PzS 12V 2	039	2025-04-08 12:00:00	5.28
11523	QF 1,28	ЗУ	PzS 12V 3	040	2025-04-08 12:00:00	18.61
11524	QF 2,28	ЗУ	PzS 12V 4	041	2025-04-08 12:00:00	6.25
11525	QF 2,27	ЗУ	PzS 12V 5	042	2025-04-08 12:00:00	27.74
11526	QF 2,26	ЗУ	PzS 12V 6	043	2025-04-08 12:00:00	27.18
11527	QF 1,20	ЗУ	China 1	044	2025-04-08 12:00:00	17.67
11528	QF 1,21	ЗУ	China 2	045	2025-04-08 12:00:00	16.7
11529	QF 1,22	ЗУ	China 3	046	2025-04-08 12:00:00	20.92
11530	QF 2,20	ЗУ	China 4	047	2025-04-08 12:00:00	25.17
11531	QF 2,21	ЗУ	China 5	048	2025-04-08 12:00:00	27.95
11532	QF 2,22	ЗУ	China 6	049	2025-04-08 12:00:00	26.08
11533	QF 2,23	ЗУ	China 7	050	2025-04-08 12:00:00	12.79
11534	QF 2,19	ЗУ	China 8	051	2025-04-08 12:00:00	19.35
11535	Q8	ЗУ	DIG	061	2025-04-08 12:00:00	52.03
11536	Q4	ЗУ	BG 1	062	2025-04-08 12:00:00	17.8
11537	Q9	ЗУ	BG 2	063	2025-04-08 12:00:00	20.21
11538	Q10	ЗУ	SM 2	064	2025-04-08 12:00:00	1.3
11539	Q11	ЗУ	SM 3	065	2025-04-08 12:00:00	0
11540	Q12	ЗУ	SM 4	066	2025-04-08 12:00:00	0
11541	Q13	ЗУ	SM 5	067	2025-04-08 12:00:00	0
11542	Q14	ЗУ	SM 6	068	2025-04-08 12:00:00	1.19
11543	Q15	ЗУ	SM 7	069	2025-04-08 12:00:00	0
11544	Q16	ЗУ	SM 8	070	2025-04-08 12:00:00	0
11545	Q17	ЗУ	MO 9	071	2025-04-08 12:00:00	0
11546	Q20	ЗУ	MO 10	072	2025-04-08 12:00:00	2.48
11547	Q21	ЗУ	MO 11	073	2025-04-08 12:00:00	6.91
11548	Q22	ЗУ	MO 12	074	2025-04-08 12:00:00	29.9
11549	Q23	ЗУ	MO 13	075	2025-04-08 12:00:00	0
11550	Q24	ЗУ	MO 14	076	2025-04-08 12:00:00	0
11551	Q25	ЗУ	MO 15	077	2025-04-08 12:00:00	10.02
11552	TP3	ЗУ	CP-300 New	078	2025-04-08 12:00:00	15.23
11554	Q17	ЗУ	MO 9	071	2026-05-09 20:31:32.876594	1.2369
11555	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:31:32.881515	21.33
11556	Q20	ЗУ	MO 10	072	2026-05-09 20:31:32.876594	13.5785
11557	TP3	ЗУ	CP-300 New	078	2026-05-09 20:31:32.887461	7.9302
11558	QF 1,20	ЗУ	China 1	044	2026-05-09 20:31:32.927586	12.3124
11559	Q10	ЗУ	SM 2	064	2026-05-09 20:31:32.905055	19.3727
11560	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:31:32.881515	10.6172
11561	Q21	ЗУ	MO 11	073	2026-05-09 20:31:32.876594	1.2315
11562	Q4	ЗУ	BG 1	062	2026-05-09 20:31:32.944582	21.6257
11563	QF 1,21	ЗУ	China 2	045	2026-05-09 20:31:32.927586	11.7836
11564	Q11	ЗУ	SM 3	065	2026-05-09 20:31:32.905055	21.7593
11565	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:31:32.881515	18.62
11566	Q22	ЗУ	MO 12	074	2026-05-09 20:31:32.876594	1.5915
11567	QF 1,22	ЗУ	China 3	046	2026-05-09 20:31:32.927586	14.3108
11568	Q9	ЗУ	BG 2	063	2026-05-09 20:31:32.944582	34.1036
11569	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:31:32.881515	8.3288
11570	QF 2,20	ЗУ	China 4	047	2026-05-09 20:31:32.927586	20.0883
11571	Q23	ЗУ	MO 13	075	2026-05-09 20:31:32.876594	1.1687
11572	Q12	ЗУ	SM 4	066	2026-05-09 20:31:32.905055	1.4574
11573	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:31:32.881515	20.2872
11574	Q24	ЗУ	MO 14	076	2026-05-09 20:31:32.876594	1.2622
11575	QF 2,21	ЗУ	China 5	048	2026-05-09 20:31:32.927586	21.3117
11576	Q13	ЗУ	SM 5	067	2026-05-09 20:31:32.905055	1.8888
11580	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:31:32.881515	19.6099
11584	QF 2,19	ЗУ	China 8	051	2026-05-09 20:31:32.927586	16.0436
11585	TP3	ЗУ	CP-300 New	078	2026-05-09 20:32:03.029273	8.1167
11589	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:32:08.056603	17.344
11593	QF 1,20	ЗУ	China 1	044	2026-05-09 20:32:13.062658	12.5432
11597	QF 2,21	ЗУ	China 5	048	2026-05-09 20:32:13.062658	22.0943
11601	Q4	ЗУ	BG 1	062	2026-05-09 20:32:18.039912	21.1462
11605	Q12	ЗУ	SM 4	066	2026-05-09 20:32:18.061922	1.9127
11609	Q16	ЗУ	SM 8	070	2026-05-09 20:32:18.061922	2.8668
11613	Q22	ЗУ	MO 12	074	2026-05-09 20:32:23.055181	0.972
11617	TP3	ЗУ	CP-300 New	078	2026-05-09 20:32:33.084344	8.2384
11621	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:32:43.080444	17.4133
11625	QF 1,20	ЗУ	China 1	044	2026-05-09 20:32:53.099863	13.0325
11629	QF 2,21	ЗУ	China 5	048	2026-05-09 20:32:53.099863	21.556
11633	Q4	ЗУ	BG 1	062	2026-05-09 20:33:03.073461	21.8763
11637	Q12	ЗУ	SM 4	066	2026-05-09 20:33:03.092177	2.1464
11641	Q16	ЗУ	SM 8	070	2026-05-09 20:33:03.092177	3.6343
11645	Q21	ЗУ	MO 11	073	2026-05-09 20:33:13.082682	0.8178
11649	Q25	ЗУ	MO 15	077	2026-05-09 20:33:13.082682	1.3353
11653	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:33:18.110183	18.3008
11657	TP3	ЗУ	CP-300 New	078	2026-05-09 20:33:33.123055	8.2763
11661	QF 2,20	ЗУ	China 4	047	2026-05-09 20:33:33.152377	19.868
11665	QF 2,19	ЗУ	China 8	051	2026-05-09 20:33:33.152377	15.4487
11669	Q11	ЗУ	SM 3	065	2026-05-09 20:33:48.1201	22.1803
11673	Q15	ЗУ	SM 7	069	2026-05-09 20:33:48.1201	2.0097
11677	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:33:53.14164	9.791
11681	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:33:53.14164	20.2978
11685	TP3	ЗУ	CP-300 New	078	2026-05-09 20:34:03.176938	8.7951
11689	Q25	ЗУ	MO 15	077	2026-05-09 20:34:03.125885	1.6461
11693	QF 2,20	ЗУ	China 4	047	2026-05-09 20:34:13.217024	19.0714
11697	QF 2,19	ЗУ	China 8	051	2026-05-09 20:34:13.217024	15.0956
11701	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:34:28.16594	18.0709
11705	Q4	ЗУ	BG 1	062	2026-05-09 20:34:33.134022	21.5139
11709	Q12	ЗУ	SM 4	066	2026-05-09 20:34:33.167661	2.0819
11713	TP3	ЗУ	CP-300 New	078	2026-05-09 20:34:33.197668	8.6274
15429	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:55:03.802165	21.5892
15430	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:55:03.802165	9.8532
15431	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:55:03.802165	16.178
15432	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:55:03.802165	7.9417
15433	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:55:03.802165	19.5938
15434	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:55:03.802165	18.9337
15435	TP3	ЗУ	CP-300 New	078	2026-05-09 21:55:07.127513	6.0821
16133	QF 1,22	ЗУ	China 3	046	2026-05-10 01:10:21.106012	13.6592
16135	QF 2,21	ЗУ	China 5	048	2026-05-10 01:10:21.106012	20.1415
16137	QF 2,23	ЗУ	China 7	050	2026-05-10 01:10:21.106012	9.8582
16140	Q9	ЗУ	BG 2	063	2026-05-10 01:10:37.603236	32.7169
16142	Q11	ЗУ	SM 3	065	2026-05-10 01:10:37.915698	21.0894
16144	Q13	ЗУ	SM 5	067	2026-05-10 01:10:37.915698	1.2302
16146	Q15	ЗУ	SM 7	069	2026-05-10 01:10:37.915698	1.3513
16148	TP3	ЗУ	CP-300 New	078	2026-05-10 01:10:37.941245	6.2891
16149	Q8	ЗУ	DIG	061	2026-05-10 01:10:47.853043	46.171
16151	Q20	ЗУ	MO 10	072	2026-05-10 01:10:48.879572	13.3772
16153	Q22	ЗУ	MO 12	074	2026-05-10 01:10:48.879572	1.2665
16155	Q24	ЗУ	MO 14	076	2026-05-10 01:10:48.879572	0.5311
16157	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:10:50.216047	20.0588
16159	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:10:50.216047	16.769
16161	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:10:50.216047	20.2296
16163	QF 1,20	ЗУ	China 1	044	2026-05-10 01:11:01.708001	11.9803
16165	QF 1,22	ЗУ	China 3	046	2026-05-10 01:11:01.708001	13.7508
16167	QF 2,21	ЗУ	China 5	048	2026-05-10 01:11:01.708001	20.0047
16169	QF 2,23	ЗУ	China 7	050	2026-05-10 01:11:01.708001	9.7641
16172	Q4	ЗУ	BG 1	062	2026-05-10 01:11:22.630289	20.5734
16174	Q8	ЗУ	DIG	061	2026-05-10 01:11:22.879986	45.8731
16176	Q11	ЗУ	SM 3	065	2026-05-10 01:11:22.949243	21.8464
16178	Q13	ЗУ	SM 5	067	2026-05-10 01:11:22.949243	0.577
16180	Q15	ЗУ	SM 7	069	2026-05-10 01:11:22.949243	1.3907
16183	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:11:25.424009	9.1149
16185	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:11:25.424009	7.3385
16187	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:11:25.424009	18.6406
16189	Q17	ЗУ	MO 9	071	2026-05-10 01:11:38.926127	1.0811
16191	Q21	ЗУ	MO 11	073	2026-05-10 01:11:38.926127	0.6971
16193	Q23	ЗУ	MO 13	075	2026-05-10 01:11:38.926127	0.622
16195	Q25	ЗУ	MO 15	077	2026-05-10 01:11:38.926127	0.4769
16197	QF 1,21	ЗУ	China 2	045	2026-05-10 01:11:41.766992	10.6421
16199	QF 2,20	ЗУ	China 4	047	2026-05-10 01:11:41.766992	18.1025
16201	QF 2,22	ЗУ	China 6	049	2026-05-10 01:11:41.766992	20.3377
16203	QF 2,19	ЗУ	China 8	051	2026-05-10 01:11:41.766992	15.4795
16255	QF 1,22	ЗУ	China 3	046	2026-05-10 01:13:01.863696	14.1255
16256	QF 2,20	ЗУ	China 4	047	2026-05-10 01:13:01.863696	18.996
16257	QF 2,21	ЗУ	China 5	048	2026-05-10 01:13:01.863696	21.0686
16258	QF 2,22	ЗУ	China 6	049	2026-05-10 01:13:01.863696	19.8504
16259	QF 2,23	ЗУ	China 7	050	2026-05-10 01:13:01.863696	10.3237
16260	QF 2,19	ЗУ	China 8	051	2026-05-10 01:13:01.863696	14.0021
16261	Q8	ЗУ	DIG	061	2026-05-10 01:13:07.943807	46.3069
16262	TP3	ЗУ	CP-300 New	078	2026-05-10 01:13:08.062099	5.8394
16263	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:13:10.553612	20.0675
16264	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:13:10.553612	8.499
16265	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:13:10.553612	16.9881
16266	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:13:10.553612	8.3845
16267	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:13:10.553612	20.6788
16268	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:13:10.553612	18.1386
16269	Q17	ЗУ	MO 9	071	2026-05-10 01:13:19.02365	0.6324
16270	Q20	ЗУ	MO 10	072	2026-05-10 01:13:19.02365	13.409
16271	Q21	ЗУ	MO 11	073	2026-05-10 01:13:19.02365	1.1794
16272	Q22	ЗУ	MO 12	074	2026-05-10 01:13:19.02365	0.3954
16273	Q23	ЗУ	MO 13	075	2026-05-10 01:13:19.02365	0.5946
16274	Q24	ЗУ	MO 14	076	2026-05-10 01:13:19.02365	0.3697
16275	Q25	ЗУ	MO 15	077	2026-05-10 01:13:19.02365	1.3073
16276	Q4	ЗУ	BG 1	062	2026-05-10 01:13:37.751248	20.2043
16277	Q9	ЗУ	BG 2	063	2026-05-10 01:13:37.751248	32.3832
16278	TP3	ЗУ	CP-300 New	078	2026-05-10 01:13:38.073018	5.9013
11577	Q25	ЗУ	MO 15	077	2026-05-09 20:31:32.876594	1.6636
11581	QF 2,23	ЗУ	China 7	050	2026-05-09 20:31:32.927586	10.4531
11586	Q8	ЗУ	DIG	061	2026-05-09 20:32:07.85478	47.3185
11590	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:32:08.056603	9.4282
11594	QF 1,21	ЗУ	China 2	045	2026-05-09 20:32:13.062658	12.0491
11598	QF 2,22	ЗУ	China 6	049	2026-05-09 20:32:13.062658	20.5826
11602	Q9	ЗУ	BG 2	063	2026-05-09 20:32:18.039912	32.8058
11606	Q13	ЗУ	SM 5	067	2026-05-09 20:32:18.061922	1.5157
11610	Q17	ЗУ	MO 9	071	2026-05-09 20:32:23.055181	1.6327
11614	Q23	ЗУ	MO 13	075	2026-05-09 20:32:23.055181	1.3486
11618	Q8	ЗУ	DIG	061	2026-05-09 20:32:42.877282	47.1944
11622	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:32:43.080444	8.2277
11626	QF 1,21	ЗУ	China 2	045	2026-05-09 20:32:53.099863	11.8946
11630	QF 2,22	ЗУ	China 6	049	2026-05-09 20:32:53.099863	19.8187
11634	Q9	ЗУ	BG 2	063	2026-05-09 20:33:03.073461	33.4723
11638	Q13	ЗУ	SM 5	067	2026-05-09 20:33:03.092177	1.7836
11642	TP3	ЗУ	CP-300 New	078	2026-05-09 20:33:03.114893	8.7046
11646	Q22	ЗУ	MO 12	074	2026-05-09 20:33:13.082682	1.6605
11650	Q8	ЗУ	DIG	061	2026-05-09 20:33:17.891595	47.0391
11654	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:33:18.110183	9.139
11658	QF 1,20	ЗУ	China 1	044	2026-05-09 20:33:33.152377	12.949
11662	QF 2,21	ЗУ	China 5	048	2026-05-09 20:33:33.152377	21.6389
11666	Q4	ЗУ	BG 1	062	2026-05-09 20:33:48.091446	20.8946
11670	Q12	ЗУ	SM 4	066	2026-05-09 20:33:48.1201	1.3533
11674	Q16	ЗУ	SM 8	070	2026-05-09 20:33:48.1201	3.3372
11678	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:33:53.14164	16.9503
11682	Q17	ЗУ	MO 9	071	2026-05-09 20:34:03.125885	1.6751
11686	Q22	ЗУ	MO 12	074	2026-05-09 20:34:03.125885	1.1058
11690	QF 1,20	ЗУ	China 1	044	2026-05-09 20:34:13.217024	11.7805
11694	QF 2,21	ЗУ	China 5	048	2026-05-09 20:34:13.217024	21.6427
11698	Q8	ЗУ	DIG	061	2026-05-09 20:34:27.922094	46.6507
11702	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:34:28.16594	8.0085
11706	Q10	ЗУ	SM 2	064	2026-05-09 20:34:33.167661	19.4864
11710	Q13	ЗУ	SM 5	067	2026-05-09 20:34:33.167661	1.6418
11714	Q16	ЗУ	SM 8	070	2026-05-09 20:34:33.167661	3.6665
15437	Q4	ЗУ	BG 1	062	2026-05-10 00:55:36.921888	20.5473
15438	Q9	ЗУ	BG 2	063	2026-05-10 00:55:36.921888	33.1411
15439	Q8	ЗУ	DIG	061	2026-05-10 00:55:37.113262	46.428
15440	TP3	ЗУ	CP-300 New	078	2026-05-10 00:55:37.139615	6.403
15441	Q10	ЗУ	SM 2	064	2026-05-10 00:55:37.145943	18.9082
15442	Q11	ЗУ	SM 3	065	2026-05-10 00:55:37.145943	21.6647
15443	Q12	ЗУ	SM 4	066	2026-05-10 00:55:37.145943	0.5787
15444	Q13	ЗУ	SM 5	067	2026-05-10 00:55:37.145943	1.6182
15445	Q14	ЗУ	SM 6	068	2026-05-10 00:55:37.145943	1.3415
15446	Q15	ЗУ	SM 7	069	2026-05-10 00:55:37.145943	1.2565
15447	Q16	ЗУ	SM 8	070	2026-05-10 00:55:37.145943	2.8009
15448	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:55:38.853403	21.0345
15449	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:55:38.853403	8.5281
15450	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:55:38.853403	17.4834
15451	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:55:38.853403	8.122
15452	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:55:38.853403	19.8879
15453	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:55:38.853403	18.7376
15454	QF 1,20	ЗУ	China 1	044	2026-05-10 00:55:39.777365	12.1444
15455	QF 1,21	ЗУ	China 2	045	2026-05-10 00:55:39.777365	10.5135
15456	QF 1,22	ЗУ	China 3	046	2026-05-10 00:55:39.777365	13.2669
15457	QF 2,20	ЗУ	China 4	047	2026-05-10 00:55:39.777365	19.2316
15458	QF 2,21	ЗУ	China 5	048	2026-05-10 00:55:39.777365	20.1271
15459	QF 2,22	ЗУ	China 6	049	2026-05-10 00:55:39.777365	19.8321
15460	QF 2,23	ЗУ	China 7	050	2026-05-10 00:55:39.777365	9.4886
15461	QF 2,19	ЗУ	China 8	051	2026-05-10 00:55:39.777365	14.9706
15462	Q17	ЗУ	MO 9	071	2026-05-10 00:55:47.995132	1.2112
15463	Q20	ЗУ	MO 10	072	2026-05-10 00:55:47.995132	13.4497
15464	Q21	ЗУ	MO 11	073	2026-05-10 00:55:47.995132	0.4928
15465	Q22	ЗУ	MO 12	074	2026-05-10 00:55:47.995132	1.2274
15466	Q23	ЗУ	MO 13	075	2026-05-10 00:55:47.995132	0.5137
15467	Q24	ЗУ	MO 14	076	2026-05-10 00:55:47.995132	1.3824
15468	Q25	ЗУ	MO 15	077	2026-05-10 00:55:47.995132	0.8207
15469	TP3	ЗУ	CP-300 New	078	2026-05-10 00:56:07.160305	6.0714
15470	Q8	ЗУ	DIG	061	2026-05-10 00:56:12.12856	46.6
15471	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:56:13.889754	20.5937
15472	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:56:13.889754	8.2081
15473	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:56:13.889754	16.2678
15474	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:56:13.889754	8.8612
15475	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:56:13.889754	19.5709
15476	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:56:13.889754	19.0512
15477	QF 1,20	ЗУ	China 1	044	2026-05-10 00:56:19.896169	11.7917
15478	QF 1,21	ЗУ	China 2	045	2026-05-10 00:56:19.896169	11.0934
15479	QF 1,22	ЗУ	China 3	046	2026-05-10 00:56:19.896169	13.5195
15480	QF 2,20	ЗУ	China 4	047	2026-05-10 00:56:19.896169	18.4962
15481	QF 2,21	ЗУ	China 5	048	2026-05-10 00:56:19.896169	20.0535
15482	QF 2,22	ЗУ	China 6	049	2026-05-10 00:56:19.896169	20.0562
15483	QF 2,23	ЗУ	China 7	050	2026-05-10 00:56:19.896169	10.2654
15484	QF 2,19	ЗУ	China 8	051	2026-05-10 00:56:19.896169	14.6654
15485	Q4	ЗУ	BG 1	062	2026-05-10 00:56:21.951424	21.1803
15486	Q9	ЗУ	BG 2	063	2026-05-10 00:56:21.951424	33.3355
15487	Q10	ЗУ	SM 2	064	2026-05-10 00:56:22.190282	19.141
15488	Q11	ЗУ	SM 3	065	2026-05-10 00:56:22.190282	21.9776
15489	Q12	ЗУ	SM 4	066	2026-05-10 00:56:22.190282	0.7857
15490	Q13	ЗУ	SM 5	067	2026-05-10 00:56:22.190282	1.6398
15491	Q14	ЗУ	SM 6	068	2026-05-10 00:56:22.190282	1.7302
15492	Q15	ЗУ	SM 7	069	2026-05-10 00:56:22.190282	0.7676
15493	Q16	ЗУ	SM 8	070	2026-05-10 00:56:22.190282	2.7339
15494	TP3	ЗУ	CP-300 New	078	2026-05-10 00:56:37.182952	5.7281
15495	Q17	ЗУ	MO 9	071	2026-05-10 00:56:38.031775	0.6898
15496	Q20	ЗУ	MO 10	072	2026-05-10 00:56:38.031775	13.4794
15497	Q21	ЗУ	MO 11	073	2026-05-10 00:56:38.031775	0.9737
15498	Q22	ЗУ	MO 12	074	2026-05-10 00:56:38.031775	0.9422
15499	Q23	ЗУ	MO 13	075	2026-05-10 00:56:38.031775	0.635
15500	Q24	ЗУ	MO 14	076	2026-05-10 00:56:38.031775	1.3839
15501	Q25	ЗУ	MO 15	077	2026-05-10 00:56:38.031775	0.5327
15502	Q8	ЗУ	DIG	061	2026-05-10 00:56:47.158349	47.2766
15503	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:56:48.921481	20.8906
15504	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:56:48.921481	8.9961
11578	QF 2,22	ЗУ	China 6	049	2026-05-09 20:31:32.927586	20.0128
11582	Q15	ЗУ	SM 7	069	2026-05-09 20:31:32.905055	1.2379
11587	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:32:08.056603	22.1342
11591	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:32:08.056603	21.0381
11595	QF 1,22	ЗУ	China 3	046	2026-05-09 20:32:13.062658	14.2993
11599	QF 2,23	ЗУ	China 7	050	2026-05-09 20:32:13.062658	10.033
11603	Q10	ЗУ	SM 2	064	2026-05-09 20:32:18.061922	19.3377
11607	Q14	ЗУ	SM 6	068	2026-05-09 20:32:18.061922	2.0002
11611	Q20	ЗУ	MO 10	072	2026-05-09 20:32:23.055181	13.623
11615	Q24	ЗУ	MO 14	076	2026-05-09 20:32:23.055181	1.6069
11619	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:32:43.080444	21.3976
11623	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:32:43.080444	21.2168
11627	QF 1,22	ЗУ	China 3	046	2026-05-09 20:32:53.099863	14.4549
11631	QF 2,23	ЗУ	China 7	050	2026-05-09 20:32:53.099863	9.9283
11635	Q10	ЗУ	SM 2	064	2026-05-09 20:33:03.092177	18.8466
11639	Q14	ЗУ	SM 6	068	2026-05-09 20:33:03.092177	2.0929
11643	Q17	ЗУ	MO 9	071	2026-05-09 20:33:13.082682	1.0649
11647	Q23	ЗУ	MO 13	075	2026-05-09 20:33:13.082682	1.4325
11651	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:33:18.110183	21.2847
11655	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:33:18.110183	21.623
11659	QF 1,21	ЗУ	China 2	045	2026-05-09 20:33:33.152377	11.146
11663	QF 2,22	ЗУ	China 6	049	2026-05-09 20:33:33.152377	19.918
11667	Q9	ЗУ	BG 2	063	2026-05-09 20:33:48.091446	33.9085
11671	Q13	ЗУ	SM 5	067	2026-05-09 20:33:48.1201	1.8698
11675	Q8	ЗУ	DIG	061	2026-05-09 20:33:52.90869	48.1869
11679	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:33:53.14164	8.3681
11683	Q20	ЗУ	MO 10	072	2026-05-09 20:34:03.125885	13.9026
11687	Q23	ЗУ	MO 13	075	2026-05-09 20:34:03.125885	1.0363
11691	QF 1,21	ЗУ	China 2	045	2026-05-09 20:34:13.217024	11.0515
11695	QF 2,22	ЗУ	China 6	049	2026-05-09 20:34:13.217024	20.8893
11699	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:34:28.16594	20.8247
11703	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:34:28.16594	19.9601
11707	Q9	ЗУ	BG 2	063	2026-05-09 20:34:33.134022	33.8116
11711	Q14	ЗУ	SM 6	068	2026-05-09 20:34:33.167661	1.5924
15505	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:56:48.921481	16.6086
15506	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:56:48.921481	8.1567
15507	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:56:48.921481	20.7674
15508	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:56:48.921481	18.1628
15509	QF 1,20	ЗУ	China 1	044	2026-05-10 00:56:59.979765	12.5101
15510	QF 1,21	ЗУ	China 2	045	2026-05-10 00:56:59.979765	11.1531
15511	QF 1,22	ЗУ	China 3	046	2026-05-10 00:56:59.979765	13.4088
15512	QF 2,20	ЗУ	China 4	047	2026-05-10 00:56:59.979765	19.5263
15513	QF 2,21	ЗУ	China 5	048	2026-05-10 00:56:59.979765	20.5497
15514	QF 2,22	ЗУ	China 6	049	2026-05-10 00:56:59.979765	20.5557
15515	QF 2,23	ЗУ	China 7	050	2026-05-10 00:56:59.979765	8.9798
15516	QF 2,19	ЗУ	China 8	051	2026-05-10 00:56:59.979765	14.0884
15517	Q4	ЗУ	BG 1	062	2026-05-10 00:57:07.003668	21.2352
15518	Q9	ЗУ	BG 2	063	2026-05-10 00:57:07.003668	32.931
15519	Q10	ЗУ	SM 2	064	2026-05-10 00:57:07.217038	18.3693
15520	Q11	ЗУ	SM 3	065	2026-05-10 00:57:07.217038	21.5329
15521	Q12	ЗУ	SM 4	066	2026-05-10 00:57:07.217038	1.4621
15523	Q13	ЗУ	SM 5	067	2026-05-10 00:57:07.217038	0.9386
15525	Q15	ЗУ	SM 7	069	2026-05-10 00:57:07.217038	0.6616
15529	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:57:23.972292	8.4508
15531	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:57:23.972292	7.7619
15533	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:57:23.972292	19.4716
15535	Q20	ЗУ	MO 10	072	2026-05-10 00:57:28.118625	12.9155
15537	Q22	ЗУ	MO 12	074	2026-05-10 00:57:28.118625	0.6307
15539	Q24	ЗУ	MO 14	076	2026-05-10 00:57:28.118625	1.3325
15541	TP3	ЗУ	CP-300 New	078	2026-05-10 00:57:37.256826	7.3769
15543	QF 1,21	ЗУ	China 2	045	2026-05-10 00:57:40.027367	11.0049
15545	QF 2,20	ЗУ	China 4	047	2026-05-10 00:57:40.027367	18.225
15547	QF 2,22	ЗУ	China 6	049	2026-05-10 00:57:40.027367	19.7234
15549	QF 2,19	ЗУ	China 8	051	2026-05-10 00:57:40.027367	14.7436
15551	Q9	ЗУ	BG 2	063	2026-05-10 00:57:52.030868	33.001
15553	Q11	ЗУ	SM 3	065	2026-05-10 00:57:52.263889	21.7434
15555	Q13	ЗУ	SM 5	067	2026-05-10 00:57:52.263889	0.939
15557	Q15	ЗУ	SM 7	069	2026-05-10 00:57:52.263889	1.0792
15559	Q8	ЗУ	DIG	061	2026-05-10 00:57:57.207661	45.466
15561	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:57:59.004145	8.8548
15563	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:57:59.004145	8.7
15565	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:57:59.004145	19.3613
15566	TP3	ЗУ	CP-300 New	078	2026-05-10 00:58:07.283766	5.8912
15568	Q20	ЗУ	MO 10	072	2026-05-10 00:58:18.164989	13.0925
15570	Q22	ЗУ	MO 12	074	2026-05-10 00:58:18.164989	0.7787
15572	Q24	ЗУ	MO 14	076	2026-05-10 00:58:18.164989	0.4444
15574	QF 1,20	ЗУ	China 1	044	2026-05-10 00:58:20.095173	12.1015
15576	QF 1,22	ЗУ	China 3	046	2026-05-10 00:58:20.095173	13.9135
15578	QF 2,21	ЗУ	China 5	048	2026-05-10 00:58:20.095173	21.219
15580	QF 2,23	ЗУ	China 7	050	2026-05-10 00:58:20.095173	9.8703
15583	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:58:34.093962	20.9246
15585	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:58:34.093962	17.1054
15587	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:58:34.093962	20.4627
15589	Q4	ЗУ	BG 1	062	2026-05-10 00:58:37.056243	20.942
15591	Q10	ЗУ	SM 2	064	2026-05-10 00:58:37.307423	18.9828
15593	TP3	ЗУ	CP-300 New	078	2026-05-10 00:58:37.323835	6.6796
15595	Q13	ЗУ	SM 5	067	2026-05-10 00:58:37.307423	1.2091
15597	Q15	ЗУ	SM 7	069	2026-05-10 00:58:37.307423	0.8658
15600	QF 1,21	ЗУ	China 2	045	2026-05-10 00:59:00.156461	10.5269
15602	QF 2,20	ЗУ	China 4	047	2026-05-10 00:59:00.156461	19.3287
15604	QF 2,22	ЗУ	China 6	049	2026-05-10 00:59:00.156461	19.8282
15606	QF 2,19	ЗУ	China 8	051	2026-05-10 00:59:00.156461	13.9638
15608	TP3	ЗУ	CP-300 New	078	2026-05-10 00:59:07.342361	6.573
15610	Q20	ЗУ	MO 10	072	2026-05-10 00:59:08.216843	13.8141
15612	Q22	ЗУ	MO 12	074	2026-05-10 00:59:08.216843	0.9615
15614	Q24	ЗУ	MO 14	076	2026-05-10 00:59:08.216843	0.9592
15616	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:59:09.139508	21.0961
15618	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:59:09.139508	17.7759
15620	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:59:09.139508	19.8741
15622	Q4	ЗУ	BG 1	062	2026-05-10 00:59:22.077236	21.0163
15624	Q10	ЗУ	SM 2	064	2026-05-10 00:59:22.351791	18.5369
15626	Q12	ЗУ	SM 4	066	2026-05-10 00:59:22.351791	1.672
11579	Q14	ЗУ	SM 6	068	2026-05-09 20:31:32.905055	1.4607
11583	Q16	ЗУ	SM 8	070	2026-05-09 20:31:32.905055	3.6887
11588	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:32:08.056603	9.4037
11592	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:32:08.056603	20.2343
11596	QF 2,20	ЗУ	China 4	047	2026-05-09 20:32:13.062658	19.3371
11600	QF 2,19	ЗУ	China 8	051	2026-05-09 20:32:13.062658	14.978
11604	Q11	ЗУ	SM 3	065	2026-05-09 20:32:18.061922	21.69
11608	Q15	ЗУ	SM 7	069	2026-05-09 20:32:18.061922	1.854
11612	Q21	ЗУ	MO 11	073	2026-05-09 20:32:23.055181	1.104
11616	Q25	ЗУ	MO 15	077	2026-05-09 20:32:23.055181	1.679
11620	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:32:43.080444	9.393
11624	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:32:43.080444	18.8578
11628	QF 2,20	ЗУ	China 4	047	2026-05-09 20:32:53.099863	18.956
11632	QF 2,19	ЗУ	China 8	051	2026-05-09 20:32:53.099863	15.0871
11636	Q11	ЗУ	SM 3	065	2026-05-09 20:33:03.092177	22.5745
11640	Q15	ЗУ	SM 7	069	2026-05-09 20:33:03.092177	1.6495
11644	Q20	ЗУ	MO 10	072	2026-05-09 20:33:13.082682	13.9434
11648	Q24	ЗУ	MO 14	076	2026-05-09 20:33:13.082682	1.5331
11652	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:33:18.110183	10.3409
11656	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:33:18.110183	20.089
11660	QF 1,22	ЗУ	China 3	046	2026-05-09 20:33:33.152377	13.8753
11664	QF 2,23	ЗУ	China 7	050	2026-05-09 20:33:33.152377	10.3081
11668	Q10	ЗУ	SM 2	064	2026-05-09 20:33:48.1201	18.6611
11672	Q14	ЗУ	SM 6	068	2026-05-09 20:33:48.1201	1.1327
11676	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:33:53.14164	21.3529
11680	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:33:53.14164	21.2465
11684	Q21	ЗУ	MO 11	073	2026-05-09 20:34:03.125885	1.3357
11688	Q24	ЗУ	MO 14	076	2026-05-09 20:34:03.125885	1.5021
11692	QF 1,22	ЗУ	China 3	046	2026-05-09 20:34:13.217024	15.0472
11696	QF 2,23	ЗУ	China 7	050	2026-05-09 20:34:13.217024	10.7809
11700	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:34:28.16594	9.7738
11704	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:34:28.16594	20.3558
11708	Q11	ЗУ	SM 3	065	2026-05-09 20:34:33.167661	22.4364
11712	Q15	ЗУ	SM 7	069	2026-05-09 20:34:33.167661	2.077
11715	Q17	ЗУ	MO 9	071	2026-05-09 20:34:53.202677	1.4045
11716	Q20	ЗУ	MO 10	072	2026-05-09 20:34:53.202677	13.5121
11717	Q21	ЗУ	MO 11	073	2026-05-09 20:34:53.202677	1.1051
11718	Q22	ЗУ	MO 12	074	2026-05-09 20:34:53.202677	1.245
11719	Q23	ЗУ	MO 13	075	2026-05-09 20:34:53.202677	1.4372
11720	Q24	ЗУ	MO 14	076	2026-05-09 20:34:53.202677	1.2957
11721	Q25	ЗУ	MO 15	077	2026-05-09 20:34:53.202677	0.8681
11722	QF 1,20	ЗУ	China 1	044	2026-05-09 20:34:53.281375	11.5625
11723	QF 1,21	ЗУ	China 2	045	2026-05-09 20:34:53.281375	11.125
11724	QF 1,22	ЗУ	China 3	046	2026-05-09 20:34:53.281375	14.8567
11725	QF 2,20	ЗУ	China 4	047	2026-05-09 20:34:53.281375	19.9277
11726	QF 2,21	ЗУ	China 5	048	2026-05-09 20:34:53.281375	20.809
11727	QF 2,22	ЗУ	China 6	049	2026-05-09 20:34:53.281375	19.6691
11728	QF 2,23	ЗУ	China 7	050	2026-05-09 20:34:53.281375	10.3714
11729	QF 2,19	ЗУ	China 8	051	2026-05-09 20:34:53.281375	14.5549
11730	Q8	ЗУ	DIG	061	2026-05-09 20:35:02.955892	46.6514
11731	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:35:03.201032	21.5231
11732	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:35:03.201032	9.9638
11733	TP3	ЗУ	CP-300 New	078	2026-05-09 20:35:03.201239	7.5001
11734	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:35:03.201032	18.4164
11735	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:35:03.201032	8.5008
11736	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:35:03.201032	21.555
11737	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:35:03.201032	19.4789
11738	Q4	ЗУ	BG 1	062	2026-05-09 20:35:18.184588	21.9786
11739	Q9	ЗУ	BG 2	063	2026-05-09 20:35:18.184588	33.3839
11740	Q10	ЗУ	SM 2	064	2026-05-09 20:35:18.2084	19.3382
11741	Q11	ЗУ	SM 3	065	2026-05-09 20:35:18.2084	22.3188
11742	Q12	ЗУ	SM 4	066	2026-05-09 20:35:18.2084	1.3908
11743	Q13	ЗУ	SM 5	067	2026-05-09 20:35:18.2084	1.4691
11744	Q14	ЗУ	SM 6	068	2026-05-09 20:35:18.2084	2.083
11745	Q15	ЗУ	SM 7	069	2026-05-09 20:35:18.2084	1.5259
11746	Q16	ЗУ	SM 8	070	2026-05-09 20:35:18.2084	2.5413
11747	TP3	ЗУ	CP-300 New	078	2026-05-09 20:35:33.23883	8.6256
11748	QF 1,20	ЗУ	China 1	044	2026-05-09 20:35:33.321851	12.448
11749	QF 1,21	ЗУ	China 2	045	2026-05-09 20:35:33.321851	11.5128
11750	QF 1,22	ЗУ	China 3	046	2026-05-09 20:35:33.321851	13.5914
11751	QF 2,20	ЗУ	China 4	047	2026-05-09 20:35:33.321851	20.0449
11752	QF 2,21	ЗУ	China 5	048	2026-05-09 20:35:33.321851	21.8009
11753	QF 2,22	ЗУ	China 6	049	2026-05-09 20:35:33.321851	20.9603
11754	QF 2,23	ЗУ	China 7	050	2026-05-09 20:35:33.321851	10.1202
11755	QF 2,19	ЗУ	China 8	051	2026-05-09 20:35:33.321851	14.523
11756	Q8	ЗУ	DIG	061	2026-05-09 20:35:37.972183	47.7639
11757	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:35:38.250767	22.288
11758	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:35:38.250767	10.6054
11759	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:35:38.250767	17.6721
11760	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:35:38.250767	8.8966
11761	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:35:38.250767	20.2911
11762	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:35:38.250767	19.6273
11763	Q17	ЗУ	MO 9	071	2026-05-09 20:35:43.262083	1.0208
11764	Q20	ЗУ	MO 10	072	2026-05-09 20:35:43.262083	13.929
11765	Q21	ЗУ	MO 11	073	2026-05-09 20:35:43.262083	1.2698
11766	Q22	ЗУ	MO 12	074	2026-05-09 20:35:43.262083	0.8236
11767	Q23	ЗУ	MO 13	075	2026-05-09 20:35:43.262083	1.3268
11768	Q24	ЗУ	MO 14	076	2026-05-09 20:35:43.262083	0.7695
11769	Q25	ЗУ	MO 15	077	2026-05-09 20:35:43.262083	1.1478
11770	Q4	ЗУ	BG 1	062	2026-05-09 20:36:03.207856	20.9615
11771	Q9	ЗУ	BG 2	063	2026-05-09 20:36:03.207856	33.761
11772	Q10	ЗУ	SM 2	064	2026-05-09 20:36:03.237775	19.3169
11773	Q11	ЗУ	SM 3	065	2026-05-09 20:36:03.237775	22.4855
11774	Q12	ЗУ	SM 4	066	2026-05-09 20:36:03.237775	1.9032
11775	Q13	ЗУ	SM 5	067	2026-05-09 20:36:03.237775	1.9497
11776	Q14	ЗУ	SM 6	068	2026-05-09 20:36:03.237775	1.0605
11777	Q15	ЗУ	SM 7	069	2026-05-09 20:36:03.237775	1.3716
11778	Q16	ЗУ	SM 8	070	2026-05-09 20:36:03.237775	3.2948
11779	TP3	ЗУ	CP-300 New	078	2026-05-09 20:36:03.271241	7.6809
11780	Q8	ЗУ	DIG	061	2026-05-09 20:36:12.985175	46.9715
11781	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:36:13.291523	21.3396
11782	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:36:13.291523	10.165
11783	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:36:13.291523	17.6258
11785	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:36:13.291523	20.8224
11787	QF 1,20	ЗУ	China 1	044	2026-05-09 20:36:13.437839	12.438
11789	QF 1,22	ЗУ	China 3	046	2026-05-09 20:36:13.437839	13.9875
11791	QF 2,21	ЗУ	China 5	048	2026-05-09 20:36:13.437839	21.8182
11793	QF 2,23	ЗУ	China 7	050	2026-05-09 20:36:13.437839	9.4766
11795	TP3	ЗУ	CP-300 New	078	2026-05-09 20:36:33.276747	7.9818
11797	Q20	ЗУ	MO 10	072	2026-05-09 20:36:33.283929	14.1451
11799	Q22	ЗУ	MO 12	074	2026-05-09 20:36:33.283929	1.6209
11801	Q24	ЗУ	MO 14	076	2026-05-09 20:36:33.283929	0.9557
11804	Q4	ЗУ	BG 1	062	2026-05-09 20:36:48.236583	21.1414
11806	Q10	ЗУ	SM 2	064	2026-05-09 20:36:48.254889	19.5686
11808	Q12	ЗУ	SM 4	066	2026-05-09 20:36:48.254889	1.2244
11810	Q14	ЗУ	SM 6	068	2026-05-09 20:36:48.254889	1.9276
11812	Q16	ЗУ	SM 8	070	2026-05-09 20:36:48.254889	3.3799
11814	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:36:48.327677	8.9485
11816	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:36:48.327677	8.9923
11818	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:36:48.327677	20.1321
11819	QF 1,20	ЗУ	China 1	044	2026-05-09 20:36:53.467829	12.1421
11821	QF 1,22	ЗУ	China 3	046	2026-05-09 20:36:53.467829	14.0819
11823	QF 2,21	ЗУ	China 5	048	2026-05-09 20:36:53.467829	21.387
11825	QF 2,23	ЗУ	China 7	050	2026-05-09 20:36:53.467829	10.3204
11827	TP3	ЗУ	CP-300 New	078	2026-05-09 20:37:03.297254	7.8552
11828	Q8	ЗУ	DIG	061	2026-05-09 20:37:23.028577	47.4657
11830	Q20	ЗУ	MO 10	072	2026-05-09 20:37:23.320277	13.5748
11832	Q22	ЗУ	MO 12	074	2026-05-09 20:37:23.320277	1.3456
11834	Q24	ЗУ	MO 14	076	2026-05-09 20:37:23.320277	1.5023
11836	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:37:23.348419	21.2031
11838	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:37:23.348419	17.5811
11840	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:37:23.348419	21.037
11843	Q9	ЗУ	BG 2	063	2026-05-09 20:37:33.254261	33.7159
11845	Q11	ЗУ	SM 3	065	2026-05-09 20:37:33.287664	22.1632
11847	Q13	ЗУ	SM 5	067	2026-05-09 20:37:33.287664	1.7766
11849	Q15	ЗУ	SM 7	069	2026-05-09 20:37:33.287664	1.4135
11851	TP3	ЗУ	CP-300 New	078	2026-05-09 20:37:33.31333	7.0885
11853	QF 1,21	ЗУ	China 2	045	2026-05-09 20:37:33.548008	11.3924
11855	QF 2,20	ЗУ	China 4	047	2026-05-09 20:37:33.548008	18.8149
11857	QF 2,22	ЗУ	China 6	049	2026-05-09 20:37:33.548008	20.3799
11859	QF 2,19	ЗУ	China 8	051	2026-05-09 20:37:33.548008	15.9514
11861	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:37:58.389416	21.8086
11863	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:37:58.389416	17.6423
11865	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:37:58.389416	20.5118
11867	TP3	ЗУ	CP-300 New	078	2026-05-09 20:38:03.318886	8.4618
11869	QF 1,20	ЗУ	China 1	044	2026-05-09 20:38:13.582541	12.9595
11871	QF 1,21	ЗУ	China 2	045	2026-05-09 20:38:13.582541	11.0937
11873	QF 1,22	ЗУ	China 3	046	2026-05-09 20:38:13.582541	14.9317
11875	QF 2,20	ЗУ	China 4	047	2026-05-09 20:38:13.582541	19.0066
11877	QF 2,21	ЗУ	China 5	048	2026-05-09 20:38:13.582541	20.5185
11879	QF 2,22	ЗУ	China 6	049	2026-05-09 20:38:13.582541	19.8756
11881	QF 2,23	ЗУ	China 7	050	2026-05-09 20:38:13.582541	10.2841
11883	Q4	ЗУ	BG 1	062	2026-05-09 20:38:18.279096	21.4123
11885	Q10	ЗУ	SM 2	064	2026-05-09 20:38:18.313851	19.1345
11887	Q12	ЗУ	SM 4	066	2026-05-09 20:38:18.313851	1.4773
11889	Q14	ЗУ	SM 6	068	2026-05-09 20:38:18.313851	1.3684
11891	Q16	ЗУ	SM 8	070	2026-05-09 20:38:18.313851	2.5757
11893	TP3	ЗУ	CP-300 New	078	2026-05-09 20:38:33.335629	7.0453
11895	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:38:33.435688	8.8148
11897	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:38:33.435688	8.776
11899	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:38:33.435688	19.2112
11901	QF 1,21	ЗУ	China 2	045	2026-05-09 20:38:53.751503	11.2362
11903	QF 2,20	ЗУ	China 4	047	2026-05-09 20:38:53.751503	19.8827
11905	QF 2,22	ЗУ	China 6	049	2026-05-09 20:38:53.751503	20.0334
11907	QF 2,19	ЗУ	China 8	051	2026-05-09 20:38:53.751503	15.6183
11909	Q9	ЗУ	BG 2	063	2026-05-09 20:39:03.305538	33.8253
11911	TP3	ЗУ	CP-300 New	078	2026-05-09 20:39:03.347151	7.367
11913	Q12	ЗУ	SM 4	066	2026-05-09 20:39:03.342521	1.8064
11915	Q14	ЗУ	SM 6	068	2026-05-09 20:39:03.342521	1.2299
11917	Q16	ЗУ	SM 8	070	2026-05-09 20:39:03.342521	2.9881
11919	Q20	ЗУ	MO 10	072	2026-05-09 20:39:03.745181	13.2859
11921	Q22	ЗУ	MO 12	074	2026-05-09 20:39:03.745181	0.9439
11923	Q24	ЗУ	MO 14	076	2026-05-09 20:39:03.745181	1.0783
11925	Q8	ЗУ	DIG	061	2026-05-09 20:39:08.149356	47.4889
11927	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:39:08.471609	9.0231
11929	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:39:08.471609	9.3041
11931	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:39:08.471609	20.2139
11933	QF 1,20	ЗУ	China 1	044	2026-05-09 20:39:33.789192	11.5015
11935	QF 1,22	ЗУ	China 3	046	2026-05-09 20:39:33.789192	14.8016
11937	QF 2,21	ЗУ	China 5	048	2026-05-09 20:39:33.789192	21.4874
11939	QF 2,23	ЗУ	China 7	050	2026-05-09 20:39:33.789192	10.5657
15522	TP3	ЗУ	CP-300 New	078	2026-05-10 00:57:07.218531	6.9764
15524	Q14	ЗУ	SM 6	068	2026-05-10 00:57:07.217038	0.8612
15526	Q16	ЗУ	SM 8	070	2026-05-10 00:57:07.217038	2.568
15527	Q8	ЗУ	DIG	061	2026-05-10 00:57:22.177881	45.3165
15528	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:57:23.972292	21.4088
15530	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:57:23.972292	17.8952
15532	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:57:23.972292	20.6099
15534	Q17	ЗУ	MO 9	071	2026-05-10 00:57:28.118625	1.0181
15536	Q21	ЗУ	MO 11	073	2026-05-10 00:57:28.118625	1.3739
15538	Q23	ЗУ	MO 13	075	2026-05-10 00:57:28.118625	0.9228
15540	Q25	ЗУ	MO 15	077	2026-05-10 00:57:28.118625	0.8624
15542	QF 1,20	ЗУ	China 1	044	2026-05-10 00:57:40.027367	11.8617
15544	QF 1,22	ЗУ	China 3	046	2026-05-10 00:57:40.027367	13.0911
15546	QF 2,21	ЗУ	China 5	048	2026-05-10 00:57:40.027367	20.3544
15548	QF 2,23	ЗУ	China 7	050	2026-05-10 00:57:40.027367	9.3961
15550	Q4	ЗУ	BG 1	062	2026-05-10 00:57:52.030868	20.3553
15552	Q10	ЗУ	SM 2	064	2026-05-10 00:57:52.263889	18.4691
15554	Q12	ЗУ	SM 4	066	2026-05-10 00:57:52.263889	0.6437
15556	Q14	ЗУ	SM 6	068	2026-05-10 00:57:52.263889	0.902
15558	Q16	ЗУ	SM 8	070	2026-05-10 00:57:52.263889	3.2312
15560	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:57:59.004145	21.6029
15562	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:57:59.004145	16.9235
15564	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:57:59.004145	19.9084
11784	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:36:13.291523	8.8936
11786	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:36:13.291523	19.9172
11788	QF 1,21	ЗУ	China 2	045	2026-05-09 20:36:13.437839	11.5006
11790	QF 2,20	ЗУ	China 4	047	2026-05-09 20:36:13.437839	19.9992
11792	QF 2,22	ЗУ	China 6	049	2026-05-09 20:36:13.437839	20.4713
11794	QF 2,19	ЗУ	China 8	051	2026-05-09 20:36:13.437839	15.6086
11796	Q17	ЗУ	MO 9	071	2026-05-09 20:36:33.283929	1.0199
11798	Q21	ЗУ	MO 11	073	2026-05-09 20:36:33.283929	0.9446
11800	Q23	ЗУ	MO 13	075	2026-05-09 20:36:33.283929	0.894
11802	Q25	ЗУ	MO 15	077	2026-05-09 20:36:33.283929	1.6714
11803	Q8	ЗУ	DIG	061	2026-05-09 20:36:48.007232	48.1698
11805	Q9	ЗУ	BG 2	063	2026-05-09 20:36:48.236583	33.771
11807	Q11	ЗУ	SM 3	065	2026-05-09 20:36:48.254889	22.0062
11809	Q13	ЗУ	SM 5	067	2026-05-09 20:36:48.254889	2.0183
11811	Q15	ЗУ	SM 7	069	2026-05-09 20:36:48.254889	2.0512
11813	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:36:48.327677	21.462
11815	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:36:48.327677	17.509
11817	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:36:48.327677	21.3217
11820	QF 1,21	ЗУ	China 2	045	2026-05-09 20:36:53.467829	11.6219
11822	QF 2,20	ЗУ	China 4	047	2026-05-09 20:36:53.467829	20.0108
11824	QF 2,22	ЗУ	China 6	049	2026-05-09 20:36:53.467829	20.0934
11826	QF 2,19	ЗУ	China 8	051	2026-05-09 20:36:53.467829	15.8758
11829	Q17	ЗУ	MO 9	071	2026-05-09 20:37:23.320277	0.737
11831	Q21	ЗУ	MO 11	073	2026-05-09 20:37:23.320277	1.2821
11833	Q23	ЗУ	MO 13	075	2026-05-09 20:37:23.320277	0.9267
11835	Q25	ЗУ	MO 15	077	2026-05-09 20:37:23.320277	0.9598
11837	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:37:23.348419	9.6357
11839	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:37:23.348419	8.4118
11841	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:37:23.348419	19.8919
11842	Q4	ЗУ	BG 1	062	2026-05-09 20:37:33.254261	21.4763
11844	Q10	ЗУ	SM 2	064	2026-05-09 20:37:33.287664	19.3165
11846	Q12	ЗУ	SM 4	066	2026-05-09 20:37:33.287664	1.4254
11848	Q14	ЗУ	SM 6	068	2026-05-09 20:37:33.287664	1.7471
11850	Q16	ЗУ	SM 8	070	2026-05-09 20:37:33.287664	2.7235
11852	QF 1,20	ЗУ	China 1	044	2026-05-09 20:37:33.548008	12.8477
11854	QF 1,22	ЗУ	China 3	046	2026-05-09 20:37:33.548008	14.8532
11856	QF 2,21	ЗУ	China 5	048	2026-05-09 20:37:33.548008	21.2823
11858	QF 2,23	ЗУ	China 7	050	2026-05-09 20:37:33.548008	10.0192
11860	Q8	ЗУ	DIG	061	2026-05-09 20:37:58.107305	48.4373
11862	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:37:58.389416	9.8553
11864	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:37:58.389416	9.0009
11866	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:37:58.389416	19.5106
11868	Q17	ЗУ	MO 9	071	2026-05-09 20:38:13.36874	1.356
11870	Q20	ЗУ	MO 10	072	2026-05-09 20:38:13.36874	13.8271
11872	Q21	ЗУ	MO 11	073	2026-05-09 20:38:13.36874	0.9229
11874	Q22	ЗУ	MO 12	074	2026-05-09 20:38:13.36874	1.4733
11876	Q23	ЗУ	MO 13	075	2026-05-09 20:38:13.36874	0.7202
11878	Q24	ЗУ	MO 14	076	2026-05-09 20:38:13.36874	0.975
11880	Q25	ЗУ	MO 15	077	2026-05-09 20:38:13.36874	1.0341
11882	QF 2,19	ЗУ	China 8	051	2026-05-09 20:38:13.582541	15.6012
11884	Q9	ЗУ	BG 2	063	2026-05-09 20:38:18.279096	33.5835
11886	Q11	ЗУ	SM 3	065	2026-05-09 20:38:18.313851	21.5418
11888	Q13	ЗУ	SM 5	067	2026-05-09 20:38:18.313851	1.3851
11890	Q15	ЗУ	SM 7	069	2026-05-09 20:38:18.313851	1.9742
11892	Q8	ЗУ	DIG	061	2026-05-09 20:38:33.139537	47.5693
11894	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:38:33.435688	21.0346
11896	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:38:33.435688	18.5742
11898	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:38:33.435688	20.2442
11900	QF 1,20	ЗУ	China 1	044	2026-05-09 20:38:53.751503	11.5299
11902	QF 1,22	ЗУ	China 3	046	2026-05-09 20:38:53.751503	13.9897
11904	QF 2,21	ЗУ	China 5	048	2026-05-09 20:38:53.751503	20.959
11906	QF 2,23	ЗУ	China 7	050	2026-05-09 20:38:53.751503	9.9712
11908	Q4	ЗУ	BG 1	062	2026-05-09 20:39:03.305538	22.0367
11910	Q10	ЗУ	SM 2	064	2026-05-09 20:39:03.342521	18.5473
11912	Q11	ЗУ	SM 3	065	2026-05-09 20:39:03.342521	21.5467
11914	Q13	ЗУ	SM 5	067	2026-05-09 20:39:03.342521	1.7357
11916	Q15	ЗУ	SM 7	069	2026-05-09 20:39:03.342521	1.9415
11918	Q17	ЗУ	MO 9	071	2026-05-09 20:39:03.745181	1.6494
11920	Q21	ЗУ	MO 11	073	2026-05-09 20:39:03.745181	0.9902
11922	Q23	ЗУ	MO 13	075	2026-05-09 20:39:03.745181	1.5453
11924	Q25	ЗУ	MO 15	077	2026-05-09 20:39:03.745181	1.2009
11926	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:39:08.471609	21.3585
11928	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:39:08.471609	17.3823
11930	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:39:08.471609	20.0208
11932	TP3	ЗУ	CP-300 New	078	2026-05-09 20:39:33.356081	8.0625
11934	QF 1,21	ЗУ	China 2	045	2026-05-09 20:39:33.789192	11.8993
11936	QF 2,20	ЗУ	China 4	047	2026-05-09 20:39:33.789192	19.9277
11938	QF 2,22	ЗУ	China 6	049	2026-05-09 20:39:33.789192	20.645
11940	QF 2,19	ЗУ	China 8	051	2026-05-09 20:39:33.789192	15.5851
11942	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:39:43.540742	22.5343
11943	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:39:43.540742	9.7516
11944	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:39:43.540742	17.8855
11945	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:39:43.540742	8.3055
11946	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:39:43.540742	20.0198
11947	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:39:43.540742	19.9837
11948	Q4	ЗУ	BG 1	062	2026-05-09 20:39:48.321057	21.2713
11950	Q10	ЗУ	SM 2	064	2026-05-09 20:39:48.368508	19.0505
11952	Q12	ЗУ	SM 4	066	2026-05-09 20:39:48.368508	1.9987
11954	Q14	ЗУ	SM 6	068	2026-05-09 20:39:48.368508	1.1244
11956	Q16	ЗУ	SM 8	070	2026-05-09 20:39:48.368508	2.581
11958	Q20	ЗУ	MO 10	072	2026-05-09 20:39:53.77121	13.7372
11960	Q22	ЗУ	MO 12	074	2026-05-09 20:39:53.77121	0.8925
11962	Q24	ЗУ	MO 14	076	2026-05-09 20:39:53.77121	0.7826
11964	TP3	ЗУ	CP-300 New	078	2026-05-09 20:40:03.390188	6.8855
11966	QF 1,21	ЗУ	China 2	045	2026-05-09 20:40:13.826436	10.7722
11968	QF 2,20	ЗУ	China 4	047	2026-05-09 20:40:13.826436	18.9856
11970	QF 2,22	ЗУ	China 6	049	2026-05-09 20:40:13.826436	19.9023
11972	QF 2,19	ЗУ	China 8	051	2026-05-09 20:40:13.826436	15.8144
11974	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:40:18.60619	22.4131
11976	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:40:18.60619	17.6953
11978	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:40:18.60619	20.8076
11981	Q9	ЗУ	BG 2	063	2026-05-09 20:40:33.336203	32.886
11949	Q9	ЗУ	BG 2	063	2026-05-09 20:39:48.321057	33.0932
11951	Q11	ЗУ	SM 3	065	2026-05-09 20:39:48.368508	21.6128
11953	Q13	ЗУ	SM 5	067	2026-05-09 20:39:48.368508	1.0261
11955	Q15	ЗУ	SM 7	069	2026-05-09 20:39:48.368508	1.4746
11957	Q17	ЗУ	MO 9	071	2026-05-09 20:39:53.77121	1.2556
11959	Q21	ЗУ	MO 11	073	2026-05-09 20:39:53.77121	1.5625
11961	Q23	ЗУ	MO 13	075	2026-05-09 20:39:53.77121	1.124
11963	Q25	ЗУ	MO 15	077	2026-05-09 20:39:53.77121	1.6118
11965	QF 1,20	ЗУ	China 1	044	2026-05-09 20:40:13.826436	12.6003
11967	QF 1,22	ЗУ	China 3	046	2026-05-09 20:40:13.826436	13.9475
11969	QF 2,21	ЗУ	China 5	048	2026-05-09 20:40:13.826436	21.6249
11971	QF 2,23	ЗУ	China 7	050	2026-05-09 20:40:13.826436	9.8958
11973	Q8	ЗУ	DIG	061	2026-05-09 20:40:18.205439	48.023
11975	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:40:18.60619	8.9482
11977	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:40:18.60619	9.0613
11979	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:40:18.60619	19.0139
11980	Q4	ЗУ	BG 1	062	2026-05-09 20:40:33.336203	21.5848
11982	Q10	ЗУ	SM 2	064	2026-05-09 20:40:33.394622	19.1565
11984	Q12	ЗУ	SM 4	066	2026-05-09 20:40:33.394622	1.7963
11986	Q13	ЗУ	SM 5	067	2026-05-09 20:40:33.394622	2.114
11988	Q15	ЗУ	SM 7	069	2026-05-09 20:40:33.394622	1.3206
11991	Q20	ЗУ	MO 10	072	2026-05-09 20:40:43.842346	13.8679
11993	Q22	ЗУ	MO 12	074	2026-05-09 20:40:43.842346	1.6573
11995	Q24	ЗУ	MO 14	076	2026-05-09 20:40:43.842346	1.499
11997	Q8	ЗУ	DIG	061	2026-05-09 20:40:53.220574	47.1239
11999	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:40:53.639964	9.4901
12001	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:40:53.639964	7.918
12003	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:40:53.639964	19.1351
12005	QF 1,21	ЗУ	China 2	045	2026-05-09 20:40:53.886128	10.6759
12007	QF 2,20	ЗУ	China 4	047	2026-05-09 20:40:53.886128	18.8598
12009	QF 2,22	ЗУ	China 6	049	2026-05-09 20:40:53.886128	20.2397
12011	QF 2,19	ЗУ	China 8	051	2026-05-09 20:40:53.886128	15.8901
12013	Q4	ЗУ	BG 1	062	2026-05-09 20:41:18.352927	21.4439
12015	Q10	ЗУ	SM 2	064	2026-05-09 20:41:18.425743	18.4972
12017	Q12	ЗУ	SM 4	066	2026-05-09 20:41:18.425743	1.3037
12019	Q14	ЗУ	SM 6	068	2026-05-09 20:41:18.425743	1.1085
12021	Q16	ЗУ	SM 8	070	2026-05-09 20:41:18.425743	3.0633
12023	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:41:28.675932	21.7419
12025	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:41:28.675932	18.2651
12027	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:41:28.675932	21.4204
12029	TP3	ЗУ	CP-300 New	078	2026-05-09 20:41:33.4578	8.7435
12031	Q20	ЗУ	MO 10	072	2026-05-09 20:41:33.901157	13.916
12033	Q22	ЗУ	MO 12	074	2026-05-09 20:41:33.901157	0.7648
12035	Q24	ЗУ	MO 14	076	2026-05-09 20:41:33.901157	1.1085
12037	Q25	ЗУ	MO 15	077	2026-05-09 20:41:33.901157	1.3147
12039	QF 1,22	ЗУ	China 3	046	2026-05-09 20:41:33.928686	13.4825
12041	QF 2,21	ЗУ	China 5	048	2026-05-09 20:41:33.928686	20.7688
12043	QF 2,23	ЗУ	China 7	050	2026-05-09 20:41:33.928686	9.7159
15567	Q17	ЗУ	MO 9	071	2026-05-10 00:58:18.164989	0.8336
15569	Q21	ЗУ	MO 11	073	2026-05-10 00:58:18.164989	1.3039
15571	Q23	ЗУ	MO 13	075	2026-05-10 00:58:18.164989	0.9618
15573	Q25	ЗУ	MO 15	077	2026-05-10 00:58:18.164989	0.5335
15575	QF 1,21	ЗУ	China 2	045	2026-05-10 00:58:20.095173	11.3009
15577	QF 2,20	ЗУ	China 4	047	2026-05-10 00:58:20.095173	18.8711
15579	QF 2,22	ЗУ	China 6	049	2026-05-10 00:58:20.095173	19.0516
15581	QF 2,19	ЗУ	China 8	051	2026-05-10 00:58:20.095173	14.81
15582	Q8	ЗУ	DIG	061	2026-05-10 00:58:32.227271	46.2689
15584	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:58:34.093962	8.5421
15586	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:58:34.093962	7.715
15588	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:58:34.093962	19.663
15590	Q9	ЗУ	BG 2	063	2026-05-10 00:58:37.056243	32.561
15592	Q11	ЗУ	SM 3	065	2026-05-10 00:58:37.307423	21.6759
15594	Q12	ЗУ	SM 4	066	2026-05-10 00:58:37.307423	1.0357
15596	Q14	ЗУ	SM 6	068	2026-05-10 00:58:37.307423	1.6353
15598	Q16	ЗУ	SM 8	070	2026-05-10 00:58:37.307423	2.5835
15599	QF 1,20	ЗУ	China 1	044	2026-05-10 00:59:00.156461	11.9136
15601	QF 1,22	ЗУ	China 3	046	2026-05-10 00:59:00.156461	13.2612
15603	QF 2,21	ЗУ	China 5	048	2026-05-10 00:59:00.156461	20.3288
15605	QF 2,23	ЗУ	China 7	050	2026-05-10 00:59:00.156461	10.1663
15607	Q8	ЗУ	DIG	061	2026-05-10 00:59:07.278694	45.2588
15609	Q17	ЗУ	MO 9	071	2026-05-10 00:59:08.216843	1.0629
15611	Q21	ЗУ	MO 11	073	2026-05-10 00:59:08.216843	0.472
15613	Q23	ЗУ	MO 13	075	2026-05-10 00:59:08.216843	0.6248
15615	Q25	ЗУ	MO 15	077	2026-05-10 00:59:08.216843	1.1665
15617	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:59:09.139508	8.4477
15619	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:59:09.139508	8.2804
15621	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:59:09.139508	19.7117
15623	Q9	ЗУ	BG 2	063	2026-05-10 00:59:22.077236	32.4738
15625	Q11	ЗУ	SM 3	065	2026-05-10 00:59:22.351791	22.0478
15627	Q13	ЗУ	SM 5	067	2026-05-10 00:59:22.351791	1.3332
15629	Q15	ЗУ	SM 7	069	2026-05-10 00:59:22.351791	1.0559
15632	QF 1,20	ЗУ	China 1	044	2026-05-10 00:59:40.211749	11.8746
15634	QF 1,22	ЗУ	China 3	046	2026-05-10 00:59:40.211749	14.165
15636	QF 2,21	ЗУ	China 5	048	2026-05-10 00:59:40.211749	20.6505
15638	QF 2,23	ЗУ	China 7	050	2026-05-10 00:59:40.211749	9.0096
15640	Q8	ЗУ	DIG	061	2026-05-10 00:59:42.287829	45.2751
15641	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 00:59:44.182479	20.8473
15643	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 00:59:44.182479	17.3473
15645	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 00:59:44.182479	20.0797
15647	Q17	ЗУ	MO 9	071	2026-05-10 00:59:58.247911	0.886
15649	Q21	ЗУ	MO 11	073	2026-05-10 00:59:58.247911	1.3999
15651	Q23	ЗУ	MO 13	075	2026-05-10 00:59:58.247911	1.0878
15653	Q25	ЗУ	MO 15	077	2026-05-10 00:59:58.247911	1.3308
15654	Q4	ЗУ	BG 1	062	2026-05-10 01:00:07.102363	20.2307
15656	TP3	ЗУ	CP-300 New	078	2026-05-10 01:00:07.384765	6.5038
15658	Q11	ЗУ	SM 3	065	2026-05-10 01:00:07.38839	21.259
15660	Q13	ЗУ	SM 5	067	2026-05-10 01:00:07.38839	0.7065
15662	Q15	ЗУ	SM 7	069	2026-05-10 01:00:07.38839	1.4432
15664	Q8	ЗУ	DIG	061	2026-05-10 01:00:17.303313	47.2619
15666	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:00:19.209259	9.2496
15668	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:00:19.209259	8.428
15670	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:00:19.209259	19.5008
15672	QF 1,21	ЗУ	China 2	045	2026-05-10 01:00:20.24142	10.6407
11983	Q11	ЗУ	SM 3	065	2026-05-09 20:40:33.394622	22.3756
11985	TP3	ЗУ	CP-300 New	078	2026-05-09 20:40:33.407672	7.4405
11987	Q14	ЗУ	SM 6	068	2026-05-09 20:40:33.394622	1.3151
11989	Q16	ЗУ	SM 8	070	2026-05-09 20:40:33.394622	3.062
11990	Q17	ЗУ	MO 9	071	2026-05-09 20:40:43.842346	1.465
11992	Q21	ЗУ	MO 11	073	2026-05-09 20:40:43.842346	0.9565
11994	Q23	ЗУ	MO 13	075	2026-05-09 20:40:43.842346	0.8978
11996	Q25	ЗУ	MO 15	077	2026-05-09 20:40:43.842346	1.3373
11998	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:40:53.639964	21.2619
12000	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:40:53.639964	16.8191
12002	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:40:53.639964	19.7972
12004	QF 1,20	ЗУ	China 1	044	2026-05-09 20:40:53.886128	11.5598
12006	QF 1,22	ЗУ	China 3	046	2026-05-09 20:40:53.886128	14.017
12008	QF 2,21	ЗУ	China 5	048	2026-05-09 20:40:53.886128	20.6531
12010	QF 2,23	ЗУ	China 7	050	2026-05-09 20:40:53.886128	9.4647
12012	TP3	ЗУ	CP-300 New	078	2026-05-09 20:41:03.418041	8.5973
12014	Q9	ЗУ	BG 2	063	2026-05-09 20:41:18.352927	33.6007
12016	Q11	ЗУ	SM 3	065	2026-05-09 20:41:18.425743	22.1577
12018	Q13	ЗУ	SM 5	067	2026-05-09 20:41:18.425743	1.9505
12020	Q15	ЗУ	SM 7	069	2026-05-09 20:41:18.425743	1.1933
12022	Q8	ЗУ	DIG	061	2026-05-09 20:41:28.2464	46.8686
12024	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:41:28.675932	8.7686
12026	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:41:28.675932	8.5029
12028	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:41:28.675932	19.9537
12030	Q17	ЗУ	MO 9	071	2026-05-09 20:41:33.901157	1.2649
12032	Q21	ЗУ	MO 11	073	2026-05-09 20:41:33.901157	0.8932
12034	Q23	ЗУ	MO 13	075	2026-05-09 20:41:33.901157	1.3592
12036	QF 1,20	ЗУ	China 1	044	2026-05-09 20:41:33.928686	12.8935
12038	QF 1,21	ЗУ	China 2	045	2026-05-09 20:41:33.928686	11.0403
12040	QF 2,20	ЗУ	China 4	047	2026-05-09 20:41:33.928686	19.8113
12042	QF 2,22	ЗУ	China 6	049	2026-05-09 20:41:33.928686	20.2734
12044	QF 2,19	ЗУ	China 8	051	2026-05-09 20:41:33.928686	15.9246
15628	Q14	ЗУ	SM 6	068	2026-05-10 00:59:22.351791	1.4839
15630	Q16	ЗУ	SM 8	070	2026-05-10 00:59:22.351791	3.1519
15631	TP3	ЗУ	CP-300 New	078	2026-05-10 00:59:37.35316	7.5599
15633	QF 1,21	ЗУ	China 2	045	2026-05-10 00:59:40.211749	11.2514
15635	QF 2,20	ЗУ	China 4	047	2026-05-10 00:59:40.211749	18.4075
15637	QF 2,22	ЗУ	China 6	049	2026-05-10 00:59:40.211749	19.0888
15639	QF 2,19	ЗУ	China 8	051	2026-05-10 00:59:40.211749	14.43
15642	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 00:59:44.182479	8.399
15644	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 00:59:44.182479	7.6101
15646	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 00:59:44.182479	18.6936
15648	Q20	ЗУ	MO 10	072	2026-05-10 00:59:58.247911	13.4744
15650	Q22	ЗУ	MO 12	074	2026-05-10 00:59:58.247911	0.4315
15652	Q24	ЗУ	MO 14	076	2026-05-10 00:59:58.247911	1.2701
15655	Q9	ЗУ	BG 2	063	2026-05-10 01:00:07.102363	32.6141
15657	Q10	ЗУ	SM 2	064	2026-05-10 01:00:07.38839	18.8325
15659	Q12	ЗУ	SM 4	066	2026-05-10 01:00:07.38839	1.3563
15661	Q14	ЗУ	SM 6	068	2026-05-10 01:00:07.38839	1.4222
15663	Q16	ЗУ	SM 8	070	2026-05-10 01:00:07.38839	3.0292
15665	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:00:19.209259	21.8233
15667	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:00:19.209259	16.8823
15669	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:00:19.209259	20.8073
15671	QF 1,20	ЗУ	China 1	044	2026-05-10 01:00:20.24142	11.3385
15673	QF 1,22	ЗУ	China 3	046	2026-05-10 01:00:20.24142	14.2224
15675	QF 2,21	ЗУ	China 5	048	2026-05-10 01:00:20.24142	20.1414
15677	QF 2,23	ЗУ	China 7	050	2026-05-10 01:00:20.24142	9.739
15681	Q20	ЗУ	MO 10	072	2026-05-10 01:00:48.303128	13.2618
15683	Q22	ЗУ	MO 12	074	2026-05-10 01:00:48.303128	1.0518
15685	Q24	ЗУ	MO 14	076	2026-05-10 01:00:48.303128	0.793
15687	Q4	ЗУ	BG 1	062	2026-05-10 01:00:52.147043	20.3494
15689	Q8	ЗУ	DIG	061	2026-05-10 01:00:52.358322	46.6041
15691	Q11	ЗУ	SM 3	065	2026-05-10 01:00:52.426535	21.5127
15693	Q13	ЗУ	SM 5	067	2026-05-10 01:00:52.426535	0.8491
15695	Q15	ЗУ	SM 7	069	2026-05-10 01:00:52.426535	1.1474
15697	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:00:54.264051	20.979
15699	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:00:54.264051	16.1562
15701	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:00:54.264051	19.1066
15703	QF 1,20	ЗУ	China 1	044	2026-05-10 01:01:00.299072	12.4191
15705	QF 1,22	ЗУ	China 3	046	2026-05-10 01:01:00.299072	13.4942
15707	QF 2,21	ЗУ	China 5	048	2026-05-10 01:01:00.299072	21.0616
15709	QF 2,23	ЗУ	China 7	050	2026-05-10 01:01:00.299072	10.0247
15713	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:01:29.299374	20.4982
15715	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:01:29.299374	17.4265
15717	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:01:29.299374	19.8279
15719	Q4	ЗУ	BG 1	062	2026-05-10 01:01:37.176431	20.8896
15721	Q10	ЗУ	SM 2	064	2026-05-10 01:01:37.462832	18.3956
15723	Q11	ЗУ	SM 3	065	2026-05-10 01:01:37.462832	22.0029
15725	Q13	ЗУ	SM 5	067	2026-05-10 01:01:37.462832	1.4213
15727	Q15	ЗУ	SM 7	069	2026-05-10 01:01:37.462832	0.6121
15729	Q17	ЗУ	MO 9	071	2026-05-10 01:01:38.346503	0.633
15731	Q21	ЗУ	MO 11	073	2026-05-10 01:01:38.346503	0.9836
15733	Q23	ЗУ	MO 13	075	2026-05-10 01:01:38.346503	1.0838
15735	Q25	ЗУ	MO 15	077	2026-05-10 01:01:38.346503	0.3984
15737	QF 1,21	ЗУ	China 2	045	2026-05-10 01:01:40.329624	11.38
15739	QF 2,20	ЗУ	China 4	047	2026-05-10 01:01:40.329624	18.5585
15741	QF 2,22	ЗУ	China 6	049	2026-05-10 01:01:40.329624	20.4834
15743	QF 2,19	ЗУ	China 8	051	2026-05-10 01:01:40.329624	14.7239
15744	Q8	ЗУ	DIG	061	2026-05-10 01:02:02.395958	46.0637
16184	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:11:25.424009	17.2282
16186	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:11:25.424009	19.7138
16188	TP3	ЗУ	CP-300 New	078	2026-05-10 01:11:37.966618	6.8976
16190	Q20	ЗУ	MO 10	072	2026-05-10 01:11:38.926127	13.598
16192	Q22	ЗУ	MO 12	074	2026-05-10 01:11:38.926127	0.7346
16194	Q24	ЗУ	MO 14	076	2026-05-10 01:11:38.926127	1.1027
16196	QF 1,20	ЗУ	China 1	044	2026-05-10 01:11:41.766992	11.1026
16198	QF 1,22	ЗУ	China 3	046	2026-05-10 01:11:41.766992	14.0585
16200	QF 2,21	ЗУ	China 5	048	2026-05-10 01:11:41.766992	20.9444
16202	QF 2,23	ЗУ	China 7	050	2026-05-10 01:11:41.766992	9.1183
16279	Q10	ЗУ	SM 2	064	2026-05-10 01:13:38.141115	18.3869
16280	Q11	ЗУ	SM 3	065	2026-05-10 01:13:38.141115	21.092
16281	Q12	ЗУ	SM 4	066	2026-05-10 01:13:38.141115	0.9749
12046	Q4	ЗУ	BG 1	062	2026-05-09 20:42:03.407382	21.4116
12047	Q9	ЗУ	BG 2	063	2026-05-09 20:42:03.407382	33.6778
12048	Q10	ЗУ	SM 2	064	2026-05-09 20:42:03.447304	19.2065
12049	Q11	ЗУ	SM 3	065	2026-05-09 20:42:03.447304	22.2569
12050	Q12	ЗУ	SM 4	066	2026-05-09 20:42:03.447304	1.7897
12051	Q13	ЗУ	SM 5	067	2026-05-09 20:42:03.447304	1.1667
12052	Q14	ЗУ	SM 6	068	2026-05-09 20:42:03.447304	1.3385
12053	Q15	ЗУ	SM 7	069	2026-05-09 20:42:03.447304	1.0077
12054	Q16	ЗУ	SM 8	070	2026-05-09 20:42:03.447304	3.6415
12055	TP3	ЗУ	CP-300 New	078	2026-05-09 20:42:03.530222	7.7708
12056	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:42:03.700764	21.8385
12057	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:42:03.700764	9.717
12058	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:42:03.700764	16.8835
12059	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:42:03.700764	8.0531
12060	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:42:03.700764	21.0071
12061	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:42:03.700764	19.3104
12062	QF 1,20	ЗУ	China 1	044	2026-05-09 20:42:13.968036	11.9675
12063	QF 1,21	ЗУ	China 2	045	2026-05-09 20:42:13.968036	11.299
12064	QF 1,22	ЗУ	China 3	046	2026-05-09 20:42:13.968036	14.7804
12065	QF 2,20	ЗУ	China 4	047	2026-05-09 20:42:13.968036	18.9305
12066	QF 2,21	ЗУ	China 5	048	2026-05-09 20:42:13.968036	20.4527
12067	QF 2,22	ЗУ	China 6	049	2026-05-09 20:42:13.968036	20.7553
12068	QF 2,23	ЗУ	China 7	050	2026-05-09 20:42:13.968036	10.1985
12069	QF 2,19	ЗУ	China 8	051	2026-05-09 20:42:13.968036	15.3797
12070	Q17	ЗУ	MO 9	071	2026-05-09 20:42:23.963766	1.0578
12071	Q20	ЗУ	MO 10	072	2026-05-09 20:42:23.963766	13.1669
12072	Q21	ЗУ	MO 11	073	2026-05-09 20:42:23.963766	1.1466
12073	Q22	ЗУ	MO 12	074	2026-05-09 20:42:23.963766	1.3202
12074	Q23	ЗУ	MO 13	075	2026-05-09 20:42:23.963766	1.2683
12075	Q24	ЗУ	MO 14	076	2026-05-09 20:42:23.963766	0.7625
12076	Q25	ЗУ	MO 15	077	2026-05-09 20:42:23.963766	1.5744
12077	TP3	ЗУ	CP-300 New	078	2026-05-09 20:42:33.549738	7.1806
12078	Q8	ЗУ	DIG	061	2026-05-09 20:42:38.366547	46.8517
12079	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:42:38.747365	21.4288
12080	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:42:38.747365	9.0321
12081	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:42:38.747365	18.3193
12082	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:42:38.747365	7.9113
12083	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:42:38.747365	20.8674
12084	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:42:38.747365	19.1582
12085	Q4	ЗУ	BG 1	062	2026-05-09 20:42:48.430439	20.8255
12086	Q9	ЗУ	BG 2	063	2026-05-09 20:42:48.430439	32.7169
12087	Q10	ЗУ	SM 2	064	2026-05-09 20:42:48.477363	18.9772
12088	Q11	ЗУ	SM 3	065	2026-05-09 20:42:48.477363	21.7732
12089	Q12	ЗУ	SM 4	066	2026-05-09 20:42:48.477363	1.2902
12090	Q13	ЗУ	SM 5	067	2026-05-09 20:42:48.477363	1.4753
12091	Q14	ЗУ	SM 6	068	2026-05-09 20:42:48.477363	1.8269
12092	Q15	ЗУ	SM 7	069	2026-05-09 20:42:48.477363	1.3409
12093	Q16	ЗУ	SM 8	070	2026-05-09 20:42:48.477363	2.5263
12094	QF 1,20	ЗУ	China 1	044	2026-05-09 20:42:54.01292	11.5169
12095	QF 1,21	ЗУ	China 2	045	2026-05-09 20:42:54.01292	11.9176
12096	QF 1,22	ЗУ	China 3	046	2026-05-09 20:42:54.01292	14.7669
12097	QF 2,20	ЗУ	China 4	047	2026-05-09 20:42:54.01292	19.1347
12098	QF 2,21	ЗУ	China 5	048	2026-05-09 20:42:54.01292	21.5835
12099	QF 2,22	ЗУ	China 6	049	2026-05-09 20:42:54.01292	20.8453
12100	QF 2,23	ЗУ	China 7	050	2026-05-09 20:42:54.01292	9.7887
12101	QF 2,19	ЗУ	China 8	051	2026-05-09 20:42:54.01292	15.7219
12102	TP3	ЗУ	CP-300 New	078	2026-05-09 20:43:03.565148	7.189
12103	Q8	ЗУ	DIG	061	2026-05-09 20:43:13.407312	47.5925
12104	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:43:13.777953	21.2952
12105	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:43:13.777953	9.2476
12106	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:43:13.777953	18.3376
12107	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:43:13.777953	7.8118
12108	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:43:13.777953	20.579
12109	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:43:13.777953	19.0554
12110	Q17	ЗУ	MO 9	071	2026-05-09 20:43:13.998248	1.0504
12111	Q20	ЗУ	MO 10	072	2026-05-09 20:43:13.998248	13.5897
12112	Q21	ЗУ	MO 11	073	2026-05-09 20:43:13.998248	1.0156
12113	Q22	ЗУ	MO 12	074	2026-05-09 20:43:13.998248	1.036
12114	Q23	ЗУ	MO 13	075	2026-05-09 20:43:13.998248	0.9458
12115	Q24	ЗУ	MO 14	076	2026-05-09 20:43:13.998248	0.9797
12116	Q25	ЗУ	MO 15	077	2026-05-09 20:43:13.998248	1.3124
12117	Q4	ЗУ	BG 1	062	2026-05-09 20:43:33.498161	21.5472
12118	Q10	ЗУ	SM 2	064	2026-05-09 20:43:33.522946	19.4998
12119	Q11	ЗУ	SM 3	065	2026-05-09 20:43:33.522946	22.0956
12120	Q9	ЗУ	BG 2	063	2026-05-09 20:43:33.498161	32.8556
12121	Q12	ЗУ	SM 4	066	2026-05-09 20:43:33.522946	1.6746
12122	Q13	ЗУ	SM 5	067	2026-05-09 20:43:33.522946	1.1902
12123	TP3	ЗУ	CP-300 New	078	2026-05-09 20:43:33.572852	7.7224
12124	Q14	ЗУ	SM 6	068	2026-05-09 20:43:33.522946	1.3086
12125	Q15	ЗУ	SM 7	069	2026-05-09 20:43:33.522946	1.3478
12126	Q16	ЗУ	SM 8	070	2026-05-09 20:43:33.522946	3.4867
12127	QF 1,20	ЗУ	China 1	044	2026-05-09 20:43:34.050727	12.5158
12128	QF 1,21	ЗУ	China 2	045	2026-05-09 20:43:34.050727	10.611
12129	QF 1,22	ЗУ	China 3	046	2026-05-09 20:43:34.050727	14.0071
12130	QF 2,20	ЗУ	China 4	047	2026-05-09 20:43:34.050727	19.5841
12131	QF 2,21	ЗУ	China 5	048	2026-05-09 20:43:34.050727	20.8094
12132	QF 2,22	ЗУ	China 6	049	2026-05-09 20:43:34.050727	19.8618
12133	QF 2,23	ЗУ	China 7	050	2026-05-09 20:43:34.050727	9.5007
12134	QF 2,19	ЗУ	China 8	051	2026-05-09 20:43:34.050727	14.4747
12135	Q8	ЗУ	DIG	061	2026-05-09 20:43:48.448132	48.2666
12136	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:43:48.841777	22.1392
12137	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:43:48.841777	9.7564
12138	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:43:48.841777	16.9501
12139	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:43:48.841777	8.3738
12140	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:43:48.841777	20.9452
12141	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:43:48.841777	19.0912
12142	TP3	ЗУ	CP-300 New	078	2026-05-09 20:44:03.585648	7.7908
12143	Q17	ЗУ	MO 9	071	2026-05-09 20:44:04.027791	0.9522
12144	Q20	ЗУ	MO 10	072	2026-05-09 20:44:04.027791	13.6445
12145	Q21	ЗУ	MO 11	073	2026-05-09 20:44:04.027791	1.4448
12146	Q22	ЗУ	MO 12	074	2026-05-09 20:44:04.027791	0.7717
12147	Q23	ЗУ	MO 13	075	2026-05-09 20:44:04.027791	0.8354
12148	Q24	ЗУ	MO 14	076	2026-05-09 20:44:04.027791	1.2587
12150	QF 1,20	ЗУ	China 1	044	2026-05-09 20:44:14.08337	12.0854
12152	QF 1,22	ЗУ	China 3	046	2026-05-09 20:44:14.08337	14.3656
12154	QF 2,21	ЗУ	China 5	048	2026-05-09 20:44:14.08337	20.9408
12156	QF 2,23	ЗУ	China 7	050	2026-05-09 20:44:14.08337	10.5546
12158	Q4	ЗУ	BG 1	062	2026-05-09 20:44:18.575863	21.5226
12160	Q10	ЗУ	SM 2	064	2026-05-09 20:44:18.591674	18.5183
12162	Q12	ЗУ	SM 4	066	2026-05-09 20:44:18.591674	1.9029
12164	Q14	ЗУ	SM 6	068	2026-05-09 20:44:18.591674	1.9296
12166	Q16	ЗУ	SM 8	070	2026-05-09 20:44:18.591674	3.0649
12168	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:44:23.885837	20.9107
12170	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:44:23.885837	17.1891
12172	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:44:23.885837	20.6423
12174	TP3	ЗУ	CP-300 New	078	2026-05-09 20:44:33.604649	8.2375
15674	QF 2,20	ЗУ	China 4	047	2026-05-10 01:00:20.24142	18.7887
15676	QF 2,22	ЗУ	China 6	049	2026-05-10 01:00:20.24142	20.2668
15678	QF 2,19	ЗУ	China 8	051	2026-05-10 01:00:20.24142	14.3843
15679	TP3	ЗУ	CP-300 New	078	2026-05-10 01:00:37.400723	6.0571
15680	Q17	ЗУ	MO 9	071	2026-05-10 01:00:48.303128	0.7307
15682	Q21	ЗУ	MO 11	073	2026-05-10 01:00:48.303128	0.6374
15684	Q23	ЗУ	MO 13	075	2026-05-10 01:00:48.303128	0.8084
15686	Q25	ЗУ	MO 15	077	2026-05-10 01:00:48.303128	1.0161
15688	Q9	ЗУ	BG 2	063	2026-05-10 01:00:52.147043	32.8064
15690	Q10	ЗУ	SM 2	064	2026-05-10 01:00:52.426535	18.5762
15692	Q12	ЗУ	SM 4	066	2026-05-10 01:00:52.426535	1.6443
15694	Q14	ЗУ	SM 6	068	2026-05-10 01:00:52.426535	1.1104
15696	Q16	ЗУ	SM 8	070	2026-05-10 01:00:52.426535	2.6699
15698	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:00:54.264051	9.2752
15700	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:00:54.264051	8.2518
15702	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:00:54.264051	19.2531
15704	QF 1,21	ЗУ	China 2	045	2026-05-10 01:01:00.299072	10.7676
15706	QF 2,20	ЗУ	China 4	047	2026-05-10 01:01:00.299072	18.1517
15708	QF 2,22	ЗУ	China 6	049	2026-05-10 01:01:00.299072	19.4485
15710	QF 2,19	ЗУ	China 8	051	2026-05-10 01:01:00.299072	14.4159
15711	TP3	ЗУ	CP-300 New	078	2026-05-10 01:01:07.443515	7.259
15712	Q8	ЗУ	DIG	061	2026-05-10 01:01:27.375895	46.3826
15714	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:01:29.299374	9.3964
15716	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:01:29.299374	8.3743
15718	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:01:29.299374	19.8385
15720	Q9	ЗУ	BG 2	063	2026-05-10 01:01:37.176431	32.7687
15722	TP3	ЗУ	CP-300 New	078	2026-05-10 01:01:37.459863	7.5215
15724	Q12	ЗУ	SM 4	066	2026-05-10 01:01:37.462832	1.6312
15726	Q14	ЗУ	SM 6	068	2026-05-10 01:01:37.462832	0.8569
15728	Q16	ЗУ	SM 8	070	2026-05-10 01:01:37.462832	2.4519
15730	Q20	ЗУ	MO 10	072	2026-05-10 01:01:38.346503	13.7998
15732	Q22	ЗУ	MO 12	074	2026-05-10 01:01:38.346503	0.5098
15734	Q24	ЗУ	MO 14	076	2026-05-10 01:01:38.346503	0.797
15736	QF 1,20	ЗУ	China 1	044	2026-05-10 01:01:40.329624	10.9929
15738	QF 1,22	ЗУ	China 3	046	2026-05-10 01:01:40.329624	13.3734
15740	QF 2,21	ЗУ	China 5	048	2026-05-10 01:01:40.329624	20.6739
15742	QF 2,23	ЗУ	China 7	050	2026-05-10 01:01:40.329624	10.2659
16204	Q8	ЗУ	DIG	061	2026-05-10 01:11:57.904222	45.0907
16205	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:12:00.479352	20.1158
16206	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:12:00.479352	8.463
16207	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:12:00.479352	17.11
16208	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:12:00.479352	7.4777
16209	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:12:00.479352	20.5973
16210	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:12:00.479352	19.3224
16211	Q4	ЗУ	BG 1	062	2026-05-10 01:12:07.675329	21.3457
16212	Q9	ЗУ	BG 2	063	2026-05-10 01:12:07.675329	32.6533
16213	Q10	ЗУ	SM 2	064	2026-05-10 01:12:07.99095	18.6263
16214	Q11	ЗУ	SM 3	065	2026-05-10 01:12:07.99095	21.3639
16215	Q12	ЗУ	SM 4	066	2026-05-10 01:12:07.99095	1.0284
16216	Q13	ЗУ	SM 5	067	2026-05-10 01:12:07.99095	1.6523
16217	Q14	ЗУ	SM 6	068	2026-05-10 01:12:07.99095	1.0009
16218	Q15	ЗУ	SM 7	069	2026-05-10 01:12:07.99095	0.7901
16219	Q16	ЗУ	SM 8	070	2026-05-10 01:12:07.99095	2.294
16220	TP3	ЗУ	CP-300 New	078	2026-05-10 01:12:08.031776	5.9522
16221	QF 1,20	ЗУ	China 1	044	2026-05-10 01:12:21.814963	11.4238
16222	QF 1,21	ЗУ	China 2	045	2026-05-10 01:12:21.814963	11.2077
16223	QF 1,22	ЗУ	China 3	046	2026-05-10 01:12:21.814963	13.6478
16224	QF 2,20	ЗУ	China 4	047	2026-05-10 01:12:21.814963	19.4481
16225	QF 2,21	ЗУ	China 5	048	2026-05-10 01:12:21.814963	21.3745
16226	QF 2,22	ЗУ	China 6	049	2026-05-10 01:12:21.814963	18.9247
16227	QF 2,23	ЗУ	China 7	050	2026-05-10 01:12:21.814963	9.1549
16228	QF 2,19	ЗУ	China 8	051	2026-05-10 01:12:21.814963	15.0592
16229	Q17	ЗУ	MO 9	071	2026-05-10 01:12:28.961571	0.8715
16230	Q20	ЗУ	MO 10	072	2026-05-10 01:12:28.961571	13.643
16231	Q21	ЗУ	MO 11	073	2026-05-10 01:12:28.961571	1.2446
16232	Q22	ЗУ	MO 12	074	2026-05-10 01:12:28.961571	0.7842
16233	Q23	ЗУ	MO 13	075	2026-05-10 01:12:28.961571	1.2454
16234	Q24	ЗУ	MO 14	076	2026-05-10 01:12:28.961571	0.5286
16235	Q25	ЗУ	MO 15	077	2026-05-10 01:12:28.961571	0.6763
16236	Q8	ЗУ	DIG	061	2026-05-10 01:12:32.922924	46.897
16237	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:12:35.51441	21.1442
16238	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:12:35.51441	9.6486
16239	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:12:35.51441	16.3876
16240	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:12:35.51441	8.6637
16241	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:12:35.51441	19.4713
16242	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:12:35.51441	19.0771
16243	TP3	ЗУ	CP-300 New	078	2026-05-10 01:12:38.039154	7.3878
16244	Q4	ЗУ	BG 1	062	2026-05-10 01:12:52.719629	20.8149
16245	Q9	ЗУ	BG 2	063	2026-05-10 01:12:52.719629	32.2353
16246	Q10	ЗУ	SM 2	064	2026-05-10 01:12:53.029488	18.3368
16247	Q11	ЗУ	SM 3	065	2026-05-10 01:12:53.029488	21.674
16248	Q12	ЗУ	SM 4	066	2026-05-10 01:12:53.029488	0.7427
16249	Q13	ЗУ	SM 5	067	2026-05-10 01:12:53.029488	0.6529
16250	Q14	ЗУ	SM 6	068	2026-05-10 01:12:53.029488	1.1593
16251	Q15	ЗУ	SM 7	069	2026-05-10 01:12:53.029488	1.4124
16252	Q16	ЗУ	SM 8	070	2026-05-10 01:12:53.029488	2.1497
16253	QF 1,20	ЗУ	China 1	044	2026-05-10 01:13:01.863696	11.8887
16254	QF 1,21	ЗУ	China 2	045	2026-05-10 01:13:01.863696	10.3988
16309	Q8	ЗУ	DIG	061	2026-05-10 01:14:17.971133	46.3985
12149	Q25	ЗУ	MO 15	077	2026-05-09 20:44:04.027791	0.8381
12151	QF 1,21	ЗУ	China 2	045	2026-05-09 20:44:14.08337	10.4938
12153	QF 2,20	ЗУ	China 4	047	2026-05-09 20:44:14.08337	19.694
12155	QF 2,22	ЗУ	China 6	049	2026-05-09 20:44:14.08337	20.0356
12157	QF 2,19	ЗУ	China 8	051	2026-05-09 20:44:14.08337	14.6688
12159	Q9	ЗУ	BG 2	063	2026-05-09 20:44:18.575863	32.8633
12161	Q11	ЗУ	SM 3	065	2026-05-09 20:44:18.591674	21.9256
12163	Q13	ЗУ	SM 5	067	2026-05-09 20:44:18.591674	1.5295
12165	Q15	ЗУ	SM 7	069	2026-05-09 20:44:18.591674	1.0346
12167	Q8	ЗУ	DIG	061	2026-05-09 20:44:23.484377	47.1363
12169	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:44:23.885837	10.1325
12171	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:44:23.885837	7.9063
12173	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:44:23.885837	19.5392
12175	Q17	ЗУ	MO 9	071	2026-05-09 20:44:54.066641	1.1397
12176	Q20	ЗУ	MO 10	072	2026-05-09 20:44:54.066641	13.4117
12177	Q21	ЗУ	MO 11	073	2026-05-09 20:44:54.066641	0.7339
12178	Q22	ЗУ	MO 12	074	2026-05-09 20:44:54.066641	0.8065
12179	Q23	ЗУ	MO 13	075	2026-05-09 20:44:54.066641	1.1138
12180	Q24	ЗУ	MO 14	076	2026-05-09 20:44:54.066641	0.9946
12181	Q25	ЗУ	MO 15	077	2026-05-09 20:44:54.066641	0.9799
12182	QF 1,20	ЗУ	China 1	044	2026-05-09 20:44:54.157876	12.6858
12183	QF 1,21	ЗУ	China 2	045	2026-05-09 20:44:54.157876	11.8256
12184	QF 1,22	ЗУ	China 3	046	2026-05-09 20:44:54.157876	13.5262
12185	QF 2,20	ЗУ	China 4	047	2026-05-09 20:44:54.157876	19.7508
12186	QF 2,21	ЗУ	China 5	048	2026-05-09 20:44:54.157876	21.8076
12187	QF 2,22	ЗУ	China 6	049	2026-05-09 20:44:54.157876	20.412
12188	QF 2,23	ЗУ	China 7	050	2026-05-09 20:44:54.157876	10.2632
12189	QF 2,19	ЗУ	China 8	051	2026-05-09 20:44:54.157876	15.4081
12190	Q8	ЗУ	DIG	061	2026-05-09 20:44:58.496724	47.9229
12191	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:44:58.913781	20.806
12192	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:44:58.913781	9.4849
12193	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:44:58.913781	17.4445
12194	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:44:58.913781	9.5119
12195	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:44:58.913781	20.1532
12196	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:44:58.913781	19.6361
12197	Q4	ЗУ	BG 1	062	2026-05-09 20:45:03.605289	21.5577
12198	Q9	ЗУ	BG 2	063	2026-05-09 20:45:03.605289	33.6599
12199	TP3	ЗУ	CP-300 New	078	2026-05-09 20:45:03.628708	7.1624
12200	Q10	ЗУ	SM 2	064	2026-05-09 20:45:03.629531	19.3148
12201	Q11	ЗУ	SM 3	065	2026-05-09 20:45:03.629531	22.4367
12202	Q12	ЗУ	SM 4	066	2026-05-09 20:45:03.629531	0.9477
12203	Q13	ЗУ	SM 5	067	2026-05-09 20:45:03.629531	2.0291
12204	Q14	ЗУ	SM 6	068	2026-05-09 20:45:03.629531	1.3818
12205	Q15	ЗУ	SM 7	069	2026-05-09 20:45:03.629531	1.9176
12206	Q16	ЗУ	SM 8	070	2026-05-09 20:45:03.629531	3.4618
12207	Q8	ЗУ	DIG	061	2026-05-09 20:45:33.516573	47.0548
12208	TP3	ЗУ	CP-300 New	078	2026-05-09 20:45:33.642637	8.3942
12209	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:45:33.952713	20.9408
12210	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:45:33.952713	10.4477
12211	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:45:33.952713	17.9306
12212	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:45:33.952713	8.2751
12213	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:45:33.952713	21.116
12214	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:45:33.952713	20.0221
12215	QF 1,20	ЗУ	China 1	044	2026-05-09 20:45:34.189927	11.5891
12216	QF 1,21	ЗУ	China 2	045	2026-05-09 20:45:34.189927	10.6243
12217	QF 1,22	ЗУ	China 3	046	2026-05-09 20:45:34.189927	14.4325
12218	QF 2,20	ЗУ	China 4	047	2026-05-09 20:45:34.189927	18.8271
12219	QF 2,21	ЗУ	China 5	048	2026-05-09 20:45:34.189927	21.3728
12220	QF 2,22	ЗУ	China 6	049	2026-05-09 20:45:34.189927	19.6465
12221	QF 2,23	ЗУ	China 7	050	2026-05-09 20:45:34.189927	10.9037
12222	QF 2,19	ЗУ	China 8	051	2026-05-09 20:45:34.189927	15.1366
12223	Q17	ЗУ	MO 9	071	2026-05-09 20:45:44.1102	0.7068
12224	Q20	ЗУ	MO 10	072	2026-05-09 20:45:44.1102	13.3565
12225	Q21	ЗУ	MO 11	073	2026-05-09 20:45:44.1102	1.1817
12226	Q22	ЗУ	MO 12	074	2026-05-09 20:45:44.1102	1.2928
12227	Q23	ЗУ	MO 13	075	2026-05-09 20:45:44.1102	1.138
12228	Q24	ЗУ	MO 14	076	2026-05-09 20:45:44.1102	1.1063
12229	Q25	ЗУ	MO 15	077	2026-05-09 20:45:44.1102	1.5156
12230	Q4	ЗУ	BG 1	062	2026-05-09 20:45:48.62845	21.4415
12231	Q9	ЗУ	BG 2	063	2026-05-09 20:45:48.62845	33.2549
12232	Q10	ЗУ	SM 2	064	2026-05-09 20:45:48.668787	19.5353
12233	Q11	ЗУ	SM 3	065	2026-05-09 20:45:48.668787	21.6427
12234	Q12	ЗУ	SM 4	066	2026-05-09 20:45:48.668787	1.8438
12235	Q13	ЗУ	SM 5	067	2026-05-09 20:45:48.668787	1.3404
12236	Q14	ЗУ	SM 6	068	2026-05-09 20:45:48.668787	1.1622
12237	Q15	ЗУ	SM 7	069	2026-05-09 20:45:48.668787	1.7405
12238	Q16	ЗУ	SM 8	070	2026-05-09 20:45:48.668787	2.5471
12239	TP3	ЗУ	CP-300 New	078	2026-05-09 20:46:03.658283	7.2968
12240	Q8	ЗУ	DIG	061	2026-05-09 20:46:08.530432	48.2843
12241	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:46:08.988273	21.4676
12242	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:46:08.988273	10.5075
12243	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:46:08.988273	17.8232
12244	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:46:08.988273	9.2131
12245	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:46:08.988273	20.2167
12246	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:46:08.988273	18.9262
12247	QF 1,20	ЗУ	China 1	044	2026-05-09 20:46:14.224976	12.0609
12248	QF 1,21	ЗУ	China 2	045	2026-05-09 20:46:14.224976	10.5296
12249	QF 1,22	ЗУ	China 3	046	2026-05-09 20:46:14.224976	14.9845
12250	QF 2,20	ЗУ	China 4	047	2026-05-09 20:46:14.224976	19.8377
12251	QF 2,21	ЗУ	China 5	048	2026-05-09 20:46:14.224976	21.7664
12252	QF 2,22	ЗУ	China 6	049	2026-05-09 20:46:14.224976	20.8523
12253	QF 2,23	ЗУ	China 7	050	2026-05-09 20:46:14.224976	10.3641
12254	QF 2,19	ЗУ	China 8	051	2026-05-09 20:46:14.224976	15.1856
12255	Q4	ЗУ	BG 1	062	2026-05-09 20:46:33.647539	21.6529
12256	Q9	ЗУ	BG 2	063	2026-05-09 20:46:33.647539	32.8028
12257	TP3	ЗУ	CP-300 New	078	2026-05-09 20:46:33.68461	8.6746
12258	Q10	ЗУ	SM 2	064	2026-05-09 20:46:33.697812	18.757
12259	Q11	ЗУ	SM 3	065	2026-05-09 20:46:33.697812	22.0559
12260	Q12	ЗУ	SM 4	066	2026-05-09 20:46:33.697812	1.509
12261	Q13	ЗУ	SM 5	067	2026-05-09 20:46:33.697812	1.7264
12262	Q14	ЗУ	SM 6	068	2026-05-09 20:46:33.697812	1.5664
12263	Q15	ЗУ	SM 7	069	2026-05-09 20:46:33.697812	1.4542
12264	Q16	ЗУ	SM 8	070	2026-05-09 20:46:33.697812	2.4531
12266	Q20	ЗУ	MO 10	072	2026-05-09 20:46:34.272585	13.2424
12268	Q22	ЗУ	MO 12	074	2026-05-09 20:46:34.272585	1.2966
12270	Q24	ЗУ	MO 14	076	2026-05-09 20:46:34.272585	1.2373
12272	Q8	ЗУ	DIG	061	2026-05-09 20:46:43.542814	46.9482
12274	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:46:44.024237	9.5205
12276	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:46:44.024237	9.4583
12278	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:46:44.024237	19.4007
12280	QF 1,21	ЗУ	China 2	045	2026-05-09 20:46:54.260673	11.3572
12282	QF 2,20	ЗУ	China 4	047	2026-05-09 20:46:54.260673	19.0569
12284	QF 2,22	ЗУ	China 6	049	2026-05-09 20:46:54.260673	19.4975
12286	QF 2,19	ЗУ	China 8	051	2026-05-09 20:46:54.260673	14.7886
12288	Q8	ЗУ	DIG	061	2026-05-09 20:47:18.560566	47.1594
12289	Q10	ЗУ	SM 2	064	2026-05-09 20:47:18.739818	19.0429
12291	Q11	ЗУ	SM 3	065	2026-05-09 20:47:18.739818	21.5056
12293	Q12	ЗУ	SM 4	066	2026-05-09 20:47:18.739818	1.7396
12295	Q14	ЗУ	SM 6	068	2026-05-09 20:47:18.739818	1.9446
12297	Q16	ЗУ	SM 8	070	2026-05-09 20:47:18.739818	2.7977
12299	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:47:19.062048	9.3476
12301	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:47:19.062048	8.6253
12303	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:47:19.062048	19.798
12305	Q20	ЗУ	MO 10	072	2026-05-09 20:47:24.308049	13.7792
12307	Q22	ЗУ	MO 12	074	2026-05-09 20:47:24.308049	1.3016
12309	Q24	ЗУ	MO 14	076	2026-05-09 20:47:24.308049	0.7242
12311	TP3	ЗУ	CP-300 New	078	2026-05-09 20:47:33.705595	7.6637
12313	QF 1,21	ЗУ	China 2	045	2026-05-09 20:47:34.332244	11.2507
12315	QF 2,20	ЗУ	China 4	047	2026-05-09 20:47:34.332244	18.5865
12317	QF 2,22	ЗУ	China 6	049	2026-05-09 20:47:34.332244	19.4889
12319	QF 2,19	ЗУ	China 8	051	2026-05-09 20:47:34.332244	15.7191
12321	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:47:54.098492	21.6112
12323	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:47:54.098492	17.3586
12325	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:47:54.098492	19.796
12327	TP3	ЗУ	CP-300 New	078	2026-05-09 20:48:03.724735	7.0369
12329	Q9	ЗУ	BG 2	063	2026-05-09 20:48:03.783492	33.6402
12331	Q11	ЗУ	SM 3	065	2026-05-09 20:48:03.808208	21.5751
12333	Q13	ЗУ	SM 5	067	2026-05-09 20:48:03.808208	2.0196
12335	Q15	ЗУ	SM 7	069	2026-05-09 20:48:03.808208	1.1043
12337	Q17	ЗУ	MO 9	071	2026-05-09 20:48:14.366567	1.615
12339	Q20	ЗУ	MO 10	072	2026-05-09 20:48:14.366567	13.8208
12341	Q21	ЗУ	MO 11	073	2026-05-09 20:48:14.366567	0.8113
12343	QF 1,22	ЗУ	China 3	046	2026-05-09 20:48:14.372273	14.2407
12345	QF 2,20	ЗУ	China 4	047	2026-05-09 20:48:14.372273	19.6418
12347	QF 2,21	ЗУ	China 5	048	2026-05-09 20:48:14.372273	20.5745
12349	QF 2,22	ЗУ	China 6	049	2026-05-09 20:48:14.372273	19.696
12351	QF 2,19	ЗУ	China 8	051	2026-05-09 20:48:14.372273	14.7807
12353	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:48:29.13421	22.098
12355	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:48:29.13421	17.3508
12357	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:48:29.13421	20.5447
12359	TP3	ЗУ	CP-300 New	078	2026-05-09 20:48:33.736895	6.7822
12362	Q9	ЗУ	BG 2	063	2026-05-09 20:48:48.800566	33.1341
12364	Q12	ЗУ	SM 4	066	2026-05-09 20:48:48.831136	1.5535
12366	Q14	ЗУ	SM 6	068	2026-05-09 20:48:48.831136	0.9238
12368	Q16	ЗУ	SM 8	070	2026-05-09 20:48:48.831136	3.2653
12370	QF 1,21	ЗУ	China 2	045	2026-05-09 20:48:54.419604	11.8328
12372	QF 2,20	ЗУ	China 4	047	2026-05-09 20:48:54.419604	19.7467
12374	QF 2,22	ЗУ	China 6	049	2026-05-09 20:48:54.419604	19.7473
12376	QF 2,19	ЗУ	China 8	051	2026-05-09 20:48:54.419604	15.3689
12378	TP3	ЗУ	CP-300 New	078	2026-05-09 20:49:03.753319	7.9034
12380	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:49:04.169699	10.1076
12382	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:49:04.169699	9.0744
12384	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:49:04.169699	19.4999
12386	Q20	ЗУ	MO 10	072	2026-05-09 20:49:04.412853	13.2245
12388	Q22	ЗУ	MO 12	074	2026-05-09 20:49:04.412853	0.8749
12390	Q24	ЗУ	MO 14	076	2026-05-09 20:49:04.412853	0.7086
12392	TP3	ЗУ	CP-300 New	078	2026-05-09 20:49:33.766723	8.0253
12394	Q9	ЗУ	BG 2	063	2026-05-09 20:49:33.846127	33.9079
12396	Q11	ЗУ	SM 3	065	2026-05-09 20:49:33.890677	22.1396
12398	Q13	ЗУ	SM 5	067	2026-05-09 20:49:33.890677	1.0732
12400	Q15	ЗУ	SM 7	069	2026-05-09 20:49:33.890677	2.0884
12402	QF 1,20	ЗУ	China 1	044	2026-05-09 20:49:34.464245	11.9479
12404	QF 1,22	ЗУ	China 3	046	2026-05-09 20:49:34.464245	14.9616
12406	QF 2,21	ЗУ	China 5	048	2026-05-09 20:49:34.464245	21.5114
12408	QF 2,23	ЗУ	China 7	050	2026-05-09 20:49:34.464245	10.5988
12410	Q8	ЗУ	DIG	061	2026-05-09 20:49:38.710012	46.6479
12412	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:49:39.20012	9.1723
12414	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:49:39.20012	8.0216
12416	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:49:39.20012	20.3254
12418	Q20	ЗУ	MO 10	072	2026-05-09 20:49:54.447496	14.0294
12420	Q22	ЗУ	MO 12	074	2026-05-09 20:49:54.447496	1.4704
12422	Q24	ЗУ	MO 14	076	2026-05-09 20:49:54.447496	0.815
15745	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:02:04.332226	20.0896
15747	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:02:04.332226	16.9004
15749	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:02:04.332226	19.8348
15751	TP3	ЗУ	CP-300 New	078	2026-05-10 01:02:07.481763	6.8074
15753	QF 1,21	ЗУ	China 2	045	2026-05-10 01:02:20.381286	9.9473
15755	QF 2,20	ЗУ	China 4	047	2026-05-10 01:02:20.381286	18.5348
15757	QF 2,22	ЗУ	China 6	049	2026-05-10 01:02:20.381286	20.1681
15759	QF 2,19	ЗУ	China 8	051	2026-05-10 01:02:20.381286	14.7315
15761	Q9	ЗУ	BG 2	063	2026-05-10 01:02:22.197327	32.2577
15763	Q11	ЗУ	SM 3	065	2026-05-10 01:02:22.506339	21.4255
15765	Q13	ЗУ	SM 5	067	2026-05-10 01:02:22.506339	1.5139
15767	Q15	ЗУ	SM 7	069	2026-05-10 01:02:22.506339	1.5131
15770	Q20	ЗУ	MO 10	072	2026-05-10 01:02:28.385401	13.4026
15772	Q22	ЗУ	MO 12	074	2026-05-10 01:02:28.385401	1.2054
15774	Q24	ЗУ	MO 14	076	2026-05-10 01:02:28.385401	0.7433
15776	Q8	ЗУ	DIG	061	2026-05-10 01:02:37.410315	45.4202
15778	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:02:39.445353	20.424
15780	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:02:39.445353	17.7356
15782	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:02:39.445353	19.965
15785	QF 1,21	ЗУ	China 2	045	2026-05-10 01:03:00.423025	10.5549
15787	QF 2,20	ЗУ	China 4	047	2026-05-10 01:03:00.423025	18.2256
15789	QF 2,22	ЗУ	China 6	049	2026-05-10 01:03:00.423025	19.3937
12265	Q17	ЗУ	MO 9	071	2026-05-09 20:46:34.272585	1.2089
12267	Q21	ЗУ	MO 11	073	2026-05-09 20:46:34.272585	1.5252
12269	Q23	ЗУ	MO 13	075	2026-05-09 20:46:34.272585	0.7324
12271	Q25	ЗУ	MO 15	077	2026-05-09 20:46:34.272585	1.3261
12273	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:46:44.024237	22.2955
12275	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:46:44.024237	17.5862
12277	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:46:44.024237	20.5502
12279	QF 1,20	ЗУ	China 1	044	2026-05-09 20:46:54.260673	12.2748
12281	QF 1,22	ЗУ	China 3	046	2026-05-09 20:46:54.260673	14.5739
12283	QF 2,21	ЗУ	China 5	048	2026-05-09 20:46:54.260673	21.8189
12285	QF 2,23	ЗУ	China 7	050	2026-05-09 20:46:54.260673	10.4139
12287	TP3	ЗУ	CP-300 New	078	2026-05-09 20:47:03.694419	8.3568
12290	Q4	ЗУ	BG 1	062	2026-05-09 20:47:18.68882	21.8797
12292	Q9	ЗУ	BG 2	063	2026-05-09 20:47:18.68882	33.1435
12294	Q13	ЗУ	SM 5	067	2026-05-09 20:47:18.739818	1.7489
12296	Q15	ЗУ	SM 7	069	2026-05-09 20:47:18.739818	2.0535
12298	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:47:19.062048	22.4133
12300	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:47:19.062048	17.9819
12302	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:47:19.062048	20.8609
12304	Q17	ЗУ	MO 9	071	2026-05-09 20:47:24.308049	1.0597
12306	Q21	ЗУ	MO 11	073	2026-05-09 20:47:24.308049	0.902
12308	Q23	ЗУ	MO 13	075	2026-05-09 20:47:24.308049	0.969
12310	Q25	ЗУ	MO 15	077	2026-05-09 20:47:24.308049	0.9011
12312	QF 1,20	ЗУ	China 1	044	2026-05-09 20:47:34.332244	12.1715
12314	QF 1,22	ЗУ	China 3	046	2026-05-09 20:47:34.332244	14.2493
12316	QF 2,21	ЗУ	China 5	048	2026-05-09 20:47:34.332244	21.646
12318	QF 2,23	ЗУ	China 7	050	2026-05-09 20:47:34.332244	10.3438
12320	Q8	ЗУ	DIG	061	2026-05-09 20:47:53.606315	46.3697
12322	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:47:54.098492	9.5199
12324	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:47:54.098492	7.9301
12326	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:47:54.098492	18.852
12328	Q4	ЗУ	BG 1	062	2026-05-09 20:48:03.783492	21.6492
12330	Q10	ЗУ	SM 2	064	2026-05-09 20:48:03.808208	19.3742
12332	Q12	ЗУ	SM 4	066	2026-05-09 20:48:03.808208	1.2789
12334	Q14	ЗУ	SM 6	068	2026-05-09 20:48:03.808208	1.0251
12336	Q16	ЗУ	SM 8	070	2026-05-09 20:48:03.808208	3.2472
12338	QF 1,20	ЗУ	China 1	044	2026-05-09 20:48:14.372273	11.5779
12340	QF 1,21	ЗУ	China 2	045	2026-05-09 20:48:14.372273	11.8761
12342	Q22	ЗУ	MO 12	074	2026-05-09 20:48:14.366567	0.8854
12344	Q23	ЗУ	MO 13	075	2026-05-09 20:48:14.366567	0.7105
12346	Q24	ЗУ	MO 14	076	2026-05-09 20:48:14.366567	0.869
12348	Q25	ЗУ	MO 15	077	2026-05-09 20:48:14.366567	0.8469
12350	QF 2,23	ЗУ	China 7	050	2026-05-09 20:48:14.372273	10.4815
12352	Q8	ЗУ	DIG	061	2026-05-09 20:48:28.642697	46.4913
12354	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:48:29.13421	8.7046
12356	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:48:29.13421	8.4101
12358	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:48:29.13421	19.9149
12360	Q4	ЗУ	BG 1	062	2026-05-09 20:48:48.800566	21.8177
12361	Q10	ЗУ	SM 2	064	2026-05-09 20:48:48.831136	18.859
12363	Q11	ЗУ	SM 3	065	2026-05-09 20:48:48.831136	21.7472
12365	Q13	ЗУ	SM 5	067	2026-05-09 20:48:48.831136	1.4297
12367	Q15	ЗУ	SM 7	069	2026-05-09 20:48:48.831136	1.0146
12369	QF 1,20	ЗУ	China 1	044	2026-05-09 20:48:54.419604	12.1443
12371	QF 1,22	ЗУ	China 3	046	2026-05-09 20:48:54.419604	14.2371
12373	QF 2,21	ЗУ	China 5	048	2026-05-09 20:48:54.419604	21.2763
12375	QF 2,23	ЗУ	China 7	050	2026-05-09 20:48:54.419604	9.8913
12377	Q8	ЗУ	DIG	061	2026-05-09 20:49:03.689413	46.5631
12379	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:49:04.169699	21.7611
12381	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:49:04.169699	16.8335
12383	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:49:04.169699	19.9331
12385	Q17	ЗУ	MO 9	071	2026-05-09 20:49:04.412853	1.3723
12387	Q21	ЗУ	MO 11	073	2026-05-09 20:49:04.412853	0.6683
12389	Q23	ЗУ	MO 13	075	2026-05-09 20:49:04.412853	1.5534
12391	Q25	ЗУ	MO 15	077	2026-05-09 20:49:04.412853	1.0101
12393	Q4	ЗУ	BG 1	062	2026-05-09 20:49:33.846127	21.6588
12395	Q10	ЗУ	SM 2	064	2026-05-09 20:49:33.890677	18.8882
12397	Q12	ЗУ	SM 4	066	2026-05-09 20:49:33.890677	1.5986
12399	Q14	ЗУ	SM 6	068	2026-05-09 20:49:33.890677	1.9061
12401	Q16	ЗУ	SM 8	070	2026-05-09 20:49:33.890677	2.9758
12403	QF 1,21	ЗУ	China 2	045	2026-05-09 20:49:34.464245	11.1447
12405	QF 2,20	ЗУ	China 4	047	2026-05-09 20:49:34.464245	19.6252
12407	QF 2,22	ЗУ	China 6	049	2026-05-09 20:49:34.464245	20.1667
12409	QF 2,19	ЗУ	China 8	051	2026-05-09 20:49:34.464245	15.3105
12411	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:49:39.20012	21.7479
12413	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:49:39.20012	17.3024
12415	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:49:39.20012	20.0439
12417	Q17	ЗУ	MO 9	071	2026-05-09 20:49:54.447496	1.2286
12419	Q21	ЗУ	MO 11	073	2026-05-09 20:49:54.447496	0.7847
12421	Q23	ЗУ	MO 13	075	2026-05-09 20:49:54.447496	1.0332
12423	Q25	ЗУ	MO 15	077	2026-05-09 20:49:54.447496	1.4415
12424	TP3	ЗУ	CP-300 New	078	2026-05-09 20:50:03.801719	7.0564
12425	Q8	ЗУ	DIG	061	2026-05-09 20:50:13.749437	47.9579
12426	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:50:14.223484	20.809
12427	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:50:14.223484	8.9675
12428	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:50:14.223484	17.9544
12429	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:50:14.223484	8.3082
12430	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:50:14.223484	20.3149
12431	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:50:14.223484	19.2335
12432	QF 1,20	ЗУ	China 1	044	2026-05-09 20:50:14.492745	11.7737
12433	QF 1,21	ЗУ	China 2	045	2026-05-09 20:50:14.492745	11.547
12434	QF 1,22	ЗУ	China 3	046	2026-05-09 20:50:14.492745	14.8701
12435	QF 2,20	ЗУ	China 4	047	2026-05-09 20:50:14.492745	19.9682
12436	QF 2,21	ЗУ	China 5	048	2026-05-09 20:50:14.492745	20.5002
12437	QF 2,22	ЗУ	China 6	049	2026-05-09 20:50:14.492745	20.0969
12438	QF 2,23	ЗУ	China 7	050	2026-05-09 20:50:14.492745	9.5702
12439	QF 2,19	ЗУ	China 8	051	2026-05-09 20:50:14.492745	15.0492
12440	Q4	ЗУ	BG 1	062	2026-05-09 20:50:18.861813	21.9185
12441	Q9	ЗУ	BG 2	063	2026-05-09 20:50:18.861813	32.8702
12442	Q10	ЗУ	SM 2	064	2026-05-09 20:50:18.918719	18.5545
12443	Q11	ЗУ	SM 3	065	2026-05-09 20:50:18.918719	22.0411
12444	Q12	ЗУ	SM 4	066	2026-05-09 20:50:18.918719	1.601
12445	Q13	ЗУ	SM 5	067	2026-05-09 20:50:18.918719	0.9549
12446	Q14	ЗУ	SM 6	068	2026-05-09 20:50:18.918719	1.5749
12448	Q16	ЗУ	SM 8	070	2026-05-09 20:50:18.918719	2.9796
12450	Q17	ЗУ	MO 9	071	2026-05-09 20:50:44.509608	0.6783
12452	Q21	ЗУ	MO 11	073	2026-05-09 20:50:44.509608	1.052
12454	Q23	ЗУ	MO 13	075	2026-05-09 20:50:44.509608	1.4935
12456	Q25	ЗУ	MO 15	077	2026-05-09 20:50:44.509608	1.3574
12458	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:50:49.254361	22.157
12460	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:50:49.254361	17.6002
12462	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:50:49.254361	20.8975
12464	QF 1,20	ЗУ	China 1	044	2026-05-09 20:50:54.522475	11.7614
12466	QF 1,22	ЗУ	China 3	046	2026-05-09 20:50:54.522475	14.1066
12468	QF 2,21	ЗУ	China 5	048	2026-05-09 20:50:54.522475	21.8945
12470	QF 2,23	ЗУ	China 7	050	2026-05-09 20:50:54.522475	9.9967
12472	TP3	ЗУ	CP-300 New	078	2026-05-09 20:51:03.837756	8.1118
12474	Q9	ЗУ	BG 2	063	2026-05-09 20:51:03.888118	32.8122
12476	Q11	ЗУ	SM 3	065	2026-05-09 20:51:03.946486	22.1086
12478	Q13	ЗУ	SM 5	067	2026-05-09 20:51:03.946486	1.1459
12480	Q15	ЗУ	SM 7	069	2026-05-09 20:51:03.946486	1.4251
12482	Q8	ЗУ	DIG	061	2026-05-09 20:51:23.814158	47.3775
12484	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:51:24.278921	9.4905
12486	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:51:24.278921	9.1332
12488	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:51:24.278921	19.1915
12490	Q17	ЗУ	MO 9	071	2026-05-09 20:51:34.549869	1.0707
12492	QF 1,20	ЗУ	China 1	044	2026-05-09 20:51:34.563995	11.5749
12494	QF 1,21	ЗУ	China 2	045	2026-05-09 20:51:34.563995	10.398
12496	QF 1,22	ЗУ	China 3	046	2026-05-09 20:51:34.563995	13.5956
12498	Q24	ЗУ	MO 14	076	2026-05-09 20:51:34.549869	1.5934
12500	Q25	ЗУ	MO 15	077	2026-05-09 20:51:34.549869	1.3791
12502	QF 2,22	ЗУ	China 6	049	2026-05-09 20:51:34.563995	20.1314
12504	QF 2,19	ЗУ	China 8	051	2026-05-09 20:51:34.563995	15.0165
12506	Q9	ЗУ	BG 2	063	2026-05-09 20:51:48.912416	33.5148
12508	Q11	ЗУ	SM 3	065	2026-05-09 20:51:48.980818	22.4311
12510	Q13	ЗУ	SM 5	067	2026-05-09 20:51:48.980818	1.6165
12512	Q15	ЗУ	SM 7	069	2026-05-09 20:51:48.980818	1.0473
12514	Q8	ЗУ	DIG	061	2026-05-09 20:51:58.827774	47.5858
12516	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:51:59.310135	9.4389
12518	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:51:59.310135	7.9687
12520	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:51:59.310135	18.9268
12522	QF 1,20	ЗУ	China 1	044	2026-05-09 20:52:14.600085	11.4234
12524	QF 1,22	ЗУ	China 3	046	2026-05-09 20:52:14.600085	14.5181
12526	QF 2,21	ЗУ	China 5	048	2026-05-09 20:52:14.600085	20.8099
12528	QF 2,23	ЗУ	China 7	050	2026-05-09 20:52:14.600085	10.6471
12531	Q20	ЗУ	MO 10	072	2026-05-09 20:52:24.589483	13.8349
12533	Q22	ЗУ	MO 12	074	2026-05-09 20:52:24.589483	0.8007
12535	Q24	ЗУ	MO 14	076	2026-05-09 20:52:24.589483	1.3932
12538	TP3	ЗУ	CP-300 New	078	2026-05-09 20:52:33.878451	7.4192
12540	Q9	ЗУ	BG 2	063	2026-05-09 20:52:33.959895	33.6886
12542	Q11	ЗУ	SM 3	065	2026-05-09 20:52:33.998366	21.4134
12544	Q13	ЗУ	SM 5	067	2026-05-09 20:52:33.998366	1.3503
12546	Q15	ЗУ	SM 7	069	2026-05-09 20:52:33.998366	1.5143
12548	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:52:34.343933	21.795
12550	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:52:34.343933	17.9675
12552	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:52:34.343933	20.873
12554	QF 1,20	ЗУ	China 1	044	2026-05-09 20:52:54.636887	11.5161
12556	QF 1,22	ЗУ	China 3	046	2026-05-09 20:52:54.636887	13.745
12558	QF 2,21	ЗУ	China 5	048	2026-05-09 20:52:54.636887	20.3993
12560	QF 2,23	ЗУ	China 7	050	2026-05-09 20:52:54.636887	10.1282
12562	TP3	ЗУ	CP-300 New	078	2026-05-09 20:53:03.88382	7.294
12564	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:53:09.380482	22.2847
12566	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:53:09.380482	17.1311
12568	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:53:09.380482	19.8606
12570	Q17	ЗУ	MO 9	071	2026-05-09 20:53:14.614552	1.4946
12572	Q21	ЗУ	MO 11	073	2026-05-09 20:53:14.614552	1.4266
12574	Q23	ЗУ	MO 13	075	2026-05-09 20:53:14.614552	1.4586
12576	Q25	ЗУ	MO 15	077	2026-05-09 20:53:14.614552	1.1223
12578	Q9	ЗУ	BG 2	063	2026-05-09 20:53:18.97495	33.3102
12580	Q11	ЗУ	SM 3	065	2026-05-09 20:53:19.026461	21.5521
12582	Q13	ЗУ	SM 5	067	2026-05-09 20:53:19.026461	1.0857
12584	Q15	ЗУ	SM 7	069	2026-05-09 20:53:19.026461	1.6963
12586	TP3	ЗУ	CP-300 New	078	2026-05-09 20:53:33.904309	6.9497
12588	QF 1,21	ЗУ	China 2	045	2026-05-09 20:53:34.693829	10.7741
12590	QF 2,20	ЗУ	China 4	047	2026-05-09 20:53:34.693829	18.899
12592	QF 2,22	ЗУ	China 6	049	2026-05-09 20:53:34.693829	20.8441
12594	QF 2,19	ЗУ	China 8	051	2026-05-09 20:53:34.693829	14.9205
12596	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:53:44.413513	21.6069
12598	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:53:44.413513	17.2291
12600	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:53:44.413513	20.6188
12602	TP3	ЗУ	CP-300 New	078	2026-05-09 20:54:03.941761	8.2705
12604	Q9	ЗУ	BG 2	063	2026-05-09 20:54:03.999121	32.919
12606	Q11	ЗУ	SM 3	065	2026-05-09 20:54:04.059896	22.3983
12608	Q13	ЗУ	SM 5	067	2026-05-09 20:54:04.059896	1.6103
12610	Q15	ЗУ	SM 7	069	2026-05-09 20:54:04.059896	1.8389
12612	Q17	ЗУ	MO 9	071	2026-05-09 20:54:04.707661	1.1411
12614	Q21	ЗУ	MO 11	073	2026-05-09 20:54:04.707661	0.7486
12616	Q23	ЗУ	MO 13	075	2026-05-09 20:54:04.707661	1.2991
12618	Q25	ЗУ	MO 15	077	2026-05-09 20:54:04.707661	0.7255
12620	QF 1,21	ЗУ	China 2	045	2026-05-09 20:54:14.738599	10.6525
12622	QF 2,20	ЗУ	China 4	047	2026-05-09 20:54:14.738599	18.4543
12624	QF 2,22	ЗУ	China 6	049	2026-05-09 20:54:14.738599	20.2544
12626	QF 2,19	ЗУ	China 8	051	2026-05-09 20:54:14.738599	14.4646
12628	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:54:19.460202	21.3087
12630	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:54:19.460202	17.5871
12632	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:54:19.460202	20.3579
12634	TP3	ЗУ	CP-300 New	078	2026-05-09 20:54:33.982611	8.189
12636	Q9	ЗУ	BG 2	063	2026-05-09 20:54:49.016023	32.8537
12638	Q11	ЗУ	SM 3	065	2026-05-09 20:54:49.084749	22.3779
12640	Q13	ЗУ	SM 5	067	2026-05-09 20:54:49.084749	1.0352
12642	Q15	ЗУ	SM 7	069	2026-05-09 20:54:49.084749	1.7721
12644	Q8	ЗУ	DIG	061	2026-05-09 20:54:53.914887	46.2077
12646	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:54:54.492202	9.7219
12648	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:54:54.492202	9.3619
12650	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:54:54.492202	20.2911
12447	Q15	ЗУ	SM 7	069	2026-05-09 20:50:18.918719	2.0802
12449	TP3	ЗУ	CP-300 New	078	2026-05-09 20:50:33.828263	6.9784
12451	Q20	ЗУ	MO 10	072	2026-05-09 20:50:44.509608	13.9381
12453	Q22	ЗУ	MO 12	074	2026-05-09 20:50:44.509608	1.628
12455	Q24	ЗУ	MO 14	076	2026-05-09 20:50:44.509608	0.8482
12457	Q8	ЗУ	DIG	061	2026-05-09 20:50:48.799338	46.7595
12459	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:50:49.254361	8.7047
12461	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:50:49.254361	9.0051
12463	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:50:49.254361	19.5287
12465	QF 1,21	ЗУ	China 2	045	2026-05-09 20:50:54.522475	10.5032
12467	QF 2,20	ЗУ	China 4	047	2026-05-09 20:50:54.522475	19.2508
12469	QF 2,22	ЗУ	China 6	049	2026-05-09 20:50:54.522475	19.8583
12471	QF 2,19	ЗУ	China 8	051	2026-05-09 20:50:54.522475	15.7464
12473	Q4	ЗУ	BG 1	062	2026-05-09 20:51:03.888118	20.6261
12475	Q10	ЗУ	SM 2	064	2026-05-09 20:51:03.946486	19.5891
12477	Q12	ЗУ	SM 4	066	2026-05-09 20:51:03.946486	1.1675
12479	Q14	ЗУ	SM 6	068	2026-05-09 20:51:03.946486	1.8744
12481	Q16	ЗУ	SM 8	070	2026-05-09 20:51:03.946486	2.9528
12483	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:51:24.278921	21.3238
12485	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:51:24.278921	17.8258
12487	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:51:24.278921	20.7969
12489	TP3	ЗУ	CP-300 New	078	2026-05-09 20:51:33.850102	6.9157
12491	Q20	ЗУ	MO 10	072	2026-05-09 20:51:34.549869	13.5777
12493	Q21	ЗУ	MO 11	073	2026-05-09 20:51:34.549869	1.2808
12495	Q22	ЗУ	MO 12	074	2026-05-09 20:51:34.549869	0.6439
12497	Q23	ЗУ	MO 13	075	2026-05-09 20:51:34.549869	0.9352
12499	QF 2,20	ЗУ	China 4	047	2026-05-09 20:51:34.563995	18.8085
12501	QF 2,21	ЗУ	China 5	048	2026-05-09 20:51:34.563995	20.5361
12503	QF 2,23	ЗУ	China 7	050	2026-05-09 20:51:34.563995	10.3314
12505	Q4	ЗУ	BG 1	062	2026-05-09 20:51:48.912416	21.0019
12507	Q10	ЗУ	SM 2	064	2026-05-09 20:51:48.980818	18.4404
12509	Q12	ЗУ	SM 4	066	2026-05-09 20:51:48.980818	1.6995
12511	Q14	ЗУ	SM 6	068	2026-05-09 20:51:48.980818	2.0703
12513	Q16	ЗУ	SM 8	070	2026-05-09 20:51:48.980818	2.4446
12515	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:51:59.310135	20.9881
12517	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:51:59.310135	17.0182
12519	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:51:59.310135	20.5143
12521	TP3	ЗУ	CP-300 New	078	2026-05-09 20:52:03.865397	6.6331
12523	QF 1,21	ЗУ	China 2	045	2026-05-09 20:52:14.600085	10.7195
12525	QF 2,20	ЗУ	China 4	047	2026-05-09 20:52:14.600085	19.7934
12527	QF 2,22	ЗУ	China 6	049	2026-05-09 20:52:14.600085	20.8141
12529	QF 2,19	ЗУ	China 8	051	2026-05-09 20:52:14.600085	14.61
12530	Q17	ЗУ	MO 9	071	2026-05-09 20:52:24.589483	0.6462
12532	Q21	ЗУ	MO 11	073	2026-05-09 20:52:24.589483	1.6208
12534	Q23	ЗУ	MO 13	075	2026-05-09 20:52:24.589483	1.4674
12536	Q25	ЗУ	MO 15	077	2026-05-09 20:52:24.589483	1.2318
12537	Q8	ЗУ	DIG	061	2026-05-09 20:52:33.839476	47.9159
12539	Q4	ЗУ	BG 1	062	2026-05-09 20:52:33.959895	21.2679
12541	Q10	ЗУ	SM 2	064	2026-05-09 20:52:33.998366	18.908
12543	Q12	ЗУ	SM 4	066	2026-05-09 20:52:33.998366	1.3624
12545	Q14	ЗУ	SM 6	068	2026-05-09 20:52:33.998366	1.0061
12547	Q16	ЗУ	SM 8	070	2026-05-09 20:52:33.998366	2.9
12549	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:52:34.343933	9.7594
12551	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:52:34.343933	8.4334
12553	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:52:34.343933	20.0696
12555	QF 1,21	ЗУ	China 2	045	2026-05-09 20:52:54.636887	11.8992
12557	QF 2,20	ЗУ	China 4	047	2026-05-09 20:52:54.636887	19.0277
12559	QF 2,22	ЗУ	China 6	049	2026-05-09 20:52:54.636887	20.8886
12561	QF 2,19	ЗУ	China 8	051	2026-05-09 20:52:54.636887	15.3699
12563	Q8	ЗУ	DIG	061	2026-05-09 20:53:08.84582	46.3742
12565	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:53:09.380482	10.4041
12567	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:53:09.380482	9.2738
12569	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:53:09.380482	19.1013
12571	Q20	ЗУ	MO 10	072	2026-05-09 20:53:14.614552	13.7612
12573	Q22	ЗУ	MO 12	074	2026-05-09 20:53:14.614552	1.2487
12575	Q24	ЗУ	MO 14	076	2026-05-09 20:53:14.614552	1.1099
12577	Q4	ЗУ	BG 1	062	2026-05-09 20:53:18.97495	21.4462
12579	Q10	ЗУ	SM 2	064	2026-05-09 20:53:19.026461	18.4891
12581	Q12	ЗУ	SM 4	066	2026-05-09 20:53:19.026461	1.6114
12583	Q14	ЗУ	SM 6	068	2026-05-09 20:53:19.026461	1.1066
12585	Q16	ЗУ	SM 8	070	2026-05-09 20:53:19.026461	3.0623
12587	QF 1,20	ЗУ	China 1	044	2026-05-09 20:53:34.693829	12.603
12589	QF 1,22	ЗУ	China 3	046	2026-05-09 20:53:34.693829	13.3916
12591	QF 2,21	ЗУ	China 5	048	2026-05-09 20:53:34.693829	21.1885
12593	QF 2,23	ЗУ	China 7	050	2026-05-09 20:53:34.693829	10.1273
12595	Q8	ЗУ	DIG	061	2026-05-09 20:53:43.86514	48.0004
12597	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:53:44.413513	9.3936
12599	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:53:44.413513	8.0037
12601	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:53:44.413513	19.4466
12603	Q4	ЗУ	BG 1	062	2026-05-09 20:54:03.999121	20.6566
12605	Q10	ЗУ	SM 2	064	2026-05-09 20:54:04.059896	18.6655
12607	Q12	ЗУ	SM 4	066	2026-05-09 20:54:04.059896	1.3716
12609	Q14	ЗУ	SM 6	068	2026-05-09 20:54:04.059896	1.4743
12611	Q16	ЗУ	SM 8	070	2026-05-09 20:54:04.059896	3.0729
12613	Q20	ЗУ	MO 10	072	2026-05-09 20:54:04.707661	14.0211
12615	Q22	ЗУ	MO 12	074	2026-05-09 20:54:04.707661	1.5791
12617	Q24	ЗУ	MO 14	076	2026-05-09 20:54:04.707661	0.7788
12619	QF 1,20	ЗУ	China 1	044	2026-05-09 20:54:14.738599	12.1357
12621	QF 1,22	ЗУ	China 3	046	2026-05-09 20:54:14.738599	13.7972
12623	QF 2,21	ЗУ	China 5	048	2026-05-09 20:54:14.738599	21.0707
12625	QF 2,23	ЗУ	China 7	050	2026-05-09 20:54:14.738599	9.3834
12627	Q8	ЗУ	DIG	061	2026-05-09 20:54:18.892104	46.2602
12629	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:54:19.460202	9.8636
12631	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:54:19.460202	8.6485
12633	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:54:19.460202	19.1356
12635	Q4	ЗУ	BG 1	062	2026-05-09 20:54:49.016023	21.8133
12637	Q10	ЗУ	SM 2	064	2026-05-09 20:54:49.084749	18.4561
12639	Q12	ЗУ	SM 4	066	2026-05-09 20:54:49.084749	1.4203
12641	Q14	ЗУ	SM 6	068	2026-05-09 20:54:49.084749	1.8944
12643	Q16	ЗУ	SM 8	070	2026-05-09 20:54:49.084749	2.9319
12645	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:54:54.492202	20.7508
12647	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:54:54.492202	17.3358
12649	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:54:54.492202	20.4197
12651	Q17	ЗУ	MO 9	071	2026-05-09 20:54:54.740222	0.9627
12653	Q21	ЗУ	MO 11	073	2026-05-09 20:54:54.740222	1.0221
12655	Q23	ЗУ	MO 13	075	2026-05-09 20:54:54.740222	1.502
12657	Q25	ЗУ	MO 15	077	2026-05-09 20:54:54.740222	1.1191
12659	QF 1,21	ЗУ	China 2	045	2026-05-09 20:54:54.782715	11.1508
12661	QF 2,20	ЗУ	China 4	047	2026-05-09 20:54:54.782715	19.8205
12663	QF 2,22	ЗУ	China 6	049	2026-05-09 20:54:54.782715	20.5557
12665	QF 2,19	ЗУ	China 8	051	2026-05-09 20:54:54.782715	15.3002
12667	Q8	ЗУ	DIG	061	2026-05-09 20:55:28.931511	46.1419
12669	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:55:29.532551	8.9937
12671	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:55:29.532551	8.7485
12673	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:55:29.532551	20.4134
12675	Q4	ЗУ	BG 1	062	2026-05-09 20:55:34.048083	21.0437
12677	Q10	ЗУ	SM 2	064	2026-05-09 20:55:34.117302	19.0715
12679	Q12	ЗУ	SM 4	066	2026-05-09 20:55:34.117302	0.9514
12681	Q14	ЗУ	SM 6	068	2026-05-09 20:55:34.117302	1.308
12683	Q16	ЗУ	SM 8	070	2026-05-09 20:55:34.117302	2.6778
12685	QF 1,21	ЗУ	China 2	045	2026-05-09 20:55:34.805495	10.5769
12687	QF 2,20	ЗУ	China 4	047	2026-05-09 20:55:34.805495	18.8351
12689	QF 2,22	ЗУ	China 6	049	2026-05-09 20:55:34.805495	19.8159
12691	QF 2,19	ЗУ	China 8	051	2026-05-09 20:55:34.805495	14.701
12693	Q20	ЗУ	MO 10	072	2026-05-09 20:55:44.773133	13.1674
12695	Q22	ЗУ	MO 12	074	2026-05-09 20:55:44.773133	1.006
12697	Q24	ЗУ	MO 14	076	2026-05-09 20:55:44.773133	1.33
12699	Q8	ЗУ	DIG	061	2026-05-09 20:56:03.987907	46.3974
12701	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:56:04.567435	22.2438
12703	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:56:04.567435	16.6503
12705	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:56:04.567435	21.386
12707	QF 1,20	ЗУ	China 1	044	2026-05-09 20:56:14.842943	12.9418
12709	QF 1,22	ЗУ	China 3	046	2026-05-09 20:56:14.842943	13.7714
12711	QF 2,21	ЗУ	China 5	048	2026-05-09 20:56:14.842943	21.0213
12713	QF 2,23	ЗУ	China 7	050	2026-05-09 20:56:14.842943	9.8713
12715	Q4	ЗУ	BG 1	062	2026-05-09 20:56:19.060485	21.2621
12717	Q10	ЗУ	SM 2	064	2026-05-09 20:56:19.148783	19.3679
12719	Q12	ЗУ	SM 4	066	2026-05-09 20:56:19.148783	1.9383
12721	Q14	ЗУ	SM 6	068	2026-05-09 20:56:19.148783	0.9141
12723	Q16	ЗУ	SM 8	070	2026-05-09 20:56:19.148783	3.1984
12725	Q17	ЗУ	MO 9	071	2026-05-09 20:56:34.809107	0.7039
12727	Q21	ЗУ	MO 11	073	2026-05-09 20:56:34.809107	1.0881
12729	Q23	ЗУ	MO 13	075	2026-05-09 20:56:34.809107	1.3353
12731	Q25	ЗУ	MO 15	077	2026-05-09 20:56:34.809107	0.674
12733	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:56:39.615253	21.6799
12735	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:56:39.615253	17.7976
12737	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:56:39.615253	19.8966
12739	QF 1,20	ЗУ	China 1	044	2026-05-09 20:56:54.906599	11.6449
12741	QF 1,22	ЗУ	China 3	046	2026-05-09 20:56:54.906599	14.147
12743	QF 2,21	ЗУ	China 5	048	2026-05-09 20:56:54.906599	21.1957
12745	QF 2,23	ЗУ	China 7	050	2026-05-09 20:56:54.906599	10.1066
12747	TP3	ЗУ	CP-300 New	078	2026-05-09 20:57:04.070887	8.3495
12749	Q9	ЗУ	BG 2	063	2026-05-09 20:57:04.075325	33.169
12751	Q11	ЗУ	SM 3	065	2026-05-09 20:57:04.185323	22.5513
12753	Q13	ЗУ	SM 5	067	2026-05-09 20:57:04.185323	1.073
12755	Q15	ЗУ	SM 7	069	2026-05-09 20:57:04.185323	1.7952
12757	Q8	ЗУ	DIG	061	2026-05-09 20:57:14.05474	46.5452
12759	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:57:14.648728	10.0698
12761	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:57:14.648728	8.0067
12763	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:57:14.648728	19.2544
12765	Q20	ЗУ	MO 10	072	2026-05-09 20:57:24.85496	14.1015
12767	Q22	ЗУ	MO 12	074	2026-05-09 20:57:24.85496	1.4522
12769	Q24	ЗУ	MO 14	076	2026-05-09 20:57:24.85496	1.1231
12771	TP3	ЗУ	CP-300 New	078	2026-05-09 20:57:34.101283	8.1222
12773	QF 1,21	ЗУ	China 2	045	2026-05-09 20:57:34.958636	10.9882
12775	QF 2,20	ЗУ	China 4	047	2026-05-09 20:57:34.958636	19.1245
12777	QF 2,22	ЗУ	China 6	049	2026-05-09 20:57:34.958636	20.292
12779	QF 2,19	ЗУ	China 8	051	2026-05-09 20:57:34.958636	15.1108
12781	Q4	ЗУ	BG 1	062	2026-05-09 20:57:49.104259	21.1459
12783	Q10	ЗУ	SM 2	064	2026-05-09 20:57:49.22776	19.3564
12785	Q12	ЗУ	SM 4	066	2026-05-09 20:57:49.22776	1.8436
12787	Q14	ЗУ	SM 6	068	2026-05-09 20:57:49.22776	1.7816
12789	Q16	ЗУ	SM 8	070	2026-05-09 20:57:49.22776	2.4005
12791	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:57:49.693897	10.2666
12793	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:57:49.693897	8.1822
12795	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:57:49.693897	19.7185
15746	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:02:04.332226	9.1547
15748	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:02:04.332226	8.3531
15750	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:02:04.332226	19.8774
15752	QF 1,20	ЗУ	China 1	044	2026-05-10 01:02:20.381286	11.9236
15754	QF 1,22	ЗУ	China 3	046	2026-05-10 01:02:20.381286	13.9384
15756	QF 2,21	ЗУ	China 5	048	2026-05-10 01:02:20.381286	20.8685
15758	QF 2,23	ЗУ	China 7	050	2026-05-10 01:02:20.381286	9.4884
15760	Q4	ЗУ	BG 1	062	2026-05-10 01:02:22.197327	21.4561
15762	Q10	ЗУ	SM 2	064	2026-05-10 01:02:22.506339	18.7063
15764	Q12	ЗУ	SM 4	066	2026-05-10 01:02:22.506339	1.3459
15766	Q14	ЗУ	SM 6	068	2026-05-10 01:02:22.506339	1.2741
15768	Q16	ЗУ	SM 8	070	2026-05-10 01:02:22.506339	2.3119
15769	Q17	ЗУ	MO 9	071	2026-05-10 01:02:28.385401	0.604
15771	Q21	ЗУ	MO 11	073	2026-05-10 01:02:28.385401	1.0132
15773	Q23	ЗУ	MO 13	075	2026-05-10 01:02:28.385401	0.5506
15775	Q25	ЗУ	MO 15	077	2026-05-10 01:02:28.385401	1.3094
15777	TP3	ЗУ	CP-300 New	078	2026-05-10 01:02:37.505748	6.6904
15779	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:02:39.445353	9.7997
15781	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:02:39.445353	8.4583
15783	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:02:39.445353	18.582
15784	QF 1,20	ЗУ	China 1	044	2026-05-10 01:03:00.423025	12.025
15786	QF 1,22	ЗУ	China 3	046	2026-05-10 01:03:00.423025	13.2711
15788	QF 2,21	ЗУ	China 5	048	2026-05-10 01:03:00.423025	21.0038
15790	QF 2,23	ЗУ	China 7	050	2026-05-10 01:03:00.423025	10.0228
15793	Q9	ЗУ	BG 2	063	2026-05-10 01:03:07.218127	32.2692
15795	Q10	ЗУ	SM 2	064	2026-05-10 01:03:07.544216	18.8606
15797	Q12	ЗУ	SM 4	066	2026-05-10 01:03:07.544216	0.9554
15799	Q14	ЗУ	SM 6	068	2026-05-10 01:03:07.544216	0.9424
15801	Q16	ЗУ	SM 8	070	2026-05-10 01:03:07.544216	2.7862
12652	Q20	ЗУ	MO 10	072	2026-05-09 20:54:54.740222	14.0467
12654	Q22	ЗУ	MO 12	074	2026-05-09 20:54:54.740222	1.1653
12656	Q24	ЗУ	MO 14	076	2026-05-09 20:54:54.740222	1.4511
12658	QF 1,20	ЗУ	China 1	044	2026-05-09 20:54:54.782715	11.9616
12660	QF 1,22	ЗУ	China 3	046	2026-05-09 20:54:54.782715	14.8909
12662	QF 2,21	ЗУ	China 5	048	2026-05-09 20:54:54.782715	21.8334
12664	QF 2,23	ЗУ	China 7	050	2026-05-09 20:54:54.782715	10.0804
12666	TP3	ЗУ	CP-300 New	078	2026-05-09 20:55:03.996852	6.8098
12668	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:55:29.532551	21.486
12670	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:55:29.532551	18.1537
12672	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:55:29.532551	20.7241
12674	TP3	ЗУ	CP-300 New	078	2026-05-09 20:55:34.009494	8.4543
12676	Q9	ЗУ	BG 2	063	2026-05-09 20:55:34.048083	32.6555
12678	Q11	ЗУ	SM 3	065	2026-05-09 20:55:34.117302	21.9617
12680	Q13	ЗУ	SM 5	067	2026-05-09 20:55:34.117302	1.9054
12682	Q15	ЗУ	SM 7	069	2026-05-09 20:55:34.117302	1.6791
12684	QF 1,20	ЗУ	China 1	044	2026-05-09 20:55:34.805495	12.7668
12686	QF 1,22	ЗУ	China 3	046	2026-05-09 20:55:34.805495	14.8095
12688	QF 2,21	ЗУ	China 5	048	2026-05-09 20:55:34.805495	20.9314
12690	QF 2,23	ЗУ	China 7	050	2026-05-09 20:55:34.805495	9.922
12692	Q17	ЗУ	MO 9	071	2026-05-09 20:55:44.773133	1.3175
12694	Q21	ЗУ	MO 11	073	2026-05-09 20:55:44.773133	1.1803
12696	Q23	ЗУ	MO 13	075	2026-05-09 20:55:44.773133	1.5712
12698	Q25	ЗУ	MO 15	077	2026-05-09 20:55:44.773133	0.8879
12700	TP3	ЗУ	CP-300 New	078	2026-05-09 20:56:04.021174	7.6339
12702	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:56:04.567435	9.728
12704	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:56:04.567435	8.591
12706	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:56:04.567435	20.0245
12708	QF 1,21	ЗУ	China 2	045	2026-05-09 20:56:14.842943	10.3674
12710	QF 2,20	ЗУ	China 4	047	2026-05-09 20:56:14.842943	18.9973
12712	QF 2,22	ЗУ	China 6	049	2026-05-09 20:56:14.842943	20.0332
12714	QF 2,19	ЗУ	China 8	051	2026-05-09 20:56:14.842943	14.5137
12716	Q9	ЗУ	BG 2	063	2026-05-09 20:56:19.060485	32.8004
12718	Q11	ЗУ	SM 3	065	2026-05-09 20:56:19.148783	21.8982
12720	Q13	ЗУ	SM 5	067	2026-05-09 20:56:19.148783	1.2973
12722	Q15	ЗУ	SM 7	069	2026-05-09 20:56:19.148783	1.5726
12724	TP3	ЗУ	CP-300 New	078	2026-05-09 20:56:34.037852	7.3231
12726	Q20	ЗУ	MO 10	072	2026-05-09 20:56:34.809107	14.0589
12728	Q22	ЗУ	MO 12	074	2026-05-09 20:56:34.809107	0.8635
12730	Q24	ЗУ	MO 14	076	2026-05-09 20:56:34.809107	1.2854
12732	Q8	ЗУ	DIG	061	2026-05-09 20:56:39.0105	47.2137
12734	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:56:39.615253	10.3358
12736	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:56:39.615253	8.3576
12738	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:56:39.615253	19.9026
12740	QF 1,21	ЗУ	China 2	045	2026-05-09 20:56:54.906599	11.4991
12742	QF 2,20	ЗУ	China 4	047	2026-05-09 20:56:54.906599	19.9065
12744	QF 2,22	ЗУ	China 6	049	2026-05-09 20:56:54.906599	19.8445
12746	QF 2,19	ЗУ	China 8	051	2026-05-09 20:56:54.906599	14.55
12748	Q4	ЗУ	BG 1	062	2026-05-09 20:57:04.075325	20.9187
12750	Q10	ЗУ	SM 2	064	2026-05-09 20:57:04.185323	19.2826
12752	Q12	ЗУ	SM 4	066	2026-05-09 20:57:04.185323	1.0149
12754	Q14	ЗУ	SM 6	068	2026-05-09 20:57:04.185323	1.7906
12756	Q16	ЗУ	SM 8	070	2026-05-09 20:57:04.185323	3.38
12758	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:57:14.648728	22.2887
12760	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:57:14.648728	17.8467
12762	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:57:14.648728	19.7836
12764	Q17	ЗУ	MO 9	071	2026-05-09 20:57:24.85496	1.5974
12766	Q21	ЗУ	MO 11	073	2026-05-09 20:57:24.85496	1.0901
12768	Q23	ЗУ	MO 13	075	2026-05-09 20:57:24.85496	0.9483
12770	Q25	ЗУ	MO 15	077	2026-05-09 20:57:24.85496	1.2667
12772	QF 1,20	ЗУ	China 1	044	2026-05-09 20:57:34.958636	12.5384
12774	QF 1,22	ЗУ	China 3	046	2026-05-09 20:57:34.958636	14.2744
12776	QF 2,21	ЗУ	China 5	048	2026-05-09 20:57:34.958636	21.9311
12778	QF 2,23	ЗУ	China 7	050	2026-05-09 20:57:34.958636	9.9349
12780	Q8	ЗУ	DIG	061	2026-05-09 20:57:49.092299	46.5212
12782	Q9	ЗУ	BG 2	063	2026-05-09 20:57:49.104259	33.877
12784	Q11	ЗУ	SM 3	065	2026-05-09 20:57:49.22776	21.5028
12786	Q13	ЗУ	SM 5	067	2026-05-09 20:57:49.22776	1.2391
12788	Q15	ЗУ	SM 7	069	2026-05-09 20:57:49.22776	1.2856
12790	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:57:49.693897	21.3591
12792	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:57:49.693897	16.9484
12794	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:57:49.693897	21.0879
12796	TP3	ЗУ	CP-300 New	078	2026-05-09 20:58:04.118001	7.3905
12797	Q17	ЗУ	MO 9	071	2026-05-09 20:58:14.910417	1.504
12798	Q20	ЗУ	MO 10	072	2026-05-09 20:58:14.910417	13.4261
12799	Q21	ЗУ	MO 11	073	2026-05-09 20:58:14.910417	0.8541
12800	Q22	ЗУ	MO 12	074	2026-05-09 20:58:14.910417	0.6916
12801	Q23	ЗУ	MO 13	075	2026-05-09 20:58:14.910417	1.479
12802	Q24	ЗУ	MO 14	076	2026-05-09 20:58:14.910417	0.98
12803	Q25	ЗУ	MO 15	077	2026-05-09 20:58:14.910417	0.85
12804	QF 1,20	ЗУ	China 1	044	2026-05-09 20:58:14.997582	11.6583
12805	QF 1,21	ЗУ	China 2	045	2026-05-09 20:58:14.997582	10.4506
12806	QF 1,22	ЗУ	China 3	046	2026-05-09 20:58:14.997582	13.9329
12807	QF 2,20	ЗУ	China 4	047	2026-05-09 20:58:14.997582	19.2206
12808	QF 2,21	ЗУ	China 5	048	2026-05-09 20:58:14.997582	21.5303
12809	QF 2,22	ЗУ	China 6	049	2026-05-09 20:58:14.997582	19.5842
12810	QF 2,23	ЗУ	China 7	050	2026-05-09 20:58:14.997582	9.8942
12811	QF 2,19	ЗУ	China 8	051	2026-05-09 20:58:14.997582	15.1753
12812	Q8	ЗУ	DIG	061	2026-05-09 20:58:24.127995	48.1495
12813	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:58:24.730273	21.5881
12814	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:58:24.730273	9.3235
12815	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:58:24.730273	18.2274
12816	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:58:24.730273	8.4102
12817	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:58:24.730273	21.2047
12818	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:58:24.730273	18.7942
12819	TP3	ЗУ	CP-300 New	078	2026-05-09 20:58:34.132601	8.0928
12820	Q4	ЗУ	BG 1	062	2026-05-09 20:58:34.133305	21.7457
12821	Q9	ЗУ	BG 2	063	2026-05-09 20:58:34.133305	33.4815
12822	Q10	ЗУ	SM 2	064	2026-05-09 20:58:34.263394	19.2062
12823	Q11	ЗУ	SM 3	065	2026-05-09 20:58:34.263394	21.9721
12824	Q12	ЗУ	SM 4	066	2026-05-09 20:58:34.263394	0.8972
12825	Q13	ЗУ	SM 5	067	2026-05-09 20:58:34.263394	1.5326
12826	Q14	ЗУ	SM 6	068	2026-05-09 20:58:34.263394	2.029
12828	Q16	ЗУ	SM 8	070	2026-05-09 20:58:34.263394	2.9063
12830	QF 1,21	ЗУ	China 2	045	2026-05-09 20:58:55.032315	10.8179
12832	QF 2,20	ЗУ	China 4	047	2026-05-09 20:58:55.032315	18.5832
12834	QF 2,22	ЗУ	China 6	049	2026-05-09 20:58:55.032315	20.8029
12836	QF 2,19	ЗУ	China 8	051	2026-05-09 20:58:55.032315	15.407
12838	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:58:59.765124	20.8472
12840	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:58:59.765124	17.5679
12842	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:58:59.765124	20.6314
12844	TP3	ЗУ	CP-300 New	078	2026-05-09 20:59:04.141149	6.9973
12846	Q20	ЗУ	MO 10	072	2026-05-09 20:59:04.947165	13.4334
12848	Q22	ЗУ	MO 12	074	2026-05-09 20:59:04.947165	1.2053
12850	Q24	ЗУ	MO 14	076	2026-05-09 20:59:04.947165	1.3904
12852	Q4	ЗУ	BG 1	062	2026-05-09 20:59:19.144847	21.9153
12854	Q10	ЗУ	SM 2	064	2026-05-09 20:59:19.292359	19.4617
12856	Q12	ЗУ	SM 4	066	2026-05-09 20:59:19.292359	1.075
12858	Q14	ЗУ	SM 6	068	2026-05-09 20:59:19.292359	0.8898
12860	Q16	ЗУ	SM 8	070	2026-05-09 20:59:19.292359	3.3234
12862	Q8	ЗУ	DIG	061	2026-05-09 20:59:34.155242	46.2258
12864	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:59:34.795828	9.6908
12866	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:59:34.795828	9.2307
12868	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:59:34.795828	18.7996
12870	QF 1,21	ЗУ	China 2	045	2026-05-09 20:59:35.069232	11.6401
12872	QF 2,20	ЗУ	China 4	047	2026-05-09 20:59:35.069232	18.8785
12874	QF 2,22	ЗУ	China 6	049	2026-05-09 20:59:35.069232	20.4598
12876	QF 2,19	ЗУ	China 8	051	2026-05-09 20:59:35.069232	15.1213
12878	Q20	ЗУ	MO 10	072	2026-05-09 20:59:54.991673	13.1547
12880	Q22	ЗУ	MO 12	074	2026-05-09 20:59:54.991673	0.6462
12882	Q24	ЗУ	MO 14	076	2026-05-09 20:59:54.991673	0.8153
12884	TP3	ЗУ	CP-300 New	078	2026-05-09 21:00:04.172786	6.9281
12886	Q9	ЗУ	BG 2	063	2026-05-09 21:00:04.188962	33.1733
12888	Q11	ЗУ	SM 3	065	2026-05-09 21:00:04.334019	21.3839
12890	Q13	ЗУ	SM 5	067	2026-05-09 21:00:04.334019	1.094
12892	Q15	ЗУ	SM 7	069	2026-05-09 21:00:04.334019	1.4845
12894	Q8	ЗУ	DIG	061	2026-05-09 21:00:09.186154	48.0638
12896	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:00:09.821327	8.8053
12898	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:00:09.821327	8.8267
12900	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:00:09.821327	18.9054
12902	QF 1,21	ЗУ	China 2	045	2026-05-09 21:00:15.111952	11.3619
12904	QF 2,20	ЗУ	China 4	047	2026-05-09 21:00:15.111952	19.5525
12906	QF 2,22	ЗУ	China 6	049	2026-05-09 21:00:15.111952	19.7763
12908	QF 2,19	ЗУ	China 8	051	2026-05-09 21:00:15.111952	14.9955
12910	Q8	ЗУ	DIG	061	2026-05-09 21:00:44.197001	46.2151
12912	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:00:44.855241	9.4289
12914	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:00:44.855241	8.5088
12916	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:00:44.855241	20.2032
12918	Q20	ЗУ	MO 10	072	2026-05-09 21:00:45.016409	13.8541
12920	Q22	ЗУ	MO 12	074	2026-05-09 21:00:45.016409	0.6192
12922	Q24	ЗУ	MO 14	076	2026-05-09 21:00:45.016409	1.391
12924	Q4	ЗУ	BG 1	062	2026-05-09 21:00:49.205927	21.4272
12926	Q10	ЗУ	SM 2	064	2026-05-09 21:00:49.371117	18.4395
12928	Q12	ЗУ	SM 4	066	2026-05-09 21:00:49.371117	1.4383
12930	Q14	ЗУ	SM 6	068	2026-05-09 21:00:49.371117	1.9355
12932	Q16	ЗУ	SM 8	070	2026-05-09 21:00:49.371117	3.458
12934	QF 1,21	ЗУ	China 2	045	2026-05-09 21:00:55.13096	10.9912
12936	QF 2,20	ЗУ	China 4	047	2026-05-09 21:00:55.13096	19.0555
12938	QF 2,22	ЗУ	China 6	049	2026-05-09 21:00:55.13096	19.442
12940	QF 2,19	ЗУ	China 8	051	2026-05-09 21:00:55.13096	14.4574
12942	Q8	ЗУ	DIG	061	2026-05-09 21:01:19.225898	47.0116
12944	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:01:19.951293	9.8676
12946	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:01:19.951293	8.3907
12948	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:01:19.951293	20.229
12950	Q4	ЗУ	BG 1	062	2026-05-09 21:01:34.369526	20.8568
12952	Q10	ЗУ	SM 2	064	2026-05-09 21:01:34.426585	18.8454
12954	Q12	ЗУ	SM 4	066	2026-05-09 21:01:34.426585	1.2306
12956	Q14	ЗУ	SM 6	068	2026-05-09 21:01:34.426585	1.6305
12958	Q16	ЗУ	SM 8	070	2026-05-09 21:01:34.426585	3.1102
12960	Q20	ЗУ	MO 10	072	2026-05-09 21:01:35.064287	13.7836
12962	Q22	ЗУ	MO 12	074	2026-05-09 21:01:35.064287	1.2352
12964	Q24	ЗУ	MO 14	076	2026-05-09 21:01:35.064287	1.4925
12966	QF 1,20	ЗУ	China 1	044	2026-05-09 21:01:35.184627	12.7962
12968	QF 1,22	ЗУ	China 3	046	2026-05-09 21:01:35.184627	13.6955
12970	QF 2,21	ЗУ	China 5	048	2026-05-09 21:01:35.184627	20.576
12972	QF 2,23	ЗУ	China 7	050	2026-05-09 21:01:35.184627	10.6327
15791	QF 2,19	ЗУ	China 8	051	2026-05-10 01:03:00.423025	14.5693
15792	Q4	ЗУ	BG 1	062	2026-05-10 01:03:07.218127	21.0076
15794	TP3	ЗУ	CP-300 New	078	2026-05-10 01:03:07.519828	5.9091
15796	Q11	ЗУ	SM 3	065	2026-05-10 01:03:07.544216	21.2083
15798	Q13	ЗУ	SM 5	067	2026-05-10 01:03:07.544216	0.5785
15800	Q15	ЗУ	SM 7	069	2026-05-10 01:03:07.544216	1.1782
15802	Q8	ЗУ	DIG	061	2026-05-10 01:03:12.438425	45.6995
15804	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:03:14.481891	9.6068
15806	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:03:14.481891	8.3732
15808	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:03:14.481891	18.171
15810	Q20	ЗУ	MO 10	072	2026-05-10 01:03:18.428452	12.9025
15812	Q22	ЗУ	MO 12	074	2026-05-10 01:03:18.428452	1.2994
15814	Q24	ЗУ	MO 14	076	2026-05-10 01:03:18.428452	1.2015
15817	QF 1,20	ЗУ	China 1	044	2026-05-10 01:03:40.463264	11.044
15819	QF 1,22	ЗУ	China 3	046	2026-05-10 01:03:40.463264	13.1676
15821	QF 2,21	ЗУ	China 5	048	2026-05-10 01:03:40.463264	20.4818
15823	QF 2,23	ЗУ	China 7	050	2026-05-10 01:03:40.463264	9.0856
15826	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:03:49.516769	21.0561
15828	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:03:49.516769	16.133
15830	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:03:49.516769	20.4836
15832	Q4	ЗУ	BG 1	062	2026-05-10 01:03:52.235236	20.942
15834	Q10	ЗУ	SM 2	064	2026-05-10 01:03:52.572558	18.7756
15836	Q12	ЗУ	SM 4	066	2026-05-10 01:03:52.572558	0.759
15838	Q14	ЗУ	SM 6	068	2026-05-10 01:03:52.572558	1.0705
15840	Q16	ЗУ	SM 8	070	2026-05-10 01:03:52.572558	2.6396
15841	TP3	ЗУ	CP-300 New	078	2026-05-10 01:04:07.544186	7.1189
15843	Q20	ЗУ	MO 10	072	2026-05-10 01:04:08.463241	13.2936
15845	Q22	ЗУ	MO 12	074	2026-05-10 01:04:08.463241	0.632
15847	Q24	ЗУ	MO 14	076	2026-05-10 01:04:08.463241	0.5604
12827	Q15	ЗУ	SM 7	069	2026-05-09 20:58:34.263394	1.3333
12829	QF 1,20	ЗУ	China 1	044	2026-05-09 20:58:55.032315	11.469
12831	QF 1,22	ЗУ	China 3	046	2026-05-09 20:58:55.032315	13.8803
12833	QF 2,21	ЗУ	China 5	048	2026-05-09 20:58:55.032315	21.2248
12835	QF 2,23	ЗУ	China 7	050	2026-05-09 20:58:55.032315	9.5857
12837	Q8	ЗУ	DIG	061	2026-05-09 20:58:59.140227	48.1031
12839	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 20:58:59.765124	9.6422
12841	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 20:58:59.765124	8.8794
12843	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 20:58:59.765124	19.463
12845	Q17	ЗУ	MO 9	071	2026-05-09 20:59:04.947165	1.0948
12847	Q21	ЗУ	MO 11	073	2026-05-09 20:59:04.947165	0.82
12849	Q23	ЗУ	MO 13	075	2026-05-09 20:59:04.947165	0.7525
12851	Q25	ЗУ	MO 15	077	2026-05-09 20:59:04.947165	0.8748
12853	Q9	ЗУ	BG 2	063	2026-05-09 20:59:19.144847	33.7861
12855	Q11	ЗУ	SM 3	065	2026-05-09 20:59:19.292359	22.3627
12857	Q13	ЗУ	SM 5	067	2026-05-09 20:59:19.292359	1.1936
12859	Q15	ЗУ	SM 7	069	2026-05-09 20:59:19.292359	1.2327
12861	TP3	ЗУ	CP-300 New	078	2026-05-09 20:59:34.158827	7.9394
12863	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 20:59:34.795828	21.8668
12865	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 20:59:34.795828	18.0367
12867	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 20:59:34.795828	21.0139
12869	QF 1,20	ЗУ	China 1	044	2026-05-09 20:59:35.069232	12.0058
12871	QF 1,22	ЗУ	China 3	046	2026-05-09 20:59:35.069232	13.3339
12873	QF 2,21	ЗУ	China 5	048	2026-05-09 20:59:35.069232	21.4158
12875	QF 2,23	ЗУ	China 7	050	2026-05-09 20:59:35.069232	10.5124
12877	Q17	ЗУ	MO 9	071	2026-05-09 20:59:54.991673	0.7262
12879	Q21	ЗУ	MO 11	073	2026-05-09 20:59:54.991673	1.4421
12881	Q23	ЗУ	MO 13	075	2026-05-09 20:59:54.991673	0.8271
12883	Q25	ЗУ	MO 15	077	2026-05-09 20:59:54.991673	0.8472
12885	Q4	ЗУ	BG 1	062	2026-05-09 21:00:04.188962	21.6606
12887	Q10	ЗУ	SM 2	064	2026-05-09 21:00:04.334019	18.9763
12889	Q12	ЗУ	SM 4	066	2026-05-09 21:00:04.334019	1.1996
12891	Q14	ЗУ	SM 6	068	2026-05-09 21:00:04.334019	1.258
12893	Q16	ЗУ	SM 8	070	2026-05-09 21:00:04.334019	2.6903
12895	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:00:09.821327	21.7039
12897	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:00:09.821327	17.5538
12899	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:00:09.821327	20.7593
12901	QF 1,20	ЗУ	China 1	044	2026-05-09 21:00:15.111952	11.7188
12903	QF 1,22	ЗУ	China 3	046	2026-05-09 21:00:15.111952	13.8296
12905	QF 2,21	ЗУ	China 5	048	2026-05-09 21:00:15.111952	21.8252
12907	QF 2,23	ЗУ	China 7	050	2026-05-09 21:00:15.111952	9.6913
12909	TP3	ЗУ	CP-300 New	078	2026-05-09 21:00:34.201996	7.8269
12911	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:00:44.855241	21.9257
12913	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:00:44.855241	18.3562
12915	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:00:44.855241	19.9002
12917	Q17	ЗУ	MO 9	071	2026-05-09 21:00:45.016409	1.5845
12919	Q21	ЗУ	MO 11	073	2026-05-09 21:00:45.016409	0.7051
12921	Q23	ЗУ	MO 13	075	2026-05-09 21:00:45.016409	1.0858
12923	Q25	ЗУ	MO 15	077	2026-05-09 21:00:45.016409	0.7294
12925	Q9	ЗУ	BG 2	063	2026-05-09 21:00:49.205927	33.5815
12927	Q11	ЗУ	SM 3	065	2026-05-09 21:00:49.371117	22.1506
12929	Q13	ЗУ	SM 5	067	2026-05-09 21:00:49.371117	1.63
12931	Q15	ЗУ	SM 7	069	2026-05-09 21:00:49.371117	1.9301
12933	QF 1,20	ЗУ	China 1	044	2026-05-09 21:00:55.13096	11.8504
12935	QF 1,22	ЗУ	China 3	046	2026-05-09 21:00:55.13096	13.8139
12937	QF 2,21	ЗУ	China 5	048	2026-05-09 21:00:55.13096	20.3627
12939	QF 2,23	ЗУ	China 7	050	2026-05-09 21:00:55.13096	9.3529
12941	TP3	ЗУ	CP-300 New	078	2026-05-09 21:01:04.285324	7.3597
12943	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:01:19.951293	21.9714
12945	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:01:19.951293	16.6422
12947	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:01:19.951293	20.4666
12949	TP3	ЗУ	CP-300 New	078	2026-05-09 21:01:34.355318	6.7445
12951	Q9	ЗУ	BG 2	063	2026-05-09 21:01:34.369526	33.7081
12953	Q11	ЗУ	SM 3	065	2026-05-09 21:01:34.426585	21.5943
12955	Q13	ЗУ	SM 5	067	2026-05-09 21:01:34.426585	1.8977
12957	Q15	ЗУ	SM 7	069	2026-05-09 21:01:34.426585	1.1348
12959	Q17	ЗУ	MO 9	071	2026-05-09 21:01:35.064287	1.4281
12961	Q21	ЗУ	MO 11	073	2026-05-09 21:01:35.064287	1.0277
12963	Q23	ЗУ	MO 13	075	2026-05-09 21:01:35.064287	0.7493
12965	Q25	ЗУ	MO 15	077	2026-05-09 21:01:35.064287	1.5726
12967	QF 1,21	ЗУ	China 2	045	2026-05-09 21:01:35.184627	11.535
12969	QF 2,20	ЗУ	China 4	047	2026-05-09 21:01:35.184627	19.214
12971	QF 2,22	ЗУ	China 6	049	2026-05-09 21:01:35.184627	19.5711
12973	QF 2,19	ЗУ	China 8	051	2026-05-09 21:01:35.184627	14.4659
15803	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:03:14.481891	21.4576
15805	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:03:14.481891	17.3812
15807	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:03:14.481891	19.7298
15809	Q17	ЗУ	MO 9	071	2026-05-10 01:03:18.428452	0.8286
15811	Q21	ЗУ	MO 11	073	2026-05-10 01:03:18.428452	0.8813
15813	Q23	ЗУ	MO 13	075	2026-05-10 01:03:18.428452	1.2475
15815	Q25	ЗУ	MO 15	077	2026-05-10 01:03:18.428452	1.1402
15816	TP3	ЗУ	CP-300 New	078	2026-05-10 01:03:37.532535	6.7626
15818	QF 1,21	ЗУ	China 2	045	2026-05-10 01:03:40.463264	11.488
15820	QF 2,20	ЗУ	China 4	047	2026-05-10 01:03:40.463264	19.2357
15822	QF 2,22	ЗУ	China 6	049	2026-05-10 01:03:40.463264	19.2595
15824	QF 2,19	ЗУ	China 8	051	2026-05-10 01:03:40.463264	15.1233
15825	Q8	ЗУ	DIG	061	2026-05-10 01:03:47.451295	46.4305
15827	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:03:49.516769	9.3034
15829	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:03:49.516769	7.9311
15831	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:03:49.516769	18.7115
15833	Q9	ЗУ	BG 2	063	2026-05-10 01:03:52.235236	32.2584
15835	Q11	ЗУ	SM 3	065	2026-05-10 01:03:52.572558	22.1591
15837	Q13	ЗУ	SM 5	067	2026-05-10 01:03:52.572558	0.6445
15839	Q15	ЗУ	SM 7	069	2026-05-10 01:03:52.572558	0.9352
15842	Q17	ЗУ	MO 9	071	2026-05-10 01:04:08.463241	1.2873
15844	Q21	ЗУ	MO 11	073	2026-05-10 01:04:08.463241	0.601
15846	Q23	ЗУ	MO 13	075	2026-05-10 01:04:08.463241	0.4354
15848	Q25	ЗУ	MO 15	077	2026-05-10 01:04:08.463241	0.9122
15850	QF 1,21	ЗУ	China 2	045	2026-05-10 01:04:20.506044	10.4513
15852	QF 2,20	ЗУ	China 4	047	2026-05-10 01:04:20.506044	19.1563
15854	QF 2,22	ЗУ	China 6	049	2026-05-10 01:04:20.506044	19.9861
15856	QF 2,19	ЗУ	China 8	051	2026-05-10 01:04:20.506044	15.1349
12975	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:01:55.046469	21.2749
12976	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:01:55.046469	9.3807
12977	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:01:55.046469	17.2615
12978	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:01:55.046469	9.1725
12979	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:01:55.046469	20.3416
12980	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:01:55.046469	19.9554
12981	TP3	ЗУ	CP-300 New	078	2026-05-09 21:02:04.395395	6.8254
12982	QF 1,20	ЗУ	China 1	044	2026-05-09 21:02:15.218808	11.868
12983	QF 1,21	ЗУ	China 2	045	2026-05-09 21:02:15.218808	10.8182
12984	QF 1,22	ЗУ	China 3	046	2026-05-09 21:02:15.218808	14.3627
12985	QF 2,20	ЗУ	China 4	047	2026-05-09 21:02:15.218808	19.3305
12986	QF 2,21	ЗУ	China 5	048	2026-05-09 21:02:15.218808	21.0265
12987	QF 2,22	ЗУ	China 6	049	2026-05-09 21:02:15.218808	19.9383
12988	QF 2,23	ЗУ	China 7	050	2026-05-09 21:02:15.218808	10.1026
12989	QF 2,19	ЗУ	China 8	051	2026-05-09 21:02:15.218808	14.7825
12990	Q4	ЗУ	BG 1	062	2026-05-09 21:02:19.392784	21.9221
12991	Q9	ЗУ	BG 2	063	2026-05-09 21:02:19.392784	32.642
12992	Q10	ЗУ	SM 2	064	2026-05-09 21:02:19.452554	19.2922
12993	Q11	ЗУ	SM 3	065	2026-05-09 21:02:19.452554	21.5161
12994	Q12	ЗУ	SM 4	066	2026-05-09 21:02:19.452554	1.1652
12995	Q13	ЗУ	SM 5	067	2026-05-09 21:02:19.452554	1.1688
12996	Q14	ЗУ	SM 6	068	2026-05-09 21:02:19.452554	0.9128
12997	Q15	ЗУ	SM 7	069	2026-05-09 21:02:19.452554	1.3082
12998	Q16	ЗУ	SM 8	070	2026-05-09 21:02:19.452554	3.17
15849	QF 1,20	ЗУ	China 1	044	2026-05-10 01:04:20.506044	11.9357
15851	QF 1,22	ЗУ	China 3	046	2026-05-10 01:04:20.506044	13.3985
15853	QF 2,21	ЗУ	China 5	048	2026-05-10 01:04:20.506044	21.4667
15855	QF 2,23	ЗУ	China 7	050	2026-05-10 01:04:20.506044	10.2185
15857	Q8	ЗУ	DIG	061	2026-05-10 01:04:22.477819	45.5596
15858	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:04:24.56091	20.2416
15860	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:04:24.56091	16.1779
15862	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:04:24.56091	20.6201
15864	Q4	ЗУ	BG 1	062	2026-05-10 01:04:37.257278	20.658
15866	TP3	ЗУ	CP-300 New	078	2026-05-10 01:04:37.56675	6.2605
15868	Q11	ЗУ	SM 3	065	2026-05-10 01:04:37.595227	21.4073
15870	Q13	ЗУ	SM 5	067	2026-05-10 01:04:37.595227	1.0445
15872	Q15	ЗУ	SM 7	069	2026-05-10 01:04:37.595227	0.5703
15875	Q17	ЗУ	MO 9	071	2026-05-10 01:04:58.507963	0.8842
15877	Q21	ЗУ	MO 11	073	2026-05-10 01:04:58.507963	0.6192
15879	Q23	ЗУ	MO 13	075	2026-05-10 01:04:58.507963	1.3115
15881	Q25	ЗУ	MO 15	077	2026-05-10 01:04:58.507963	1.3006
15883	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:04:59.603844	9.5893
15885	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:04:59.603844	8.091
15887	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:04:59.603844	18.3199
15889	QF 1,21	ЗУ	China 2	045	2026-05-10 01:05:00.572013	11.0073
15891	QF 2,20	ЗУ	China 4	047	2026-05-10 01:05:00.572013	19.1086
15893	QF 2,22	ЗУ	China 6	049	2026-05-10 01:05:00.572013	19.1212
15895	QF 2,19	ЗУ	China 8	051	2026-05-10 01:05:00.572013	15.0817
15896	TP3	ЗУ	CP-300 New	078	2026-05-10 01:05:07.589071	6.2939
15898	Q9	ЗУ	BG 2	063	2026-05-10 01:05:22.324744	33.0563
15900	Q11	ЗУ	SM 3	065	2026-05-10 01:05:22.641985	21.441
15902	Q13	ЗУ	SM 5	067	2026-05-10 01:05:22.641985	1.6011
15904	Q15	ЗУ	SM 7	069	2026-05-10 01:05:22.641985	1.3335
15907	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:05:34.64882	21.7331
15909	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:05:34.64882	17.1223
15911	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:05:34.64882	19.4225
15913	TP3	ЗУ	CP-300 New	078	2026-05-10 01:05:37.61325	7.0355
15915	QF 1,21	ЗУ	China 2	045	2026-05-10 01:05:40.615484	10.0287
15917	QF 2,20	ЗУ	China 4	047	2026-05-10 01:05:40.615484	18.0469
15919	QF 2,22	ЗУ	China 6	049	2026-05-10 01:05:40.615484	19.2601
15921	QF 2,19	ЗУ	China 8	051	2026-05-10 01:05:40.615484	14.3959
15922	Q17	ЗУ	MO 9	071	2026-05-10 01:05:48.547626	0.9941
15924	Q21	ЗУ	MO 11	073	2026-05-10 01:05:48.547626	0.7885
15926	Q23	ЗУ	MO 13	075	2026-05-10 01:05:48.547626	0.6211
15928	Q25	ЗУ	MO 15	077	2026-05-10 01:05:48.547626	0.3956
15929	Q4	ЗУ	BG 1	062	2026-05-10 01:06:07.381869	20.3042
15931	TP3	ЗУ	CP-300 New	078	2026-05-10 01:06:07.62881	7.4941
15933	Q10	ЗУ	SM 2	064	2026-05-10 01:06:07.692977	18.6503
15935	Q12	ЗУ	SM 4	066	2026-05-10 01:06:07.692977	1.0074
15937	Q14	ЗУ	SM 6	068	2026-05-10 01:06:07.692977	1.5656
15939	Q16	ЗУ	SM 8	070	2026-05-10 01:06:07.692977	3.1098
15941	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:06:09.721806	8.1987
15943	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:06:09.721806	7.8046
15945	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:06:09.721806	18.3932
15947	QF 1,21	ЗУ	China 2	045	2026-05-10 01:06:20.675844	10.4424
15949	QF 2,20	ЗУ	China 4	047	2026-05-10 01:06:20.675844	19.186
15951	QF 2,22	ЗУ	China 6	049	2026-05-10 01:06:20.675844	19.159
15953	QF 2,19	ЗУ	China 8	051	2026-05-10 01:06:20.675844	15.3689
15954	TP3	ЗУ	CP-300 New	078	2026-05-10 01:06:37.660925	6.1485
15956	Q20	ЗУ	MO 10	072	2026-05-10 01:06:38.593847	13.3886
15958	Q22	ЗУ	MO 12	074	2026-05-10 01:06:38.593847	0.8372
15960	Q24	ЗУ	MO 14	076	2026-05-10 01:06:38.593847	0.418
15962	Q8	ЗУ	DIG	061	2026-05-10 01:06:42.6537	46.076
15963	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:06:44.755119	21.0379
15965	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:06:44.755119	17.463
15967	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:06:44.755119	20.0505
15969	Q4	ЗУ	BG 1	062	2026-05-10 01:06:52.425726	21.3869
15971	Q10	ЗУ	SM 2	064	2026-05-10 01:06:52.729402	18.6871
15973	Q12	ЗУ	SM 4	066	2026-05-10 01:06:52.729402	1.5007
15975	Q14	ЗУ	SM 6	068	2026-05-10 01:06:52.729402	1.6008
15977	Q16	ЗУ	SM 8	070	2026-05-10 01:06:52.729402	2.9517
15979	QF 1,21	ЗУ	China 2	045	2026-05-10 01:07:00.76157	11.3282
15981	QF 2,20	ЗУ	China 4	047	2026-05-10 01:07:00.76157	19.1347
15983	QF 2,22	ЗУ	China 6	049	2026-05-10 01:07:00.76157	19.9468
15985	QF 2,19	ЗУ	China 8	051	2026-05-10 01:07:00.76157	14.4133
15986	TP3	ЗУ	CP-300 New	078	2026-05-10 01:07:07.713848	5.9846
15988	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:07:19.850199	20.532
15990	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:07:19.850199	17.2142
15992	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:07:19.850199	20.5825
15995	Q20	ЗУ	MO 10	072	2026-05-10 01:07:28.634277	13.6647
15997	Q22	ЗУ	MO 12	074	2026-05-10 01:07:28.634277	0.4425
15999	Q24	ЗУ	MO 14	076	2026-05-10 01:07:28.634277	0.7115
13000	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:02:30.086689	20.65
13001	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:02:30.086689	9.6071
13002	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:02:30.086689	17.4882
13003	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:02:30.086689	9.077
13004	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:02:30.086689	19.9878
13005	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:02:30.086689	19.5062
13006	TP3	ЗУ	CP-300 New	078	2026-05-09 21:02:34.436061	7.0197
13007	QF 1,20	ЗУ	China 1	044	2026-05-09 21:02:55.29419	12.3322
13008	QF 1,21	ЗУ	China 2	045	2026-05-09 21:02:55.29419	10.7919
13009	QF 1,22	ЗУ	China 3	046	2026-05-09 21:02:55.29419	13.8809
13010	QF 2,20	ЗУ	China 4	047	2026-05-09 21:02:55.29419	18.9354
13011	QF 2,21	ЗУ	China 5	048	2026-05-09 21:02:55.29419	20.3395
13012	QF 2,22	ЗУ	China 6	049	2026-05-09 21:02:55.29419	20.5936
13013	QF 2,23	ЗУ	China 7	050	2026-05-09 21:02:55.29419	10.4377
13014	QF 2,19	ЗУ	China 8	051	2026-05-09 21:02:55.29419	15.5863
13015	Q8	ЗУ	DIG	061	2026-05-09 21:03:04.352052	47.6612
13016	Q4	ЗУ	BG 1	062	2026-05-09 21:03:04.42554	21.3121
13017	Q9	ЗУ	BG 2	063	2026-05-09 21:03:04.42554	33.8604
13018	Q10	ЗУ	SM 2	064	2026-05-09 21:03:04.477452	18.7544
13019	TP3	ЗУ	CP-300 New	078	2026-05-09 21:03:04.481446	7.4234
13020	Q11	ЗУ	SM 3	065	2026-05-09 21:03:04.477452	22.4345
13021	Q12	ЗУ	SM 4	066	2026-05-09 21:03:04.477452	0.9187
13022	Q13	ЗУ	SM 5	067	2026-05-09 21:03:04.477452	1.7067
13023	Q14	ЗУ	SM 6	068	2026-05-09 21:03:04.477452	1.3435
13024	Q15	ЗУ	SM 7	069	2026-05-09 21:03:04.477452	1.016
13025	Q16	ЗУ	SM 8	070	2026-05-09 21:03:04.477452	3.5328
13026	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:03:05.124846	20.9283
13027	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:03:05.124846	8.8407
13028	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:03:05.124846	17.7955
13029	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:03:05.124846	8.6938
13030	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:03:05.124846	20.8177
13031	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:03:05.124846	19.7203
13032	Q17	ЗУ	MO 9	071	2026-05-09 21:03:15.204705	1.0765
13033	Q20	ЗУ	MO 10	072	2026-05-09 21:03:15.204705	13.9095
13034	Q21	ЗУ	MO 11	073	2026-05-09 21:03:15.204705	1.124
13035	Q22	ЗУ	MO 12	074	2026-05-09 21:03:15.204705	1.0779
13036	Q23	ЗУ	MO 13	075	2026-05-09 21:03:15.204705	0.7652
13037	Q24	ЗУ	MO 14	076	2026-05-09 21:03:15.204705	0.727
13038	Q25	ЗУ	MO 15	077	2026-05-09 21:03:15.204705	0.9621
13039	TP3	ЗУ	CP-300 New	078	2026-05-09 21:03:34.493394	7.4645
13040	QF 1,20	ЗУ	China 1	044	2026-05-09 21:03:35.461886	11.5718
13041	QF 1,21	ЗУ	China 2	045	2026-05-09 21:03:35.461886	10.9199
13042	QF 1,22	ЗУ	China 3	046	2026-05-09 21:03:35.461886	14.6021
13043	QF 2,20	ЗУ	China 4	047	2026-05-09 21:03:35.461886	19.1608
13044	QF 2,21	ЗУ	China 5	048	2026-05-09 21:03:35.461886	21.6619
13045	QF 2,22	ЗУ	China 6	049	2026-05-09 21:03:35.461886	20.2142
13046	QF 2,23	ЗУ	China 7	050	2026-05-09 21:03:35.461886	9.9138
13047	QF 2,19	ЗУ	China 8	051	2026-05-09 21:03:35.461886	15.7412
13048	Q8	ЗУ	DIG	061	2026-05-09 21:03:39.366591	46.5879
13049	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:03:40.154897	21.8318
13050	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:03:40.154897	8.8016
13051	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:03:40.154897	17.8431
13052	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:03:40.154897	7.5802
13053	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:03:40.154897	20.1012
13054	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:03:40.154897	18.6198
13055	Q4	ЗУ	BG 1	062	2026-05-09 21:03:49.447287	21.2489
13056	Q9	ЗУ	BG 2	063	2026-05-09 21:03:49.447287	33.5347
13057	Q10	ЗУ	SM 2	064	2026-05-09 21:03:49.50826	19.4177
13058	Q11	ЗУ	SM 3	065	2026-05-09 21:03:49.50826	22.0527
13059	Q12	ЗУ	SM 4	066	2026-05-09 21:03:49.50826	1.1925
13060	Q13	ЗУ	SM 5	067	2026-05-09 21:03:49.50826	1.1029
13061	Q14	ЗУ	SM 6	068	2026-05-09 21:03:49.50826	1.2497
13062	Q15	ЗУ	SM 7	069	2026-05-09 21:03:49.50826	1.7784
13063	Q16	ЗУ	SM 8	070	2026-05-09 21:03:49.50826	2.5919
13064	TP3	ЗУ	CP-300 New	078	2026-05-09 21:04:04.53884	6.4532
13065	Q17	ЗУ	MO 9	071	2026-05-09 21:04:05.263382	0.6087
13066	Q20	ЗУ	MO 10	072	2026-05-09 21:04:05.263382	13.1224
13067	Q21	ЗУ	MO 11	073	2026-05-09 21:04:05.263382	0.6062
13068	Q22	ЗУ	MO 12	074	2026-05-09 21:04:05.263382	0.963
13069	Q23	ЗУ	MO 13	075	2026-05-09 21:04:05.263382	1.1085
13070	Q24	ЗУ	MO 14	076	2026-05-09 21:04:05.263382	0.625
13071	Q25	ЗУ	MO 15	077	2026-05-09 21:04:05.263382	0.9168
13072	Q8	ЗУ	DIG	061	2026-05-09 21:04:14.398414	47.2527
13073	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:04:15.204366	22.0096
13074	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:04:15.204366	8.876
13075	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:04:15.204366	17.7799
13076	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:04:15.204366	8.8298
13077	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:04:15.204366	19.7158
13078	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:04:15.204366	20.1707
13079	QF 1,20	ЗУ	China 1	044	2026-05-09 21:04:15.532143	11.9971
13080	QF 1,21	ЗУ	China 2	045	2026-05-09 21:04:15.532143	10.7631
13081	QF 1,22	ЗУ	China 3	046	2026-05-09 21:04:15.532143	14.7763
13082	QF 2,20	ЗУ	China 4	047	2026-05-09 21:04:15.532143	19.7104
13083	QF 2,21	ЗУ	China 5	048	2026-05-09 21:04:15.532143	20.3945
13084	QF 2,22	ЗУ	China 6	049	2026-05-09 21:04:15.532143	19.996
13085	QF 2,23	ЗУ	China 7	050	2026-05-09 21:04:15.532143	9.3391
13086	QF 2,19	ЗУ	China 8	051	2026-05-09 21:04:15.532143	14.8539
13087	Q4	ЗУ	BG 1	062	2026-05-09 21:04:34.486334	21.0083
13088	Q9	ЗУ	BG 2	063	2026-05-09 21:04:34.486334	33.8287
13089	Q10	ЗУ	SM 2	064	2026-05-09 21:04:34.538388	18.868
13090	Q11	ЗУ	SM 3	065	2026-05-09 21:04:34.538388	21.6
13091	Q12	ЗУ	SM 4	066	2026-05-09 21:04:34.538388	1.5638
13092	Q13	ЗУ	SM 5	067	2026-05-09 21:04:34.538388	1.6423
13093	Q14	ЗУ	SM 6	068	2026-05-09 21:04:34.538388	1.7398
13094	Q15	ЗУ	SM 7	069	2026-05-09 21:04:34.538388	1.9816
13095	Q16	ЗУ	SM 8	070	2026-05-09 21:04:34.538388	3.0198
13096	TP3	ЗУ	CP-300 New	078	2026-05-09 21:04:34.576952	6.6774
13097	Q8	ЗУ	DIG	061	2026-05-09 21:04:49.418184	45.8751
13098	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:04:50.270164	22.2248
13099	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:04:50.270164	9.4958
13100	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:04:50.270164	16.9403
13101	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:04:50.270164	9.3511
13102	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:04:50.270164	20.5754
13104	Q17	ЗУ	MO 9	071	2026-05-09 21:04:55.317224	0.7565
13106	Q21	ЗУ	MO 11	073	2026-05-09 21:04:55.317224	0.6794
13108	Q23	ЗУ	MO 13	075	2026-05-09 21:04:55.317224	0.87
13110	Q25	ЗУ	MO 15	077	2026-05-09 21:04:55.317224	1.0668
13112	QF 1,21	ЗУ	China 2	045	2026-05-09 21:04:55.579833	10.3787
13114	QF 2,20	ЗУ	China 4	047	2026-05-09 21:04:55.579833	19.4442
13116	QF 2,22	ЗУ	China 6	049	2026-05-09 21:04:55.579833	19.4169
13118	QF 2,19	ЗУ	China 8	051	2026-05-09 21:04:55.579833	14.5249
13120	Q4	ЗУ	BG 1	062	2026-05-09 21:05:19.530105	21.4305
13122	Q10	ЗУ	SM 2	064	2026-05-09 21:05:19.579945	18.4772
13124	Q12	ЗУ	SM 4	066	2026-05-09 21:05:19.579945	1.9755
13126	Q14	ЗУ	SM 6	068	2026-05-09 21:05:19.579945	1.3929
13128	Q16	ЗУ	SM 8	070	2026-05-09 21:05:19.579945	2.9806
13130	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:05:25.308673	22.3576
13132	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:05:25.308673	17.5867
13134	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:05:25.308673	20.0481
13136	TP3	ЗУ	CP-300 New	078	2026-05-09 21:05:34.688192	7.6832
13138	QF 1,21	ЗУ	China 2	045	2026-05-09 21:05:35.613712	11.2195
13140	QF 2,20	ЗУ	China 4	047	2026-05-09 21:05:35.613712	18.8212
13142	QF 2,22	ЗУ	China 6	049	2026-05-09 21:05:35.613712	19.8887
13144	QF 2,19	ЗУ	China 8	051	2026-05-09 21:05:35.613712	14.407
13146	Q20	ЗУ	MO 10	072	2026-05-09 21:05:45.382351	13.4576
13148	Q22	ЗУ	MO 12	074	2026-05-09 21:05:45.382351	1.4732
13150	Q24	ЗУ	MO 14	076	2026-05-09 21:05:45.382351	0.6681
13152	Q8	ЗУ	DIG	061	2026-05-09 21:05:59.480166	47.0302
13154	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:06:00.347843	8.8042
13156	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:06:00.347843	8.7216
13158	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:06:00.347843	19.261
13160	Q9	ЗУ	BG 2	063	2026-05-09 21:06:04.577413	33.819
13162	Q11	ЗУ	SM 3	065	2026-05-09 21:06:04.610482	21.5955
13164	Q13	ЗУ	SM 5	067	2026-05-09 21:06:04.610482	1.6932
13166	Q15	ЗУ	SM 7	069	2026-05-09 21:06:04.610482	1.4937
13168	TP3	ЗУ	CP-300 New	078	2026-05-09 21:06:04.711955	6.9073
13170	QF 1,21	ЗУ	China 2	045	2026-05-09 21:06:15.66879	11.5897
13172	QF 2,20	ЗУ	China 4	047	2026-05-09 21:06:15.66879	18.4766
13174	QF 2,22	ЗУ	China 6	049	2026-05-09 21:06:15.66879	20.4193
13176	QF 2,19	ЗУ	China 8	051	2026-05-09 21:06:15.66879	15.6352
13178	TP3	ЗУ	CP-300 New	078	2026-05-09 21:06:34.729887	7.8864
13180	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:06:35.385022	8.6732
13182	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:06:35.385022	9.1802
13184	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:06:35.385022	19.469
13186	Q20	ЗУ	MO 10	072	2026-05-09 21:06:35.426053	13.1743
13188	Q22	ЗУ	MO 12	074	2026-05-09 21:06:35.426053	0.9289
13190	Q24	ЗУ	MO 14	076	2026-05-09 21:06:35.426053	1.1495
13192	Q4	ЗУ	BG 1	062	2026-05-09 21:06:49.601815	20.8694
13194	Q10	ЗУ	SM 2	064	2026-05-09 21:06:49.644542	18.7557
13196	Q12	ЗУ	SM 4	066	2026-05-09 21:06:49.644542	1.0237
13198	Q14	ЗУ	SM 6	068	2026-05-09 21:06:49.644542	1.8194
13200	Q16	ЗУ	SM 8	070	2026-05-09 21:06:49.644542	2.987
13202	QF 1,21	ЗУ	China 2	045	2026-05-09 21:06:55.754841	10.7973
13204	QF 2,20	ЗУ	China 4	047	2026-05-09 21:06:55.754841	18.9856
13206	QF 2,22	ЗУ	China 6	049	2026-05-09 21:06:55.754841	20.221
13208	QF 2,19	ЗУ	China 8	051	2026-05-09 21:06:55.754841	15.8543
13210	Q8	ЗУ	DIG	061	2026-05-09 21:07:09.546448	46.4076
13212	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:07:10.416923	10.0264
13214	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:07:10.416923	8.2162
13216	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:07:10.416923	19.218
13218	Q20	ЗУ	MO 10	072	2026-05-09 21:07:25.451817	14.0449
13220	Q22	ЗУ	MO 12	074	2026-05-09 21:07:25.451817	1.3592
13222	Q24	ЗУ	MO 14	076	2026-05-09 21:07:25.451817	0.7849
13224	Q4	ЗУ	BG 1	062	2026-05-09 21:07:34.647058	21.5018
13226	Q9	ЗУ	BG 2	063	2026-05-09 21:07:34.647058	33.4204
13228	Q12	ЗУ	SM 4	066	2026-05-09 21:07:34.690964	1.0416
13230	Q14	ЗУ	SM 6	068	2026-05-09 21:07:34.690964	1.0182
13232	Q16	ЗУ	SM 8	070	2026-05-09 21:07:34.690964	3.2569
13234	QF 1,20	ЗУ	China 1	044	2026-05-09 21:07:35.833716	12.5157
13236	QF 1,22	ЗУ	China 3	046	2026-05-09 21:07:35.833716	14.312
13238	QF 2,21	ЗУ	China 5	048	2026-05-09 21:07:35.833716	20.3924
13240	QF 2,23	ЗУ	China 7	050	2026-05-09 21:07:35.833716	9.3124
13242	Q8	ЗУ	DIG	061	2026-05-09 21:07:44.559846	46.8592
13244	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:07:45.468211	9.8699
13246	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:07:45.468211	8.0376
13248	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:07:45.468211	19.4226
13250	Q17	ЗУ	MO 9	071	2026-05-09 21:08:15.520242	1.4375
13252	Q21	ЗУ	MO 11	073	2026-05-09 21:08:15.520242	0.7689
13254	Q23	ЗУ	MO 13	075	2026-05-09 21:08:15.520242	0.9386
13256	Q25	ЗУ	MO 15	077	2026-05-09 21:08:15.520242	1.0568
13258	QF 1,21	ЗУ	China 2	045	2026-05-09 21:08:15.871911	11.7209
13260	QF 2,20	ЗУ	China 4	047	2026-05-09 21:08:15.871911	19.6433
13262	QF 2,22	ЗУ	China 6	049	2026-05-09 21:08:15.871911	20.2806
13264	QF 2,19	ЗУ	China 8	051	2026-05-09 21:08:15.871911	15.6293
13266	Q4	ЗУ	BG 1	062	2026-05-09 21:08:19.744302	21.6621
13268	Q10	ЗУ	SM 2	064	2026-05-09 21:08:19.786258	18.6443
13270	Q12	ЗУ	SM 4	066	2026-05-09 21:08:19.786258	2.0076
13272	Q14	ЗУ	SM 6	068	2026-05-09 21:08:19.786258	1.0465
13274	Q16	ЗУ	SM 8	070	2026-05-09 21:08:19.786258	3.3137
13276	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:08:20.559517	9.2223
13278	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:08:20.559517	8.5035
13280	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:08:20.559517	18.96
13282	Q8	ЗУ	DIG	061	2026-05-09 21:08:54.651525	46.2525
13284	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:08:55.61941	10.2066
13286	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:08:55.61941	9.2367
13288	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:08:55.61941	18.9426
13290	QF 1,21	ЗУ	China 2	045	2026-05-09 21:08:55.907508	10.7724
13292	QF 2,20	ЗУ	China 4	047	2026-05-09 21:08:55.907508	18.291
13294	QF 2,22	ЗУ	China 6	049	2026-05-09 21:08:55.907508	20.782
13296	QF 2,19	ЗУ	China 8	051	2026-05-09 21:08:55.907508	15.6602
13298	Q9	ЗУ	BG 2	063	2026-05-09 21:09:04.76738	33.6673
13300	Q11	ЗУ	SM 3	065	2026-05-09 21:09:04.832646	21.4112
13302	Q13	ЗУ	SM 5	067	2026-05-09 21:09:04.832646	1.7945
13304	Q15	ЗУ	SM 7	069	2026-05-09 21:09:04.832646	1.7383
13103	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:04:50.270164	19.3231
13105	Q20	ЗУ	MO 10	072	2026-05-09 21:04:55.317224	13.1943
13107	Q22	ЗУ	MO 12	074	2026-05-09 21:04:55.317224	0.8536
13109	Q24	ЗУ	MO 14	076	2026-05-09 21:04:55.317224	1.3327
13111	QF 1,20	ЗУ	China 1	044	2026-05-09 21:04:55.579833	11.9172
13113	QF 1,22	ЗУ	China 3	046	2026-05-09 21:04:55.579833	13.3679
13115	QF 2,21	ЗУ	China 5	048	2026-05-09 21:04:55.579833	21.7078
13117	QF 2,23	ЗУ	China 7	050	2026-05-09 21:04:55.579833	10.0024
13119	TP3	ЗУ	CP-300 New	078	2026-05-09 21:05:04.614604	8.145
13121	Q9	ЗУ	BG 2	063	2026-05-09 21:05:19.530105	33.4428
13123	Q11	ЗУ	SM 3	065	2026-05-09 21:05:19.579945	22.2564
13125	Q13	ЗУ	SM 5	067	2026-05-09 21:05:19.579945	0.8571
13127	Q15	ЗУ	SM 7	069	2026-05-09 21:05:19.579945	1.6562
13129	Q8	ЗУ	DIG	061	2026-05-09 21:05:24.458171	47.3437
13131	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:05:25.308673	8.6033
13133	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:05:25.308673	8.6798
13135	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:05:25.308673	19.2332
13137	QF 1,20	ЗУ	China 1	044	2026-05-09 21:05:35.613712	12.039
13139	QF 1,22	ЗУ	China 3	046	2026-05-09 21:05:35.613712	14.2868
13141	QF 2,21	ЗУ	China 5	048	2026-05-09 21:05:35.613712	20.6197
13143	QF 2,23	ЗУ	China 7	050	2026-05-09 21:05:35.613712	9.9464
13145	Q17	ЗУ	MO 9	071	2026-05-09 21:05:45.382351	1.4023
13147	Q21	ЗУ	MO 11	073	2026-05-09 21:05:45.382351	1.3343
13149	Q23	ЗУ	MO 13	075	2026-05-09 21:05:45.382351	1.0183
13151	Q25	ЗУ	MO 15	077	2026-05-09 21:05:45.382351	0.8753
13153	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:06:00.347843	22.2675
13155	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:06:00.347843	17.3016
13157	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:06:00.347843	20.6759
13159	Q4	ЗУ	BG 1	062	2026-05-09 21:06:04.577413	21.1237
13161	Q10	ЗУ	SM 2	064	2026-05-09 21:06:04.610482	18.713
13163	Q12	ЗУ	SM 4	066	2026-05-09 21:06:04.610482	1.9946
13165	Q14	ЗУ	SM 6	068	2026-05-09 21:06:04.610482	1.4116
13167	Q16	ЗУ	SM 8	070	2026-05-09 21:06:04.610482	2.8769
13169	QF 1,20	ЗУ	China 1	044	2026-05-09 21:06:15.66879	12.1551
13171	QF 1,22	ЗУ	China 3	046	2026-05-09 21:06:15.66879	14.2166
13173	QF 2,21	ЗУ	China 5	048	2026-05-09 21:06:15.66879	20.785
13175	QF 2,23	ЗУ	China 7	050	2026-05-09 21:06:15.66879	9.3083
13177	Q8	ЗУ	DIG	061	2026-05-09 21:06:34.507148	46.39
13179	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:06:35.385022	22.2244
13181	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:06:35.385022	16.9196
13183	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:06:35.385022	20.5458
13185	Q17	ЗУ	MO 9	071	2026-05-09 21:06:35.426053	0.979
13187	Q21	ЗУ	MO 11	073	2026-05-09 21:06:35.426053	0.6037
13189	Q23	ЗУ	MO 13	075	2026-05-09 21:06:35.426053	1.3011
13191	Q25	ЗУ	MO 15	077	2026-05-09 21:06:35.426053	1.3974
13193	Q9	ЗУ	BG 2	063	2026-05-09 21:06:49.601815	33.83
13195	Q11	ЗУ	SM 3	065	2026-05-09 21:06:49.644542	21.5321
13197	Q13	ЗУ	SM 5	067	2026-05-09 21:06:49.644542	0.8926
13199	Q15	ЗУ	SM 7	069	2026-05-09 21:06:49.644542	1.4935
13201	QF 1,20	ЗУ	China 1	044	2026-05-09 21:06:55.754841	12.483
13203	QF 1,22	ЗУ	China 3	046	2026-05-09 21:06:55.754841	13.6295
13205	QF 2,21	ЗУ	China 5	048	2026-05-09 21:06:55.754841	21.786
13207	QF 2,23	ЗУ	China 7	050	2026-05-09 21:06:55.754841	9.8638
13209	TP3	ЗУ	CP-300 New	078	2026-05-09 21:07:04.780435	6.8527
13211	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:07:10.416923	20.8492
13213	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:07:10.416923	17.9643
13215	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:07:10.416923	20.8008
13217	Q17	ЗУ	MO 9	071	2026-05-09 21:07:25.451817	1.0308
13219	Q21	ЗУ	MO 11	073	2026-05-09 21:07:25.451817	1.1249
13221	Q23	ЗУ	MO 13	075	2026-05-09 21:07:25.451817	1.1891
13223	Q25	ЗУ	MO 15	077	2026-05-09 21:07:25.451817	1.0355
13225	Q10	ЗУ	SM 2	064	2026-05-09 21:07:34.690964	19.3184
13227	Q11	ЗУ	SM 3	065	2026-05-09 21:07:34.690964	22.1697
13229	Q13	ЗУ	SM 5	067	2026-05-09 21:07:34.690964	1.1063
13231	Q15	ЗУ	SM 7	069	2026-05-09 21:07:34.690964	1.5331
13233	TP3	ЗУ	CP-300 New	078	2026-05-09 21:07:34.804627	7.3872
13235	QF 1,21	ЗУ	China 2	045	2026-05-09 21:07:35.833716	11.1656
13237	QF 2,20	ЗУ	China 4	047	2026-05-09 21:07:35.833716	19.0838
13239	QF 2,22	ЗУ	China 6	049	2026-05-09 21:07:35.833716	20.2277
13241	QF 2,19	ЗУ	China 8	051	2026-05-09 21:07:35.833716	14.6573
13243	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:07:45.468211	22.033
13245	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:07:45.468211	18.0017
13247	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:07:45.468211	20.1751
13249	TP3	ЗУ	CP-300 New	078	2026-05-09 21:08:04.824986	8.0425
13251	Q20	ЗУ	MO 10	072	2026-05-09 21:08:15.520242	13.0896
13253	Q22	ЗУ	MO 12	074	2026-05-09 21:08:15.520242	0.732
13255	Q24	ЗУ	MO 14	076	2026-05-09 21:08:15.520242	1.2996
13257	QF 1,20	ЗУ	China 1	044	2026-05-09 21:08:15.871911	11.3097
13259	QF 1,22	ЗУ	China 3	046	2026-05-09 21:08:15.871911	13.9795
13261	QF 2,21	ЗУ	China 5	048	2026-05-09 21:08:15.871911	21.4732
13263	QF 2,23	ЗУ	China 7	050	2026-05-09 21:08:15.871911	10.6469
13265	Q8	ЗУ	DIG	061	2026-05-09 21:08:19.623363	47.1839
13267	Q9	ЗУ	BG 2	063	2026-05-09 21:08:19.744302	32.5593
13269	Q11	ЗУ	SM 3	065	2026-05-09 21:08:19.786258	21.7708
13271	Q13	ЗУ	SM 5	067	2026-05-09 21:08:19.786258	0.9732
13273	Q15	ЗУ	SM 7	069	2026-05-09 21:08:19.786258	1.274
13275	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:08:20.559517	22.1231
13277	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:08:20.559517	18.0671
13279	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:08:20.559517	21.2778
13281	TP3	ЗУ	CP-300 New	078	2026-05-09 21:08:34.854459	6.5034
13283	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:08:55.61941	21.4664
13285	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:08:55.61941	17.2286
13287	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:08:55.61941	20.7864
13289	QF 1,20	ЗУ	China 1	044	2026-05-09 21:08:55.907508	12.4936
13291	QF 1,22	ЗУ	China 3	046	2026-05-09 21:08:55.907508	14.3877
13293	QF 2,21	ЗУ	China 5	048	2026-05-09 21:08:55.907508	20.8555
13295	QF 2,23	ЗУ	China 7	050	2026-05-09 21:08:55.907508	10.0314
13297	Q4	ЗУ	BG 1	062	2026-05-09 21:09:04.76738	20.5315
13299	Q10	ЗУ	SM 2	064	2026-05-09 21:09:04.832646	18.7382
13301	Q12	ЗУ	SM 4	066	2026-05-09 21:09:04.832646	1.4269
13303	Q14	ЗУ	SM 6	068	2026-05-09 21:09:04.832646	1.456
13305	Q16	ЗУ	SM 8	070	2026-05-09 21:09:04.832646	3.0657
13306	TP3	ЗУ	CP-300 New	078	2026-05-09 21:09:04.909178	8.0796
13308	Q20	ЗУ	MO 10	072	2026-05-09 21:09:05.553983	13.2122
13310	Q22	ЗУ	MO 12	074	2026-05-09 21:09:05.553983	1.1059
13312	Q24	ЗУ	MO 14	076	2026-05-09 21:09:05.553983	1.1778
13314	Q8	ЗУ	DIG	061	2026-05-09 21:09:29.686217	46.396
13316	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:09:30.660485	10.2786
13318	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:09:30.660485	9.1036
13320	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:09:30.660485	18.6887
13322	QF 1,20	ЗУ	China 1	044	2026-05-09 21:09:35.958534	12.2458
13324	QF 1,22	ЗУ	China 3	046	2026-05-09 21:09:35.958534	14.728
13326	QF 2,21	ЗУ	China 5	048	2026-05-09 21:09:35.958534	20.6026
13328	QF 2,23	ЗУ	China 7	050	2026-05-09 21:09:35.958534	9.2785
13330	Q4	ЗУ	BG 1	062	2026-05-09 21:09:49.786769	21.1689
13332	Q10	ЗУ	SM 2	064	2026-05-09 21:09:49.880334	18.8551
13334	Q12	ЗУ	SM 4	066	2026-05-09 21:09:49.880334	1.9988
13336	Q14	ЗУ	SM 6	068	2026-05-09 21:09:49.880334	1.6766
13338	Q16	ЗУ	SM 8	070	2026-05-09 21:09:49.880334	3.4614
13340	Q20	ЗУ	MO 10	072	2026-05-09 21:09:55.600118	13.9435
13342	Q22	ЗУ	MO 12	074	2026-05-09 21:09:55.600118	1.339
13344	Q24	ЗУ	MO 14	076	2026-05-09 21:09:55.600118	1.1351
13346	Q8	ЗУ	DIG	061	2026-05-09 21:10:04.695696	46.725
13348	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:10:05.683374	20.8304
13350	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:10:05.683374	18.131
13352	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:10:05.683374	19.6169
13354	QF 1,20	ЗУ	China 1	044	2026-05-09 21:10:15.984848	12.6918
13356	QF 1,22	ЗУ	China 3	046	2026-05-09 21:10:15.984848	13.8951
13358	QF 2,21	ЗУ	China 5	048	2026-05-09 21:10:15.984848	20.4637
13360	QF 2,23	ЗУ	China 7	050	2026-05-09 21:10:15.984848	9.9955
13362	Q4	ЗУ	BG 1	062	2026-05-09 21:10:34.79786	21.7161
13364	Q10	ЗУ	SM 2	064	2026-05-09 21:10:34.909526	18.6994
13366	Q12	ЗУ	SM 4	066	2026-05-09 21:10:34.909526	1.9406
13368	Q13	ЗУ	SM 5	067	2026-05-09 21:10:34.909526	1.537
13370	Q15	ЗУ	SM 7	069	2026-05-09 21:10:34.909526	1.8878
13372	Q8	ЗУ	DIG	061	2026-05-09 21:10:39.707309	47.3566
13374	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:10:40.704526	8.5204
13376	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:10:40.704526	9.1577
13378	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:10:40.704526	19.906
13380	Q20	ЗУ	MO 10	072	2026-05-09 21:10:45.629115	13.71
13382	Q22	ЗУ	MO 12	074	2026-05-09 21:10:45.629115	1.228
13384	Q24	ЗУ	MO 14	076	2026-05-09 21:10:45.629115	0.938
13386	QF 1,20	ЗУ	China 1	044	2026-05-09 21:10:56.022427	12.3343
13388	QF 1,22	ЗУ	China 3	046	2026-05-09 21:10:56.022427	13.773
13390	QF 2,21	ЗУ	China 5	048	2026-05-09 21:10:56.022427	21.7948
13392	QF 2,23	ЗУ	China 7	050	2026-05-09 21:10:56.022427	10.1995
13394	TP3	ЗУ	CP-300 New	078	2026-05-09 21:11:04.943338	7.1008
13396	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:11:15.741635	22.302
13398	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:11:15.741635	17.5564
13400	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:11:15.741635	20.881
13402	Q4	ЗУ	BG 1	062	2026-05-09 21:11:19.820188	21.7963
13404	Q10	ЗУ	SM 2	064	2026-05-09 21:11:19.952126	19.2133
13406	Q12	ЗУ	SM 4	066	2026-05-09 21:11:19.952126	1.944
13408	Q14	ЗУ	SM 6	068	2026-05-09 21:11:19.952126	1.479
13410	Q16	ЗУ	SM 8	070	2026-05-09 21:11:19.952126	2.5855
13412	Q17	ЗУ	MO 9	071	2026-05-09 21:11:35.68187	1.2237
13414	Q21	ЗУ	MO 11	073	2026-05-09 21:11:35.68187	1.5386
13416	Q23	ЗУ	MO 13	075	2026-05-09 21:11:35.68187	0.813
13418	Q25	ЗУ	MO 15	077	2026-05-09 21:11:35.68187	0.5952
13420	QF 1,21	ЗУ	China 2	045	2026-05-09 21:11:36.052103	11.5426
13422	QF 2,20	ЗУ	China 4	047	2026-05-09 21:11:36.052103	19.3803
13424	QF 2,22	ЗУ	China 6	049	2026-05-09 21:11:36.052103	20.2701
13426	QF 2,19	ЗУ	China 8	051	2026-05-09 21:11:36.052103	15.42
13428	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:11:50.782758	21.9367
13430	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:11:50.782758	18.2529
13432	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:11:50.782758	20.6819
13434	Q4	ЗУ	BG 1	062	2026-05-09 21:12:04.833462	21.5683
13436	Q10	ЗУ	SM 2	064	2026-05-09 21:12:05.005603	18.9143
13438	Q11	ЗУ	SM 3	065	2026-05-09 21:12:05.005603	22.0209
13440	Q13	ЗУ	SM 5	067	2026-05-09 21:12:05.005603	1.1239
13442	Q15	ЗУ	SM 7	069	2026-05-09 21:12:05.005603	1.1412
13444	QF 1,20	ЗУ	China 1	044	2026-05-09 21:12:16.081869	12.4763
13446	QF 1,22	ЗУ	China 3	046	2026-05-09 21:12:16.081869	13.4072
13448	QF 2,21	ЗУ	China 5	048	2026-05-09 21:12:16.081869	21.1144
13450	QF 2,23	ЗУ	China 7	050	2026-05-09 21:12:16.081869	10.4045
13452	Q8	ЗУ	DIG	061	2026-05-09 21:12:24.747447	46.0049
13454	Q20	ЗУ	MO 10	072	2026-05-09 21:12:25.71225	14.0529
13456	Q22	ЗУ	MO 12	074	2026-05-09 21:12:25.71225	1.2226
13458	Q24	ЗУ	MO 14	076	2026-05-09 21:12:25.71225	1.4584
13460	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:12:25.810625	20.998
13462	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:12:25.810625	16.8711
13464	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:12:25.810625	21.068
15859	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:04:24.56091	9.6603
15861	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:04:24.56091	7.4429
15863	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:04:24.56091	18.861
15865	Q9	ЗУ	BG 2	063	2026-05-10 01:04:37.257278	32.2714
15867	Q10	ЗУ	SM 2	064	2026-05-10 01:04:37.595227	18.8502
15869	Q12	ЗУ	SM 4	066	2026-05-10 01:04:37.595227	1.3953
15871	Q14	ЗУ	SM 6	068	2026-05-10 01:04:37.595227	0.7736
15873	Q16	ЗУ	SM 8	070	2026-05-10 01:04:37.595227	2.4814
15874	Q8	ЗУ	DIG	061	2026-05-10 01:04:57.525521	45.2374
15876	Q20	ЗУ	MO 10	072	2026-05-10 01:04:58.507963	12.9222
15878	Q22	ЗУ	MO 12	074	2026-05-10 01:04:58.507963	0.438
15880	Q24	ЗУ	MO 14	076	2026-05-10 01:04:58.507963	0.608
15882	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:04:59.603844	20.9808
15884	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:04:59.603844	17.5105
15886	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:04:59.603844	20.6295
15888	QF 1,20	ЗУ	China 1	044	2026-05-10 01:05:00.572013	11.1165
15890	QF 1,22	ЗУ	China 3	046	2026-05-10 01:05:00.572013	14.155
15892	QF 2,21	ЗУ	China 5	048	2026-05-10 01:05:00.572013	21.2408
15894	QF 2,23	ЗУ	China 7	050	2026-05-10 01:05:00.572013	9.0268
15897	Q4	ЗУ	BG 1	062	2026-05-10 01:05:22.324744	20.2398
15899	Q10	ЗУ	SM 2	064	2026-05-10 01:05:22.641985	18.8339
15901	Q12	ЗУ	SM 4	066	2026-05-10 01:05:22.641985	1.6718
17172	Q8	ЗУ	DIG	061	2026-05-10 01:34:08.616405	46.1057
13307	Q17	ЗУ	MO 9	071	2026-05-09 21:09:05.553983	0.5779
13309	Q21	ЗУ	MO 11	073	2026-05-09 21:09:05.553983	1.0917
13311	Q23	ЗУ	MO 13	075	2026-05-09 21:09:05.553983	1.5348
13313	Q25	ЗУ	MO 15	077	2026-05-09 21:09:05.553983	0.7749
13315	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:09:30.660485	21.6295
13317	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:09:30.660485	17.236
13319	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:09:30.660485	20.6264
13321	TP3	ЗУ	CP-300 New	078	2026-05-09 21:09:34.919494	7.6113
13323	QF 1,21	ЗУ	China 2	045	2026-05-09 21:09:35.958534	10.4253
13325	QF 2,20	ЗУ	China 4	047	2026-05-09 21:09:35.958534	19.7051
13327	QF 2,22	ЗУ	China 6	049	2026-05-09 21:09:35.958534	19.7257
13329	QF 2,19	ЗУ	China 8	051	2026-05-09 21:09:35.958534	15.7669
13331	Q9	ЗУ	BG 2	063	2026-05-09 21:09:49.786769	33.2128
13333	Q11	ЗУ	SM 3	065	2026-05-09 21:09:49.880334	21.7511
13335	Q13	ЗУ	SM 5	067	2026-05-09 21:09:49.880334	1.5847
13337	Q15	ЗУ	SM 7	069	2026-05-09 21:09:49.880334	1.0691
13339	Q17	ЗУ	MO 9	071	2026-05-09 21:09:55.600118	0.7844
13341	Q21	ЗУ	MO 11	073	2026-05-09 21:09:55.600118	1.2137
13343	Q23	ЗУ	MO 13	075	2026-05-09 21:09:55.600118	0.7773
13345	Q25	ЗУ	MO 15	077	2026-05-09 21:09:55.600118	1.5493
13347	TP3	ЗУ	CP-300 New	078	2026-05-09 21:10:04.92564	7.2799
13349	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:10:05.683374	9.8324
13351	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:10:05.683374	8.8097
13353	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:10:05.683374	19.7905
13355	QF 1,21	ЗУ	China 2	045	2026-05-09 21:10:15.984848	10.911
13357	QF 2,20	ЗУ	China 4	047	2026-05-09 21:10:15.984848	18.4457
13359	QF 2,22	ЗУ	China 6	049	2026-05-09 21:10:15.984848	19.3133
13361	QF 2,19	ЗУ	China 8	051	2026-05-09 21:10:15.984848	14.5194
13363	Q9	ЗУ	BG 2	063	2026-05-09 21:10:34.79786	33.0105
13365	Q11	ЗУ	SM 3	065	2026-05-09 21:10:34.909526	21.3857
13367	TP3	ЗУ	CP-300 New	078	2026-05-09 21:10:34.934518	6.6571
13369	Q14	ЗУ	SM 6	068	2026-05-09 21:10:34.909526	1.7827
13371	Q16	ЗУ	SM 8	070	2026-05-09 21:10:34.909526	2.4005
13373	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:10:40.704526	22.0051
13375	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:10:40.704526	16.9727
13377	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:10:40.704526	20.5267
13379	Q17	ЗУ	MO 9	071	2026-05-09 21:10:45.629115	0.7773
13381	Q21	ЗУ	MO 11	073	2026-05-09 21:10:45.629115	1.0984
13383	Q23	ЗУ	MO 13	075	2026-05-09 21:10:45.629115	0.7455
13385	Q25	ЗУ	MO 15	077	2026-05-09 21:10:45.629115	0.8286
13387	QF 1,21	ЗУ	China 2	045	2026-05-09 21:10:56.022427	11.2844
13389	QF 2,20	ЗУ	China 4	047	2026-05-09 21:10:56.022427	19.125
13391	QF 2,22	ЗУ	China 6	049	2026-05-09 21:10:56.022427	20.6375
13393	QF 2,19	ЗУ	China 8	051	2026-05-09 21:10:56.022427	14.5376
13395	Q8	ЗУ	DIG	061	2026-05-09 21:11:14.718106	47.8538
13397	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:11:15.741635	9.1768
13399	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:11:15.741635	8.5824
13401	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:11:15.741635	19.6013
13403	Q9	ЗУ	BG 2	063	2026-05-09 21:11:19.820188	33.7745
13405	Q11	ЗУ	SM 3	065	2026-05-09 21:11:19.952126	21.5604
13407	Q13	ЗУ	SM 5	067	2026-05-09 21:11:19.952126	0.8027
13409	Q15	ЗУ	SM 7	069	2026-05-09 21:11:19.952126	1.1739
13411	TP3	ЗУ	CP-300 New	078	2026-05-09 21:11:34.956254	7.1321
13413	Q20	ЗУ	MO 10	072	2026-05-09 21:11:35.68187	13.4767
13415	Q22	ЗУ	MO 12	074	2026-05-09 21:11:35.68187	1.243
13417	Q24	ЗУ	MO 14	076	2026-05-09 21:11:35.68187	1.2229
13419	QF 1,20	ЗУ	China 1	044	2026-05-09 21:11:36.052103	11.6596
13421	QF 1,22	ЗУ	China 3	046	2026-05-09 21:11:36.052103	14.3917
13423	QF 2,21	ЗУ	China 5	048	2026-05-09 21:11:36.052103	21.7816
13425	QF 2,23	ЗУ	China 7	050	2026-05-09 21:11:36.052103	9.873
13427	Q8	ЗУ	DIG	061	2026-05-09 21:11:49.735278	46.681
13429	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:11:50.782758	8.8463
13431	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:11:50.782758	7.8741
13433	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:11:50.782758	19.4586
13435	Q9	ЗУ	BG 2	063	2026-05-09 21:12:04.833462	33.2446
13437	TP3	ЗУ	CP-300 New	078	2026-05-09 21:12:05.005989	7.4915
13439	Q12	ЗУ	SM 4	066	2026-05-09 21:12:05.005603	1.7398
13441	Q14	ЗУ	SM 6	068	2026-05-09 21:12:05.005603	0.9143
13443	Q16	ЗУ	SM 8	070	2026-05-09 21:12:05.005603	3.4662
13445	QF 1,21	ЗУ	China 2	045	2026-05-09 21:12:16.081869	11.4809
13447	QF 2,20	ЗУ	China 4	047	2026-05-09 21:12:16.081869	18.2543
13449	QF 2,22	ЗУ	China 6	049	2026-05-09 21:12:16.081869	19.6069
13451	QF 2,19	ЗУ	China 8	051	2026-05-09 21:12:16.081869	15.0176
13453	Q17	ЗУ	MO 9	071	2026-05-09 21:12:25.71225	1.2753
13455	Q21	ЗУ	MO 11	073	2026-05-09 21:12:25.71225	0.6648
13457	Q23	ЗУ	MO 13	075	2026-05-09 21:12:25.71225	1.4527
13459	Q25	ЗУ	MO 15	077	2026-05-09 21:12:25.71225	0.9238
13461	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:12:25.810625	9.2387
13463	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:12:25.810625	8.3213
13465	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:12:25.810625	18.9319
13466	TP3	ЗУ	CP-300 New	078	2026-05-09 21:12:35.022801	7.4582
13467	Q4	ЗУ	BG 1	062	2026-05-09 21:12:49.854801	21.3639
13468	Q9	ЗУ	BG 2	063	2026-05-09 21:12:49.854801	33.3023
13469	Q10	ЗУ	SM 2	064	2026-05-09 21:12:50.037209	18.5538
13470	Q11	ЗУ	SM 3	065	2026-05-09 21:12:50.037209	22.1
13471	Q12	ЗУ	SM 4	066	2026-05-09 21:12:50.037209	1.5776
13472	Q13	ЗУ	SM 5	067	2026-05-09 21:12:50.037209	1.5535
13473	Q14	ЗУ	SM 6	068	2026-05-09 21:12:50.037209	1.537
13474	Q15	ЗУ	SM 7	069	2026-05-09 21:12:50.037209	0.9628
13475	Q16	ЗУ	SM 8	070	2026-05-09 21:12:50.037209	3.3258
13476	QF 1,20	ЗУ	China 1	044	2026-05-09 21:12:56.128358	12.4435
13477	QF 1,21	ЗУ	China 2	045	2026-05-09 21:12:56.128358	11.6482
13478	QF 1,22	ЗУ	China 3	046	2026-05-09 21:12:56.128358	13.8352
13479	QF 2,20	ЗУ	China 4	047	2026-05-09 21:12:56.128358	18.3152
13480	QF 2,21	ЗУ	China 5	048	2026-05-09 21:12:56.128358	20.7345
13481	QF 2,22	ЗУ	China 6	049	2026-05-09 21:12:56.128358	19.4737
13482	QF 2,23	ЗУ	China 7	050	2026-05-09 21:12:56.128358	9.8451
13483	QF 2,19	ЗУ	China 8	051	2026-05-09 21:12:56.128358	14.3115
13484	Q8	ЗУ	DIG	061	2026-05-09 21:12:59.755456	45.6883
13485	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:13:00.832977	21.316
13486	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:13:00.832977	8.6121
13487	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:13:00.832977	16.5553
13488	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:13:00.832977	9.1391
13489	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:13:00.832977	19.6149
13490	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:13:00.832977	18.6968
13491	TP3	ЗУ	CP-300 New	078	2026-05-09 21:13:05.046029	7.1179
13492	Q17	ЗУ	MO 9	071	2026-05-09 21:13:15.744062	0.6777
13493	Q20	ЗУ	MO 10	072	2026-05-09 21:13:15.744062	14.0227
13494	Q21	ЗУ	MO 11	073	2026-05-09 21:13:15.744062	0.5618
13495	Q22	ЗУ	MO 12	074	2026-05-09 21:13:15.744062	1.2073
13496	Q23	ЗУ	MO 13	075	2026-05-09 21:13:15.744062	0.9343
13497	Q24	ЗУ	MO 14	076	2026-05-09 21:13:15.744062	0.897
13498	Q25	ЗУ	MO 15	077	2026-05-09 21:13:15.744062	1.0324
13499	Q8	ЗУ	DIG	061	2026-05-09 21:13:34.768824	46.3383
13500	Q4	ЗУ	BG 1	062	2026-05-09 21:13:34.873891	21.556
13501	Q9	ЗУ	BG 2	063	2026-05-09 21:13:34.873891	32.7371
13502	TP3	ЗУ	CP-300 New	078	2026-05-09 21:13:35.059385	7.7154
13503	Q10	ЗУ	SM 2	064	2026-05-09 21:13:35.076855	19.4812
13504	Q11	ЗУ	SM 3	065	2026-05-09 21:13:35.076855	22.4774
13505	Q12	ЗУ	SM 4	066	2026-05-09 21:13:35.076855	1.0317
13506	Q13	ЗУ	SM 5	067	2026-05-09 21:13:35.076855	0.9027
13507	Q14	ЗУ	SM 6	068	2026-05-09 21:13:35.076855	1.9065
13508	Q15	ЗУ	SM 7	069	2026-05-09 21:13:35.076855	1.3143
13509	Q16	ЗУ	SM 8	070	2026-05-09 21:13:35.076855	2.441
13510	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:13:35.866918	20.541
13511	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:13:35.866918	8.5037
13512	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:13:35.866918	17.3033
13513	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:13:35.866918	7.9996
13514	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:13:35.866918	21.1105
13515	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:13:35.866918	19.119
13516	QF 1,20	ЗУ	China 1	044	2026-05-09 21:13:36.16127	12.3263
13517	QF 1,21	ЗУ	China 2	045	2026-05-09 21:13:36.16127	10.3171
13518	QF 1,22	ЗУ	China 3	046	2026-05-09 21:13:36.16127	14.5513
13519	QF 2,20	ЗУ	China 4	047	2026-05-09 21:13:36.16127	19.7027
13520	QF 2,21	ЗУ	China 5	048	2026-05-09 21:13:36.16127	20.2846
13521	QF 2,22	ЗУ	China 6	049	2026-05-09 21:13:36.16127	20.6945
13522	QF 2,23	ЗУ	China 7	050	2026-05-09 21:13:36.16127	9.9943
13523	QF 2,19	ЗУ	China 8	051	2026-05-09 21:13:36.16127	14.7536
13524	TP3	ЗУ	CP-300 New	078	2026-05-09 21:14:05.068211	7.2833
13525	Q17	ЗУ	MO 9	071	2026-05-09 21:14:05.77301	0.685
13526	Q20	ЗУ	MO 10	072	2026-05-09 21:14:05.77301	13.7749
13527	Q21	ЗУ	MO 11	073	2026-05-09 21:14:05.77301	1.2225
13528	Q22	ЗУ	MO 12	074	2026-05-09 21:14:05.77301	1.38
13529	Q23	ЗУ	MO 13	075	2026-05-09 21:14:05.77301	0.725
13530	Q24	ЗУ	MO 14	076	2026-05-09 21:14:05.77301	1.4739
13531	Q25	ЗУ	MO 15	077	2026-05-09 21:14:05.77301	1.3928
13532	Q8	ЗУ	DIG	061	2026-05-09 21:14:09.780838	47.7473
13533	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:14:10.89224	21.5736
13534	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:14:10.89224	9.3881
13535	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:14:10.89224	17.7692
13536	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:14:10.89224	9.0351
13537	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:14:10.89224	19.7844
13538	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:14:10.89224	18.7793
13539	QF 1,20	ЗУ	China 1	044	2026-05-09 21:14:16.199441	12.6212
13540	QF 1,21	ЗУ	China 2	045	2026-05-09 21:14:16.199441	11.1385
13541	QF 1,22	ЗУ	China 3	046	2026-05-09 21:14:16.199441	14.0543
13542	QF 2,20	ЗУ	China 4	047	2026-05-09 21:14:16.199441	19.8023
13543	QF 2,21	ЗУ	China 5	048	2026-05-09 21:14:16.199441	21.1144
13544	QF 2,22	ЗУ	China 6	049	2026-05-09 21:14:16.199441	20.4698
13545	QF 2,23	ЗУ	China 7	050	2026-05-09 21:14:16.199441	10.0636
13546	QF 2,19	ЗУ	China 8	051	2026-05-09 21:14:16.199441	15.8236
13547	Q4	ЗУ	BG 1	062	2026-05-09 21:14:19.887024	21.4956
13548	Q9	ЗУ	BG 2	063	2026-05-09 21:14:19.887024	33.6854
13549	Q10	ЗУ	SM 2	064	2026-05-09 21:14:20.104424	18.7049
13550	Q11	ЗУ	SM 3	065	2026-05-09 21:14:20.104424	21.8708
13551	Q12	ЗУ	SM 4	066	2026-05-09 21:14:20.104424	1.7492
13552	Q13	ЗУ	SM 5	067	2026-05-09 21:14:20.104424	1.8512
13553	Q14	ЗУ	SM 6	068	2026-05-09 21:14:20.104424	0.8038
13554	Q15	ЗУ	SM 7	069	2026-05-09 21:14:20.104424	1.812
13555	Q16	ЗУ	SM 8	070	2026-05-09 21:14:20.104424	2.8939
13556	TP3	ЗУ	CP-300 New	078	2026-05-09 21:14:35.106375	7.136
13557	Q8	ЗУ	DIG	061	2026-05-09 21:14:44.801809	47.9349
13558	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:14:45.934229	20.7514
13559	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:14:45.934229	8.6352
13560	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:14:45.934229	18.1241
13561	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:14:45.934229	8.2607
13562	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:14:45.934229	19.6323
13563	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:14:45.934229	19.7187
13564	Q17	ЗУ	MO 9	071	2026-05-09 21:14:55.821286	1.1931
13565	Q20	ЗУ	MO 10	072	2026-05-09 21:14:55.821286	13.7597
13566	Q21	ЗУ	MO 11	073	2026-05-09 21:14:55.821286	1.0269
13567	Q22	ЗУ	MO 12	074	2026-05-09 21:14:55.821286	0.9469
13568	Q23	ЗУ	MO 13	075	2026-05-09 21:14:55.821286	1.148
13569	Q24	ЗУ	MO 14	076	2026-05-09 21:14:55.821286	1.2059
13570	Q25	ЗУ	MO 15	077	2026-05-09 21:14:55.821286	1.0102
13571	QF 1,20	ЗУ	China 1	044	2026-05-09 21:14:56.244429	11.3865
13572	QF 1,21	ЗУ	China 2	045	2026-05-09 21:14:56.244429	10.4063
13573	QF 1,22	ЗУ	China 3	046	2026-05-09 21:14:56.244429	14.0973
13574	QF 2,20	ЗУ	China 4	047	2026-05-09 21:14:56.244429	19.4678
13575	QF 2,21	ЗУ	China 5	048	2026-05-09 21:14:56.244429	21.3358
13576	QF 2,22	ЗУ	China 6	049	2026-05-09 21:14:56.244429	19.4078
13577	QF 2,23	ЗУ	China 7	050	2026-05-09 21:14:56.244429	10.2958
13578	QF 2,19	ЗУ	China 8	051	2026-05-09 21:14:56.244429	14.864
13579	Q4	ЗУ	BG 1	062	2026-05-09 21:15:04.935934	21.712
13580	Q9	ЗУ	BG 2	063	2026-05-09 21:15:04.935934	32.4995
13581	Q10	ЗУ	SM 2	064	2026-05-09 21:15:05.140819	18.9291
13582	TP3	ЗУ	CP-300 New	078	2026-05-09 21:15:05.143422	7.0419
13583	Q11	ЗУ	SM 3	065	2026-05-09 21:15:05.140819	21.6082
13584	Q12	ЗУ	SM 4	066	2026-05-09 21:15:05.140819	0.9794
13585	Q13	ЗУ	SM 5	067	2026-05-09 21:15:05.140819	0.7902
13586	Q14	ЗУ	SM 6	068	2026-05-09 21:15:05.140819	1.598
13587	Q15	ЗУ	SM 7	069	2026-05-09 21:15:05.140819	1.7262
13588	Q16	ЗУ	SM 8	070	2026-05-09 21:15:05.140819	2.3184
15903	Q14	ЗУ	SM 6	068	2026-05-10 01:05:22.641985	1.6712
15905	Q16	ЗУ	SM 8	070	2026-05-10 01:05:22.641985	2.5521
13590	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:15:20.96404	20.5535
13591	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:15:20.96404	9.7607
13592	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:15:20.96404	17.4022
13593	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:15:20.96404	9.1633
13594	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:15:20.96404	20.5508
13595	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:15:20.96404	19.9449
13596	TP3	ЗУ	CP-300 New	078	2026-05-09 21:15:35.16829	8.1136
13597	QF 1,20	ЗУ	China 1	044	2026-05-09 21:15:36.278533	11.6684
13598	QF 1,21	ЗУ	China 2	045	2026-05-09 21:15:36.278533	11.423
13599	QF 1,22	ЗУ	China 3	046	2026-05-09 21:15:36.278533	14.2037
13600	QF 2,20	ЗУ	China 4	047	2026-05-09 21:15:36.278533	19.7991
13601	QF 2,21	ЗУ	China 5	048	2026-05-09 21:15:36.278533	21.3164
13602	QF 2,22	ЗУ	China 6	049	2026-05-09 21:15:36.278533	19.541
13603	QF 2,23	ЗУ	China 7	050	2026-05-09 21:15:36.278533	10.3563
13604	QF 2,19	ЗУ	China 8	051	2026-05-09 21:15:36.278533	15.3044
13605	Q17	ЗУ	MO 9	071	2026-05-09 21:15:45.85725	0.9439
13606	Q20	ЗУ	MO 10	072	2026-05-09 21:15:45.85725	13.4771
13607	Q21	ЗУ	MO 11	073	2026-05-09 21:15:45.85725	0.7063
13608	Q22	ЗУ	MO 12	074	2026-05-09 21:15:45.85725	1.2806
13609	Q23	ЗУ	MO 13	075	2026-05-09 21:15:45.85725	0.7128
13610	Q24	ЗУ	MO 14	076	2026-05-09 21:15:45.85725	1.2448
13611	Q25	ЗУ	MO 15	077	2026-05-09 21:15:45.85725	1.0263
13612	Q4	ЗУ	BG 1	062	2026-05-09 21:15:49.982669	21.8091
13613	Q9	ЗУ	BG 2	063	2026-05-09 21:15:49.982669	33.4101
13614	Q10	ЗУ	SM 2	064	2026-05-09 21:15:50.197707	19.4048
13615	Q11	ЗУ	SM 3	065	2026-05-09 21:15:50.197707	21.9208
13616	Q12	ЗУ	SM 4	066	2026-05-09 21:15:50.197707	1.0786
13617	Q13	ЗУ	SM 5	067	2026-05-09 21:15:50.197707	1.3219
13618	Q14	ЗУ	SM 6	068	2026-05-09 21:15:50.197707	1.6133
13619	Q15	ЗУ	SM 7	069	2026-05-09 21:15:50.197707	1.7256
13620	Q16	ЗУ	SM 8	070	2026-05-09 21:15:50.197707	3.2085
13621	Q8	ЗУ	DIG	061	2026-05-09 21:15:54.84718	47.4623
13622	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:15:56.009549	21.3028
13623	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:15:56.009549	8.7608
13624	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:15:56.009549	17.0999
13625	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:15:56.009549	7.7542
13626	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:15:56.009549	20.8893
13627	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:15:56.009549	19.8113
13628	TP3	ЗУ	CP-300 New	078	2026-05-09 21:16:05.180547	7.3545
13629	QF 1,20	ЗУ	China 1	044	2026-05-09 21:16:16.337426	12.2433
13630	QF 1,21	ЗУ	China 2	045	2026-05-09 21:16:16.337426	10.2519
13631	QF 1,22	ЗУ	China 3	046	2026-05-09 21:16:16.337426	13.8314
13632	QF 2,20	ЗУ	China 4	047	2026-05-09 21:16:16.337426	18.8235
13633	QF 2,21	ЗУ	China 5	048	2026-05-09 21:16:16.337426	20.4773
13634	QF 2,22	ЗУ	China 6	049	2026-05-09 21:16:16.337426	20.6603
13635	QF 2,23	ЗУ	China 7	050	2026-05-09 21:16:16.337426	9.9855
13636	QF 2,19	ЗУ	China 8	051	2026-05-09 21:16:16.337426	14.3048
13637	Q8	ЗУ	DIG	061	2026-05-09 21:16:29.876598	47.1293
13638	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:16:31.050977	20.8566
13639	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:16:31.050977	9.492
13640	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:16:31.050977	17.075
13641	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:16:31.050977	8.1856
13642	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:16:31.050977	19.7106
13643	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:16:31.050977	20.2385
13644	Q4	ЗУ	BG 1	062	2026-05-09 21:16:35.035304	21.7792
13645	Q9	ЗУ	BG 2	063	2026-05-09 21:16:35.035304	32.7403
13646	TP3	ЗУ	CP-300 New	078	2026-05-09 21:16:35.194883	7.8296
13647	Q10	ЗУ	SM 2	064	2026-05-09 21:16:35.248566	18.4894
13648	Q11	ЗУ	SM 3	065	2026-05-09 21:16:35.248566	21.7435
13649	Q12	ЗУ	SM 4	066	2026-05-09 21:16:35.248566	1.7854
13650	Q13	ЗУ	SM 5	067	2026-05-09 21:16:35.248566	1.1699
13651	Q14	ЗУ	SM 6	068	2026-05-09 21:16:35.248566	1.7102
13652	Q15	ЗУ	SM 7	069	2026-05-09 21:16:35.248566	0.8721
13653	Q16	ЗУ	SM 8	070	2026-05-09 21:16:35.248566	3.4629
13654	Q17	ЗУ	MO 9	071	2026-05-09 21:16:35.902762	0.8828
13655	Q20	ЗУ	MO 10	072	2026-05-09 21:16:35.902762	13.0765
13656	Q21	ЗУ	MO 11	073	2026-05-09 21:16:35.902762	1.0494
13657	Q22	ЗУ	MO 12	074	2026-05-09 21:16:35.902762	0.5981
13658	Q23	ЗУ	MO 13	075	2026-05-09 21:16:35.902762	1.3738
13659	Q24	ЗУ	MO 14	076	2026-05-09 21:16:35.902762	1.0622
13660	Q25	ЗУ	MO 15	077	2026-05-09 21:16:35.902762	0.5873
13661	QF 1,20	ЗУ	China 1	044	2026-05-09 21:16:56.368534	12.3711
13662	QF 1,21	ЗУ	China 2	045	2026-05-09 21:16:56.368534	10.3405
13663	QF 1,22	ЗУ	China 3	046	2026-05-09 21:16:56.368534	14.2405
13664	QF 2,20	ЗУ	China 4	047	2026-05-09 21:16:56.368534	18.2991
13665	QF 2,21	ЗУ	China 5	048	2026-05-09 21:16:56.368534	20.4452
13666	QF 2,22	ЗУ	China 6	049	2026-05-09 21:16:56.368534	19.6326
13667	QF 2,23	ЗУ	China 7	050	2026-05-09 21:16:56.368534	9.8202
13668	QF 2,19	ЗУ	China 8	051	2026-05-09 21:16:56.368534	15.0524
13669	Q8	ЗУ	DIG	061	2026-05-09 21:17:04.939698	46.86
13670	TP3	ЗУ	CP-300 New	078	2026-05-09 21:17:05.211886	8.1318
13671	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:17:06.103388	20.895
13672	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:17:06.103388	8.5149
13673	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:17:06.103388	16.7159
13674	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:17:06.103388	8.3605
13675	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:17:06.103388	20.6814
13676	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:17:06.103388	18.8102
13677	Q4	ЗУ	BG 1	062	2026-05-09 21:17:20.066248	21.4491
13678	Q9	ЗУ	BG 2	063	2026-05-09 21:17:20.066248	32.6054
13679	Q10	ЗУ	SM 2	064	2026-05-09 21:17:20.283411	18.5341
13680	Q11	ЗУ	SM 3	065	2026-05-09 21:17:20.283411	21.7712
13681	Q12	ЗУ	SM 4	066	2026-05-09 21:17:20.283411	1.5763
13682	Q13	ЗУ	SM 5	067	2026-05-09 21:17:20.283411	0.9436
13683	Q14	ЗУ	SM 6	068	2026-05-09 21:17:20.283411	1.0998
13684	Q15	ЗУ	SM 7	069	2026-05-09 21:17:20.283411	1.0793
13685	Q16	ЗУ	SM 8	070	2026-05-09 21:17:20.283411	2.6363
13686	Q17	ЗУ	MO 9	071	2026-05-09 21:17:25.947523	0.5642
13687	Q20	ЗУ	MO 10	072	2026-05-09 21:17:25.947523	13.1548
13688	Q21	ЗУ	MO 11	073	2026-05-09 21:17:25.947523	0.9104
13689	Q22	ЗУ	MO 12	074	2026-05-09 21:17:25.947523	1.4427
13690	Q23	ЗУ	MO 13	075	2026-05-09 21:17:25.947523	1.264
13691	Q24	ЗУ	MO 14	076	2026-05-09 21:17:25.947523	0.6669
13692	Q25	ЗУ	MO 15	077	2026-05-09 21:17:25.947523	1.2679
13693	TP3	ЗУ	CP-300 New	078	2026-05-09 21:17:35.225502	7.6516
13694	QF 1,20	ЗУ	China 1	044	2026-05-09 21:17:36.421256	11.8626
13695	QF 1,21	ЗУ	China 2	045	2026-05-09 21:17:36.421256	11.7321
13696	QF 1,22	ЗУ	China 3	046	2026-05-09 21:17:36.421256	13.9299
13697	QF 2,20	ЗУ	China 4	047	2026-05-09 21:17:36.421256	19.0946
13698	QF 2,21	ЗУ	China 5	048	2026-05-09 21:17:36.421256	20.8176
13699	QF 2,22	ЗУ	China 6	049	2026-05-09 21:17:36.421256	19.8973
13700	QF 2,23	ЗУ	China 7	050	2026-05-09 21:17:36.421256	9.4309
13701	QF 2,19	ЗУ	China 8	051	2026-05-09 21:17:36.421256	14.7267
13702	Q8	ЗУ	DIG	061	2026-05-09 21:17:39.98082	47.5527
13703	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:17:41.13669	21.1841
13704	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:17:41.13669	9.2567
13705	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:17:41.13669	17.4535
13706	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:17:41.13669	8.383
13707	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:17:41.13669	20.6325
13708	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:17:41.13669	18.6612
13709	Q4	ЗУ	BG 1	062	2026-05-09 21:18:05.097405	20.6573
13710	Q9	ЗУ	BG 2	063	2026-05-09 21:18:05.097405	32.6667
13711	TP3	ЗУ	CP-300 New	078	2026-05-09 21:18:05.250321	7.5604
13712	Q10	ЗУ	SM 2	064	2026-05-09 21:18:05.327151	18.5965
13713	Q11	ЗУ	SM 3	065	2026-05-09 21:18:05.327151	21.4238
13714	Q12	ЗУ	SM 4	066	2026-05-09 21:18:05.327151	0.87
13715	Q13	ЗУ	SM 5	067	2026-05-09 21:18:05.327151	1.7335
13716	Q14	ЗУ	SM 6	068	2026-05-09 21:18:05.327151	1.9011
13717	Q15	ЗУ	SM 7	069	2026-05-09 21:18:05.327151	1.0035
13718	Q16	ЗУ	SM 8	070	2026-05-09 21:18:05.327151	3.1088
13719	Q8	ЗУ	DIG	061	2026-05-09 21:18:14.995375	47.0301
13720	Q17	ЗУ	MO 9	071	2026-05-09 21:18:15.993157	0.5531
13721	Q20	ЗУ	MO 10	072	2026-05-09 21:18:15.993157	14.0042
13722	Q21	ЗУ	MO 11	073	2026-05-09 21:18:15.993157	0.7472
13723	Q22	ЗУ	MO 12	074	2026-05-09 21:18:15.993157	1.18
13724	Q23	ЗУ	MO 13	075	2026-05-09 21:18:15.993157	0.793
13725	Q24	ЗУ	MO 14	076	2026-05-09 21:18:15.993157	0.709
13726	Q25	ЗУ	MO 15	077	2026-05-09 21:18:15.993157	1.2609
13727	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:18:16.17527	21.4975
13728	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:18:16.17527	8.9972
13729	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:18:16.17527	16.7557
13730	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:18:16.17527	8.8993
13731	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:18:16.17527	19.617
13732	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:18:16.17527	18.9887
13733	QF 1,20	ЗУ	China 1	044	2026-05-09 21:18:16.467	12.1652
13734	QF 1,21	ЗУ	China 2	045	2026-05-09 21:18:16.467	10.8493
13735	QF 1,22	ЗУ	China 3	046	2026-05-09 21:18:16.467	13.9749
13736	QF 2,20	ЗУ	China 4	047	2026-05-09 21:18:16.467	18.8445
13737	QF 2,21	ЗУ	China 5	048	2026-05-09 21:18:16.467	20.7338
13738	QF 2,22	ЗУ	China 6	049	2026-05-09 21:18:16.467	19.3342
13739	QF 2,23	ЗУ	China 7	050	2026-05-09 21:18:16.467	10.7348
13740	QF 2,19	ЗУ	China 8	051	2026-05-09 21:18:16.467	15.21
13741	TP3	ЗУ	CP-300 New	078	2026-05-09 21:18:35.265057	6.6977
15906	Q8	ЗУ	DIG	061	2026-05-10 01:05:32.577285	46.9808
15908	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:05:34.64882	8.242
15910	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:05:34.64882	7.8035
15912	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:05:34.64882	18.2958
15914	QF 1,20	ЗУ	China 1	044	2026-05-10 01:05:40.615484	12.3398
15916	QF 1,22	ЗУ	China 3	046	2026-05-10 01:05:40.615484	14.4046
15918	QF 2,21	ЗУ	China 5	048	2026-05-10 01:05:40.615484	21.4619
15920	QF 2,23	ЗУ	China 7	050	2026-05-10 01:05:40.615484	9.5166
15923	Q20	ЗУ	MO 10	072	2026-05-10 01:05:48.547626	13.2691
15925	Q22	ЗУ	MO 12	074	2026-05-10 01:05:48.547626	0.5582
15927	Q24	ЗУ	MO 14	076	2026-05-10 01:05:48.547626	0.6406
15930	Q9	ЗУ	BG 2	063	2026-05-10 01:06:07.381869	33.2991
15932	Q8	ЗУ	DIG	061	2026-05-10 01:06:07.629237	46.0947
15934	Q11	ЗУ	SM 3	065	2026-05-10 01:06:07.692977	21.2335
15936	Q13	ЗУ	SM 5	067	2026-05-10 01:06:07.692977	0.6876
15938	Q15	ЗУ	SM 7	069	2026-05-10 01:06:07.692977	1.1864
15940	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:06:09.721806	20.4351
15942	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:06:09.721806	16.7359
15944	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:06:09.721806	20.3202
15946	QF 1,20	ЗУ	China 1	044	2026-05-10 01:06:20.675844	11.8606
15948	QF 1,22	ЗУ	China 3	046	2026-05-10 01:06:20.675844	14.4567
15950	QF 2,21	ЗУ	China 5	048	2026-05-10 01:06:20.675844	21.0637
15952	QF 2,23	ЗУ	China 7	050	2026-05-10 01:06:20.675844	10.3703
15955	Q17	ЗУ	MO 9	071	2026-05-10 01:06:38.593847	0.909
15957	Q21	ЗУ	MO 11	073	2026-05-10 01:06:38.593847	1.1566
15959	Q23	ЗУ	MO 13	075	2026-05-10 01:06:38.593847	0.7741
15961	Q25	ЗУ	MO 15	077	2026-05-10 01:06:38.593847	1.2966
15964	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:06:44.755119	9.6895
15966	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:06:44.755119	7.3897
15968	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:06:44.755119	18.469
15970	Q9	ЗУ	BG 2	063	2026-05-10 01:06:52.425726	33.3589
15972	Q11	ЗУ	SM 3	065	2026-05-10 01:06:52.729402	21.678
15974	Q13	ЗУ	SM 5	067	2026-05-10 01:06:52.729402	0.867
15976	Q15	ЗУ	SM 7	069	2026-05-10 01:06:52.729402	0.5035
15978	QF 1,20	ЗУ	China 1	044	2026-05-10 01:07:00.76157	12.3382
15980	QF 1,22	ЗУ	China 3	046	2026-05-10 01:07:00.76157	13.2664
15982	QF 2,21	ЗУ	China 5	048	2026-05-10 01:07:00.76157	21.4616
15984	QF 2,23	ЗУ	China 7	050	2026-05-10 01:07:00.76157	10.142
15987	Q8	ЗУ	DIG	061	2026-05-10 01:07:17.676092	46.3642
15989	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:07:19.850199	8.9222
15991	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:07:19.850199	8.2019
15993	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:07:19.850199	18.2182
15994	Q17	ЗУ	MO 9	071	2026-05-10 01:07:28.634277	1.0181
15996	Q21	ЗУ	MO 11	073	2026-05-10 01:07:28.634277	0.857
15998	Q23	ЗУ	MO 13	075	2026-05-10 01:07:28.634277	1.1626
16000	Q25	ЗУ	MO 15	077	2026-05-10 01:07:28.634277	0.7931
16002	Q9	ЗУ	BG 2	063	2026-05-10 01:07:37.462496	32.832
16004	Q10	ЗУ	SM 2	064	2026-05-10 01:07:37.777736	18.3492
16006	Q12	ЗУ	SM 4	066	2026-05-10 01:07:37.777736	0.5254
16008	Q14	ЗУ	SM 6	068	2026-05-10 01:07:37.777736	0.8509
16010	Q16	ЗУ	SM 8	070	2026-05-10 01:07:37.777736	2.2455
16012	QF 1,21	ЗУ	China 2	045	2026-05-10 01:07:40.855106	10.0857
13743	Q4	ЗУ	BG 1	062	2026-05-09 21:18:50.120406	20.831
13744	Q9	ЗУ	BG 2	063	2026-05-09 21:18:50.120406	33.2805
13745	Q10	ЗУ	SM 2	064	2026-05-09 21:18:50.360633	18.7475
13746	Q11	ЗУ	SM 3	065	2026-05-09 21:18:50.360633	21.9585
13747	Q12	ЗУ	SM 4	066	2026-05-09 21:18:50.360633	1.7922
13748	Q13	ЗУ	SM 5	067	2026-05-09 21:18:50.360633	1.4815
13749	Q14	ЗУ	SM 6	068	2026-05-09 21:18:50.360633	1.7797
13750	Q15	ЗУ	SM 7	069	2026-05-09 21:18:50.360633	1.4529
13751	Q16	ЗУ	SM 8	070	2026-05-09 21:18:50.360633	3.3095
13752	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:18:51.208154	21.3662
13753	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:18:51.208154	9.6217
13754	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:18:51.208154	17.7462
13755	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:18:51.208154	8.8306
13756	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:18:51.208154	19.7393
13757	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:18:51.208154	19.4755
13758	QF 1,20	ЗУ	China 1	044	2026-05-09 21:18:56.502841	11.6298
13759	QF 1,21	ЗУ	China 2	045	2026-05-09 21:18:56.502841	11.5679
13760	QF 1,22	ЗУ	China 3	046	2026-05-09 21:18:56.502841	13.7711
13761	QF 2,20	ЗУ	China 4	047	2026-05-09 21:18:56.502841	19.1416
13762	QF 2,21	ЗУ	China 5	048	2026-05-09 21:18:56.502841	21.4408
13763	QF 2,22	ЗУ	China 6	049	2026-05-09 21:18:56.502841	19.2468
13764	QF 2,23	ЗУ	China 7	050	2026-05-09 21:18:56.502841	10.4988
13765	QF 2,19	ЗУ	China 8	051	2026-05-09 21:18:56.502841	14.6822
13766	TP3	ЗУ	CP-300 New	078	2026-05-09 21:19:05.274436	7.8356
13767	Q17	ЗУ	MO 9	071	2026-05-09 21:19:06.024865	1.2032
13768	Q20	ЗУ	MO 10	072	2026-05-09 21:19:06.024865	13.3045
13769	Q21	ЗУ	MO 11	073	2026-05-09 21:19:06.024865	0.8095
13770	Q22	ЗУ	MO 12	074	2026-05-09 21:19:06.024865	1.0754
13771	Q23	ЗУ	MO 13	075	2026-05-09 21:19:06.024865	1.2383
13772	Q24	ЗУ	MO 14	076	2026-05-09 21:19:06.024865	0.7288
13773	Q25	ЗУ	MO 15	077	2026-05-09 21:19:06.024865	1.0947
13774	Q8	ЗУ	DIG	061	2026-05-09 21:19:25.017906	47.4622
13775	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:19:26.231979	21.3203
13776	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:19:26.231979	9.6353
13777	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:19:26.231979	17.6937
13778	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:19:26.231979	7.6325
13779	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:19:26.231979	19.5354
13780	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:19:26.231979	19.1236
13781	Q4	ЗУ	BG 1	062	2026-05-09 21:19:35.140831	20.9867
13782	Q9	ЗУ	BG 2	063	2026-05-09 21:19:35.140831	32.9974
13783	TP3	ЗУ	CP-300 New	078	2026-05-09 21:19:35.291098	7.358
13784	Q10	ЗУ	SM 2	064	2026-05-09 21:19:35.385004	19.2021
13785	Q11	ЗУ	SM 3	065	2026-05-09 21:19:35.385004	22.1038
13786	Q12	ЗУ	SM 4	066	2026-05-09 21:19:35.385004	1.7272
13787	Q13	ЗУ	SM 5	067	2026-05-09 21:19:35.385004	1.1145
13788	Q14	ЗУ	SM 6	068	2026-05-09 21:19:35.385004	1.9281
13789	Q15	ЗУ	SM 7	069	2026-05-09 21:19:35.385004	0.946
13790	Q16	ЗУ	SM 8	070	2026-05-09 21:19:35.385004	3.3148
13791	QF 1,20	ЗУ	China 1	044	2026-05-09 21:19:36.564371	12.1011
13792	QF 1,21	ЗУ	China 2	045	2026-05-09 21:19:36.564371	10.7952
13793	QF 1,22	ЗУ	China 3	046	2026-05-09 21:19:36.564371	14.378
13794	QF 2,20	ЗУ	China 4	047	2026-05-09 21:19:36.564371	19.3396
13795	QF 2,21	ЗУ	China 5	048	2026-05-09 21:19:36.564371	21.5782
13796	QF 2,22	ЗУ	China 6	049	2026-05-09 21:19:36.564371	19.375
13797	QF 2,23	ЗУ	China 7	050	2026-05-09 21:19:36.564371	10.4883
13798	QF 2,19	ЗУ	China 8	051	2026-05-09 21:19:36.564371	15.5968
13799	Q17	ЗУ	MO 9	071	2026-05-09 21:19:56.065271	1.1665
13800	Q20	ЗУ	MO 10	072	2026-05-09 21:19:56.065271	13.9607
13801	Q21	ЗУ	MO 11	073	2026-05-09 21:19:56.065271	0.6169
13802	Q22	ЗУ	MO 12	074	2026-05-09 21:19:56.065271	0.7099
13803	Q23	ЗУ	MO 13	075	2026-05-09 21:19:56.065271	1.0648
13804	Q24	ЗУ	MO 14	076	2026-05-09 21:19:56.065271	1.5008
13805	Q25	ЗУ	MO 15	077	2026-05-09 21:19:56.065271	0.6971
13806	Q8	ЗУ	DIG	061	2026-05-09 21:20:00.029223	47.9089
13807	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:20:01.265436	21.6581
13808	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:20:01.265436	9.7329
13809	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:20:01.265436	16.8337
13810	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:20:01.265436	8.1235
13811	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:20:01.265436	21.023
13812	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:20:01.265436	18.9749
13813	TP3	ЗУ	CP-300 New	078	2026-05-09 21:20:05.304794	8.1569
13814	QF 1,20	ЗУ	China 1	044	2026-05-09 21:20:16.60283	12.1768
13815	QF 1,21	ЗУ	China 2	045	2026-05-09 21:20:16.60283	10.4749
13816	QF 1,22	ЗУ	China 3	046	2026-05-09 21:20:16.60283	14.1438
13817	QF 2,20	ЗУ	China 4	047	2026-05-09 21:20:16.60283	18.5894
13818	QF 2,21	ЗУ	China 5	048	2026-05-09 21:20:16.60283	20.9967
13819	QF 2,22	ЗУ	China 6	049	2026-05-09 21:20:16.60283	20.0064
13820	QF 2,23	ЗУ	China 7	050	2026-05-09 21:20:16.60283	10.1936
13821	QF 2,19	ЗУ	China 8	051	2026-05-09 21:20:16.60283	14.9523
13822	Q4	ЗУ	BG 1	062	2026-05-09 21:20:20.199728	20.7209
13823	Q9	ЗУ	BG 2	063	2026-05-09 21:20:20.199728	32.6547
13824	Q10	ЗУ	SM 2	064	2026-05-09 21:20:20.428396	19.1461
13825	Q11	ЗУ	SM 3	065	2026-05-09 21:20:20.428396	22.1394
13826	Q12	ЗУ	SM 4	066	2026-05-09 21:20:20.428396	1.0475
13827	Q13	ЗУ	SM 5	067	2026-05-09 21:20:20.428396	1.6455
13828	Q14	ЗУ	SM 6	068	2026-05-09 21:20:20.428396	1.468
13829	Q15	ЗУ	SM 7	069	2026-05-09 21:20:20.428396	1.3125
13830	Q16	ЗУ	SM 8	070	2026-05-09 21:20:20.428396	2.9777
13831	Q8	ЗУ	DIG	061	2026-05-09 21:20:35.047583	46.5179
13832	TP3	ЗУ	CP-300 New	078	2026-05-09 21:20:35.326665	7.7268
13833	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:20:36.306989	21.4276
13834	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:20:36.306989	8.4375
13835	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:20:36.306989	16.8491
13836	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:20:36.306989	8.3541
13837	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:20:36.306989	20.7762
13838	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:20:36.306989	20.0323
13839	Q17	ЗУ	MO 9	071	2026-05-09 21:20:46.117243	0.8345
13840	Q20	ЗУ	MO 10	072	2026-05-09 21:20:46.117243	13.4029
13841	Q21	ЗУ	MO 11	073	2026-05-09 21:20:46.117243	1.508
13842	Q22	ЗУ	MO 12	074	2026-05-09 21:20:46.117243	1.0644
13843	Q23	ЗУ	MO 13	075	2026-05-09 21:20:46.117243	1.2475
13844	Q24	ЗУ	MO 14	076	2026-05-09 21:20:46.117243	0.7972
13845	Q25	ЗУ	MO 15	077	2026-05-09 21:20:46.117243	0.8641
13846	QF 1,20	ЗУ	China 1	044	2026-05-09 21:20:56.649684	11.977
13847	QF 1,21	ЗУ	China 2	045	2026-05-09 21:20:56.649684	11.5175
13848	QF 1,22	ЗУ	China 3	046	2026-05-09 21:20:56.649684	14.6876
13849	QF 2,20	ЗУ	China 4	047	2026-05-09 21:20:56.649684	18.5018
13850	QF 2,21	ЗУ	China 5	048	2026-05-09 21:20:56.649684	21.554
13851	QF 2,22	ЗУ	China 6	049	2026-05-09 21:20:56.649684	20.444
13852	QF 2,23	ЗУ	China 7	050	2026-05-09 21:20:56.649684	9.2653
13853	QF 2,19	ЗУ	China 8	051	2026-05-09 21:20:56.649684	14.2093
13854	Q4	ЗУ	BG 1	062	2026-05-09 21:21:05.229355	21.6778
13855	Q9	ЗУ	BG 2	063	2026-05-09 21:21:05.229355	32.4714
13856	TP3	ЗУ	CP-300 New	078	2026-05-09 21:21:05.355032	7.715
13857	Q10	ЗУ	SM 2	064	2026-05-09 21:21:05.466647	18.3393
13858	Q11	ЗУ	SM 3	065	2026-05-09 21:21:05.466647	21.88
13859	Q12	ЗУ	SM 4	066	2026-05-09 21:21:05.466647	1.7635
13860	Q13	ЗУ	SM 5	067	2026-05-09 21:21:05.466647	1.545
13861	Q14	ЗУ	SM 6	068	2026-05-09 21:21:05.466647	1.0299
13862	Q15	ЗУ	SM 7	069	2026-05-09 21:21:05.466647	0.8017
13863	Q16	ЗУ	SM 8	070	2026-05-09 21:21:05.466647	2.9806
13864	Q8	ЗУ	DIG	061	2026-05-09 21:21:10.114505	47.5261
13865	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:21:11.348145	20.5042
13866	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:21:11.348145	9.5104
13867	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:21:11.348145	17.3536
13868	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:21:11.348145	8.4572
13869	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:21:11.348145	21.0413
13870	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:21:11.348145	19.0643
13871	TP3	ЗУ	CP-300 New	078	2026-05-09 21:21:35.375053	6.3583
13872	Q17	ЗУ	MO 9	071	2026-05-09 21:21:36.157779	0.6339
13873	Q20	ЗУ	MO 10	072	2026-05-09 21:21:36.157779	13.6351
13874	Q21	ЗУ	MO 11	073	2026-05-09 21:21:36.157779	0.584
13875	Q22	ЗУ	MO 12	074	2026-05-09 21:21:36.157779	0.8595
13876	Q23	ЗУ	MO 13	075	2026-05-09 21:21:36.157779	0.9694
13877	Q24	ЗУ	MO 14	076	2026-05-09 21:21:36.157779	1.1145
13878	Q25	ЗУ	MO 15	077	2026-05-09 21:21:36.157779	0.5649
13879	QF 1,20	ЗУ	China 1	044	2026-05-09 21:21:36.701427	12.2513
13880	QF 1,21	ЗУ	China 2	045	2026-05-09 21:21:36.701427	11.5049
13881	QF 1,22	ЗУ	China 3	046	2026-05-09 21:21:36.701427	14.5249
13882	QF 2,20	ЗУ	China 4	047	2026-05-09 21:21:36.701427	19.7801
13883	QF 2,21	ЗУ	China 5	048	2026-05-09 21:21:36.701427	21.0625
13884	QF 2,22	ЗУ	China 6	049	2026-05-09 21:21:36.701427	20.495
13885	QF 2,23	ЗУ	China 7	050	2026-05-09 21:21:36.701427	9.6401
13886	QF 2,19	ЗУ	China 8	051	2026-05-09 21:21:36.701427	14.2784
13887	Q8	ЗУ	DIG	061	2026-05-09 21:21:45.153826	46.8182
13888	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:21:46.394433	21.7081
13889	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:21:46.394433	8.9323
13890	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:21:46.394433	18.1441
13891	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:21:46.394433	8.5626
13892	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:21:46.394433	20.229
13893	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:21:46.394433	18.6466
13894	Q4	ЗУ	BG 1	062	2026-05-09 21:21:50.252628	21.7836
13895	Q9	ЗУ	BG 2	063	2026-05-09 21:21:50.252628	32.8319
13896	Q10	ЗУ	SM 2	064	2026-05-09 21:21:50.49825	19.2923
13897	Q11	ЗУ	SM 3	065	2026-05-09 21:21:50.49825	21.5023
13898	Q12	ЗУ	SM 4	066	2026-05-09 21:21:50.49825	0.9428
13899	Q13	ЗУ	SM 5	067	2026-05-09 21:21:50.49825	1.2248
13900	Q14	ЗУ	SM 6	068	2026-05-09 21:21:50.49825	0.8799
13901	Q15	ЗУ	SM 7	069	2026-05-09 21:21:50.49825	1.8723
13902	Q16	ЗУ	SM 8	070	2026-05-09 21:21:50.49825	3.3705
13903	TP3	ЗУ	CP-300 New	078	2026-05-09 21:22:05.41618	7.5384
13904	QF 1,20	ЗУ	China 1	044	2026-05-09 21:22:16.741099	11.6018
13905	QF 1,21	ЗУ	China 2	045	2026-05-09 21:22:16.741099	11.5578
13906	QF 1,22	ЗУ	China 3	046	2026-05-09 21:22:16.741099	13.9865
13907	QF 2,20	ЗУ	China 4	047	2026-05-09 21:22:16.741099	18.4771
13908	QF 2,21	ЗУ	China 5	048	2026-05-09 21:22:16.741099	20.4965
13909	QF 2,22	ЗУ	China 6	049	2026-05-09 21:22:16.741099	19.4966
13910	QF 2,23	ЗУ	China 7	050	2026-05-09 21:22:16.741099	10.4486
13911	QF 2,19	ЗУ	China 8	051	2026-05-09 21:22:16.741099	14.8103
13912	Q8	ЗУ	DIG	061	2026-05-09 21:22:20.177534	46.7331
13913	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:22:21.434366	21.9422
13914	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:22:21.434366	9.2596
13915	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:22:21.434366	17.3152
13916	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:22:21.434366	7.5295
13917	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:22:21.434366	19.4202
13918	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:22:21.434366	18.8179
13919	Q17	ЗУ	MO 9	071	2026-05-09 21:22:26.204484	0.6675
13920	Q20	ЗУ	MO 10	072	2026-05-09 21:22:26.204484	13.9982
13921	Q21	ЗУ	MO 11	073	2026-05-09 21:22:26.204484	0.8278
13922	Q22	ЗУ	MO 12	074	2026-05-09 21:22:26.204484	1.2606
13923	Q23	ЗУ	MO 13	075	2026-05-09 21:22:26.204484	0.9765
13924	Q24	ЗУ	MO 14	076	2026-05-09 21:22:26.204484	0.5456
13925	Q25	ЗУ	MO 15	077	2026-05-09 21:22:26.204484	1.4391
13926	Q4	ЗУ	BG 1	062	2026-05-09 21:22:35.2688	20.4044
13927	Q9	ЗУ	BG 2	063	2026-05-09 21:22:35.2688	32.904
13928	TP3	ЗУ	CP-300 New	078	2026-05-09 21:22:35.435273	7.2222
13929	Q10	ЗУ	SM 2	064	2026-05-09 21:22:35.526252	19.0987
13930	Q11	ЗУ	SM 3	065	2026-05-09 21:22:35.526252	22.4037
13931	Q12	ЗУ	SM 4	066	2026-05-09 21:22:35.526252	1.5242
13932	Q13	ЗУ	SM 5	067	2026-05-09 21:22:35.526252	1.4548
13933	Q14	ЗУ	SM 6	068	2026-05-09 21:22:35.526252	1.8595
13934	Q15	ЗУ	SM 7	069	2026-05-09 21:22:35.526252	1.7296
13935	Q16	ЗУ	SM 8	070	2026-05-09 21:22:35.526252	2.7086
16001	Q4	ЗУ	BG 1	062	2026-05-10 01:07:37.462496	21.0973
16003	TP3	ЗУ	CP-300 New	078	2026-05-10 01:07:37.761798	6.0806
16005	Q11	ЗУ	SM 3	065	2026-05-10 01:07:37.777736	21.3213
16007	Q13	ЗУ	SM 5	067	2026-05-10 01:07:37.777736	0.6746
16009	Q15	ЗУ	SM 7	069	2026-05-10 01:07:37.777736	0.8388
16011	QF 1,20	ЗУ	China 1	044	2026-05-10 01:07:40.855106	11.6283
16013	QF 1,22	ЗУ	China 3	046	2026-05-10 01:07:40.855106	14.226
16015	QF 2,21	ЗУ	China 5	048	2026-05-10 01:07:40.855106	20.0389
16017	QF 2,23	ЗУ	China 7	050	2026-05-10 01:07:40.855106	9.1861
16020	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:07:54.881369	20.36
16022	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:07:54.881369	17.452
13937	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:22:56.461503	20.8958
13938	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:22:56.461503	9.3181
13939	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:22:56.461503	16.5081
13940	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:22:56.461503	8.4519
13941	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:22:56.461503	19.5134
13942	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:22:56.461503	19.7041
13943	QF 1,20	ЗУ	China 1	044	2026-05-09 21:22:56.79997	11.4471
13944	QF 1,21	ЗУ	China 2	045	2026-05-09 21:22:56.79997	11.1245
13945	QF 1,22	ЗУ	China 3	046	2026-05-09 21:22:56.79997	13.9465
13946	QF 2,20	ЗУ	China 4	047	2026-05-09 21:22:56.79997	18.7245
13947	QF 2,21	ЗУ	China 5	048	2026-05-09 21:22:56.79997	20.4385
13948	QF 2,22	ЗУ	China 6	049	2026-05-09 21:22:56.79997	20.2145
13949	QF 2,23	ЗУ	China 7	050	2026-05-09 21:22:56.79997	9.9078
13950	QF 2,19	ЗУ	China 8	051	2026-05-09 21:22:56.79997	15.4843
13951	TP3	ЗУ	CP-300 New	078	2026-05-09 21:23:05.454328	6.8472
13952	Q17	ЗУ	MO 9	071	2026-05-09 21:23:16.248183	0.5431
13953	Q20	ЗУ	MO 10	072	2026-05-09 21:23:16.248183	13.8061
13954	Q21	ЗУ	MO 11	073	2026-05-09 21:23:16.248183	0.5888
13955	Q22	ЗУ	MO 12	074	2026-05-09 21:23:16.248183	0.5365
13956	Q23	ЗУ	MO 13	075	2026-05-09 21:23:16.248183	1.3355
13957	Q24	ЗУ	MO 14	076	2026-05-09 21:23:16.248183	1.1439
13958	Q25	ЗУ	MO 15	077	2026-05-09 21:23:16.248183	1.1847
13959	Q4	ЗУ	BG 1	062	2026-05-09 21:23:20.317931	21.1989
13960	Q9	ЗУ	BG 2	063	2026-05-09 21:23:20.317931	32.7026
13961	Q10	ЗУ	SM 2	064	2026-05-09 21:23:20.559198	18.9796
13962	Q11	ЗУ	SM 3	065	2026-05-09 21:23:20.559198	21.3324
13963	Q12	ЗУ	SM 4	066	2026-05-09 21:23:20.559198	0.8998
13964	Q13	ЗУ	SM 5	067	2026-05-09 21:23:20.559198	1.6676
13965	Q14	ЗУ	SM 6	068	2026-05-09 21:23:20.559198	1.575
13966	Q15	ЗУ	SM 7	069	2026-05-09 21:23:20.559198	1.8082
13967	Q16	ЗУ	SM 8	070	2026-05-09 21:23:20.559198	2.3641
13968	Q8	ЗУ	DIG	061	2026-05-09 21:23:30.331272	47.8733
13969	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:23:31.495574	20.9465
13970	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:23:31.495574	8.9999
13971	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:23:31.495574	17.8338
13972	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:23:31.495574	7.5282
13973	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:23:31.495574	20.0912
13974	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:23:31.495574	18.5364
13975	TP3	ЗУ	CP-300 New	078	2026-05-09 21:23:35.483183	7.6448
13976	QF 1,20	ЗУ	China 1	044	2026-05-09 21:23:36.83677	11.3064
13977	QF 1,21	ЗУ	China 2	045	2026-05-09 21:23:36.83677	10.893
13978	QF 1,22	ЗУ	China 3	046	2026-05-09 21:23:36.83677	13.2913
13979	QF 2,20	ЗУ	China 4	047	2026-05-09 21:23:36.83677	18.918
13980	QF 2,21	ЗУ	China 5	048	2026-05-09 21:23:36.83677	21.4645
13981	QF 2,22	ЗУ	China 6	049	2026-05-09 21:23:36.83677	20.2979
13982	QF 2,23	ЗУ	China 7	050	2026-05-09 21:23:36.83677	10.1275
13983	QF 2,19	ЗУ	China 8	051	2026-05-09 21:23:36.83677	14.2044
13984	Q4	ЗУ	BG 1	062	2026-05-09 21:24:05.335372	20.4018
13985	Q9	ЗУ	BG 2	063	2026-05-09 21:24:05.335372	32.5232
13986	Q8	ЗУ	DIG	061	2026-05-09 21:24:05.357804	47.0515
13987	TP3	ЗУ	CP-300 New	078	2026-05-09 21:24:05.498502	7.8215
13988	Q10	ЗУ	SM 2	064	2026-05-09 21:24:05.597311	18.3909
13989	Q11	ЗУ	SM 3	065	2026-05-09 21:24:05.597311	21.4424
13990	Q12	ЗУ	SM 4	066	2026-05-09 21:24:05.597311	1.6421
13991	Q13	ЗУ	SM 5	067	2026-05-09 21:24:05.597311	1.0104
13992	Q14	ЗУ	SM 6	068	2026-05-09 21:24:05.597311	1.4742
13993	Q15	ЗУ	SM 7	069	2026-05-09 21:24:05.597311	1.4178
13994	Q16	ЗУ	SM 8	070	2026-05-09 21:24:05.597311	2.9999
13995	Q17	ЗУ	MO 9	071	2026-05-09 21:24:06.275857	0.837
13996	Q20	ЗУ	MO 10	072	2026-05-09 21:24:06.275857	13.7528
13997	Q21	ЗУ	MO 11	073	2026-05-09 21:24:06.275857	0.9124
13998	Q22	ЗУ	MO 12	074	2026-05-09 21:24:06.275857	0.751
13999	Q23	ЗУ	MO 13	075	2026-05-09 21:24:06.275857	1.3579
14000	Q24	ЗУ	MO 14	076	2026-05-09 21:24:06.275857	0.9835
14001	Q25	ЗУ	MO 15	077	2026-05-09 21:24:06.275857	1.1668
14002	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:24:06.523084	22.0271
14003	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:24:06.523084	8.9058
14004	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:24:06.523084	17.2543
14005	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:24:06.523084	9.075
14006	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:24:06.523084	19.8145
14007	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:24:06.523084	19.2563
14008	QF 1,20	ЗУ	China 1	044	2026-05-09 21:24:16.871795	12.2963
14009	QF 1,21	ЗУ	China 2	045	2026-05-09 21:24:16.871795	11.3573
14010	QF 1,22	ЗУ	China 3	046	2026-05-09 21:24:16.871795	14.7627
14011	QF 2,20	ЗУ	China 4	047	2026-05-09 21:24:16.871795	18.7806
14012	QF 2,21	ЗУ	China 5	048	2026-05-09 21:24:16.871795	21.7383
14013	QF 2,22	ЗУ	China 6	049	2026-05-09 21:24:16.871795	19.3635
14014	QF 2,23	ЗУ	China 7	050	2026-05-09 21:24:16.871795	10.6349
14015	QF 2,19	ЗУ	China 8	051	2026-05-09 21:24:16.871795	15.0251
14016	TP3	ЗУ	CP-300 New	078	2026-05-09 21:24:35.516497	6.2669
14017	Q8	ЗУ	DIG	061	2026-05-09 21:24:40.373236	46.1605
14018	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:24:41.642577	21.9248
14019	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:24:41.642577	9.6251
14020	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:24:41.642577	16.4186
14021	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:24:41.642577	8.1287
14022	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:24:41.642577	19.817
14023	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:24:41.642577	19.8058
14024	Q4	ЗУ	BG 1	062	2026-05-09 21:24:50.365384	21.3938
14025	Q9	ЗУ	BG 2	063	2026-05-09 21:24:50.365384	33.1801
14026	Q10	ЗУ	SM 2	064	2026-05-09 21:24:50.644977	18.5083
14027	Q11	ЗУ	SM 3	065	2026-05-09 21:24:50.644977	22.3773
14028	Q12	ЗУ	SM 4	066	2026-05-09 21:24:50.644977	1.4608
14029	Q13	ЗУ	SM 5	067	2026-05-09 21:24:50.644977	1.7137
14030	Q14	ЗУ	SM 6	068	2026-05-09 21:24:50.644977	1.3419
14031	Q15	ЗУ	SM 7	069	2026-05-09 21:24:50.644977	1.4667
14032	Q16	ЗУ	SM 8	070	2026-05-09 21:24:50.644977	2.8521
14033	Q17	ЗУ	MO 9	071	2026-05-09 21:24:56.304491	1.3701
14034	Q20	ЗУ	MO 10	072	2026-05-09 21:24:56.304491	13.3624
14035	Q21	ЗУ	MO 11	073	2026-05-09 21:24:56.304491	0.7234
14036	Q22	ЗУ	MO 12	074	2026-05-09 21:24:56.304491	0.903
14037	Q23	ЗУ	MO 13	075	2026-05-09 21:24:56.304491	0.7839
14038	Q24	ЗУ	MO 14	076	2026-05-09 21:24:56.304491	1.0398
14039	Q25	ЗУ	MO 15	077	2026-05-09 21:24:56.304491	1.204
14040	QF 1,20	ЗУ	China 1	044	2026-05-09 21:24:56.9428	11.3365
14041	QF 1,21	ЗУ	China 2	045	2026-05-09 21:24:56.9428	10.341
14042	QF 1,22	ЗУ	China 3	046	2026-05-09 21:24:56.9428	13.9116
14043	QF 2,20	ЗУ	China 4	047	2026-05-09 21:24:56.9428	19.0706
14044	QF 2,21	ЗУ	China 5	048	2026-05-09 21:24:56.9428	21.3724
14045	QF 2,22	ЗУ	China 6	049	2026-05-09 21:24:56.9428	20.3373
14046	QF 2,23	ЗУ	China 7	050	2026-05-09 21:24:56.9428	9.6728
14047	QF 2,19	ЗУ	China 8	051	2026-05-09 21:24:56.9428	15.5258
14048	TP3	ЗУ	CP-300 New	078	2026-05-09 21:25:05.541382	6.8811
14049	Q8	ЗУ	DIG	061	2026-05-09 21:25:15.388703	47.416
14050	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:25:16.714201	21.3979
14051	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:25:16.714201	9.783
14052	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:25:16.714201	17.4882
14053	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:25:16.714201	8.49
14054	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:25:16.714201	20.0551
14055	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:25:16.714201	19.5669
14056	Q4	ЗУ	BG 1	062	2026-05-09 21:25:35.386299	20.5551
14057	Q9	ЗУ	BG 2	063	2026-05-09 21:25:35.386299	32.7261
14058	TP3	ЗУ	CP-300 New	078	2026-05-09 21:25:35.562284	7.8072
14059	Q10	ЗУ	SM 2	064	2026-05-09 21:25:35.686235	18.9814
14060	Q11	ЗУ	SM 3	065	2026-05-09 21:25:35.686235	21.8061
14061	Q12	ЗУ	SM 4	066	2026-05-09 21:25:35.686235	1.6149
14062	Q13	ЗУ	SM 5	067	2026-05-09 21:25:35.686235	0.8706
14063	Q14	ЗУ	SM 6	068	2026-05-09 21:25:35.686235	0.8502
14064	Q15	ЗУ	SM 7	069	2026-05-09 21:25:35.686235	1.3942
14065	Q16	ЗУ	SM 8	070	2026-05-09 21:25:35.686235	2.5506
14066	QF 1,20	ЗУ	China 1	044	2026-05-09 21:25:36.990868	11.5993
14067	QF 1,21	ЗУ	China 2	045	2026-05-09 21:25:36.990868	11.2327
14068	QF 1,22	ЗУ	China 3	046	2026-05-09 21:25:36.990868	13.6382
14069	QF 2,20	ЗУ	China 4	047	2026-05-09 21:25:36.990868	18.9971
14070	QF 2,21	ЗУ	China 5	048	2026-05-09 21:25:36.990868	20.3505
14071	QF 2,22	ЗУ	China 6	049	2026-05-09 21:25:36.990868	19.1724
14072	QF 2,23	ЗУ	China 7	050	2026-05-09 21:25:36.990868	9.449
14073	QF 2,19	ЗУ	China 8	051	2026-05-09 21:25:36.990868	14.5004
14074	Q17	ЗУ	MO 9	071	2026-05-09 21:25:46.338311	1.043
14075	Q20	ЗУ	MO 10	072	2026-05-09 21:25:46.338311	13.4935
14076	Q21	ЗУ	MO 11	073	2026-05-09 21:25:46.338311	1.4007
14077	Q22	ЗУ	MO 12	074	2026-05-09 21:25:46.338311	1.4675
14078	Q23	ЗУ	MO 13	075	2026-05-09 21:25:46.338311	0.9125
14079	Q24	ЗУ	MO 14	076	2026-05-09 21:25:46.338311	1.2798
14080	Q25	ЗУ	MO 15	077	2026-05-09 21:25:46.338311	0.8616
14081	Q8	ЗУ	DIG	061	2026-05-09 21:25:50.450309	47.9101
14082	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:25:51.754394	21.945
14083	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:25:51.754394	9.1233
14084	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:25:51.754394	17.4286
14085	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:25:51.754394	8.9859
14086	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:25:51.754394	20.261
14087	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:25:51.754394	20.1433
14088	TP3	ЗУ	CP-300 New	078	2026-05-09 21:26:05.579182	7.4133
14089	QF 1,20	ЗУ	China 1	044	2026-05-09 21:26:17.033353	12.133
14090	QF 1,21	ЗУ	China 2	045	2026-05-09 21:26:17.033353	10.2883
14091	QF 1,22	ЗУ	China 3	046	2026-05-09 21:26:17.033353	14.2682
14092	QF 2,20	ЗУ	China 4	047	2026-05-09 21:26:17.033353	19.4114
14093	QF 2,21	ЗУ	China 5	048	2026-05-09 21:26:17.033353	21.4874
14094	QF 2,22	ЗУ	China 6	049	2026-05-09 21:26:17.033353	20.5048
14095	QF 2,23	ЗУ	China 7	050	2026-05-09 21:26:17.033353	9.3015
14096	QF 2,19	ЗУ	China 8	051	2026-05-09 21:26:17.033353	15.7241
16014	QF 2,20	ЗУ	China 4	047	2026-05-10 01:07:40.855106	19.4778
16016	QF 2,22	ЗУ	China 6	049	2026-05-10 01:07:40.855106	20.2364
16018	QF 2,19	ЗУ	China 8	051	2026-05-10 01:07:40.855106	14.6997
16019	Q8	ЗУ	DIG	061	2026-05-10 01:07:52.72484	45.3485
16021	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:07:54.881369	8.7639
16023	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:07:54.881369	7.24
16025	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:07:54.881369	19.6025
16026	TP3	ЗУ	CP-300 New	078	2026-05-10 01:08:07.780475	7.1825
16028	Q20	ЗУ	MO 10	072	2026-05-10 01:08:18.718263	13.5239
16030	Q22	ЗУ	MO 12	074	2026-05-10 01:08:18.718263	1.0456
16032	Q24	ЗУ	MO 14	076	2026-05-10 01:08:18.718263	0.7145
16034	QF 1,20	ЗУ	China 1	044	2026-05-10 01:08:20.896184	12.0764
16036	QF 1,22	ЗУ	China 3	046	2026-05-10 01:08:20.896184	13.1558
16038	QF 2,21	ЗУ	China 5	048	2026-05-10 01:08:20.896184	20.8177
16040	QF 2,23	ЗУ	China 7	050	2026-05-10 01:08:20.896184	9.231
16042	Q4	ЗУ	BG 1	062	2026-05-10 01:08:22.486625	20.1841
16044	Q10	ЗУ	SM 2	064	2026-05-10 01:08:22.806213	18.47
16046	Q12	ЗУ	SM 4	066	2026-05-10 01:08:22.806213	1.6439
16048	Q14	ЗУ	SM 6	068	2026-05-10 01:08:22.806213	0.8113
16050	Q16	ЗУ	SM 8	070	2026-05-10 01:08:22.806213	2.3109
16051	Q8	ЗУ	DIG	061	2026-05-10 01:08:27.754908	47.073
16053	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:08:29.928966	8.4027
16055	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:08:29.928966	7.4401
16057	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:08:29.928966	18.1682
16060	QF 1,21	ЗУ	China 2	045	2026-05-10 01:09:00.929844	10.0327
16062	QF 2,20	ЗУ	China 4	047	2026-05-10 01:09:00.929844	18.743
16064	QF 2,22	ЗУ	China 6	049	2026-05-10 01:09:00.929844	18.9403
16066	QF 2,19	ЗУ	China 8	051	2026-05-10 01:09:00.929844	14.1261
16069	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:09:04.969709	8.126
16071	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:09:04.969709	7.8426
16073	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:09:04.969709	19.2514
16075	Q9	ЗУ	BG 2	063	2026-05-10 01:09:07.507062	32.1285
16077	TP3	ЗУ	CP-300 New	078	2026-05-10 01:09:07.845666	5.8281
16079	Q12	ЗУ	SM 4	066	2026-05-10 01:09:07.844762	1.1733
16081	Q14	ЗУ	SM 6	068	2026-05-10 01:09:07.844762	0.8172
16083	Q16	ЗУ	SM 8	070	2026-05-10 01:09:07.844762	3.0943
16085	Q20	ЗУ	MO 10	072	2026-05-10 01:09:08.74603	13.6641
16087	Q22	ЗУ	MO 12	074	2026-05-10 01:09:08.74603	0.875
16089	Q24	ЗУ	MO 14	076	2026-05-10 01:09:08.74603	0.5873
16092	TP3	ЗУ	CP-300 New	078	2026-05-10 01:09:37.86526	6.2238
16094	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:09:39.994039	9.8091
16096	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:09:39.994039	8.1546
16098	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:09:39.994039	18.299
14098	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:26:26.827039	21.4963
14099	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:26:26.827039	10.1202
14100	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:26:26.827039	17.983
14101	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:26:26.827039	7.8286
14102	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:26:26.827039	20.6268
14103	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:26:26.827039	19.3056
14104	TP3	ЗУ	CP-300 New	078	2026-05-09 21:26:35.633899	6.9681
14105	Q17	ЗУ	MO 9	071	2026-05-09 21:26:36.378325	1.4657
14106	Q20	ЗУ	MO 10	072	2026-05-09 21:26:36.378325	13.6814
14107	Q21	ЗУ	MO 11	073	2026-05-09 21:26:36.378325	1.4997
14108	Q22	ЗУ	MO 12	074	2026-05-09 21:26:36.378325	1.3816
14109	Q23	ЗУ	MO 13	075	2026-05-09 21:26:36.378325	0.9859
14110	Q24	ЗУ	MO 14	076	2026-05-09 21:26:36.378325	1.1218
14111	Q25	ЗУ	MO 15	077	2026-05-09 21:26:36.378325	1.5121
14112	QF 1,20	ЗУ	China 1	044	2026-05-09 21:26:57.126432	11.6143
14113	QF 1,21	ЗУ	China 2	045	2026-05-09 21:26:57.126432	10.3501
14114	QF 1,22	ЗУ	China 3	046	2026-05-09 21:26:57.126432	13.8326
14115	QF 2,20	ЗУ	China 4	047	2026-05-09 21:26:57.126432	19.6353
14116	QF 2,21	ЗУ	China 5	048	2026-05-09 21:26:57.126432	21.7315
14117	QF 2,22	ЗУ	China 6	049	2026-05-09 21:26:57.126432	20.6991
14118	QF 2,23	ЗУ	China 7	050	2026-05-09 21:26:57.126432	10.0865
14119	QF 2,19	ЗУ	China 8	051	2026-05-09 21:26:57.126432	15.3396
14120	Q8	ЗУ	DIG	061	2026-05-09 21:27:00.796235	46.358
14121	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:27:01.870447	21.446
14122	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:27:01.870447	8.6153
14123	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:27:01.870447	17.7064
14124	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:27:01.870447	9.1011
14125	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:27:01.870447	20.1662
14126	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:27:01.870447	18.7403
14127	Q4	ЗУ	BG 1	062	2026-05-09 21:27:05.439813	21.6353
14128	Q9	ЗУ	BG 2	063	2026-05-09 21:27:05.439813	32.495
14129	TP3	ЗУ	CP-300 New	078	2026-05-09 21:27:05.671404	6.4817
14130	Q10	ЗУ	SM 2	064	2026-05-09 21:27:05.729702	19.3811
14131	Q11	ЗУ	SM 3	065	2026-05-09 21:27:05.729702	21.5301
14132	Q12	ЗУ	SM 4	066	2026-05-09 21:27:05.729702	0.8035
14133	Q13	ЗУ	SM 5	067	2026-05-09 21:27:05.729702	0.7201
14134	Q14	ЗУ	SM 6	068	2026-05-09 21:27:05.729702	0.8753
14135	Q15	ЗУ	SM 7	069	2026-05-09 21:27:05.729702	1.5243
14136	Q16	ЗУ	SM 8	070	2026-05-09 21:27:05.729702	2.9009
14137	Q17	ЗУ	MO 9	071	2026-05-09 21:27:26.416186	1.4939
14138	Q20	ЗУ	MO 10	072	2026-05-09 21:27:26.416186	13.9984
14139	Q21	ЗУ	MO 11	073	2026-05-09 21:27:26.416186	0.9254
14140	Q22	ЗУ	MO 12	074	2026-05-09 21:27:26.416186	1.1966
14141	Q23	ЗУ	MO 13	075	2026-05-09 21:27:26.416186	1.3779
14142	Q24	ЗУ	MO 14	076	2026-05-09 21:27:26.416186	1.1503
14143	Q25	ЗУ	MO 15	077	2026-05-09 21:27:26.416186	1.0684
14144	TP3	ЗУ	CP-300 New	078	2026-05-09 21:27:35.707379	8.1156
14145	Q8	ЗУ	DIG	061	2026-05-09 21:27:35.817989	45.9544
14146	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:27:36.909361	20.9909
14147	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:27:36.909361	9.4559
14148	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:27:36.909361	18.0336
14149	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:27:36.909361	8.1493
14150	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:27:36.909361	20.0736
14151	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:27:36.909361	18.5895
14152	QF 1,20	ЗУ	China 1	044	2026-05-09 21:27:37.184949	11.9013
14153	QF 1,21	ЗУ	China 2	045	2026-05-09 21:27:37.184949	10.3738
14154	QF 1,22	ЗУ	China 3	046	2026-05-09 21:27:37.184949	14.6609
14155	QF 2,20	ЗУ	China 4	047	2026-05-09 21:27:37.184949	18.7111
14156	QF 2,21	ЗУ	China 5	048	2026-05-09 21:27:37.184949	20.2576
14157	QF 2,22	ЗУ	China 6	049	2026-05-09 21:27:37.184949	20.6723
14158	QF 2,23	ЗУ	China 7	050	2026-05-09 21:27:37.184949	9.2139
14159	QF 2,19	ЗУ	China 8	051	2026-05-09 21:27:37.184949	14.1568
14160	Q4	ЗУ	BG 1	062	2026-05-09 21:27:50.466374	20.3663
14161	Q9	ЗУ	BG 2	063	2026-05-09 21:27:50.466374	32.8169
14162	Q10	ЗУ	SM 2	064	2026-05-09 21:27:50.76781	18.6001
14163	Q11	ЗУ	SM 3	065	2026-05-09 21:27:50.76781	21.3014
14164	Q12	ЗУ	SM 4	066	2026-05-09 21:27:50.76781	0.7702
14165	Q13	ЗУ	SM 5	067	2026-05-09 21:27:50.76781	1.0897
14166	Q14	ЗУ	SM 6	068	2026-05-09 21:27:50.76781	1.1427
14167	Q15	ЗУ	SM 7	069	2026-05-09 21:27:50.76781	1.0218
14168	Q16	ЗУ	SM 8	070	2026-05-09 21:27:50.76781	3.1943
14169	TP3	ЗУ	CP-300 New	078	2026-05-09 21:28:05.756574	6.1434
14170	Q8	ЗУ	DIG	061	2026-05-09 21:28:10.82693	47.1632
14171	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:28:11.951156	21.5348
14172	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:28:11.951156	9.5584
14173	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:28:11.951156	17.9648
14174	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:28:11.951156	8.0824
14175	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:28:11.951156	20.6946
14176	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:28:11.951156	20.1524
14177	Q17	ЗУ	MO 9	071	2026-05-09 21:28:16.494238	1.4214
14178	Q20	ЗУ	MO 10	072	2026-05-09 21:28:16.494238	13.1683
14179	Q21	ЗУ	MO 11	073	2026-05-09 21:28:16.494238	0.7365
14180	Q22	ЗУ	MO 12	074	2026-05-09 21:28:16.494238	0.9612
14181	Q23	ЗУ	MO 13	075	2026-05-09 21:28:16.494238	1.4703
14182	Q24	ЗУ	MO 14	076	2026-05-09 21:28:16.494238	0.7943
14183	Q25	ЗУ	MO 15	077	2026-05-09 21:28:16.494238	0.5988
14184	QF 1,20	ЗУ	China 1	044	2026-05-09 21:28:17.227257	11.7477
14185	QF 1,21	ЗУ	China 2	045	2026-05-09 21:28:17.227257	10.9455
14186	QF 1,22	ЗУ	China 3	046	2026-05-09 21:28:17.227257	13.8628
14187	QF 2,20	ЗУ	China 4	047	2026-05-09 21:28:17.227257	19.1571
14188	QF 2,21	ЗУ	China 5	048	2026-05-09 21:28:17.227257	21.1361
14189	QF 2,22	ЗУ	China 6	049	2026-05-09 21:28:17.227257	19.7878
14190	QF 2,23	ЗУ	China 7	050	2026-05-09 21:28:17.227257	10.5471
14191	QF 2,19	ЗУ	China 8	051	2026-05-09 21:28:17.227257	15.0756
14192	Q4	ЗУ	BG 1	062	2026-05-09 21:28:35.488278	21.0574
14193	Q9	ЗУ	BG 2	063	2026-05-09 21:28:35.488278	33.3886
14194	TP3	ЗУ	CP-300 New	078	2026-05-09 21:28:35.784463	7.1191
14195	Q10	ЗУ	SM 2	064	2026-05-09 21:28:35.790331	18.6122
14196	Q11	ЗУ	SM 3	065	2026-05-09 21:28:35.790331	21.9014
14197	Q12	ЗУ	SM 4	066	2026-05-09 21:28:35.790331	0.9704
14198	Q13	ЗУ	SM 5	067	2026-05-09 21:28:35.790331	1.3366
14199	Q14	ЗУ	SM 6	068	2026-05-09 21:28:35.790331	0.8869
14200	Q15	ЗУ	SM 7	069	2026-05-09 21:28:35.790331	0.7863
14201	Q16	ЗУ	SM 8	070	2026-05-09 21:28:35.790331	2.7976
14202	Q8	ЗУ	DIG	061	2026-05-09 21:28:45.849372	47.8396
14203	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:28:46.983306	21.1497
14204	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:28:46.983306	9.7544
14205	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:28:46.983306	16.384
14206	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:28:46.983306	7.6916
14207	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:28:46.983306	19.4227
14208	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:28:46.983306	19.9643
14209	QF 1,20	ЗУ	China 1	044	2026-05-09 21:28:57.430784	12.2724
14210	QF 1,21	ЗУ	China 2	045	2026-05-09 21:28:57.430784	10.4539
14211	QF 1,22	ЗУ	China 3	046	2026-05-09 21:28:57.430784	14.0833
14212	QF 2,20	ЗУ	China 4	047	2026-05-09 21:28:57.430784	18.5606
14213	QF 2,21	ЗУ	China 5	048	2026-05-09 21:28:57.430784	21.0359
14214	QF 2,22	ЗУ	China 6	049	2026-05-09 21:28:57.430784	20.0755
14215	QF 2,23	ЗУ	China 7	050	2026-05-09 21:28:57.430784	10.4075
14216	QF 2,19	ЗУ	China 8	051	2026-05-09 21:28:57.430784	15.1
14217	TP3	ЗУ	CP-300 New	078	2026-05-09 21:29:05.805375	6.5043
14218	Q17	ЗУ	MO 9	071	2026-05-09 21:29:06.534523	1.2315
14219	Q20	ЗУ	MO 10	072	2026-05-09 21:29:06.534523	13.7752
14220	Q21	ЗУ	MO 11	073	2026-05-09 21:29:06.534523	0.6839
14221	Q22	ЗУ	MO 12	074	2026-05-09 21:29:06.534523	0.8195
14222	Q23	ЗУ	MO 13	075	2026-05-09 21:29:06.534523	0.7609
14223	Q24	ЗУ	MO 14	076	2026-05-09 21:29:06.534523	1.1544
14224	Q25	ЗУ	MO 15	077	2026-05-09 21:29:06.534523	1.2382
14225	Q4	ЗУ	BG 1	062	2026-05-09 21:29:20.534685	21.1625
14226	Q9	ЗУ	BG 2	063	2026-05-09 21:29:20.534685	33.5252
14227	Q10	ЗУ	SM 2	064	2026-05-09 21:29:20.83374	18.5184
14228	Q11	ЗУ	SM 3	065	2026-05-09 21:29:20.83374	21.666
14229	Q12	ЗУ	SM 4	066	2026-05-09 21:29:20.83374	1.7696
14230	Q13	ЗУ	SM 5	067	2026-05-09 21:29:20.83374	0.8666
14231	Q14	ЗУ	SM 6	068	2026-05-09 21:29:20.83374	0.9621
14232	Q15	ЗУ	SM 7	069	2026-05-09 21:29:20.83374	1.8786
14233	Q16	ЗУ	SM 8	070	2026-05-09 21:29:20.83374	2.415
14234	Q8	ЗУ	DIG	061	2026-05-09 21:29:20.866509	47.5742
14235	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:29:22.014126	21.2197
14236	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:29:22.014126	8.7449
14237	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:29:22.014126	18.0499
14238	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:29:22.014126	8.7899
14239	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:29:22.014126	21.1196
14240	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:29:22.014126	18.901
14241	TP3	ЗУ	CP-300 New	078	2026-05-09 21:29:35.829551	7.4351
14242	QF 1,20	ЗУ	China 1	044	2026-05-09 21:29:37.509376	11.3656
14243	QF 1,21	ЗУ	China 2	045	2026-05-09 21:29:37.509376	10.1712
14244	QF 1,22	ЗУ	China 3	046	2026-05-09 21:29:37.509376	13.8653
14245	QF 2,20	ЗУ	China 4	047	2026-05-09 21:29:37.509376	18.7744
14246	QF 2,21	ЗУ	China 5	048	2026-05-09 21:29:37.509376	20.6366
14247	QF 2,22	ЗУ	China 6	049	2026-05-09 21:29:37.509376	20.4752
14248	QF 2,23	ЗУ	China 7	050	2026-05-09 21:29:37.509376	9.6451
14249	QF 2,19	ЗУ	China 8	051	2026-05-09 21:29:37.509376	14.4859
14250	Q8	ЗУ	DIG	061	2026-05-09 21:29:55.878963	47.708
14251	Q17	ЗУ	MO 9	071	2026-05-09 21:29:56.592376	1.1317
14252	Q20	ЗУ	MO 10	072	2026-05-09 21:29:56.592376	13.8606
14253	Q21	ЗУ	MO 11	073	2026-05-09 21:29:56.592376	0.8897
14254	Q22	ЗУ	MO 12	074	2026-05-09 21:29:56.592376	0.8778
14255	Q23	ЗУ	MO 13	075	2026-05-09 21:29:56.592376	1.4876
14256	Q24	ЗУ	MO 14	076	2026-05-09 21:29:56.592376	1.0219
14257	Q25	ЗУ	MO 15	077	2026-05-09 21:29:56.592376	0.9702
14258	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:29:57.040005	20.4501
14259	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:29:57.040005	9.683
14260	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:29:57.040005	16.893
14261	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:29:57.040005	8.239
14262	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:29:57.040005	20.8443
14263	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:29:57.040005	19.2795
14264	Q4	ЗУ	BG 1	062	2026-05-09 21:30:05.566011	21.0128
14265	Q9	ЗУ	BG 2	063	2026-05-09 21:30:05.566011	32.3471
14266	TP3	ЗУ	CP-300 New	078	2026-05-09 21:30:05.86247	7.7144
14267	Q10	ЗУ	SM 2	064	2026-05-09 21:30:05.866161	19.292
14268	Q11	ЗУ	SM 3	065	2026-05-09 21:30:05.866161	21.4385
14269	Q12	ЗУ	SM 4	066	2026-05-09 21:30:05.866161	1.8127
14270	Q13	ЗУ	SM 5	067	2026-05-09 21:30:05.866161	1.1447
14271	Q14	ЗУ	SM 6	068	2026-05-09 21:30:05.866161	1.3679
14272	Q15	ЗУ	SM 7	069	2026-05-09 21:30:05.866161	0.8617
14273	Q16	ЗУ	SM 8	070	2026-05-09 21:30:05.866161	3.0762
14274	QF 1,20	ЗУ	China 1	044	2026-05-09 21:30:17.561936	12.6179
14275	QF 1,21	ЗУ	China 2	045	2026-05-09 21:30:17.561936	11.5361
14276	QF 1,22	ЗУ	China 3	046	2026-05-09 21:30:17.561936	13.2826
14277	QF 2,20	ЗУ	China 4	047	2026-05-09 21:30:17.561936	19.3549
14278	QF 2,21	ЗУ	China 5	048	2026-05-09 21:30:17.561936	21.2076
14279	QF 2,22	ЗУ	China 6	049	2026-05-09 21:30:17.561936	20.0713
14280	QF 2,23	ЗУ	China 7	050	2026-05-09 21:30:17.561936	9.1736
14281	QF 2,19	ЗУ	China 8	051	2026-05-09 21:30:17.561936	15.5137
14282	Q8	ЗУ	DIG	061	2026-05-09 21:30:30.898705	47.2143
14283	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:30:32.076732	21.56
14284	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:30:32.076732	9.8386
14285	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:30:32.076732	17.1881
14286	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:30:32.076732	8.6634
14287	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:30:32.076732	20.8481
14288	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:30:32.076732	18.9839
14289	TP3	ЗУ	CP-300 New	078	2026-05-09 21:30:35.876874	7.7288
14290	Q17	ЗУ	MO 9	071	2026-05-09 21:30:46.629581	1.2303
14291	Q20	ЗУ	MO 10	072	2026-05-09 21:30:46.629581	13.5405
14292	Q21	ЗУ	MO 11	073	2026-05-09 21:30:46.629581	0.6268
14293	Q22	ЗУ	MO 12	074	2026-05-09 21:30:46.629581	0.8424
14294	Q23	ЗУ	MO 13	075	2026-05-09 21:30:46.629581	0.8202
14295	Q24	ЗУ	MO 14	076	2026-05-09 21:30:46.629581	0.7783
14296	Q25	ЗУ	MO 15	077	2026-05-09 21:30:46.629581	1.4482
14297	Q4	ЗУ	BG 1	062	2026-05-09 21:30:50.618608	20.9071
14298	Q9	ЗУ	BG 2	063	2026-05-09 21:30:50.618608	32.5981
14299	Q10	ЗУ	SM 2	064	2026-05-09 21:30:50.895204	18.4387
14300	Q11	ЗУ	SM 3	065	2026-05-09 21:30:50.895204	21.8558
14301	Q12	ЗУ	SM 4	066	2026-05-09 21:30:50.895204	1.394
14302	Q13	ЗУ	SM 5	067	2026-05-09 21:30:50.895204	0.9904
14304	Q15	ЗУ	SM 7	069	2026-05-09 21:30:50.895204	0.9355
14307	QF 1,21	ЗУ	China 2	045	2026-05-09 21:30:57.598003	10.2288
14309	QF 2,20	ЗУ	China 4	047	2026-05-09 21:30:57.598003	19.7117
14311	QF 2,22	ЗУ	China 6	049	2026-05-09 21:30:57.598003	19.4306
14313	QF 2,19	ЗУ	China 8	051	2026-05-09 21:30:57.598003	14.9719
14315	Q8	ЗУ	DIG	061	2026-05-09 21:31:05.943258	47.6226
14317	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:31:07.117118	8.4203
14319	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:31:07.117118	8.9433
14321	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:31:07.117118	18.9234
14323	Q9	ЗУ	BG 2	063	2026-05-09 21:31:35.655722	32.48
14325	TP3	ЗУ	CP-300 New	078	2026-05-09 21:31:35.935005	6.6804
14327	Q12	ЗУ	SM 4	066	2026-05-09 21:31:35.931214	1.8351
14329	Q14	ЗУ	SM 6	068	2026-05-09 21:31:35.931214	1.0677
14331	Q16	ЗУ	SM 8	070	2026-05-09 21:31:35.931214	2.6768
14333	Q20	ЗУ	MO 10	072	2026-05-09 21:31:36.67025	13.1295
14335	Q22	ЗУ	MO 12	074	2026-05-09 21:31:36.67025	1.3914
14337	Q24	ЗУ	MO 14	076	2026-05-09 21:31:36.67025	1.2391
14339	QF 1,20	ЗУ	China 1	044	2026-05-09 21:31:37.635726	12.0678
14341	QF 1,22	ЗУ	China 3	046	2026-05-09 21:31:37.635726	13.6886
14343	QF 2,21	ЗУ	China 5	048	2026-05-09 21:31:37.635726	21.1245
14345	QF 2,23	ЗУ	China 7	050	2026-05-09 21:31:37.635726	9.8604
14347	Q8	ЗУ	DIG	061	2026-05-09 21:31:40.970978	46.9954
14349	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:31:42.149358	8.7262
14351	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:31:42.149358	8.3383
14353	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:31:42.149358	18.7153
14354	TP3	ЗУ	CP-300 New	078	2026-05-09 21:32:05.948158	6.4401
14355	Q8	ЗУ	DIG	061	2026-05-09 21:32:16.022892	46.9015
14357	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:32:17.183248	9.9723
14359	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:32:17.183248	7.5937
14361	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:32:17.183248	19.9016
14363	QF 1,21	ЗУ	China 2	045	2026-05-09 21:32:17.675088	11.0207
14365	QF 2,20	ЗУ	China 4	047	2026-05-09 21:32:17.675088	18.4009
14367	QF 2,22	ЗУ	China 6	049	2026-05-09 21:32:17.675088	20.0326
14369	QF 2,19	ЗУ	China 8	051	2026-05-09 21:32:17.675088	15.0012
14371	Q9	ЗУ	BG 2	063	2026-05-09 21:32:20.681768	33.5168
14373	Q11	ЗУ	SM 3	065	2026-05-09 21:32:20.963521	22.314
14375	Q13	ЗУ	SM 5	067	2026-05-09 21:32:20.963521	0.7424
14377	Q15	ЗУ	SM 7	069	2026-05-09 21:32:20.963521	1.3747
14379	Q17	ЗУ	MO 9	071	2026-05-09 21:32:26.696882	0.7842
14381	Q21	ЗУ	MO 11	073	2026-05-09 21:32:26.696882	0.6525
14383	Q23	ЗУ	MO 13	075	2026-05-09 21:32:26.696882	0.8763
14385	Q25	ЗУ	MO 15	077	2026-05-09 21:32:26.696882	1.4332
14386	TP3	ЗУ	CP-300 New	078	2026-05-09 21:32:35.975824	7.0937
14388	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:32:52.226288	22.0908
14390	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:32:52.226288	16.6913
14392	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:32:52.226288	20.7717
14395	QF 1,21	ЗУ	China 2	045	2026-05-09 21:32:57.721152	11.1642
14397	QF 2,20	ЗУ	China 4	047	2026-05-09 21:32:57.721152	18.3461
14399	QF 2,22	ЗУ	China 6	049	2026-05-09 21:32:57.721152	20.1833
14401	QF 2,19	ЗУ	China 8	051	2026-05-09 21:32:57.721152	14.4674
14403	Q9	ЗУ	BG 2	063	2026-05-09 21:33:05.716034	32.7478
14405	Q10	ЗУ	SM 2	064	2026-05-09 21:33:06.007882	19.066
14407	Q12	ЗУ	SM 4	066	2026-05-09 21:33:06.007882	1.7702
14409	Q14	ЗУ	SM 6	068	2026-05-09 21:33:06.007882	1.6357
14411	Q16	ЗУ	SM 8	070	2026-05-09 21:33:06.007882	2.3332
14412	Q17	ЗУ	MO 9	071	2026-05-09 21:33:16.733528	0.5264
14414	Q21	ЗУ	MO 11	073	2026-05-09 21:33:16.733528	0.854
14416	Q23	ЗУ	MO 13	075	2026-05-09 21:33:16.733528	0.8676
14418	Q25	ЗУ	MO 15	077	2026-05-09 21:33:16.733528	1.1641
14420	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:33:27.258507	21.072
14422	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:33:27.258507	16.9701
14424	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:33:27.258507	20.9459
14427	QF 1,20	ЗУ	China 1	044	2026-05-09 21:33:37.77332	12.2431
14429	QF 1,22	ЗУ	China 3	046	2026-05-09 21:33:37.77332	13.2358
14431	QF 2,21	ЗУ	China 5	048	2026-05-09 21:33:37.77332	21.3434
14433	QF 2,23	ЗУ	China 7	050	2026-05-09 21:33:37.77332	9.5039
14435	Q4	ЗУ	BG 1	062	2026-05-09 21:33:50.749451	20.4586
14437	Q10	ЗУ	SM 2	064	2026-05-09 21:33:51.046717	19.1433
14439	Q12	ЗУ	SM 4	066	2026-05-09 21:33:51.046717	1.6168
14441	Q14	ЗУ	SM 6	068	2026-05-09 21:33:51.046717	1.073
14443	Q16	ЗУ	SM 8	070	2026-05-09 21:33:51.046717	2.2579
14444	Q8	ЗУ	DIG	061	2026-05-09 21:34:01.129399	46.3602
14446	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:34:02.305239	9.5958
14448	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:34:02.305239	7.7633
14450	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:34:02.305239	18.9374
14452	Q17	ЗУ	MO 9	071	2026-05-09 21:34:06.779812	1.0276
14454	Q21	ЗУ	MO 11	073	2026-05-09 21:34:06.779812	1.4076
14456	Q23	ЗУ	MO 13	075	2026-05-09 21:34:06.779812	1.3574
14458	Q25	ЗУ	MO 15	077	2026-05-09 21:34:06.779812	0.7986
14459	QF 1,20	ЗУ	China 1	044	2026-05-09 21:34:17.816472	11.5604
14461	QF 1,22	ЗУ	China 3	046	2026-05-09 21:34:17.816472	14.2868
14463	QF 2,21	ЗУ	China 5	048	2026-05-09 21:34:17.816472	20.4295
14465	QF 2,23	ЗУ	China 7	050	2026-05-09 21:34:17.816472	10.1618
14468	Q9	ЗУ	BG 2	063	2026-05-09 21:34:35.7906	32.6078
14470	Q10	ЗУ	SM 2	064	2026-05-09 21:34:36.091149	19.0678
14472	Q12	ЗУ	SM 4	066	2026-05-09 21:34:36.091149	1.5027
14474	Q14	ЗУ	SM 6	068	2026-05-09 21:34:36.091149	1.4564
14476	Q16	ЗУ	SM 8	070	2026-05-09 21:34:36.091149	2.4485
14478	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:34:37.354096	20.9849
14480	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:34:37.354096	17.4106
14482	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:34:37.354096	20.568
14485	Q20	ЗУ	MO 10	072	2026-05-09 21:34:56.816899	13.8243
14487	Q22	ЗУ	MO 12	074	2026-05-09 21:34:56.816899	0.8821
14489	Q24	ЗУ	MO 14	076	2026-05-09 21:34:56.816899	1.16
14491	QF 1,20	ЗУ	China 1	044	2026-05-09 21:34:57.86681	11.357
14493	QF 1,22	ЗУ	China 3	046	2026-05-09 21:34:57.86681	13.6087
14495	QF 2,21	ЗУ	China 5	048	2026-05-09 21:34:57.86681	20.9917
14497	QF 2,23	ЗУ	China 7	050	2026-05-09 21:34:57.86681	10.6411
14499	TP3	ЗУ	CP-300 New	078	2026-05-09 21:35:06.112952	7.2072
14501	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:35:12.387204	21.2832
14503	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:35:12.387204	16.5745
14303	Q14	ЗУ	SM 6	068	2026-05-09 21:30:50.895204	1.5362
14305	Q16	ЗУ	SM 8	070	2026-05-09 21:30:50.895204	2.9009
14306	QF 1,20	ЗУ	China 1	044	2026-05-09 21:30:57.598003	12.3479
14308	QF 1,22	ЗУ	China 3	046	2026-05-09 21:30:57.598003	13.9609
14310	QF 2,21	ЗУ	China 5	048	2026-05-09 21:30:57.598003	20.1404
14312	QF 2,23	ЗУ	China 7	050	2026-05-09 21:30:57.598003	10.5735
14314	TP3	ЗУ	CP-300 New	078	2026-05-09 21:31:05.900417	6.8635
14316	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:31:07.117118	21.0571
14318	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:31:07.117118	17.2266
14320	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:31:07.117118	20.7469
14322	Q4	ЗУ	BG 1	062	2026-05-09 21:31:35.655722	20.7607
14324	Q10	ЗУ	SM 2	064	2026-05-09 21:31:35.931214	18.9143
14326	Q11	ЗУ	SM 3	065	2026-05-09 21:31:35.931214	22.244
14328	Q13	ЗУ	SM 5	067	2026-05-09 21:31:35.931214	1.436
14330	Q15	ЗУ	SM 7	069	2026-05-09 21:31:35.931214	1.8342
14332	Q17	ЗУ	MO 9	071	2026-05-09 21:31:36.67025	1.4271
14334	Q21	ЗУ	MO 11	073	2026-05-09 21:31:36.67025	0.9339
14336	Q23	ЗУ	MO 13	075	2026-05-09 21:31:36.67025	0.7889
14338	Q25	ЗУ	MO 15	077	2026-05-09 21:31:36.67025	0.8344
14340	QF 1,21	ЗУ	China 2	045	2026-05-09 21:31:37.635726	11.1688
14342	QF 2,20	ЗУ	China 4	047	2026-05-09 21:31:37.635726	18.7251
14344	QF 2,22	ЗУ	China 6	049	2026-05-09 21:31:37.635726	20.4921
14346	QF 2,19	ЗУ	China 8	051	2026-05-09 21:31:37.635726	15.1542
14348	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:31:42.149358	21.653
14350	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:31:42.149358	17.1997
14352	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:31:42.149358	20.4478
14356	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:32:17.183248	22.0392
14358	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:32:17.183248	16.795
14360	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:32:17.183248	20.937
14362	QF 1,20	ЗУ	China 1	044	2026-05-09 21:32:17.675088	11.5473
14364	QF 1,22	ЗУ	China 3	046	2026-05-09 21:32:17.675088	14.5666
14366	QF 2,21	ЗУ	China 5	048	2026-05-09 21:32:17.675088	20.7463
14368	QF 2,23	ЗУ	China 7	050	2026-05-09 21:32:17.675088	10.3112
14370	Q4	ЗУ	BG 1	062	2026-05-09 21:32:20.681768	21.0034
14372	Q10	ЗУ	SM 2	064	2026-05-09 21:32:20.963521	18.5899
14374	Q12	ЗУ	SM 4	066	2026-05-09 21:32:20.963521	1.8095
14376	Q14	ЗУ	SM 6	068	2026-05-09 21:32:20.963521	0.963
14378	Q16	ЗУ	SM 8	070	2026-05-09 21:32:20.963521	2.9949
14380	Q20	ЗУ	MO 10	072	2026-05-09 21:32:26.696882	13.9581
14382	Q22	ЗУ	MO 12	074	2026-05-09 21:32:26.696882	0.6047
14384	Q24	ЗУ	MO 14	076	2026-05-09 21:32:26.696882	0.5072
14387	Q8	ЗУ	DIG	061	2026-05-09 21:32:51.056327	46.0552
14389	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:32:52.226288	8.7433
14391	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:32:52.226288	8.0661
14393	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:32:52.226288	18.735
14394	QF 1,20	ЗУ	China 1	044	2026-05-09 21:32:57.721152	11.2701
14396	QF 1,22	ЗУ	China 3	046	2026-05-09 21:32:57.721152	13.7272
14398	QF 2,21	ЗУ	China 5	048	2026-05-09 21:32:57.721152	20.6391
14400	QF 2,23	ЗУ	China 7	050	2026-05-09 21:32:57.721152	9.5733
14402	Q4	ЗУ	BG 1	062	2026-05-09 21:33:05.716034	21.0368
14404	TP3	ЗУ	CP-300 New	078	2026-05-09 21:33:05.994735	7.6916
14406	Q11	ЗУ	SM 3	065	2026-05-09 21:33:06.007882	21.9022
14408	Q13	ЗУ	SM 5	067	2026-05-09 21:33:06.007882	1.789
14410	Q15	ЗУ	SM 7	069	2026-05-09 21:33:06.007882	1.6148
14413	Q20	ЗУ	MO 10	072	2026-05-09 21:33:16.733528	13.9026
14415	Q22	ЗУ	MO 12	074	2026-05-09 21:33:16.733528	1.1083
14417	Q24	ЗУ	MO 14	076	2026-05-09 21:33:16.733528	0.6777
14419	Q8	ЗУ	DIG	061	2026-05-09 21:33:26.087827	46.0066
14421	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:33:27.258507	9.3014
14423	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:33:27.258507	8.6286
14425	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:33:27.258507	18.6044
14426	TP3	ЗУ	CP-300 New	078	2026-05-09 21:33:36.015657	6.8555
14428	QF 1,21	ЗУ	China 2	045	2026-05-09 21:33:37.77332	11.6872
14430	QF 2,20	ЗУ	China 4	047	2026-05-09 21:33:37.77332	18.6045
14432	QF 2,22	ЗУ	China 6	049	2026-05-09 21:33:37.77332	19.9676
14434	QF 2,19	ЗУ	China 8	051	2026-05-09 21:33:37.77332	15.2114
14436	Q9	ЗУ	BG 2	063	2026-05-09 21:33:50.749451	32.5339
14438	Q11	ЗУ	SM 3	065	2026-05-09 21:33:51.046717	21.1868
14440	Q13	ЗУ	SM 5	067	2026-05-09 21:33:51.046717	1.322
14442	Q15	ЗУ	SM 7	069	2026-05-09 21:33:51.046717	0.8218
14445	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:34:02.305239	20.6857
14447	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:34:02.305239	17.8925
14449	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:34:02.305239	20.2943
14451	TP3	ЗУ	CP-300 New	078	2026-05-09 21:34:06.061527	7.2937
14453	Q20	ЗУ	MO 10	072	2026-05-09 21:34:06.779812	13.5003
14455	Q22	ЗУ	MO 12	074	2026-05-09 21:34:06.779812	1.3336
14457	Q24	ЗУ	MO 14	076	2026-05-09 21:34:06.779812	0.7903
14460	QF 1,21	ЗУ	China 2	045	2026-05-09 21:34:17.816472	11.4043
14462	QF 2,20	ЗУ	China 4	047	2026-05-09 21:34:17.816472	19.7105
14464	QF 2,22	ЗУ	China 6	049	2026-05-09 21:34:17.816472	19.3489
14466	QF 2,19	ЗУ	China 8	051	2026-05-09 21:34:17.816472	14.8583
14467	Q4	ЗУ	BG 1	062	2026-05-09 21:34:35.7906	21.4352
14469	TP3	ЗУ	CP-300 New	078	2026-05-09 21:34:36.086188	7.191
14471	Q11	ЗУ	SM 3	065	2026-05-09 21:34:36.091149	21.4425
14473	Q13	ЗУ	SM 5	067	2026-05-09 21:34:36.091149	1.3147
14475	Q15	ЗУ	SM 7	069	2026-05-09 21:34:36.091149	0.8529
14477	Q8	ЗУ	DIG	061	2026-05-09 21:34:36.146456	45.4957
14479	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:34:37.354096	8.7268
14481	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:34:37.354096	7.6289
14483	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:34:37.354096	19.7706
14484	Q17	ЗУ	MO 9	071	2026-05-09 21:34:56.816899	1.2399
14486	Q21	ЗУ	MO 11	073	2026-05-09 21:34:56.816899	0.9422
14488	Q23	ЗУ	MO 13	075	2026-05-09 21:34:56.816899	0.614
14490	Q25	ЗУ	MO 15	077	2026-05-09 21:34:56.816899	0.6924
14492	QF 1,21	ЗУ	China 2	045	2026-05-09 21:34:57.86681	11.3882
14494	QF 2,20	ЗУ	China 4	047	2026-05-09 21:34:57.86681	18.9163
14496	QF 2,22	ЗУ	China 6	049	2026-05-09 21:34:57.86681	20.2484
14498	QF 2,19	ЗУ	China 8	051	2026-05-09 21:34:57.86681	15.6616
14500	Q8	ЗУ	DIG	061	2026-05-09 21:35:11.156397	46.5803
14502	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:35:12.387204	8.9202
14504	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:35:12.387204	7.6503
14506	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:35:12.387204	19.5929
14505	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:35:12.387204	19.4657
14507	Q4	ЗУ	BG 1	062	2026-05-09 21:35:20.824176	20.7852
14509	Q10	ЗУ	SM 2	064	2026-05-09 21:35:21.138239	18.8
14511	Q12	ЗУ	SM 4	066	2026-05-09 21:35:21.138239	0.6911
14513	Q14	ЗУ	SM 6	068	2026-05-09 21:35:21.138239	0.791
14515	Q16	ЗУ	SM 8	070	2026-05-09 21:35:21.138239	2.4919
14517	QF 1,20	ЗУ	China 1	044	2026-05-09 21:35:37.921873	11.8409
14519	QF 1,22	ЗУ	China 3	046	2026-05-09 21:35:37.921873	13.5873
14521	QF 2,21	ЗУ	China 5	048	2026-05-09 21:35:37.921873	20.4507
14523	QF 2,23	ЗУ	China 7	050	2026-05-09 21:35:37.921873	9.2631
14525	Q8	ЗУ	DIG	061	2026-05-09 21:35:46.2054	45.6289
14527	Q20	ЗУ	MO 10	072	2026-05-09 21:35:46.878557	13.4358
14529	Q22	ЗУ	MO 12	074	2026-05-09 21:35:46.878557	0.7024
14531	Q24	ЗУ	MO 14	076	2026-05-09 21:35:46.878557	1.431
14533	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:35:47.435767	20.3402
14535	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:35:47.435767	16.5266
14537	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:35:47.435767	20.877
14540	Q9	ЗУ	BG 2	063	2026-05-09 21:36:05.85967	33.6287
14542	Q10	ЗУ	SM 2	064	2026-05-09 21:36:06.199501	18.2307
14544	Q12	ЗУ	SM 4	066	2026-05-09 21:36:06.199501	0.7086
14546	Q14	ЗУ	SM 6	068	2026-05-09 21:36:06.199501	1.3991
14548	Q16	ЗУ	SM 8	070	2026-05-09 21:36:06.199501	2.2103
14549	QF 1,20	ЗУ	China 1	044	2026-05-09 21:36:17.950295	12.2571
14551	QF 1,22	ЗУ	China 3	046	2026-05-09 21:36:17.950295	14.6485
14553	QF 2,21	ЗУ	China 5	048	2026-05-09 21:36:17.950295	20.9084
14555	QF 2,23	ЗУ	China 7	050	2026-05-09 21:36:17.950295	9.3951
14557	Q8	ЗУ	DIG	061	2026-05-09 21:36:21.278479	46.9524
14559	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:36:22.473089	8.6358
14561	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:36:22.473089	7.6207
14563	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:36:22.473089	18.5416
14564	TP3	ЗУ	CP-300 New	078	2026-05-09 21:36:36.217831	7.6224
14566	Q20	ЗУ	MO 10	072	2026-05-09 21:36:36.903855	13.051
14568	Q22	ЗУ	MO 12	074	2026-05-09 21:36:36.903855	1.08
14570	Q24	ЗУ	MO 14	076	2026-05-09 21:36:36.903855	0.9775
14572	Q4	ЗУ	BG 1	062	2026-05-09 21:36:50.91119	20.398
14574	Q10	ЗУ	SM 2	064	2026-05-09 21:36:51.241796	19.3386
14576	Q12	ЗУ	SM 4	066	2026-05-09 21:36:51.241796	1.7235
14578	Q14	ЗУ	SM 6	068	2026-05-09 21:36:51.241796	1.3648
14580	Q16	ЗУ	SM 8	070	2026-05-09 21:36:51.241796	2.5323
14581	Q8	ЗУ	DIG	061	2026-05-09 21:36:56.306795	46.1101
14583	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:36:57.508488	8.9773
14585	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:36:57.508488	8.1089
14587	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:36:57.508488	19.1022
14589	QF 1,21	ЗУ	China 2	045	2026-05-09 21:36:58.02292	10.5067
14591	QF 2,20	ЗУ	China 4	047	2026-05-09 21:36:58.02292	18.8078
14593	QF 2,22	ЗУ	China 6	049	2026-05-09 21:36:58.02292	20.426
14595	QF 2,19	ЗУ	China 8	051	2026-05-09 21:36:58.02292	14.3757
16024	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:07:54.881369	19.1558
16027	Q17	ЗУ	MO 9	071	2026-05-10 01:08:18.718263	1.2764
16029	Q21	ЗУ	MO 11	073	2026-05-10 01:08:18.718263	0.8714
16031	Q23	ЗУ	MO 13	075	2026-05-10 01:08:18.718263	1.1017
16033	Q25	ЗУ	MO 15	077	2026-05-10 01:08:18.718263	0.3735
16035	QF 1,21	ЗУ	China 2	045	2026-05-10 01:08:20.896184	10.0363
16037	QF 2,20	ЗУ	China 4	047	2026-05-10 01:08:20.896184	19.3401
16039	QF 2,22	ЗУ	China 6	049	2026-05-10 01:08:20.896184	19.0685
16041	QF 2,19	ЗУ	China 8	051	2026-05-10 01:08:20.896184	15.0437
16043	Q9	ЗУ	BG 2	063	2026-05-10 01:08:22.486625	33.3965
16045	Q11	ЗУ	SM 3	065	2026-05-10 01:08:22.806213	21.4783
16047	Q13	ЗУ	SM 5	067	2026-05-10 01:08:22.806213	0.9312
16049	Q15	ЗУ	SM 7	069	2026-05-10 01:08:22.806213	0.5312
16052	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:08:29.928966	21.4136
16054	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:08:29.928966	16.9854
16056	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:08:29.928966	20.656
16058	TP3	ЗУ	CP-300 New	078	2026-05-10 01:08:37.812226	6.2304
16059	QF 1,20	ЗУ	China 1	044	2026-05-10 01:09:00.929844	11.9294
16061	QF 1,22	ЗУ	China 3	046	2026-05-10 01:09:00.929844	13.5489
16063	QF 2,21	ЗУ	China 5	048	2026-05-10 01:09:00.929844	20.8497
16065	QF 2,23	ЗУ	China 7	050	2026-05-10 01:09:00.929844	9.8314
16067	Q8	ЗУ	DIG	061	2026-05-10 01:09:02.787045	47.1641
16068	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:09:04.969709	21.6034
16070	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:09:04.969709	16.3565
16072	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:09:04.969709	19.1756
16074	Q4	ЗУ	BG 1	062	2026-05-10 01:09:07.507062	20.1112
16076	Q10	ЗУ	SM 2	064	2026-05-10 01:09:07.844762	18.4328
16078	Q11	ЗУ	SM 3	065	2026-05-10 01:09:07.844762	21.6876
16080	Q13	ЗУ	SM 5	067	2026-05-10 01:09:07.844762	0.9589
16082	Q15	ЗУ	SM 7	069	2026-05-10 01:09:07.844762	0.9847
16084	Q17	ЗУ	MO 9	071	2026-05-10 01:09:08.74603	1.3218
16086	Q21	ЗУ	MO 11	073	2026-05-10 01:09:08.74603	1.0174
16088	Q23	ЗУ	MO 13	075	2026-05-10 01:09:08.74603	0.7873
16090	Q25	ЗУ	MO 15	077	2026-05-10 01:09:08.74603	0.695
16091	Q8	ЗУ	DIG	061	2026-05-10 01:09:37.80486	46.9907
16093	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:09:39.994039	21.3814
16095	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:09:39.994039	16.5795
16097	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:09:39.994039	19.9478
16099	QF 1,20	ЗУ	China 1	044	2026-05-10 01:09:41.071812	12.1985
16101	QF 1,22	ЗУ	China 3	046	2026-05-10 01:09:41.071812	13.351
16103	QF 2,21	ЗУ	China 5	048	2026-05-10 01:09:41.071812	20.0388
16105	QF 2,23	ЗУ	China 7	050	2026-05-10 01:09:41.071812	10.3357
16108	Q9	ЗУ	BG 2	063	2026-05-10 01:09:52.534605	33.1984
16110	Q11	ЗУ	SM 3	065	2026-05-10 01:09:52.885249	21.9621
16112	Q13	ЗУ	SM 5	067	2026-05-10 01:09:52.885249	0.8462
16114	Q15	ЗУ	SM 7	069	2026-05-10 01:09:52.885249	0.638
16116	Q17	ЗУ	MO 9	071	2026-05-10 01:09:58.784164	0.7321
16118	Q21	ЗУ	MO 11	073	2026-05-10 01:09:58.784164	0.4976
16120	Q23	ЗУ	MO 13	075	2026-05-10 01:09:58.784164	0.6043
16122	Q25	ЗУ	MO 15	077	2026-05-10 01:09:58.784164	0.6365
16123	TP3	ЗУ	CP-300 New	078	2026-05-10 01:10:07.87956	6.254
16125	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:10:15.097557	20.5823
16127	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:10:15.097557	17.7974
16129	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:10:15.097557	19.4282
16131	QF 1,20	ЗУ	China 1	044	2026-05-10 01:10:21.106012	11.7803
17228	Q8	ЗУ	DIG	061	2026-05-10 01:35:18.693527	45.6609
14508	Q9	ЗУ	BG 2	063	2026-05-09 21:35:20.824176	33.4941
14510	Q11	ЗУ	SM 3	065	2026-05-09 21:35:21.138239	22.1742
14512	Q13	ЗУ	SM 5	067	2026-05-09 21:35:21.138239	1.5445
14514	Q15	ЗУ	SM 7	069	2026-05-09 21:35:21.138239	1.664
14516	TP3	ЗУ	CP-300 New	078	2026-05-09 21:35:36.157174	6.6191
14518	QF 1,21	ЗУ	China 2	045	2026-05-09 21:35:37.921873	11.5964
14520	QF 2,20	ЗУ	China 4	047	2026-05-09 21:35:37.921873	19.0028
14522	QF 2,22	ЗУ	China 6	049	2026-05-09 21:35:37.921873	20.4688
14524	QF 2,19	ЗУ	China 8	051	2026-05-09 21:35:37.921873	14.5576
14526	Q17	ЗУ	MO 9	071	2026-05-09 21:35:46.878557	1.3553
14528	Q21	ЗУ	MO 11	073	2026-05-09 21:35:46.878557	1.3912
14530	Q23	ЗУ	MO 13	075	2026-05-09 21:35:46.878557	0.8153
14532	Q25	ЗУ	MO 15	077	2026-05-09 21:35:46.878557	1.2911
14534	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:35:47.435767	8.4243
14536	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:35:47.435767	8.4262
14538	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:35:47.435767	19.647
14539	Q4	ЗУ	BG 1	062	2026-05-09 21:36:05.85967	20.9704
14541	TP3	ЗУ	CP-300 New	078	2026-05-09 21:36:06.185143	7.712
14543	Q11	ЗУ	SM 3	065	2026-05-09 21:36:06.199501	22.132
14545	Q13	ЗУ	SM 5	067	2026-05-09 21:36:06.199501	1.3129
14547	Q15	ЗУ	SM 7	069	2026-05-09 21:36:06.199501	1.5287
14550	QF 1,21	ЗУ	China 2	045	2026-05-09 21:36:17.950295	11.1152
14552	QF 2,20	ЗУ	China 4	047	2026-05-09 21:36:17.950295	19.5056
14554	QF 2,22	ЗУ	China 6	049	2026-05-09 21:36:17.950295	20.1938
14556	QF 2,19	ЗУ	China 8	051	2026-05-09 21:36:17.950295	14.5663
14558	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:36:22.473089	21.2741
14560	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:36:22.473089	16.6809
14562	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:36:22.473089	20.6586
14565	Q17	ЗУ	MO 9	071	2026-05-09 21:36:36.903855	1.3494
14567	Q21	ЗУ	MO 11	073	2026-05-09 21:36:36.903855	0.5944
14569	Q23	ЗУ	MO 13	075	2026-05-09 21:36:36.903855	0.8091
14571	Q25	ЗУ	MO 15	077	2026-05-09 21:36:36.903855	1.3225
14573	Q9	ЗУ	BG 2	063	2026-05-09 21:36:50.91119	33.2001
14575	Q11	ЗУ	SM 3	065	2026-05-09 21:36:51.241796	21.6499
14577	Q13	ЗУ	SM 5	067	2026-05-09 21:36:51.241796	1.8398
14579	Q15	ЗУ	SM 7	069	2026-05-09 21:36:51.241796	0.6853
14582	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:36:57.508488	21.359
14584	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:36:57.508488	17.4189
14586	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:36:57.508488	21.061
14588	QF 1,20	ЗУ	China 1	044	2026-05-09 21:36:58.02292	11.8109
14590	QF 1,22	ЗУ	China 3	046	2026-05-09 21:36:58.02292	13.6371
14592	QF 2,21	ЗУ	China 5	048	2026-05-09 21:36:58.02292	20.4055
14594	QF 2,23	ЗУ	China 7	050	2026-05-09 21:36:58.02292	9.3687
14596	TP3	ЗУ	CP-300 New	078	2026-05-09 21:37:06.236479	7.7815
14597	Q17	ЗУ	MO 9	071	2026-05-09 21:37:26.939591	1.2406
14598	Q20	ЗУ	MO 10	072	2026-05-09 21:37:26.939591	13.4079
14599	Q21	ЗУ	MO 11	073	2026-05-09 21:37:26.939591	0.5169
14600	Q22	ЗУ	MO 12	074	2026-05-09 21:37:26.939591	0.5748
14601	Q23	ЗУ	MO 13	075	2026-05-09 21:37:26.939591	1.2937
14602	Q24	ЗУ	MO 14	076	2026-05-09 21:37:26.939591	1.1124
14603	Q25	ЗУ	MO 15	077	2026-05-09 21:37:26.939591	0.6358
14604	Q8	ЗУ	DIG	061	2026-05-09 21:37:31.324673	46.6454
14605	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:37:32.540315	21.0156
14606	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:37:32.540315	8.7328
14607	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:37:32.540315	16.4377
14608	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:37:32.540315	8.7268
14609	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:37:32.540315	19.4985
14610	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:37:32.540315	18.3402
14611	Q4	ЗУ	BG 1	062	2026-05-09 21:37:35.965466	20.9514
14612	Q9	ЗУ	BG 2	063	2026-05-09 21:37:35.965466	33.2292
14613	TP3	ЗУ	CP-300 New	078	2026-05-09 21:37:36.272702	6.6319
14614	Q10	ЗУ	SM 2	064	2026-05-09 21:37:36.283274	19.2911
14615	Q11	ЗУ	SM 3	065	2026-05-09 21:37:36.283274	21.6443
14616	Q12	ЗУ	SM 4	066	2026-05-09 21:37:36.283274	0.6656
14617	Q13	ЗУ	SM 5	067	2026-05-09 21:37:36.283274	0.9213
14618	Q14	ЗУ	SM 6	068	2026-05-09 21:37:36.283274	1.6094
14619	Q15	ЗУ	SM 7	069	2026-05-09 21:37:36.283274	0.7459
14620	Q16	ЗУ	SM 8	070	2026-05-09 21:37:36.283274	3.2148
14621	QF 1,20	ЗУ	China 1	044	2026-05-09 21:37:38.065314	11.2086
14622	QF 1,21	ЗУ	China 2	045	2026-05-09 21:37:38.065314	11.3497
14623	QF 1,22	ЗУ	China 3	046	2026-05-09 21:37:38.065314	14.164
14624	QF 2,20	ЗУ	China 4	047	2026-05-09 21:37:38.065314	18.5623
14625	QF 2,21	ЗУ	China 5	048	2026-05-09 21:37:38.065314	20.4379
14626	QF 2,22	ЗУ	China 6	049	2026-05-09 21:37:38.065314	19.3799
14627	QF 2,23	ЗУ	China 7	050	2026-05-09 21:37:38.065314	10.5862
14628	QF 2,19	ЗУ	China 8	051	2026-05-09 21:37:38.065314	14.4871
14629	TP3	ЗУ	CP-300 New	078	2026-05-09 21:38:06.289258	6.9508
14630	Q8	ЗУ	DIG	061	2026-05-09 21:38:06.347717	45.9865
14631	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:38:07.585043	21.244
14632	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:38:07.585043	9.1825
14633	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:38:07.585043	17.2416
14634	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:38:07.585043	8.5211
14635	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:38:07.585043	21.0407
14636	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:38:07.585043	18.6982
14637	Q17	ЗУ	MO 9	071	2026-05-09 21:38:17.018155	0.5899
14638	Q20	ЗУ	MO 10	072	2026-05-09 21:38:17.018155	13.9432
14639	Q21	ЗУ	MO 11	073	2026-05-09 21:38:17.018155	1.0958
14640	Q22	ЗУ	MO 12	074	2026-05-09 21:38:17.018155	0.7016
14641	Q23	ЗУ	MO 13	075	2026-05-09 21:38:17.018155	0.9938
14642	Q24	ЗУ	MO 14	076	2026-05-09 21:38:17.018155	0.6798
14643	Q25	ЗУ	MO 15	077	2026-05-09 21:38:17.018155	1.4678
14644	QF 1,20	ЗУ	China 1	044	2026-05-09 21:38:18.166372	12.6527
14645	QF 1,21	ЗУ	China 2	045	2026-05-09 21:38:18.166372	10.771
14646	QF 1,22	ЗУ	China 3	046	2026-05-09 21:38:18.166372	14.4725
14647	QF 2,20	ЗУ	China 4	047	2026-05-09 21:38:18.166372	18.2897
14648	QF 2,21	ЗУ	China 5	048	2026-05-09 21:38:18.166372	20.4446
14649	QF 2,22	ЗУ	China 6	049	2026-05-09 21:38:18.166372	20.2528
14650	QF 2,23	ЗУ	China 7	050	2026-05-09 21:38:18.166372	9.4252
14651	QF 2,19	ЗУ	China 8	051	2026-05-09 21:38:18.166372	14.4618
14652	Q4	ЗУ	BG 1	062	2026-05-09 21:38:20.997675	21.5244
14653	Q9	ЗУ	BG 2	063	2026-05-09 21:38:20.997675	32.7084
14654	Q10	ЗУ	SM 2	064	2026-05-09 21:38:21.317679	19.3163
14655	Q11	ЗУ	SM 3	065	2026-05-09 21:38:21.317679	21.9439
14657	Q13	ЗУ	SM 5	067	2026-05-09 21:38:21.317679	1.665
14659	Q15	ЗУ	SM 7	069	2026-05-09 21:38:21.317679	1.1406
14662	Q8	ЗУ	DIG	061	2026-05-09 21:38:41.365117	46.0194
14664	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:38:42.621299	8.8543
14666	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:38:42.621299	7.8113
14668	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:38:42.621299	19.258
14669	QF 1,20	ЗУ	China 1	044	2026-05-09 21:38:58.216081	11.1863
14671	QF 1,22	ЗУ	China 3	046	2026-05-09 21:38:58.216081	14.3462
14673	QF 2,21	ЗУ	China 5	048	2026-05-09 21:38:58.216081	21.5607
14675	QF 2,23	ЗУ	China 7	050	2026-05-09 21:38:58.216081	10.2695
14677	Q4	ЗУ	BG 1	062	2026-05-09 21:39:06.018567	21.0887
14679	TP3	ЗУ	CP-300 New	078	2026-05-09 21:39:06.328617	7.5761
14681	Q11	ЗУ	SM 3	065	2026-05-09 21:39:06.352617	21.4238
14683	Q13	ЗУ	SM 5	067	2026-05-09 21:39:06.352617	1.6916
14685	Q15	ЗУ	SM 7	069	2026-05-09 21:39:06.352617	0.854
14687	Q17	ЗУ	MO 9	071	2026-05-09 21:39:07.059192	0.7578
14689	Q21	ЗУ	MO 11	073	2026-05-09 21:39:07.059192	0.5285
14691	Q23	ЗУ	MO 13	075	2026-05-09 21:39:07.059192	0.5324
14693	Q25	ЗУ	MO 15	077	2026-05-09 21:39:07.059192	1.3418
14694	Q8	ЗУ	DIG	061	2026-05-09 21:39:16.37734	46.2474
14696	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:39:17.653475	9.6291
14698	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:39:17.653475	7.291
14700	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:39:17.653475	19.3303
14701	TP3	ЗУ	CP-300 New	078	2026-05-09 21:39:36.354896	7.8466
14703	QF 1,21	ЗУ	China 2	045	2026-05-09 21:39:38.253623	10.3016
14705	QF 2,20	ЗУ	China 4	047	2026-05-09 21:39:38.253623	18.3427
14707	QF 2,22	ЗУ	China 6	049	2026-05-09 21:39:38.253623	19.2331
14709	QF 2,19	ЗУ	China 8	051	2026-05-09 21:39:38.253623	14.2209
14711	Q9	ЗУ	BG 2	063	2026-05-09 21:39:51.035272	32.4376
14713	Q11	ЗУ	SM 3	065	2026-05-09 21:39:51.384796	21.8815
14715	Q12	ЗУ	SM 4	066	2026-05-09 21:39:51.384796	0.7823
14717	Q14	ЗУ	SM 6	068	2026-05-09 21:39:51.384796	0.9689
14719	Q16	ЗУ	SM 8	070	2026-05-09 21:39:51.384796	2.2879
14721	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:39:52.711985	9.6564
14723	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:39:52.711985	8.0952
14725	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:39:52.711985	19.4675
14726	Q17	ЗУ	MO 9	071	2026-05-09 21:39:57.094375	1.1043
14728	Q21	ЗУ	MO 11	073	2026-05-09 21:39:57.094375	0.8475
14730	Q23	ЗУ	MO 13	075	2026-05-09 21:39:57.094375	0.7817
14732	Q25	ЗУ	MO 15	077	2026-05-09 21:39:57.094375	1.3326
14735	QF 1,21	ЗУ	China 2	045	2026-05-09 21:40:18.301829	10.5875
14737	QF 2,20	ЗУ	China 4	047	2026-05-09 21:40:18.301829	19.1515
14739	QF 2,22	ЗУ	China 6	049	2026-05-09 21:40:18.301829	19.6263
14741	QF 2,19	ЗУ	China 8	051	2026-05-09 21:40:18.301829	15.2025
14743	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:40:27.763252	20.3873
14745	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:40:27.763252	17.6551
14747	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:40:27.763252	19.4621
14750	Q9	ЗУ	BG 2	063	2026-05-09 21:40:36.080133	33.4922
14752	Q11	ЗУ	SM 3	065	2026-05-09 21:40:36.424063	21.603
14754	Q13	ЗУ	SM 5	067	2026-05-09 21:40:36.424063	1.036
14756	Q15	ЗУ	SM 7	069	2026-05-09 21:40:36.424063	0.9591
14758	Q16	ЗУ	SM 8	070	2026-05-09 21:40:36.424063	2.2986
14760	Q20	ЗУ	MO 10	072	2026-05-09 21:40:47.130995	13.3617
14762	Q22	ЗУ	MO 12	074	2026-05-09 21:40:47.130995	1.1613
14764	Q24	ЗУ	MO 14	076	2026-05-09 21:40:47.130995	0.745
14767	QF 1,21	ЗУ	China 2	045	2026-05-09 21:40:58.496748	11.4847
14769	QF 2,20	ЗУ	China 4	047	2026-05-09 21:40:58.496748	18.6568
14771	QF 2,22	ЗУ	China 6	049	2026-05-09 21:40:58.496748	20.6173
14773	QF 2,19	ЗУ	China 8	051	2026-05-09 21:40:58.496748	14.2672
14775	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:41:02.848545	21.3844
14777	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:41:02.848545	16.3602
14779	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:41:02.848545	19.8029
14781	TP3	ЗУ	CP-300 New	078	2026-05-09 21:41:06.46591	5.9797
14782	Q4	ЗУ	BG 1	062	2026-05-09 21:41:21.181409	21.1993
14784	Q10	ЗУ	SM 2	064	2026-05-09 21:41:21.470344	19.1377
14786	Q12	ЗУ	SM 4	066	2026-05-09 21:41:21.470344	0.8431
14788	Q14	ЗУ	SM 6	068	2026-05-09 21:41:21.470344	1.6477
14790	Q16	ЗУ	SM 8	070	2026-05-09 21:41:21.470344	2.4154
14791	TP3	ЗУ	CP-300 New	078	2026-05-09 21:41:36.486452	6.3388
14793	Q17	ЗУ	MO 9	071	2026-05-09 21:41:37.218224	1.0336
14795	Q21	ЗУ	MO 11	073	2026-05-09 21:41:37.218224	0.6754
14797	Q23	ЗУ	MO 13	075	2026-05-09 21:41:37.218224	1.0575
14799	Q25	ЗУ	MO 15	077	2026-05-09 21:41:37.218224	1.448
14801	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:41:37.881393	9.3923
14803	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:41:37.881393	7.5036
14805	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:41:37.881393	19.366
14807	QF 1,21	ЗУ	China 2	045	2026-05-09 21:41:38.548168	11.373
14809	QF 2,20	ЗУ	China 4	047	2026-05-09 21:41:38.548168	18.7309
14811	QF 2,22	ЗУ	China 6	049	2026-05-09 21:41:38.548168	19.8399
14813	QF 2,19	ЗУ	China 8	051	2026-05-09 21:41:38.548168	15.0753
14814	Q4	ЗУ	BG 1	062	2026-05-09 21:42:06.205532	20.7178
14816	TP3	ЗУ	CP-300 New	078	2026-05-09 21:42:06.504065	7.5909
14818	Q11	ЗУ	SM 3	065	2026-05-09 21:42:06.510384	21.4737
14820	Q13	ЗУ	SM 5	067	2026-05-09 21:42:06.510384	1.3091
14822	Q15	ЗУ	SM 7	069	2026-05-09 21:42:06.510384	0.8065
14824	Q8	ЗУ	DIG	061	2026-05-09 21:42:11.526385	45.8739
14826	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:42:12.915678	9.5655
14828	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:42:12.915678	8.3579
14830	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:42:12.915678	18.5924
14831	QF 1,20	ЗУ	China 1	044	2026-05-09 21:42:18.584929	11.069
14833	QF 1,22	ЗУ	China 3	046	2026-05-09 21:42:18.584929	14.5431
14835	QF 2,21	ЗУ	China 5	048	2026-05-09 21:42:18.584929	21.5174
14837	QF 2,23	ЗУ	China 7	050	2026-05-09 21:42:18.584929	9.9532
14839	Q17	ЗУ	MO 9	071	2026-05-09 21:42:27.259182	1.1106
14841	Q21	ЗУ	MO 11	073	2026-05-09 21:42:27.259182	1.1367
14843	Q23	ЗУ	MO 13	075	2026-05-09 21:42:27.259182	0.4877
14845	Q25	ЗУ	MO 15	077	2026-05-09 21:42:27.259182	0.8119
14846	TP3	ЗУ	CP-300 New	078	2026-05-09 21:42:36.524113	7.4042
14848	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:42:47.952304	21.8201
14850	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:42:47.952304	16.6856
14852	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:42:47.952304	19.5219
14656	Q12	ЗУ	SM 4	066	2026-05-09 21:38:21.317679	0.8139
14658	Q14	ЗУ	SM 6	068	2026-05-09 21:38:21.317679	0.9331
14660	Q16	ЗУ	SM 8	070	2026-05-09 21:38:21.317679	3.0584
14661	TP3	ЗУ	CP-300 New	078	2026-05-09 21:38:36.316566	7.0089
14663	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:38:42.621299	22.0447
14665	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:38:42.621299	16.3448
14667	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:38:42.621299	19.5762
14670	QF 1,21	ЗУ	China 2	045	2026-05-09 21:38:58.216081	10.8639
14672	QF 2,20	ЗУ	China 4	047	2026-05-09 21:38:58.216081	18.5907
14674	QF 2,22	ЗУ	China 6	049	2026-05-09 21:38:58.216081	20.3224
14676	QF 2,19	ЗУ	China 8	051	2026-05-09 21:38:58.216081	14.9682
14678	Q9	ЗУ	BG 2	063	2026-05-09 21:39:06.018567	32.9526
14680	Q10	ЗУ	SM 2	064	2026-05-09 21:39:06.352617	18.9664
14682	Q12	ЗУ	SM 4	066	2026-05-09 21:39:06.352617	0.827
14684	Q14	ЗУ	SM 6	068	2026-05-09 21:39:06.352617	1.378
14686	Q16	ЗУ	SM 8	070	2026-05-09 21:39:06.352617	2.4666
14688	Q20	ЗУ	MO 10	072	2026-05-09 21:39:07.059192	13.4436
14690	Q22	ЗУ	MO 12	074	2026-05-09 21:39:07.059192	0.5166
14692	Q24	ЗУ	MO 14	076	2026-05-09 21:39:07.059192	1.1994
14695	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:39:17.653475	21.7123
14697	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:39:17.653475	17.2681
14699	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:39:17.653475	20.3728
14702	QF 1,20	ЗУ	China 1	044	2026-05-09 21:39:38.253623	11.3176
14704	QF 1,22	ЗУ	China 3	046	2026-05-09 21:39:38.253623	14.5991
14706	QF 2,21	ЗУ	China 5	048	2026-05-09 21:39:38.253623	20.1789
14708	QF 2,23	ЗУ	China 7	050	2026-05-09 21:39:38.253623	9.2213
14710	Q4	ЗУ	BG 1	062	2026-05-09 21:39:51.035272	21.0299
14712	Q10	ЗУ	SM 2	064	2026-05-09 21:39:51.384796	19.1112
14714	Q8	ЗУ	DIG	061	2026-05-09 21:39:51.396921	47.0443
14716	Q13	ЗУ	SM 5	067	2026-05-09 21:39:51.384796	1.4081
14718	Q15	ЗУ	SM 7	069	2026-05-09 21:39:51.384796	1.1172
14720	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:39:52.711985	20.4437
14722	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:39:52.711985	18.0509
14724	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:39:52.711985	19.4952
14727	Q20	ЗУ	MO 10	072	2026-05-09 21:39:57.094375	13.3234
14729	Q22	ЗУ	MO 12	074	2026-05-09 21:39:57.094375	1.0622
14731	Q24	ЗУ	MO 14	076	2026-05-09 21:39:57.094375	0.8432
14733	TP3	ЗУ	CP-300 New	078	2026-05-09 21:40:06.386893	6.1206
14734	QF 1,20	ЗУ	China 1	044	2026-05-09 21:40:18.301829	11.2764
14736	QF 1,22	ЗУ	China 3	046	2026-05-09 21:40:18.301829	13.7756
14738	QF 2,21	ЗУ	China 5	048	2026-05-09 21:40:18.301829	20.906
14740	QF 2,23	ЗУ	China 7	050	2026-05-09 21:40:18.301829	9.5863
14742	Q8	ЗУ	DIG	061	2026-05-09 21:40:26.419553	45.7949
14744	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:40:27.763252	10.0638
14746	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:40:27.763252	8.3358
14748	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:40:27.763252	18.4354
14749	Q4	ЗУ	BG 1	062	2026-05-09 21:40:36.080133	20.5539
14751	Q10	ЗУ	SM 2	064	2026-05-09 21:40:36.424063	18.2817
14753	Q12	ЗУ	SM 4	066	2026-05-09 21:40:36.424063	1.5936
14755	Q14	ЗУ	SM 6	068	2026-05-09 21:40:36.424063	1.1394
14757	TP3	ЗУ	CP-300 New	078	2026-05-09 21:40:36.45144	7.0757
14759	Q17	ЗУ	MO 9	071	2026-05-09 21:40:47.130995	0.6883
14761	Q21	ЗУ	MO 11	073	2026-05-09 21:40:47.130995	1.0507
14763	Q23	ЗУ	MO 13	075	2026-05-09 21:40:47.130995	0.5168
14765	Q25	ЗУ	MO 15	077	2026-05-09 21:40:47.130995	0.5789
14766	QF 1,20	ЗУ	China 1	044	2026-05-09 21:40:58.496748	12.3245
14768	QF 1,22	ЗУ	China 3	046	2026-05-09 21:40:58.496748	13.4492
14770	QF 2,21	ЗУ	China 5	048	2026-05-09 21:40:58.496748	21.4117
14772	QF 2,23	ЗУ	China 7	050	2026-05-09 21:40:58.496748	10.5768
14774	Q8	ЗУ	DIG	061	2026-05-09 21:41:01.493859	45.4282
14776	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:41:02.848545	9.6306
14778	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:41:02.848545	8.419
14780	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:41:02.848545	18.4358
14783	Q9	ЗУ	BG 2	063	2026-05-09 21:41:21.181409	32.6922
14785	Q11	ЗУ	SM 3	065	2026-05-09 21:41:21.470344	21.1599
14787	Q13	ЗУ	SM 5	067	2026-05-09 21:41:21.470344	0.8452
14789	Q15	ЗУ	SM 7	069	2026-05-09 21:41:21.470344	1.482
14792	Q8	ЗУ	DIG	061	2026-05-09 21:41:36.515617	46.7005
14794	Q20	ЗУ	MO 10	072	2026-05-09 21:41:37.218224	13.5898
14796	Q22	ЗУ	MO 12	074	2026-05-09 21:41:37.218224	0.987
14798	Q24	ЗУ	MO 14	076	2026-05-09 21:41:37.218224	1.4054
14800	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:41:37.881393	21.6515
14802	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:41:37.881393	17.4837
14804	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:41:37.881393	19.4285
14806	QF 1,20	ЗУ	China 1	044	2026-05-09 21:41:38.548168	11.7846
14808	QF 1,22	ЗУ	China 3	046	2026-05-09 21:41:38.548168	14.3097
14810	QF 2,21	ЗУ	China 5	048	2026-05-09 21:41:38.548168	20.8122
14812	QF 2,23	ЗУ	China 7	050	2026-05-09 21:41:38.548168	9.2087
14815	Q9	ЗУ	BG 2	063	2026-05-09 21:42:06.205532	32.9222
14817	Q10	ЗУ	SM 2	064	2026-05-09 21:42:06.510384	18.6533
14819	Q12	ЗУ	SM 4	066	2026-05-09 21:42:06.510384	1.1791
14821	Q14	ЗУ	SM 6	068	2026-05-09 21:42:06.510384	0.7877
14823	Q16	ЗУ	SM 8	070	2026-05-09 21:42:06.510384	2.9829
14825	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:42:12.915678	20.9615
14827	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:42:12.915678	16.6457
14829	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:42:12.915678	20.4416
14832	QF 1,21	ЗУ	China 2	045	2026-05-09 21:42:18.584929	10.5946
14834	QF 2,20	ЗУ	China 4	047	2026-05-09 21:42:18.584929	18.8113
14836	QF 2,22	ЗУ	China 6	049	2026-05-09 21:42:18.584929	20.0461
14838	QF 2,19	ЗУ	China 8	051	2026-05-09 21:42:18.584929	15.5083
14840	Q20	ЗУ	MO 10	072	2026-05-09 21:42:27.259182	13.4809
14842	Q22	ЗУ	MO 12	074	2026-05-09 21:42:27.259182	1.234
14844	Q24	ЗУ	MO 14	076	2026-05-09 21:42:27.259182	1.1805
14847	Q8	ЗУ	DIG	061	2026-05-09 21:42:46.540869	47.0402
14849	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:42:47.952304	9.348
14851	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:42:47.952304	9.0263
14853	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:42:47.952304	18.722
14855	Q9	ЗУ	BG 2	063	2026-05-09 21:42:51.223687	32.7119
14857	Q11	ЗУ	SM 3	065	2026-05-09 21:42:51.546762	21.681
14859	Q13	ЗУ	SM 5	067	2026-05-09 21:42:51.546762	0.7474
14861	Q15	ЗУ	SM 7	069	2026-05-09 21:42:51.546762	1.6102
14864	QF 1,21	ЗУ	China 2	045	2026-05-09 21:42:58.62901	11.3369
14854	Q4	ЗУ	BG 1	062	2026-05-09 21:42:51.223687	21.066
14856	Q10	ЗУ	SM 2	064	2026-05-09 21:42:51.546762	18.9122
14858	Q12	ЗУ	SM 4	066	2026-05-09 21:42:51.546762	0.9938
14860	Q14	ЗУ	SM 6	068	2026-05-09 21:42:51.546762	0.6819
14862	Q16	ЗУ	SM 8	070	2026-05-09 21:42:51.546762	2.3814
14863	QF 1,20	ЗУ	China 1	044	2026-05-09 21:42:58.62901	12.5769
14865	QF 1,22	ЗУ	China 3	046	2026-05-09 21:42:58.62901	13.7367
14867	QF 2,21	ЗУ	China 5	048	2026-05-09 21:42:58.62901	20.5159
14869	QF 2,23	ЗУ	China 7	050	2026-05-09 21:42:58.62901	10.2554
14871	TP3	ЗУ	CP-300 New	078	2026-05-09 21:43:06.53744	7.4983
14872	Q17	ЗУ	MO 9	071	2026-05-09 21:43:17.299334	0.8919
14874	Q21	ЗУ	MO 11	073	2026-05-09 21:43:17.299334	1.2406
14876	Q23	ЗУ	MO 13	075	2026-05-09 21:43:17.299334	1.2003
14878	Q25	ЗУ	MO 15	077	2026-05-09 21:43:17.299334	0.6299
14880	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:43:22.983348	21.5798
14882	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:43:22.983348	16.7358
14884	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:43:22.983348	19.3763
14887	Q9	ЗУ	BG 2	063	2026-05-09 21:43:36.247526	32.2855
14889	Q10	ЗУ	SM 2	064	2026-05-09 21:43:36.581935	18.7464
14891	Q12	ЗУ	SM 4	066	2026-05-09 21:43:36.581935	1.7901
14893	Q14	ЗУ	SM 6	068	2026-05-09 21:43:36.581935	1.1377
14895	Q16	ЗУ	SM 8	070	2026-05-09 21:43:36.581935	3.0158
14897	QF 1,21	ЗУ	China 2	045	2026-05-09 21:43:38.671228	11.0252
14899	QF 2,20	ЗУ	China 4	047	2026-05-09 21:43:38.671228	18.7815
14901	QF 2,22	ЗУ	China 6	049	2026-05-09 21:43:38.671228	20.3215
14903	QF 2,19	ЗУ	China 8	051	2026-05-09 21:43:38.671228	15.2389
14904	Q8	ЗУ	DIG	061	2026-05-09 21:43:56.573167	47.1712
14906	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:43:58.014564	8.6023
14908	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:43:58.014564	8.9532
14910	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:43:58.014564	18.4002
14912	Q17	ЗУ	MO 9	071	2026-05-09 21:44:07.341526	1.0425
14914	Q21	ЗУ	MO 11	073	2026-05-09 21:44:07.341526	1.1184
14916	Q23	ЗУ	MO 13	075	2026-05-09 21:44:07.341526	0.9304
14918	Q25	ЗУ	MO 15	077	2026-05-09 21:44:07.341526	1.1605
14919	QF 1,20	ЗУ	China 1	044	2026-05-09 21:44:18.753004	11.3508
14921	QF 1,22	ЗУ	China 3	046	2026-05-09 21:44:18.753004	13.7286
14923	QF 2,21	ЗУ	China 5	048	2026-05-09 21:44:18.753004	20.6246
14925	QF 2,23	ЗУ	China 7	050	2026-05-09 21:44:18.753004	9.4725
14927	Q4	ЗУ	BG 1	062	2026-05-09 21:44:21.27446	20.6768
14929	Q10	ЗУ	SM 2	064	2026-05-09 21:44:21.618095	18.3681
14931	Q12	ЗУ	SM 4	066	2026-05-09 21:44:21.618095	1.4721
14933	Q14	ЗУ	SM 6	068	2026-05-09 21:44:21.618095	0.9926
14935	Q16	ЗУ	SM 8	070	2026-05-09 21:44:21.618095	2.5186
14937	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:44:33.053083	20.4113
14939	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:44:33.053083	18.0333
14941	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:44:33.053083	19.356
14944	Q17	ЗУ	MO 9	071	2026-05-09 21:44:57.387717	1.1986
14946	Q21	ЗУ	MO 11	073	2026-05-09 21:44:57.387717	1.2977
14948	Q23	ЗУ	MO 13	075	2026-05-09 21:44:57.387717	0.7433
14950	Q25	ЗУ	MO 15	077	2026-05-09 21:44:57.387717	1.2409
14952	QF 1,21	ЗУ	China 2	045	2026-05-09 21:44:58.827652	11.444
14954	QF 2,20	ЗУ	China 4	047	2026-05-09 21:44:58.827652	19.5291
14956	QF 2,22	ЗУ	China 6	049	2026-05-09 21:44:58.827652	19.3136
14958	QF 2,19	ЗУ	China 8	051	2026-05-09 21:44:58.827652	14.564
14960	Q9	ЗУ	BG 2	063	2026-05-09 21:45:06.302498	32.5939
14962	Q8	ЗУ	DIG	061	2026-05-09 21:45:06.625648	46.2626
14964	Q11	ЗУ	SM 3	065	2026-05-09 21:45:06.65489	22.278
14966	Q13	ЗУ	SM 5	067	2026-05-09 21:45:06.65489	1.5115
14968	Q15	ЗУ	SM 7	069	2026-05-09 21:45:06.65489	0.9377
14970	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:45:08.115519	21.6331
14972	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:45:08.115519	16.2565
14974	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:45:08.115519	20.0078
14976	TP3	ЗУ	CP-300 New	078	2026-05-09 21:45:36.625739	6.4001
14978	QF 1,21	ЗУ	China 2	045	2026-05-09 21:45:38.870758	10.8261
14980	QF 2,20	ЗУ	China 4	047	2026-05-09 21:45:38.870758	19.4964
14982	QF 2,22	ЗУ	China 6	049	2026-05-09 21:45:38.870758	19.3669
14984	QF 2,19	ЗУ	China 8	051	2026-05-09 21:45:38.870758	15.2635
14986	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:45:43.149209	21.8005
14988	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:45:43.149209	17.0839
14990	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:45:43.149209	20.4932
14993	Q20	ЗУ	MO 10	072	2026-05-09 21:45:47.431637	13.8624
14995	Q22	ЗУ	MO 12	074	2026-05-09 21:45:47.431637	0.9201
14997	Q24	ЗУ	MO 14	076	2026-05-09 21:45:47.431637	0.5362
14999	Q4	ЗУ	BG 1	062	2026-05-09 21:45:51.327479	20.2859
15001	Q10	ЗУ	SM 2	064	2026-05-09 21:45:51.676027	18.7104
15003	Q12	ЗУ	SM 4	066	2026-05-09 21:45:51.676027	1.5797
15005	Q14	ЗУ	SM 6	068	2026-05-09 21:45:51.676027	1.4344
15007	Q16	ЗУ	SM 8	070	2026-05-09 21:45:51.676027	2.1562
15008	TP3	ЗУ	CP-300 New	078	2026-05-09 21:46:06.656198	7.6881
15009	Q8	ЗУ	DIG	061	2026-05-09 21:46:16.651149	46.2906
15011	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:46:18.17863	9.7592
15013	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:46:18.17863	7.3549
15015	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:46:18.17863	18.4932
15017	QF 1,21	ЗУ	China 2	045	2026-05-09 21:46:18.913302	10.301
15019	QF 2,20	ЗУ	China 4	047	2026-05-09 21:46:18.913302	19.0349
15021	QF 2,22	ЗУ	China 6	049	2026-05-09 21:46:18.913302	19.9361
15023	QF 2,19	ЗУ	China 8	051	2026-05-09 21:46:18.913302	14.8347
15024	Q4	ЗУ	BG 1	062	2026-05-09 21:46:36.347284	21.2658
15026	TP3	ЗУ	CP-300 New	078	2026-05-09 21:46:36.66685	6.8883
15028	Q11	ЗУ	SM 3	065	2026-05-09 21:46:36.714027	21.5517
15030	Q13	ЗУ	SM 5	067	2026-05-09 21:46:36.714027	1.1747
15032	Q15	ЗУ	SM 7	069	2026-05-09 21:46:36.714027	1.0381
15034	Q17	ЗУ	MO 9	071	2026-05-09 21:46:37.50071	1.0096
15036	Q21	ЗУ	MO 11	073	2026-05-09 21:46:37.50071	0.5504
15038	Q23	ЗУ	MO 13	075	2026-05-09 21:46:37.50071	1.1396
15040	Q25	ЗУ	MO 15	077	2026-05-09 21:46:37.50071	0.9474
15042	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:46:53.214231	20.9282
15044	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:46:53.214231	16.4479
15046	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:46:53.214231	19.8257
15049	QF 1,21	ЗУ	China 2	045	2026-05-09 21:46:58.94743	10.2299
15051	QF 2,20	ЗУ	China 4	047	2026-05-09 21:46:58.94743	18.9214
15053	QF 2,22	ЗУ	China 6	049	2026-05-09 21:46:58.94743	19.0398
14866	QF 2,20	ЗУ	China 4	047	2026-05-09 21:42:58.62901	18.7565
14868	QF 2,22	ЗУ	China 6	049	2026-05-09 21:42:58.62901	19.9707
14870	QF 2,19	ЗУ	China 8	051	2026-05-09 21:42:58.62901	15.3598
14873	Q20	ЗУ	MO 10	072	2026-05-09 21:43:17.299334	13.4126
14875	Q22	ЗУ	MO 12	074	2026-05-09 21:43:17.299334	1.4309
14877	Q24	ЗУ	MO 14	076	2026-05-09 21:43:17.299334	1.0167
14879	Q8	ЗУ	DIG	061	2026-05-09 21:43:21.558647	47.3307
14881	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:43:22.983348	8.907
14883	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:43:22.983348	7.726
14885	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:43:22.983348	18.2733
14886	Q4	ЗУ	BG 1	062	2026-05-09 21:43:36.247526	21.6361
14888	TP3	ЗУ	CP-300 New	078	2026-05-09 21:43:36.551605	7.6
14890	Q11	ЗУ	SM 3	065	2026-05-09 21:43:36.581935	22.2483
14892	Q13	ЗУ	SM 5	067	2026-05-09 21:43:36.581935	0.6382
14894	Q15	ЗУ	SM 7	069	2026-05-09 21:43:36.581935	0.9198
14896	QF 1,20	ЗУ	China 1	044	2026-05-09 21:43:38.671228	12.0165
14898	QF 1,22	ЗУ	China 3	046	2026-05-09 21:43:38.671228	14.2678
14900	QF 2,21	ЗУ	China 5	048	2026-05-09 21:43:38.671228	21.5202
14902	QF 2,23	ЗУ	China 7	050	2026-05-09 21:43:38.671228	10.0782
14905	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:43:58.014564	20.8417
14907	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:43:58.014564	17.4185
14909	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:43:58.014564	19.319
14911	TP3	ЗУ	CP-300 New	078	2026-05-09 21:44:06.564778	7.4761
14913	Q20	ЗУ	MO 10	072	2026-05-09 21:44:07.341526	13.7441
14915	Q22	ЗУ	MO 12	074	2026-05-09 21:44:07.341526	1.0292
14917	Q24	ЗУ	MO 14	076	2026-05-09 21:44:07.341526	0.6117
14920	QF 1,21	ЗУ	China 2	045	2026-05-09 21:44:18.753004	10.9333
14922	QF 2,20	ЗУ	China 4	047	2026-05-09 21:44:18.753004	19.3901
14924	QF 2,22	ЗУ	China 6	049	2026-05-09 21:44:18.753004	20.2699
14926	QF 2,19	ЗУ	China 8	051	2026-05-09 21:44:18.753004	15.1938
14928	Q9	ЗУ	BG 2	063	2026-05-09 21:44:21.27446	32.8732
14930	Q11	ЗУ	SM 3	065	2026-05-09 21:44:21.618095	22.1337
14932	Q13	ЗУ	SM 5	067	2026-05-09 21:44:21.618095	1.6738
14934	Q15	ЗУ	SM 7	069	2026-05-09 21:44:21.618095	0.7135
14936	Q8	ЗУ	DIG	061	2026-05-09 21:44:31.592835	47.3952
14938	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:44:33.053083	9.6784
14940	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:44:33.053083	7.6144
14942	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:44:33.053083	19.2333
14943	TP3	ЗУ	CP-300 New	078	2026-05-09 21:44:36.597968	6.7832
14945	Q20	ЗУ	MO 10	072	2026-05-09 21:44:57.387717	13.2508
14947	Q22	ЗУ	MO 12	074	2026-05-09 21:44:57.387717	0.7896
14949	Q24	ЗУ	MO 14	076	2026-05-09 21:44:57.387717	1.4128
14951	QF 1,20	ЗУ	China 1	044	2026-05-09 21:44:58.827652	12.2287
14953	QF 1,22	ЗУ	China 3	046	2026-05-09 21:44:58.827652	14.4462
14955	QF 2,21	ЗУ	China 5	048	2026-05-09 21:44:58.827652	20.9366
14957	QF 2,23	ЗУ	China 7	050	2026-05-09 21:44:58.827652	9.2181
14959	Q4	ЗУ	BG 1	062	2026-05-09 21:45:06.302498	20.4378
14961	TP3	ЗУ	CP-300 New	078	2026-05-09 21:45:06.612642	7.2281
14963	Q10	ЗУ	SM 2	064	2026-05-09 21:45:06.65489	19.1792
14965	Q12	ЗУ	SM 4	066	2026-05-09 21:45:06.65489	1.0377
14967	Q14	ЗУ	SM 6	068	2026-05-09 21:45:06.65489	1.1959
14969	Q16	ЗУ	SM 8	070	2026-05-09 21:45:06.65489	2.3032
14971	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:45:08.115519	8.8969
14973	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:45:08.115519	8.9935
14975	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:45:08.115519	18.6783
14977	QF 1,20	ЗУ	China 1	044	2026-05-09 21:45:38.870758	12.6162
14979	QF 1,22	ЗУ	China 3	046	2026-05-09 21:45:38.870758	14.2799
14981	QF 2,21	ЗУ	China 5	048	2026-05-09 21:45:38.870758	21.448
14983	QF 2,23	ЗУ	China 7	050	2026-05-09 21:45:38.870758	9.4113
14985	Q8	ЗУ	DIG	061	2026-05-09 21:45:41.637342	46.3168
14987	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:45:43.149209	8.6394
14989	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:45:43.149209	7.3232
14991	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:45:43.149209	18.3372
14992	Q17	ЗУ	MO 9	071	2026-05-09 21:45:47.431637	1.3697
14994	Q21	ЗУ	MO 11	073	2026-05-09 21:45:47.431637	1.2412
14996	Q23	ЗУ	MO 13	075	2026-05-09 21:45:47.431637	1.1478
14998	Q25	ЗУ	MO 15	077	2026-05-09 21:45:47.431637	0.9966
15000	Q9	ЗУ	BG 2	063	2026-05-09 21:45:51.327479	33.1249
15002	Q11	ЗУ	SM 3	065	2026-05-09 21:45:51.676027	21.2023
15004	Q13	ЗУ	SM 5	067	2026-05-09 21:45:51.676027	0.6542
15006	Q15	ЗУ	SM 7	069	2026-05-09 21:45:51.676027	1.0834
15010	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:46:18.17863	21.9578
15012	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:46:18.17863	17.7921
15014	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:46:18.17863	20.4364
15016	QF 1,20	ЗУ	China 1	044	2026-05-09 21:46:18.913302	11.1409
15018	QF 1,22	ЗУ	China 3	046	2026-05-09 21:46:18.913302	13.9801
15020	QF 2,21	ЗУ	China 5	048	2026-05-09 21:46:18.913302	21.1523
15022	QF 2,23	ЗУ	China 7	050	2026-05-09 21:46:18.913302	10.5237
15025	Q9	ЗУ	BG 2	063	2026-05-09 21:46:36.347284	33.4208
15027	Q10	ЗУ	SM 2	064	2026-05-09 21:46:36.714027	19.0841
15029	Q12	ЗУ	SM 4	066	2026-05-09 21:46:36.714027	1.4014
15031	Q14	ЗУ	SM 6	068	2026-05-09 21:46:36.714027	0.9086
15033	Q16	ЗУ	SM 8	070	2026-05-09 21:46:36.714027	2.2031
15035	Q20	ЗУ	MO 10	072	2026-05-09 21:46:37.50071	13.239
15037	Q22	ЗУ	MO 12	074	2026-05-09 21:46:37.50071	0.7944
15039	Q24	ЗУ	MO 14	076	2026-05-09 21:46:37.50071	1.3234
15041	Q8	ЗУ	DIG	061	2026-05-09 21:46:51.666125	46.4326
15043	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:46:53.214231	8.9874
15045	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:46:53.214231	8.9676
15047	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:46:53.214231	19.7733
15048	QF 1,20	ЗУ	China 1	044	2026-05-09 21:46:58.94743	11.4642
15050	QF 1,22	ЗУ	China 3	046	2026-05-09 21:46:58.94743	14.299
15052	QF 2,21	ЗУ	China 5	048	2026-05-09 21:46:58.94743	20.3903
15054	QF 2,23	ЗУ	China 7	050	2026-05-09 21:46:58.94743	9.7234
15056	TP3	ЗУ	CP-300 New	078	2026-05-09 21:47:06.67654	6.9362
16100	QF 1,21	ЗУ	China 2	045	2026-05-10 01:09:41.071812	10.6368
16102	QF 2,20	ЗУ	China 4	047	2026-05-10 01:09:41.071812	18.1905
16104	QF 2,22	ЗУ	China 6	049	2026-05-10 01:09:41.071812	19.9065
16106	QF 2,19	ЗУ	China 8	051	2026-05-10 01:09:41.071812	14.0682
16107	Q4	ЗУ	BG 1	062	2026-05-10 01:09:52.534605	20.8467
16109	Q10	ЗУ	SM 2	064	2026-05-10 01:09:52.885249	18.0054
16111	Q12	ЗУ	SM 4	066	2026-05-10 01:09:52.885249	1.3212
15055	QF 2,19	ЗУ	China 8	051	2026-05-09 21:46:58.94743	15.2845
15057	Q4	ЗУ	BG 1	062	2026-05-09 21:47:21.497067	21.1547
15058	Q9	ЗУ	BG 2	063	2026-05-09 21:47:21.497067	32.6461
15059	Q10	ЗУ	SM 2	064	2026-05-09 21:47:21.751117	18.6121
15060	Q11	ЗУ	SM 3	065	2026-05-09 21:47:21.751117	22.2257
15061	Q12	ЗУ	SM 4	066	2026-05-09 21:47:21.751117	1.2336
15062	Q13	ЗУ	SM 5	067	2026-05-09 21:47:21.751117	1.2012
15063	Q14	ЗУ	SM 6	068	2026-05-09 21:47:21.751117	0.7556
15064	Q15	ЗУ	SM 7	069	2026-05-09 21:47:21.751117	1.4847
15065	Q16	ЗУ	SM 8	070	2026-05-09 21:47:21.751117	2.9108
15066	Q8	ЗУ	DIG	061	2026-05-09 21:47:26.732281	46.9732
15067	Q17	ЗУ	MO 9	071	2026-05-09 21:47:27.535849	1.1792
15068	Q20	ЗУ	MO 10	072	2026-05-09 21:47:27.535849	13.6749
15069	Q21	ЗУ	MO 11	073	2026-05-09 21:47:27.535849	0.6714
15070	Q22	ЗУ	MO 12	074	2026-05-09 21:47:27.535849	0.4549
15071	Q23	ЗУ	MO 13	075	2026-05-09 21:47:27.535849	0.8146
15072	Q24	ЗУ	MO 14	076	2026-05-09 21:47:27.535849	1.2956
15073	Q25	ЗУ	MO 15	077	2026-05-09 21:47:27.535849	0.894
15074	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:47:28.255626	21.9621
15075	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:47:28.255626	9.2382
15076	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:47:28.255626	16.873
15077	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:47:28.255626	8.3505
15078	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:47:28.255626	20.1247
15079	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:47:28.255626	18.3622
15080	TP3	ЗУ	CP-300 New	078	2026-05-09 21:47:36.725241	6.76
15081	QF 1,20	ЗУ	China 1	044	2026-05-09 21:47:39.013266	11.7434
15082	QF 1,21	ЗУ	China 2	045	2026-05-09 21:47:39.013266	11.572
15083	QF 1,22	ЗУ	China 3	046	2026-05-09 21:47:39.013266	13.6221
15084	QF 2,20	ЗУ	China 4	047	2026-05-09 21:47:39.013266	19.2319
15085	QF 2,21	ЗУ	China 5	048	2026-05-09 21:47:39.013266	20.612
15086	QF 2,22	ЗУ	China 6	049	2026-05-09 21:47:39.013266	20.0445
15087	QF 2,23	ЗУ	China 7	050	2026-05-09 21:47:39.013266	10.2595
15088	QF 2,19	ЗУ	China 8	051	2026-05-09 21:47:39.013266	15.6217
15089	Q8	ЗУ	DIG	061	2026-05-09 21:48:01.7752	45.4435
15090	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:48:03.285215	21.5334
15091	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:48:03.285215	9.9982
15092	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:48:03.285215	16.6542
15093	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:48:03.285215	7.4409
15094	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:48:03.285215	19.7964
15095	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:48:03.285215	19.1988
15096	Q4	ЗУ	BG 1	062	2026-05-09 21:48:06.558932	21.507
15097	Q9	ЗУ	BG 2	063	2026-05-09 21:48:06.558932	32.7229
15098	TP3	ЗУ	CP-300 New	078	2026-05-09 21:48:06.777723	6.2083
15099	Q10	ЗУ	SM 2	064	2026-05-09 21:48:06.799982	18.3754
15100	Q11	ЗУ	SM 3	065	2026-05-09 21:48:06.799982	21.6994
15101	Q12	ЗУ	SM 4	066	2026-05-09 21:48:06.799982	1.4769
15102	Q13	ЗУ	SM 5	067	2026-05-09 21:48:06.799982	0.6535
15103	Q14	ЗУ	SM 6	068	2026-05-09 21:48:06.799982	1.5944
15104	Q15	ЗУ	SM 7	069	2026-05-09 21:48:06.799982	1.151
15105	Q16	ЗУ	SM 8	070	2026-05-09 21:48:06.799982	2.5491
15106	Q17	ЗУ	MO 9	071	2026-05-09 21:48:17.573537	0.7042
15107	Q20	ЗУ	MO 10	072	2026-05-09 21:48:17.573537	13.4062
15108	Q21	ЗУ	MO 11	073	2026-05-09 21:48:17.573537	0.6494
15109	Q22	ЗУ	MO 12	074	2026-05-09 21:48:17.573537	1.3911
15110	Q23	ЗУ	MO 13	075	2026-05-09 21:48:17.573537	1.3328
15111	Q24	ЗУ	MO 14	076	2026-05-09 21:48:17.573537	1.0788
15112	Q25	ЗУ	MO 15	077	2026-05-09 21:48:17.573537	1.2471
15113	QF 1,20	ЗУ	China 1	044	2026-05-09 21:48:19.150448	12.3342
15114	QF 1,21	ЗУ	China 2	045	2026-05-09 21:48:19.150448	10.5934
15115	QF 1,22	ЗУ	China 3	046	2026-05-09 21:48:19.150448	14.0744
15116	QF 2,20	ЗУ	China 4	047	2026-05-09 21:48:19.150448	19.5368
15117	QF 2,21	ЗУ	China 5	048	2026-05-09 21:48:19.150448	20.3521
15118	QF 2,22	ЗУ	China 6	049	2026-05-09 21:48:19.150448	20.5862
15119	QF 2,23	ЗУ	China 7	050	2026-05-09 21:48:19.150448	9.177
15120	QF 2,19	ЗУ	China 8	051	2026-05-09 21:48:19.150448	14.386
15121	TP3	ЗУ	CP-300 New	078	2026-05-09 21:48:36.79124	5.9759
15122	Q8	ЗУ	DIG	061	2026-05-09 21:48:36.809032	46.7799
15123	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:48:38.302293	21.6111
15124	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:48:38.302293	9.5907
15125	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:48:38.302293	16.6498
15126	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:48:38.302293	8.9986
15127	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:48:38.302293	20.8669
15128	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:48:38.302293	18.2667
15129	Q4	ЗУ	BG 1	062	2026-05-09 21:48:51.571578	21.0413
15130	Q9	ЗУ	BG 2	063	2026-05-09 21:48:51.571578	32.3116
15131	Q10	ЗУ	SM 2	064	2026-05-09 21:48:51.81687	18.8834
15132	Q11	ЗУ	SM 3	065	2026-05-09 21:48:51.81687	21.1112
15133	Q12	ЗУ	SM 4	066	2026-05-09 21:48:51.81687	0.7525
15134	Q13	ЗУ	SM 5	067	2026-05-09 21:48:51.81687	1.5847
15135	Q14	ЗУ	SM 6	068	2026-05-09 21:48:51.81687	0.8893
15136	Q15	ЗУ	SM 7	069	2026-05-09 21:48:51.81687	1.4596
15137	Q16	ЗУ	SM 8	070	2026-05-09 21:48:51.81687	2.1322
15138	QF 1,20	ЗУ	China 1	044	2026-05-09 21:48:59.179647	11.2009
15139	QF 1,21	ЗУ	China 2	045	2026-05-09 21:48:59.179647	11.1558
15140	QF 1,22	ЗУ	China 3	046	2026-05-09 21:48:59.179647	14.5322
15141	QF 2,20	ЗУ	China 4	047	2026-05-09 21:48:59.179647	18.1683
15142	QF 2,21	ЗУ	China 5	048	2026-05-09 21:48:59.179647	20.7183
15143	QF 2,22	ЗУ	China 6	049	2026-05-09 21:48:59.179647	19.1346
15144	QF 2,23	ЗУ	China 7	050	2026-05-09 21:48:59.179647	10.5243
15145	QF 2,19	ЗУ	China 8	051	2026-05-09 21:48:59.179647	14.1593
15146	TP3	ЗУ	CP-300 New	078	2026-05-09 21:49:06.805128	7.255
15147	Q17	ЗУ	MO 9	071	2026-05-09 21:49:07.620862	1.1684
15148	Q20	ЗУ	MO 10	072	2026-05-09 21:49:07.620862	12.9568
15149	Q21	ЗУ	MO 11	073	2026-05-09 21:49:07.620862	1.2567
15150	Q22	ЗУ	MO 12	074	2026-05-09 21:49:07.620862	0.8152
15151	Q23	ЗУ	MO 13	075	2026-05-09 21:49:07.620862	1.1428
15152	Q24	ЗУ	MO 14	076	2026-05-09 21:49:07.620862	0.8038
15153	Q25	ЗУ	MO 15	077	2026-05-09 21:49:07.620862	0.4572
15154	Q8	ЗУ	DIG	061	2026-05-09 21:49:11.828307	47.3778
15155	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:49:13.347266	21.4124
15156	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:49:13.347266	8.8462
15157	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:49:13.347266	17.3537
17318	Q8	ЗУ	DIG	061	2026-05-10 01:37:38.859112	45.6849
15158	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:49:13.347266	8.0316
15159	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:49:13.347266	19.2804
15160	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:49:13.347266	18.9425
15161	Q4	ЗУ	BG 1	062	2026-05-09 21:49:36.645295	21.0954
15162	Q9	ЗУ	BG 2	063	2026-05-09 21:49:36.645295	32.9359
15163	TP3	ЗУ	CP-300 New	078	2026-05-09 21:49:36.854635	7.5638
15164	Q10	ЗУ	SM 2	064	2026-05-09 21:49:36.876816	18.5365
15165	Q11	ЗУ	SM 3	065	2026-05-09 21:49:36.876816	21.8343
15166	Q12	ЗУ	SM 4	066	2026-05-09 21:49:36.876816	0.8896
15167	Q13	ЗУ	SM 5	067	2026-05-09 21:49:36.876816	1.3952
15168	Q14	ЗУ	SM 6	068	2026-05-09 21:49:36.876816	1.3059
15169	Q15	ЗУ	SM 7	069	2026-05-09 21:49:36.876816	1.7236
15170	Q16	ЗУ	SM 8	070	2026-05-09 21:49:36.876816	3.0179
15171	QF 1,20	ЗУ	China 1	044	2026-05-09 21:49:39.255013	12.3025
15172	QF 1,21	ЗУ	China 2	045	2026-05-09 21:49:39.255013	11.4634
15173	QF 1,22	ЗУ	China 3	046	2026-05-09 21:49:39.255013	14.6173
15174	QF 2,20	ЗУ	China 4	047	2026-05-09 21:49:39.255013	19.0923
15175	QF 2,21	ЗУ	China 5	048	2026-05-09 21:49:39.255013	20.3633
15176	QF 2,22	ЗУ	China 6	049	2026-05-09 21:49:39.255013	20.2097
15177	QF 2,23	ЗУ	China 7	050	2026-05-09 21:49:39.255013	9.7952
15178	QF 2,19	ЗУ	China 8	051	2026-05-09 21:49:39.255013	14.9014
15179	Q8	ЗУ	DIG	061	2026-05-09 21:49:46.847232	45.2757
15180	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:49:48.396431	20.8452
15181	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:49:48.396431	9.5643
15182	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:49:48.396431	17.1483
15183	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:49:48.396431	8.4805
15184	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:49:48.396431	20.5576
15185	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:49:48.396431	18.4023
15186	Q17	ЗУ	MO 9	071	2026-05-09 21:49:57.678434	0.5915
15187	Q20	ЗУ	MO 10	072	2026-05-09 21:49:57.678434	13.2369
15188	Q21	ЗУ	MO 11	073	2026-05-09 21:49:57.678434	1.2867
15189	Q22	ЗУ	MO 12	074	2026-05-09 21:49:57.678434	1.4338
15190	Q23	ЗУ	MO 13	075	2026-05-09 21:49:57.678434	0.7447
15191	Q24	ЗУ	MO 14	076	2026-05-09 21:49:57.678434	0.6665
15192	Q25	ЗУ	MO 15	077	2026-05-09 21:49:57.678434	0.8768
15193	TP3	ЗУ	CP-300 New	078	2026-05-09 21:50:06.871115	7.3335
15194	QF 1,20	ЗУ	China 1	044	2026-05-09 21:50:19.294293	11.5753
15195	QF 1,21	ЗУ	China 2	045	2026-05-09 21:50:19.294293	10.2355
15196	QF 1,22	ЗУ	China 3	046	2026-05-09 21:50:19.294293	13.3161
15197	QF 2,20	ЗУ	China 4	047	2026-05-09 21:50:19.294293	19.2508
15198	QF 2,21	ЗУ	China 5	048	2026-05-09 21:50:19.294293	21.0697
15199	QF 2,22	ЗУ	China 6	049	2026-05-09 21:50:19.294293	19.2808
15200	QF 2,23	ЗУ	China 7	050	2026-05-09 21:50:19.294293	10.4783
15201	QF 2,19	ЗУ	China 8	051	2026-05-09 21:50:19.294293	15.1859
15202	Q4	ЗУ	BG 1	062	2026-05-09 21:50:21.680097	20.8556
15203	Q9	ЗУ	BG 2	063	2026-05-09 21:50:21.680097	33.4367
15204	Q8	ЗУ	DIG	061	2026-05-09 21:50:21.867901	47.0926
15205	Q10	ЗУ	SM 2	064	2026-05-09 21:50:21.910956	18.1367
15206	Q11	ЗУ	SM 3	065	2026-05-09 21:50:21.910956	21.54
15207	Q12	ЗУ	SM 4	066	2026-05-09 21:50:21.910956	1.3029
15208	Q13	ЗУ	SM 5	067	2026-05-09 21:50:21.910956	0.7867
15209	Q14	ЗУ	SM 6	068	2026-05-09 21:50:21.910956	1.4695
15210	Q15	ЗУ	SM 7	069	2026-05-09 21:50:21.910956	1.6841
15211	Q16	ЗУ	SM 8	070	2026-05-09 21:50:21.910956	2.8189
15212	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:50:23.450822	20.5936
15213	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:50:23.450822	9.7546
15214	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:50:23.450822	16.4249
15215	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:50:23.450822	7.1947
15216	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:50:23.450822	20.3893
15217	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:50:23.450822	18.6539
15218	TP3	ЗУ	CP-300 New	078	2026-05-09 21:50:36.884781	7.8039
15219	Q17	ЗУ	MO 9	071	2026-05-09 21:50:47.7179	0.4414
15220	Q20	ЗУ	MO 10	072	2026-05-09 21:50:47.7179	13.2971
15221	Q21	ЗУ	MO 11	073	2026-05-09 21:50:47.7179	0.6867
15222	Q22	ЗУ	MO 12	074	2026-05-09 21:50:47.7179	0.7599
15223	Q23	ЗУ	MO 13	075	2026-05-09 21:50:47.7179	0.8844
15224	Q24	ЗУ	MO 14	076	2026-05-09 21:50:47.7179	1.2875
15225	Q25	ЗУ	MO 15	077	2026-05-09 21:50:47.7179	0.5553
15226	Q8	ЗУ	DIG	061	2026-05-09 21:50:56.885391	46.4641
15227	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:50:58.484682	20.2743
15228	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:50:58.484682	8.502
15229	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:50:58.484682	16.5803
15230	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:50:58.484682	7.4823
15231	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:50:58.484682	19.4753
15232	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:50:58.484682	18.4379
15233	QF 1,20	ЗУ	China 1	044	2026-05-09 21:50:59.376162	11.2487
15234	QF 1,21	ЗУ	China 2	045	2026-05-09 21:50:59.376162	10.5152
15235	QF 1,22	ЗУ	China 3	046	2026-05-09 21:50:59.376162	14.5938
15236	QF 2,20	ЗУ	China 4	047	2026-05-09 21:50:59.376162	18.6752
15237	QF 2,21	ЗУ	China 5	048	2026-05-09 21:50:59.376162	21.3469
15238	QF 2,22	ЗУ	China 6	049	2026-05-09 21:50:59.376162	20.3577
15239	QF 2,23	ЗУ	China 7	050	2026-05-09 21:50:59.376162	9.4864
15240	QF 2,19	ЗУ	China 8	051	2026-05-09 21:50:59.376162	14.6761
15241	Q4	ЗУ	BG 1	062	2026-05-09 21:51:06.703203	21.5097
15242	Q9	ЗУ	BG 2	063	2026-05-09 21:51:06.703203	32.823
15243	TP3	ЗУ	CP-300 New	078	2026-05-09 21:51:06.933788	6.5571
15244	Q10	ЗУ	SM 2	064	2026-05-09 21:51:06.945417	18.9694
15245	Q11	ЗУ	SM 3	065	2026-05-09 21:51:06.945417	21.3599
15246	Q12	ЗУ	SM 4	066	2026-05-09 21:51:06.945417	1.2192
15247	Q13	ЗУ	SM 5	067	2026-05-09 21:51:06.945417	1.4978
15248	Q14	ЗУ	SM 6	068	2026-05-09 21:51:06.945417	1.2704
15249	Q15	ЗУ	SM 7	069	2026-05-09 21:51:06.945417	1.7298
15250	Q16	ЗУ	SM 8	070	2026-05-09 21:51:06.945417	3.2115
15251	Q8	ЗУ	DIG	061	2026-05-09 21:51:31.921717	46.8345
15252	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:51:33.538088	21.4978
15253	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:51:33.538088	9.7568
15254	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:51:33.538088	17.4064
15255	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:51:33.538088	8.5199
15256	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:51:33.538088	20.7252
15257	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:51:33.538088	18.6362
15258	TP3	ЗУ	CP-300 New	078	2026-05-09 21:51:36.948069	6.5929
15259	Q17	ЗУ	MO 9	071	2026-05-09 21:51:37.774534	0.806
15260	Q20	ЗУ	MO 10	072	2026-05-09 21:51:37.774534	13.5278
15261	Q21	ЗУ	MO 11	073	2026-05-09 21:51:37.774534	0.7943
15262	Q22	ЗУ	MO 12	074	2026-05-09 21:51:37.774534	0.8591
15263	Q23	ЗУ	MO 13	075	2026-05-09 21:51:37.774534	1.3468
15264	Q24	ЗУ	MO 14	076	2026-05-09 21:51:37.774534	0.4637
15265	Q25	ЗУ	MO 15	077	2026-05-09 21:51:37.774534	1.3556
15266	QF 1,20	ЗУ	China 1	044	2026-05-09 21:51:39.423647	11.3572
15267	QF 1,21	ЗУ	China 2	045	2026-05-09 21:51:39.423647	10.8978
15268	QF 1,22	ЗУ	China 3	046	2026-05-09 21:51:39.423647	13.4755
15269	QF 2,20	ЗУ	China 4	047	2026-05-09 21:51:39.423647	18.5363
15270	QF 2,21	ЗУ	China 5	048	2026-05-09 21:51:39.423647	21.0917
15271	QF 2,22	ЗУ	China 6	049	2026-05-09 21:51:39.423647	20.44
15272	QF 2,23	ЗУ	China 7	050	2026-05-09 21:51:39.423647	9.3265
15273	QF 2,19	ЗУ	China 8	051	2026-05-09 21:51:39.423647	15.5547
15274	Q4	ЗУ	BG 1	062	2026-05-09 21:51:51.733414	20.2833
15275	Q9	ЗУ	BG 2	063	2026-05-09 21:51:51.733414	32.2255
15276	Q10	ЗУ	SM 2	064	2026-05-09 21:51:51.975719	18.6804
15277	Q11	ЗУ	SM 3	065	2026-05-09 21:51:51.975719	22.0507
15278	Q12	ЗУ	SM 4	066	2026-05-09 21:51:51.975719	1.2417
15279	Q13	ЗУ	SM 5	067	2026-05-09 21:51:51.975719	1.6392
15280	Q14	ЗУ	SM 6	068	2026-05-09 21:51:51.975719	0.6225
15281	Q15	ЗУ	SM 7	069	2026-05-09 21:51:51.975719	1.1671
15282	Q16	ЗУ	SM 8	070	2026-05-09 21:51:51.975719	2.1846
15283	Q8	ЗУ	DIG	061	2026-05-09 21:52:06.946448	46.1291
15284	TP3	ЗУ	CP-300 New	078	2026-05-09 21:52:06.97289	6.4511
15285	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:52:08.574763	20.8945
15286	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:52:08.574763	9.1812
15287	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:52:08.574763	16.3659
15288	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:52:08.574763	7.7056
15289	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:52:08.574763	19.1967
15290	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:52:08.574763	18.9839
15291	QF 1,20	ЗУ	China 1	044	2026-05-09 21:52:19.471503	12.4013
15292	QF 1,21	ЗУ	China 2	045	2026-05-09 21:52:19.471503	11.5381
15293	QF 1,22	ЗУ	China 3	046	2026-05-09 21:52:19.471503	13.7655
15294	QF 2,20	ЗУ	China 4	047	2026-05-09 21:52:19.471503	18.7987
15295	QF 2,21	ЗУ	China 5	048	2026-05-09 21:52:19.471503	20.9693
15296	QF 2,22	ЗУ	China 6	049	2026-05-09 21:52:19.471503	20.1379
15297	QF 2,23	ЗУ	China 7	050	2026-05-09 21:52:19.471503	9.328
15298	QF 2,19	ЗУ	China 8	051	2026-05-09 21:52:19.471503	14.1458
15299	Q17	ЗУ	MO 9	071	2026-05-09 21:52:27.818721	1.3508
15300	Q20	ЗУ	MO 10	072	2026-05-09 21:52:27.818721	13.8213
15301	Q21	ЗУ	MO 11	073	2026-05-09 21:52:27.818721	1.415
15302	Q22	ЗУ	MO 12	074	2026-05-09 21:52:27.818721	1.325
15303	Q23	ЗУ	MO 13	075	2026-05-09 21:52:27.818721	0.9892
15304	Q24	ЗУ	MO 14	076	2026-05-09 21:52:27.818721	1.4166
15305	Q25	ЗУ	MO 15	077	2026-05-09 21:52:27.818721	0.941
15306	Q4	ЗУ	BG 1	062	2026-05-09 21:52:36.781121	20.6542
15307	Q9	ЗУ	BG 2	063	2026-05-09 21:52:36.781121	32.8809
15308	TP3	ЗУ	CP-300 New	078	2026-05-09 21:52:36.987161	7.2558
15309	Q10	ЗУ	SM 2	064	2026-05-09 21:52:37.015558	18.3569
15310	Q11	ЗУ	SM 3	065	2026-05-09 21:52:37.015558	21.6905
15311	Q12	ЗУ	SM 4	066	2026-05-09 21:52:37.015558	0.9561
15312	Q13	ЗУ	SM 5	067	2026-05-09 21:52:37.015558	0.8528
15313	Q14	ЗУ	SM 6	068	2026-05-09 21:52:37.015558	0.9523
15314	Q15	ЗУ	SM 7	069	2026-05-09 21:52:37.015558	1.5797
15315	Q16	ЗУ	SM 8	070	2026-05-09 21:52:37.015558	2.4872
15316	Q8	ЗУ	DIG	061	2026-05-09 21:52:41.961189	46.574
15317	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:52:43.615201	21.2415
15318	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:52:43.615201	9.8083
15319	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:52:43.615201	17.4555
15320	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:52:43.615201	8.0324
15321	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:52:43.615201	20.7363
15322	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:52:43.615201	18.3827
15323	QF 1,20	ЗУ	China 1	044	2026-05-09 21:52:59.530887	12.2347
15324	QF 1,21	ЗУ	China 2	045	2026-05-09 21:52:59.530887	10.3229
15325	QF 1,22	ЗУ	China 3	046	2026-05-09 21:52:59.530887	14.3133
15326	QF 2,20	ЗУ	China 4	047	2026-05-09 21:52:59.530887	18.5585
15327	QF 2,21	ЗУ	China 5	048	2026-05-09 21:52:59.530887	21.2662
15328	QF 2,22	ЗУ	China 6	049	2026-05-09 21:52:59.530887	19.0672
15329	QF 2,23	ЗУ	China 7	050	2026-05-09 21:52:59.530887	10.4596
15330	QF 2,19	ЗУ	China 8	051	2026-05-09 21:52:59.530887	14.7136
15331	TP3	ЗУ	CP-300 New	078	2026-05-09 21:53:07.007295	7.1574
15332	Q8	ЗУ	DIG	061	2026-05-09 21:53:16.979628	46.9183
15333	Q17	ЗУ	MO 9	071	2026-05-09 21:53:17.856811	0.9864
15334	Q20	ЗУ	MO 10	072	2026-05-09 21:53:17.856811	13.4572
15335	Q21	ЗУ	MO 11	073	2026-05-09 21:53:17.856811	1.3936
15336	Q22	ЗУ	MO 12	074	2026-05-09 21:53:17.856811	1.0505
15337	Q23	ЗУ	MO 13	075	2026-05-09 21:53:17.856811	1.3964
15338	Q24	ЗУ	MO 14	076	2026-05-09 21:53:17.856811	1.1605
15339	Q25	ЗУ	MO 15	077	2026-05-09 21:53:17.856811	1.2814
15340	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:53:18.664485	20.7495
15341	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:53:18.664485	9.5563
15342	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:53:18.664485	17.7071
15343	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:53:18.664485	7.9603
15344	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:53:18.664485	20.281
15345	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:53:18.664485	18.2326
15346	Q4	ЗУ	BG 1	062	2026-05-09 21:53:21.815619	20.9003
15347	Q9	ЗУ	BG 2	063	2026-05-09 21:53:21.815619	32.4905
15348	Q10	ЗУ	SM 2	064	2026-05-09 21:53:22.049494	18.1879
15349	Q11	ЗУ	SM 3	065	2026-05-09 21:53:22.049494	21.2298
15350	Q12	ЗУ	SM 4	066	2026-05-09 21:53:22.049494	1.0695
15351	Q13	ЗУ	SM 5	067	2026-05-09 21:53:22.049494	1.0385
15352	Q14	ЗУ	SM 6	068	2026-05-09 21:53:22.049494	0.6066
15353	Q15	ЗУ	SM 7	069	2026-05-09 21:53:22.049494	0.5961
15354	Q16	ЗУ	SM 8	070	2026-05-09 21:53:22.049494	2.6556
15355	TP3	ЗУ	CP-300 New	078	2026-05-09 21:53:37.029826	6.3351
15356	QF 1,20	ЗУ	China 1	044	2026-05-09 21:53:39.605097	11.8372
15357	QF 1,21	ЗУ	China 2	045	2026-05-09 21:53:39.605097	10.7673
15358	QF 1,22	ЗУ	China 3	046	2026-05-09 21:53:39.605097	14.2745
15359	QF 2,20	ЗУ	China 4	047	2026-05-09 21:53:39.605097	18.0521
15360	QF 2,21	ЗУ	China 5	048	2026-05-09 21:53:39.605097	21.0855
15361	QF 2,22	ЗУ	China 6	049	2026-05-09 21:53:39.605097	20.2319
15362	QF 2,23	ЗУ	China 7	050	2026-05-09 21:53:39.605097	10.2989
15363	QF 2,19	ЗУ	China 8	051	2026-05-09 21:53:39.605097	14.6286
15364	Q8	ЗУ	DIG	061	2026-05-09 21:53:52.014459	46.8036
15365	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:53:53.705469	21.6929
15366	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:53:53.705469	9.327
15367	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:53:53.705469	17.3686
15368	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:53:53.705469	8.8394
15369	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:53:53.705469	19.8001
15370	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:53:53.705469	19.9533
15371	Q4	ЗУ	BG 1	062	2026-05-09 21:54:06.836149	21.437
15372	Q9	ЗУ	BG 2	063	2026-05-09 21:54:06.836149	32.9161
15373	TP3	ЗУ	CP-300 New	078	2026-05-09 21:54:07.062819	7.6542
15374	Q10	ЗУ	SM 2	064	2026-05-09 21:54:07.090544	18.2552
15375	Q11	ЗУ	SM 3	065	2026-05-09 21:54:07.090544	21.5552
15376	Q12	ЗУ	SM 4	066	2026-05-09 21:54:07.090544	0.6014
15377	Q13	ЗУ	SM 5	067	2026-05-09 21:54:07.090544	1.6645
15378	Q14	ЗУ	SM 6	068	2026-05-09 21:54:07.090544	1.2646
15379	Q15	ЗУ	SM 7	069	2026-05-09 21:54:07.090544	1.4727
15380	Q16	ЗУ	SM 8	070	2026-05-09 21:54:07.090544	2.1081
15381	Q17	ЗУ	MO 9	071	2026-05-09 21:54:07.895596	0.6994
15382	Q20	ЗУ	MO 10	072	2026-05-09 21:54:07.895596	13.8179
15383	Q21	ЗУ	MO 11	073	2026-05-09 21:54:07.895596	0.7087
15384	Q22	ЗУ	MO 12	074	2026-05-09 21:54:07.895596	0.697
15385	Q23	ЗУ	MO 13	075	2026-05-09 21:54:07.895596	1.3043
15386	Q24	ЗУ	MO 14	076	2026-05-09 21:54:07.895596	0.9486
15387	Q25	ЗУ	MO 15	077	2026-05-09 21:54:07.895596	0.881
15388	QF 1,20	ЗУ	China 1	044	2026-05-09 21:54:19.647637	11.0278
15389	QF 1,21	ЗУ	China 2	045	2026-05-09 21:54:19.647637	10.723
15390	QF 1,22	ЗУ	China 3	046	2026-05-09 21:54:19.647637	12.9878
15391	QF 2,20	ЗУ	China 4	047	2026-05-09 21:54:19.647637	19.358
15392	QF 2,21	ЗУ	China 5	048	2026-05-09 21:54:19.647637	21.3647
15393	QF 2,22	ЗУ	China 6	049	2026-05-09 21:54:19.647637	19.4571
15394	QF 2,23	ЗУ	China 7	050	2026-05-09 21:54:19.647637	10.2403
15395	QF 2,19	ЗУ	China 8	051	2026-05-09 21:54:19.647637	14.8537
15396	Q8	ЗУ	DIG	061	2026-05-09 21:54:27.069989	46.8623
15397	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-09 21:54:28.769657	20.6138
15398	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-09 21:54:28.769657	8.22
15399	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-09 21:54:28.769657	17.1451
15400	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-09 21:54:28.769657	8.2532
15401	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-09 21:54:28.769657	19.8806
15402	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-09 21:54:28.769657	18.8248
15403	TP3	ЗУ	CP-300 New	078	2026-05-09 21:54:37.074353	7.1635
15404	Q4	ЗУ	BG 1	062	2026-05-09 21:54:51.903179	20.6066
15405	Q9	ЗУ	BG 2	063	2026-05-09 21:54:51.903179	33.3163
15406	Q10	ЗУ	SM 2	064	2026-05-09 21:54:52.12517	18.2327
15407	Q11	ЗУ	SM 3	065	2026-05-09 21:54:52.12517	21.3045
15408	Q12	ЗУ	SM 4	066	2026-05-09 21:54:52.12517	1.0264
15409	Q13	ЗУ	SM 5	067	2026-05-09 21:54:52.12517	0.5709
15410	Q14	ЗУ	SM 6	068	2026-05-09 21:54:52.12517	1.1084
15411	Q15	ЗУ	SM 7	069	2026-05-09 21:54:52.12517	1.3834
15412	Q16	ЗУ	SM 8	070	2026-05-09 21:54:52.12517	2.0724
15413	Q17	ЗУ	MO 9	071	2026-05-09 21:54:57.928769	1.3814
15414	Q20	ЗУ	MO 10	072	2026-05-09 21:54:57.928769	13.4254
15415	Q21	ЗУ	MO 11	073	2026-05-09 21:54:57.928769	0.9471
15416	Q22	ЗУ	MO 12	074	2026-05-09 21:54:57.928769	0.635
15417	Q23	ЗУ	MO 13	075	2026-05-09 21:54:57.928769	1.116
15418	Q24	ЗУ	MO 14	076	2026-05-09 21:54:57.928769	1.3108
15419	Q25	ЗУ	MO 15	077	2026-05-09 21:54:57.928769	0.9884
15420	QF 1,20	ЗУ	China 1	044	2026-05-09 21:54:59.715876	12.1981
15421	QF 1,21	ЗУ	China 2	045	2026-05-09 21:54:59.715876	10.8285
15422	QF 1,22	ЗУ	China 3	046	2026-05-09 21:54:59.715876	13.6524
15423	QF 2,20	ЗУ	China 4	047	2026-05-09 21:54:59.715876	19.3078
15424	QF 2,21	ЗУ	China 5	048	2026-05-09 21:54:59.715876	20.6786
15425	QF 2,22	ЗУ	China 6	049	2026-05-09 21:54:59.715876	19.1789
15426	QF 2,23	ЗУ	China 7	050	2026-05-09 21:54:59.715876	10.2795
15427	QF 2,19	ЗУ	China 8	051	2026-05-09 21:54:59.715876	14.8749
15428	Q8	ЗУ	DIG	061	2026-05-09 21:55:02.100202	47.4609
16113	Q14	ЗУ	SM 6	068	2026-05-10 01:09:52.885249	0.7237
16115	Q16	ЗУ	SM 8	070	2026-05-10 01:09:52.885249	3.0346
16117	Q20	ЗУ	MO 10	072	2026-05-10 01:09:58.784164	13.7628
16119	Q22	ЗУ	MO 12	074	2026-05-10 01:09:58.784164	1.0383
16121	Q24	ЗУ	MO 14	076	2026-05-10 01:09:58.784164	1.1764
16124	Q8	ЗУ	DIG	061	2026-05-10 01:10:12.834126	46.8911
16126	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:10:15.097557	8.2398
16128	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:10:15.097557	7.8094
16130	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:10:15.097557	18.8059
16132	QF 1,21	ЗУ	China 2	045	2026-05-10 01:10:21.106012	10.7226
16134	QF 2,20	ЗУ	China 4	047	2026-05-10 01:10:21.106012	18.4478
16136	QF 2,22	ЗУ	China 6	049	2026-05-10 01:10:21.106012	19.1998
16138	QF 2,19	ЗУ	China 8	051	2026-05-10 01:10:21.106012	14.0132
16139	Q4	ЗУ	BG 1	062	2026-05-10 01:10:37.603236	20.3048
16141	Q10	ЗУ	SM 2	064	2026-05-10 01:10:37.915698	18.7154
16143	Q12	ЗУ	SM 4	066	2026-05-10 01:10:37.915698	1.0489
16145	Q14	ЗУ	SM 6	068	2026-05-10 01:10:37.915698	0.6245
16147	Q16	ЗУ	SM 8	070	2026-05-10 01:10:37.915698	2.2712
16150	Q17	ЗУ	MO 9	071	2026-05-10 01:10:48.879572	0.9404
16152	Q21	ЗУ	MO 11	073	2026-05-10 01:10:48.879572	0.9659
16154	Q23	ЗУ	MO 13	075	2026-05-10 01:10:48.879572	0.4105
16156	Q25	ЗУ	MO 15	077	2026-05-10 01:10:48.879572	0.6867
16158	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:10:50.216047	8.9774
16160	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:10:50.216047	7.4533
16162	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:10:50.216047	19.6392
16164	QF 1,21	ЗУ	China 2	045	2026-05-10 01:11:01.708001	11.0809
16166	QF 2,20	ЗУ	China 4	047	2026-05-10 01:11:01.708001	18.0447
16168	QF 2,22	ЗУ	China 6	049	2026-05-10 01:11:01.708001	19.5562
16170	QF 2,19	ЗУ	China 8	051	2026-05-10 01:11:01.708001	15.1017
16171	TP3	ЗУ	CP-300 New	078	2026-05-10 01:11:07.958553	7.0001
16173	Q9	ЗУ	BG 2	063	2026-05-10 01:11:22.630289	32.5834
16175	Q10	ЗУ	SM 2	064	2026-05-10 01:11:22.949243	18.2392
16177	Q12	ЗУ	SM 4	066	2026-05-10 01:11:22.949243	1.5249
16179	Q14	ЗУ	SM 6	068	2026-05-10 01:11:22.949243	1.6127
16181	Q16	ЗУ	SM 8	070	2026-05-10 01:11:22.949243	3.079
16182	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:11:25.424009	21.5821
16282	Q13	ЗУ	SM 5	067	2026-05-10 01:13:38.141115	1.229
16283	Q14	ЗУ	SM 6	068	2026-05-10 01:13:38.141115	1.1834
16284	Q15	ЗУ	SM 7	069	2026-05-10 01:13:38.141115	1.1178
16285	Q16	ЗУ	SM 8	070	2026-05-10 01:13:38.141115	2.1336
16286	QF 1,20	ЗУ	China 1	044	2026-05-10 01:13:41.920779	11.4207
16287	QF 1,21	ЗУ	China 2	045	2026-05-10 01:13:41.920779	10.1443
16288	QF 1,22	ЗУ	China 3	046	2026-05-10 01:13:41.920779	13.4597
16289	QF 2,20	ЗУ	China 4	047	2026-05-10 01:13:41.920779	18.8274
16290	QF 2,21	ЗУ	China 5	048	2026-05-10 01:13:41.920779	21.309
16291	QF 2,22	ЗУ	China 6	049	2026-05-10 01:13:41.920779	19.0179
16292	QF 2,23	ЗУ	China 7	050	2026-05-10 01:13:41.920779	8.9204
16293	QF 2,19	ЗУ	China 8	051	2026-05-10 01:13:41.920779	14.5127
16294	Q8	ЗУ	DIG	061	2026-05-10 01:13:42.958498	45.7861
16295	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:13:45.594019	20.7592
16296	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:13:45.594019	9.3774
16297	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:13:45.594019	16.0725
16298	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:13:45.594019	7.0563
16299	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:13:45.594019	19.8351
16300	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:13:45.594019	18.997
16301	TP3	ЗУ	CP-300 New	078	2026-05-10 01:14:08.08309	6.7342
16302	Q17	ЗУ	MO 9	071	2026-05-10 01:14:09.05282	1.1165
16303	Q20	ЗУ	MO 10	072	2026-05-10 01:14:09.05282	13.8368
16304	Q21	ЗУ	MO 11	073	2026-05-10 01:14:09.05282	0.6858
16305	Q22	ЗУ	MO 12	074	2026-05-10 01:14:09.05282	0.4937
16306	Q23	ЗУ	MO 13	075	2026-05-10 01:14:09.05282	0.4935
16307	Q24	ЗУ	MO 14	076	2026-05-10 01:14:09.05282	1.2762
16308	Q25	ЗУ	MO 15	077	2026-05-10 01:14:09.05282	0.9107
16368	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:15:30.675437	9.4278
16371	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:15:30.675437	19.6065
16374	QF 1,20	ЗУ	China 1	044	2026-05-10 01:15:42.044584	12.1478
16377	QF 2,20	ЗУ	China 4	047	2026-05-10 01:15:42.044584	19.3331
16380	QF 2,23	ЗУ	China 7	050	2026-05-10 01:15:42.044584	9.8451
16384	Q21	ЗУ	MO 11	073	2026-05-10 01:15:49.104743	0.7508
16387	Q24	ЗУ	MO 14	076	2026-05-10 01:15:49.104743	1.1931
16389	Q4	ЗУ	BG 1	062	2026-05-10 01:15:52.853123	20.966
16392	Q11	ЗУ	SM 3	065	2026-05-10 01:15:53.265804	21.3158
16395	Q14	ЗУ	SM 6	068	2026-05-10 01:15:53.265804	0.9233
16398	Q8	ЗУ	DIG	061	2026-05-10 01:16:03.032391	46.4039
16401	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:16:05.783373	17.2889
16404	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:16:05.783373	18.4627
16406	QF 1,20	ЗУ	China 1	044	2026-05-10 01:16:22.12805	11.9311
16409	QF 2,20	ЗУ	China 4	047	2026-05-10 01:16:22.12805	18.2654
16412	QF 2,23	ЗУ	China 7	050	2026-05-10 01:16:22.12805	9.0682
16416	Q8	ЗУ	DIG	061	2026-05-10 01:16:38.066863	45.829
16419	Q11	ЗУ	SM 3	065	2026-05-10 01:16:38.309246	21.64
16422	Q14	ЗУ	SM 6	068	2026-05-10 01:16:38.309246	0.5416
16425	Q17	ЗУ	MO 9	071	2026-05-10 01:16:39.156963	0.7514
16428	Q22	ЗУ	MO 12	074	2026-05-10 01:16:39.156963	0.526
16431	Q25	ЗУ	MO 15	077	2026-05-10 01:16:39.156963	0.4298
16434	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:16:40.819214	17.1708
16437	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:16:40.819214	19.1302
16438	QF 1,20	ЗУ	China 1	044	2026-05-10 01:17:02.183856	12.3727
16441	QF 2,20	ЗУ	China 4	047	2026-05-10 01:17:02.183856	19.1917
16444	QF 2,23	ЗУ	China 7	050	2026-05-10 01:17:02.183856	8.8645
16447	Q8	ЗУ	DIG	061	2026-05-10 01:17:13.091054	47.3127
16450	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:17:15.86191	16.7023
16453	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:17:15.86191	18.9586
16454	Q4	ЗУ	BG 1	062	2026-05-10 01:17:22.951241	20.9291
16456	Q10	ЗУ	SM 2	064	2026-05-10 01:17:23.352062	17.9616
16459	Q13	ЗУ	SM 5	067	2026-05-10 01:17:23.352062	0.4524
16462	Q16	ЗУ	SM 8	070	2026-05-10 01:17:23.352062	2.1579
16464	Q20	ЗУ	MO 10	072	2026-05-10 01:17:29.213151	13.2235
16467	Q23	ЗУ	MO 13	075	2026-05-10 01:17:29.213151	1.2066
16470	TP3	ЗУ	CP-300 New	078	2026-05-10 01:17:38.243148	5.6933
16473	QF 1,22	ЗУ	China 3	046	2026-05-10 01:17:42.24774	14.0559
16476	QF 2,22	ЗУ	China 6	049	2026-05-10 01:17:42.24774	19.9118
16480	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:17:50.909184	21.3215
16483	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:17:50.909184	7.7665
16490	Q11	ЗУ	SM 3	065	2026-05-10 01:18:08.42161	21.9192
16493	Q14	ЗУ	SM 6	068	2026-05-10 01:18:08.42161	0.6753
16496	Q17	ЗУ	MO 9	071	2026-05-10 01:18:19.28086	1.0602
16499	Q22	ЗУ	MO 12	074	2026-05-10 01:18:19.28086	1.1907
16502	Q25	ЗУ	MO 15	077	2026-05-10 01:18:19.28086	0.9154
16505	QF 1,22	ЗУ	China 3	046	2026-05-10 01:18:22.291222	13.8538
16508	QF 2,22	ЗУ	China 6	049	2026-05-10 01:18:22.291222	20.1976
16511	Q8	ЗУ	DIG	061	2026-05-10 01:18:23.134032	46.5697
16514	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:18:25.9447	16.933
16517	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:18:25.9447	19.5525
16310	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:14:20.625111	21.666
16311	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:14:20.625111	9.0248
16312	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:14:20.625111	16.1493
16313	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:14:20.625111	7.1822
16314	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:14:20.625111	20.5033
16315	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:14:20.625111	19.4157
16316	QF 1,20	ЗУ	China 1	044	2026-05-10 01:14:21.952561	12.4007
16317	QF 1,21	ЗУ	China 2	045	2026-05-10 01:14:21.952561	10.8259
16318	QF 1,22	ЗУ	China 3	046	2026-05-10 01:14:21.952561	13.8108
16319	QF 2,20	ЗУ	China 4	047	2026-05-10 01:14:21.952561	17.9731
16320	QF 2,21	ЗУ	China 5	048	2026-05-10 01:14:21.952561	20.7867
16321	QF 2,22	ЗУ	China 6	049	2026-05-10 01:14:21.952561	19.3254
16322	QF 2,23	ЗУ	China 7	050	2026-05-10 01:14:21.952561	10.056
16323	QF 2,19	ЗУ	China 8	051	2026-05-10 01:14:21.952561	14.7792
16324	Q4	ЗУ	BG 1	062	2026-05-10 01:14:22.782426	21.1186
16325	Q9	ЗУ	BG 2	063	2026-05-10 01:14:22.782426	33.0084
16326	Q10	ЗУ	SM 2	064	2026-05-10 01:14:23.188316	18.3755
16327	Q11	ЗУ	SM 3	065	2026-05-10 01:14:23.188316	21.7694
16328	Q12	ЗУ	SM 4	066	2026-05-10 01:14:23.188316	1.5677
16329	Q13	ЗУ	SM 5	067	2026-05-10 01:14:23.188316	0.6756
16330	Q14	ЗУ	SM 6	068	2026-05-10 01:14:23.188316	1.4551
16331	Q15	ЗУ	SM 7	069	2026-05-10 01:14:23.188316	1.5315
16332	Q16	ЗУ	SM 8	070	2026-05-10 01:14:23.188316	2.9397
16333	TP3	ЗУ	CP-300 New	078	2026-05-10 01:14:38.097776	7.007
16334	Q8	ЗУ	DIG	061	2026-05-10 01:14:52.978221	45.5467
16335	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:14:55.652886	20.8358
16336	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:14:55.652886	8.9655
16337	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:14:55.652886	17.7094
16338	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:14:55.652886	7.0122
16339	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:14:55.652886	19.8012
16340	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:14:55.652886	18.2072
16341	Q17	ЗУ	MO 9	071	2026-05-10 01:14:59.080836	0.8327
16342	Q20	ЗУ	MO 10	072	2026-05-10 01:14:59.080836	13.0352
16343	Q21	ЗУ	MO 11	073	2026-05-10 01:14:59.080836	1.0403
16344	Q22	ЗУ	MO 12	074	2026-05-10 01:14:59.080836	0.7092
16345	Q23	ЗУ	MO 13	075	2026-05-10 01:14:59.080836	0.8182
16346	Q24	ЗУ	MO 14	076	2026-05-10 01:14:59.080836	0.6367
16347	Q25	ЗУ	MO 15	077	2026-05-10 01:14:59.080836	1.1244
16348	QF 1,20	ЗУ	China 1	044	2026-05-10 01:15:01.990422	11.0376
16349	QF 1,21	ЗУ	China 2	045	2026-05-10 01:15:01.990422	10.3944
16350	QF 1,22	ЗУ	China 3	046	2026-05-10 01:15:01.990422	14.4377
16351	QF 2,20	ЗУ	China 4	047	2026-05-10 01:15:01.990422	18.3676
16352	QF 2,21	ЗУ	China 5	048	2026-05-10 01:15:01.990422	20.8618
16353	QF 2,22	ЗУ	China 6	049	2026-05-10 01:15:01.990422	18.9621
16354	QF 2,23	ЗУ	China 7	050	2026-05-10 01:15:01.990422	9.3521
16355	QF 2,19	ЗУ	China 8	051	2026-05-10 01:15:01.990422	14.8439
16356	Q4	ЗУ	BG 1	062	2026-05-10 01:15:07.804702	20.6159
16357	Q9	ЗУ	BG 2	063	2026-05-10 01:15:07.804702	33.279
16358	TP3	ЗУ	CP-300 New	078	2026-05-10 01:15:08.104012	7.1154
16359	Q10	ЗУ	SM 2	064	2026-05-10 01:15:08.225025	18.0031
16360	Q11	ЗУ	SM 3	065	2026-05-10 01:15:08.225025	21.9589
16361	Q12	ЗУ	SM 4	066	2026-05-10 01:15:08.225025	0.7647
16362	Q13	ЗУ	SM 5	067	2026-05-10 01:15:08.225025	0.8189
16363	Q14	ЗУ	SM 6	068	2026-05-10 01:15:08.225025	0.6725
16364	Q15	ЗУ	SM 7	069	2026-05-10 01:15:08.225025	0.5542
16365	Q16	ЗУ	SM 8	070	2026-05-10 01:15:08.225025	2.1345
16366	Q8	ЗУ	DIG	061	2026-05-10 01:15:27.998118	46.8576
16367	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:15:30.675437	20.4007
16369	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:15:30.675437	16.4563
16370	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:15:30.675437	7.8348
16372	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:15:30.675437	18.5928
16373	TP3	ЗУ	CP-300 New	078	2026-05-10 01:15:38.127737	5.9443
16375	QF 1,21	ЗУ	China 2	045	2026-05-10 01:15:42.044584	10.7659
16376	QF 1,22	ЗУ	China 3	046	2026-05-10 01:15:42.044584	12.8584
16378	QF 2,21	ЗУ	China 5	048	2026-05-10 01:15:42.044584	21.3418
16379	QF 2,22	ЗУ	China 6	049	2026-05-10 01:15:42.044584	20.1552
16381	QF 2,19	ЗУ	China 8	051	2026-05-10 01:15:42.044584	14.796
16382	Q17	ЗУ	MO 9	071	2026-05-10 01:15:49.104743	0.4561
16383	Q20	ЗУ	MO 10	072	2026-05-10 01:15:49.104743	13.8209
16385	Q22	ЗУ	MO 12	074	2026-05-10 01:15:49.104743	1.0846
16386	Q23	ЗУ	MO 13	075	2026-05-10 01:15:49.104743	0.8447
16388	Q25	ЗУ	MO 15	077	2026-05-10 01:15:49.104743	0.4333
16390	Q9	ЗУ	BG 2	063	2026-05-10 01:15:52.853123	32.3392
16391	Q10	ЗУ	SM 2	064	2026-05-10 01:15:53.265804	18.8565
16393	Q12	ЗУ	SM 4	066	2026-05-10 01:15:53.265804	0.9019
16394	Q13	ЗУ	SM 5	067	2026-05-10 01:15:53.265804	1.6319
16396	Q15	ЗУ	SM 7	069	2026-05-10 01:15:53.265804	1.232
16397	Q16	ЗУ	SM 8	070	2026-05-10 01:15:53.265804	2.8215
16399	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:16:05.783373	20.6035
16400	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:16:05.783373	8.3862
16402	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:16:05.783373	7.3641
16403	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:16:05.783373	20.4179
16405	TP3	ЗУ	CP-300 New	078	2026-05-10 01:16:08.169937	7.2428
16407	QF 1,21	ЗУ	China 2	045	2026-05-10 01:16:22.12805	9.9461
16408	QF 1,22	ЗУ	China 3	046	2026-05-10 01:16:22.12805	14.0198
16410	QF 2,21	ЗУ	China 5	048	2026-05-10 01:16:22.12805	20.1428
16411	QF 2,22	ЗУ	China 6	049	2026-05-10 01:16:22.12805	20.2161
16413	QF 2,19	ЗУ	China 8	051	2026-05-10 01:16:22.12805	14.5931
16414	Q4	ЗУ	BG 1	062	2026-05-10 01:16:37.893934	21.1745
16415	Q9	ЗУ	BG 2	063	2026-05-10 01:16:37.893934	32.4968
16417	TP3	ЗУ	CP-300 New	078	2026-05-10 01:16:38.182383	6.9902
16418	Q10	ЗУ	SM 2	064	2026-05-10 01:16:38.309246	18.8933
16420	Q12	ЗУ	SM 4	066	2026-05-10 01:16:38.309246	0.8418
16421	Q13	ЗУ	SM 5	067	2026-05-10 01:16:38.309246	0.704
16423	Q15	ЗУ	SM 7	069	2026-05-10 01:16:38.309246	0.9175
16424	Q16	ЗУ	SM 8	070	2026-05-10 01:16:38.309246	2.9172
16426	Q20	ЗУ	MO 10	072	2026-05-10 01:16:39.156963	13.0784
16427	Q21	ЗУ	MO 11	073	2026-05-10 01:16:39.156963	0.6292
16429	Q23	ЗУ	MO 13	075	2026-05-10 01:16:39.156963	0.702
16430	Q24	ЗУ	MO 14	076	2026-05-10 01:16:39.156963	0.5427
16432	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:16:40.819214	21.5022
16433	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:16:40.819214	7.9823
16435	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:16:40.819214	8.6757
16439	QF 1,21	ЗУ	China 2	045	2026-05-10 01:17:02.183856	10.6934
16442	QF 2,21	ЗУ	China 5	048	2026-05-10 01:17:02.183856	20.0086
16445	QF 2,19	ЗУ	China 8	051	2026-05-10 01:17:02.183856	14.5041
16446	TP3	ЗУ	CP-300 New	078	2026-05-10 01:17:08.196245	6.0952
16448	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:17:15.86191	21.5601
16451	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:17:15.86191	8.57
16455	Q9	ЗУ	BG 2	063	2026-05-10 01:17:22.951241	32.3174
16457	Q11	ЗУ	SM 3	065	2026-05-10 01:17:23.352062	20.9864
16460	Q14	ЗУ	SM 6	068	2026-05-10 01:17:23.352062	0.6137
16465	Q21	ЗУ	MO 11	073	2026-05-10 01:17:29.213151	1.3304
16468	Q24	ЗУ	MO 14	076	2026-05-10 01:17:29.213151	0.8392
16471	QF 1,20	ЗУ	China 1	044	2026-05-10 01:17:42.24774	12.1286
16474	QF 2,20	ЗУ	China 4	047	2026-05-10 01:17:42.24774	19.3656
16477	QF 2,23	ЗУ	China 7	050	2026-05-10 01:17:42.24774	9.6977
16479	Q8	ЗУ	DIG	061	2026-05-10 01:17:48.112076	46.2493
16481	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:17:50.909184	7.9863
16484	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:17:50.909184	19.2812
16486	Q4	ЗУ	BG 1	062	2026-05-10 01:18:07.997741	20.2184
16488	TP3	ЗУ	CP-300 New	078	2026-05-10 01:18:08.271576	6.1401
16491	Q12	ЗУ	SM 4	066	2026-05-10 01:18:08.42161	1.1984
16494	Q15	ЗУ	SM 7	069	2026-05-10 01:18:08.42161	1.0956
16497	Q20	ЗУ	MO 10	072	2026-05-10 01:18:19.28086	13.264
16500	Q23	ЗУ	MO 13	075	2026-05-10 01:18:19.28086	0.3697
16503	QF 1,20	ЗУ	China 1	044	2026-05-10 01:18:22.291222	11.1473
16506	QF 2,20	ЗУ	China 4	047	2026-05-10 01:18:22.291222	18.589
16509	QF 2,23	ЗУ	China 7	050	2026-05-10 01:18:22.291222	9.0778
16512	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:18:25.9447	21.5778
16515	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:18:25.9447	8.6341
16518	TP3	ЗУ	CP-300 New	078	2026-05-10 01:18:38.292277	6.6655
16521	Q10	ЗУ	SM 2	064	2026-05-10 01:18:53.460942	18.4657
16524	Q13	ЗУ	SM 5	067	2026-05-10 01:18:53.460942	1.5916
16527	Q16	ЗУ	SM 8	070	2026-05-10 01:18:53.460942	2.3573
16528	Q8	ЗУ	DIG	061	2026-05-10 01:18:58.150499	47.2007
16531	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:19:00.988834	16.6706
16534	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:19:00.988834	19.0024
16536	QF 1,21	ЗУ	China 2	045	2026-05-10 01:19:02.331006	10.2287
16539	QF 2,21	ЗУ	China 5	048	2026-05-10 01:19:02.331006	20.6998
16542	QF 2,19	ЗУ	China 8	051	2026-05-10 01:19:02.331006	15.1982
16544	Q17	ЗУ	MO 9	071	2026-05-10 01:19:09.532076	1.216
16547	Q22	ЗУ	MO 12	074	2026-05-10 01:19:09.532076	1.1785
16550	Q25	ЗУ	MO 15	077	2026-05-10 01:19:09.532076	1.064
16436	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:16:40.819214	19.3495
16440	QF 1,22	ЗУ	China 3	046	2026-05-10 01:17:02.183856	14.2704
16443	QF 2,22	ЗУ	China 6	049	2026-05-10 01:17:02.183856	19.1672
16449	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:17:15.86191	8.3337
16452	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:17:15.86191	20.4767
16458	Q12	ЗУ	SM 4	066	2026-05-10 01:17:23.352062	0.5596
16461	Q15	ЗУ	SM 7	069	2026-05-10 01:17:23.352062	0.8284
16463	Q17	ЗУ	MO 9	071	2026-05-10 01:17:29.213151	0.8273
16466	Q22	ЗУ	MO 12	074	2026-05-10 01:17:29.213151	0.5916
16469	Q25	ЗУ	MO 15	077	2026-05-10 01:17:29.213151	0.7847
16472	QF 1,21	ЗУ	China 2	045	2026-05-10 01:17:42.24774	11.1288
16475	QF 2,21	ЗУ	China 5	048	2026-05-10 01:17:42.24774	20.5354
16478	QF 2,19	ЗУ	China 8	051	2026-05-10 01:17:42.24774	14.5813
16482	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:17:50.909184	17.65
16485	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:17:50.909184	18.5117
16487	Q9	ЗУ	BG 2	063	2026-05-10 01:18:07.997741	33.3455
16489	Q10	ЗУ	SM 2	064	2026-05-10 01:18:08.42161	18.1523
16492	Q13	ЗУ	SM 5	067	2026-05-10 01:18:08.42161	0.8653
16495	Q16	ЗУ	SM 8	070	2026-05-10 01:18:08.42161	2.2667
16498	Q21	ЗУ	MO 11	073	2026-05-10 01:18:19.28086	0.3649
16501	Q24	ЗУ	MO 14	076	2026-05-10 01:18:19.28086	1.1952
16504	QF 1,21	ЗУ	China 2	045	2026-05-10 01:18:22.291222	10.1365
16507	QF 2,21	ЗУ	China 5	048	2026-05-10 01:18:22.291222	20.8519
16510	QF 2,19	ЗУ	China 8	051	2026-05-10 01:18:22.291222	14.6882
16513	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:18:25.9447	9.5599
16516	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:18:25.9447	20.5569
16519	Q4	ЗУ	BG 1	062	2026-05-10 01:18:53.040431	20.0163
16520	Q9	ЗУ	BG 2	063	2026-05-10 01:18:53.040431	32.8556
16522	Q11	ЗУ	SM 3	065	2026-05-10 01:18:53.460942	21.7089
16523	Q12	ЗУ	SM 4	066	2026-05-10 01:18:53.460942	0.6202
16525	Q14	ЗУ	SM 6	068	2026-05-10 01:18:53.460942	0.5603
16526	Q15	ЗУ	SM 7	069	2026-05-10 01:18:53.460942	1.2369
16529	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:19:00.988834	21.6481
16530	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:19:00.988834	8.1008
16532	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:19:00.988834	7.8591
16533	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:19:00.988834	20.1626
16535	QF 1,20	ЗУ	China 1	044	2026-05-10 01:19:02.331006	12.1374
16537	QF 1,22	ЗУ	China 3	046	2026-05-10 01:19:02.331006	13.8668
16538	QF 2,20	ЗУ	China 4	047	2026-05-10 01:19:02.331006	19.0945
16540	QF 2,22	ЗУ	China 6	049	2026-05-10 01:19:02.331006	19.5791
16541	QF 2,23	ЗУ	China 7	050	2026-05-10 01:19:02.331006	9.6378
16543	TP3	ЗУ	CP-300 New	078	2026-05-10 01:19:08.314157	6.6606
16545	Q20	ЗУ	MO 10	072	2026-05-10 01:19:09.532076	13.7285
16546	Q21	ЗУ	MO 11	073	2026-05-10 01:19:09.532076	1.1409
16548	Q23	ЗУ	MO 13	075	2026-05-10 01:19:09.532076	1.1969
16549	Q24	ЗУ	MO 14	076	2026-05-10 01:19:09.532076	1.1348
16551	QF 1,20	ЗУ	China 1	044	2026-05-10 01:19:42.367269	10.9576
16552	QF 1,21	ЗУ	China 2	045	2026-05-10 01:19:42.367269	10.4191
16553	QF 1,22	ЗУ	China 3	046	2026-05-10 01:19:42.367269	13.7972
16554	QF 2,20	ЗУ	China 4	047	2026-05-10 01:19:42.367269	19.1001
16555	QF 2,21	ЗУ	China 5	048	2026-05-10 01:19:42.367269	20.8604
16556	QF 2,22	ЗУ	China 6	049	2026-05-10 01:19:42.367269	19.9935
16557	QF 2,23	ЗУ	China 7	050	2026-05-10 01:19:42.367269	10.1223
16558	QF 2,19	ЗУ	China 8	051	2026-05-10 01:19:42.367269	13.9412
16559	Q17	ЗУ	MO 9	071	2026-05-10 01:19:59.575252	0.4562
16560	Q20	ЗУ	MO 10	072	2026-05-10 01:19:59.575252	13.6086
16561	Q21	ЗУ	MO 11	073	2026-05-10 01:19:59.575252	0.5349
16562	Q22	ЗУ	MO 12	074	2026-05-10 01:19:59.575252	0.3594
16563	Q23	ЗУ	MO 13	075	2026-05-10 01:19:59.575252	0.4976
16564	Q24	ЗУ	MO 14	076	2026-05-10 01:19:59.575252	0.9142
16565	Q25	ЗУ	MO 15	077	2026-05-10 01:19:59.575252	1.0163
16566	Q8	ЗУ	DIG	061	2026-05-10 01:20:08.192561	46.373
16567	TP3	ЗУ	CP-300 New	078	2026-05-10 01:20:08.44992	5.4682
16568	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:20:11.048918	21.2439
16569	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:20:11.048918	9.7279
16570	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:20:11.048918	16.0749
16571	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:20:11.048918	8.042
16572	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:20:11.048918	20.3513
16573	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:20:11.048918	18.2907
16574	QF 1,20	ЗУ	China 1	044	2026-05-10 01:20:22.414743	10.8917
16575	QF 1,21	ЗУ	China 2	045	2026-05-10 01:20:22.414743	10.4513
16576	QF 1,22	ЗУ	China 3	046	2026-05-10 01:20:22.414743	13.736
16577	QF 2,20	ЗУ	China 4	047	2026-05-10 01:20:22.414743	17.8915
16578	QF 2,21	ЗУ	China 5	048	2026-05-10 01:20:22.414743	21.0144
16579	QF 2,22	ЗУ	China 6	049	2026-05-10 01:20:22.414743	19.0921
16580	QF 2,23	ЗУ	China 7	050	2026-05-10 01:20:22.414743	8.8647
16581	QF 2,19	ЗУ	China 8	051	2026-05-10 01:20:22.414743	14.5083
16582	Q4	ЗУ	BG 1	062	2026-05-10 01:20:23.094249	20.1087
16583	Q9	ЗУ	BG 2	063	2026-05-10 01:20:23.094249	32.3308
16584	Q10	ЗУ	SM 2	064	2026-05-10 01:20:23.542166	18.5085
16585	Q11	ЗУ	SM 3	065	2026-05-10 01:20:23.542166	20.9684
16586	Q12	ЗУ	SM 4	066	2026-05-10 01:20:23.542166	1.1022
16587	Q13	ЗУ	SM 5	067	2026-05-10 01:20:23.542166	1.249
16588	Q14	ЗУ	SM 6	068	2026-05-10 01:20:23.542166	1.1501
16589	Q15	ЗУ	SM 7	069	2026-05-10 01:20:23.542166	1.2176
16590	Q16	ЗУ	SM 8	070	2026-05-10 01:20:23.542166	2.6462
16591	TP3	ЗУ	CP-300 New	078	2026-05-10 01:20:38.499129	6.6108
16592	Q8	ЗУ	DIG	061	2026-05-10 01:20:43.208971	46.2145
16593	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:20:46.089965	21.4329
16594	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:20:46.089965	8.9134
16595	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:20:46.089965	16.3357
16596	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:20:46.089965	7.7787
16597	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:20:46.089965	19.0249
16598	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:20:46.089965	19.5721
16599	Q17	ЗУ	MO 9	071	2026-05-10 01:20:49.611311	0.3645
16600	Q20	ЗУ	MO 10	072	2026-05-10 01:20:49.611311	13.2369
16601	Q21	ЗУ	MO 11	073	2026-05-10 01:20:49.611311	1.3053
16602	Q22	ЗУ	MO 12	074	2026-05-10 01:20:49.611311	0.5312
16603	Q23	ЗУ	MO 13	075	2026-05-10 01:20:49.611311	1.1887
16604	Q24	ЗУ	MO 14	076	2026-05-10 01:20:49.611311	0.4895
16605	Q25	ЗУ	MO 15	077	2026-05-10 01:20:49.611311	1.2895
16606	QF 1,20	ЗУ	China 1	044	2026-05-10 01:21:02.446539	10.9836
16607	QF 1,21	ЗУ	China 2	045	2026-05-10 01:21:02.446539	10.1516
16608	QF 1,22	ЗУ	China 3	046	2026-05-10 01:21:02.446539	13.2416
16609	QF 2,20	ЗУ	China 4	047	2026-05-10 01:21:02.446539	18.5505
16610	QF 2,21	ЗУ	China 5	048	2026-05-10 01:21:02.446539	19.9342
16611	QF 2,22	ЗУ	China 6	049	2026-05-10 01:21:02.446539	19.036
16612	QF 2,23	ЗУ	China 7	050	2026-05-10 01:21:02.446539	9.6657
16613	QF 2,19	ЗУ	China 8	051	2026-05-10 01:21:02.446539	14.5345
16614	Q4	ЗУ	BG 1	062	2026-05-10 01:21:08.114403	20.3735
16615	Q9	ЗУ	BG 2	063	2026-05-10 01:21:08.114403	33.1879
16616	TP3	ЗУ	CP-300 New	078	2026-05-10 01:21:08.514846	5.9074
16617	Q10	ЗУ	SM 2	064	2026-05-10 01:21:08.583642	18.1971
16618	Q11	ЗУ	SM 3	065	2026-05-10 01:21:08.583642	21.8529
16619	Q12	ЗУ	SM 4	066	2026-05-10 01:21:08.583642	0.7876
16620	Q13	ЗУ	SM 5	067	2026-05-10 01:21:08.583642	1.3452
16621	Q14	ЗУ	SM 6	068	2026-05-10 01:21:08.583642	1.3942
16622	Q15	ЗУ	SM 7	069	2026-05-10 01:21:08.583642	0.585
16623	Q16	ЗУ	SM 8	070	2026-05-10 01:21:08.583642	2.4167
16624	Q8	ЗУ	DIG	061	2026-05-10 01:21:18.221386	45.0862
16625	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:21:21.117855	21.6419
16626	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:21:21.117855	8.6352
16627	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:21:21.117855	17.2455
16628	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:21:21.117855	7.8821
16629	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:21:21.117855	19.1273
16630	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:21:21.117855	18.2173
16631	TP3	ЗУ	CP-300 New	078	2026-05-10 01:21:38.529891	6.8953
16632	Q17	ЗУ	MO 9	071	2026-05-10 01:21:39.646364	0.6628
16633	Q20	ЗУ	MO 10	072	2026-05-10 01:21:39.646364	13.1777
16634	Q21	ЗУ	MO 11	073	2026-05-10 01:21:39.646364	0.9678
16635	Q22	ЗУ	MO 12	074	2026-05-10 01:21:39.646364	0.6508
16636	Q23	ЗУ	MO 13	075	2026-05-10 01:21:39.646364	0.9497
16637	Q24	ЗУ	MO 14	076	2026-05-10 01:21:39.646364	0.4012
16638	Q25	ЗУ	MO 15	077	2026-05-10 01:21:39.646364	0.9642
16639	QF 1,20	ЗУ	China 1	044	2026-05-10 01:21:42.491914	11.8523
16640	QF 1,21	ЗУ	China 2	045	2026-05-10 01:21:42.491914	11.2857
16641	QF 1,22	ЗУ	China 3	046	2026-05-10 01:21:42.491914	14.0733
16642	QF 2,20	ЗУ	China 4	047	2026-05-10 01:21:42.491914	18.4268
16643	QF 2,21	ЗУ	China 5	048	2026-05-10 01:21:42.491914	20.5067
16644	QF 2,22	ЗУ	China 6	049	2026-05-10 01:21:42.491914	19.3826
16645	QF 2,23	ЗУ	China 7	050	2026-05-10 01:21:42.491914	9.5964
16646	QF 2,19	ЗУ	China 8	051	2026-05-10 01:21:42.491914	14.4876
16647	Q4	ЗУ	BG 1	062	2026-05-10 01:21:53.142383	20.0126
16648	Q9	ЗУ	BG 2	063	2026-05-10 01:21:53.142383	33.0283
16649	Q8	ЗУ	DIG	061	2026-05-10 01:21:53.240838	47.2071
16650	Q10	ЗУ	SM 2	064	2026-05-10 01:21:53.61171	18.442
16651	Q11	ЗУ	SM 3	065	2026-05-10 01:21:53.61171	21.2934
16652	Q12	ЗУ	SM 4	066	2026-05-10 01:21:53.61171	1.4985
16653	Q13	ЗУ	SM 5	067	2026-05-10 01:21:53.61171	0.9026
16654	Q14	ЗУ	SM 6	068	2026-05-10 01:21:53.61171	0.9037
16655	Q15	ЗУ	SM 7	069	2026-05-10 01:21:53.61171	0.7101
16656	Q16	ЗУ	SM 8	070	2026-05-10 01:21:53.61171	2.1432
16657	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:21:56.14172	20.7489
16658	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:21:56.14172	9.0141
16659	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:21:56.14172	16.1656
16660	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:21:56.14172	7.0172
16661	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:21:56.14172	20.5172
16662	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:21:56.14172	19.7028
16663	TP3	ЗУ	CP-300 New	078	2026-05-10 01:22:08.550036	5.4727
16664	QF 1,20	ЗУ	China 1	044	2026-05-10 01:22:22.533394	11.2165
16665	QF 1,21	ЗУ	China 2	045	2026-05-10 01:22:22.533394	10.7815
16666	QF 1,22	ЗУ	China 3	046	2026-05-10 01:22:22.533394	13.568
16667	QF 2,20	ЗУ	China 4	047	2026-05-10 01:22:22.533394	19.2203
16668	QF 2,21	ЗУ	China 5	048	2026-05-10 01:22:22.533394	21.0086
16669	QF 2,22	ЗУ	China 6	049	2026-05-10 01:22:22.533394	18.9785
16670	QF 2,23	ЗУ	China 7	050	2026-05-10 01:22:22.533394	8.8899
16671	QF 2,19	ЗУ	China 8	051	2026-05-10 01:22:22.533394	15.0517
16672	Q8	ЗУ	DIG	061	2026-05-10 01:22:28.252203	45.395
16673	Q17	ЗУ	MO 9	071	2026-05-10 01:22:29.69038	0.512
16674	Q20	ЗУ	MO 10	072	2026-05-10 01:22:29.69038	13.81
16675	Q21	ЗУ	MO 11	073	2026-05-10 01:22:29.69038	1.2605
16676	Q22	ЗУ	MO 12	074	2026-05-10 01:22:29.69038	0.9246
16677	Q23	ЗУ	MO 13	075	2026-05-10 01:22:29.69038	0.9272
16678	Q24	ЗУ	MO 14	076	2026-05-10 01:22:29.69038	0.6959
16679	Q25	ЗУ	MO 15	077	2026-05-10 01:22:29.69038	0.3301
16680	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:22:31.169635	20.0315
16681	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:22:31.169635	9.2315
16682	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:22:31.169635	17.5306
16683	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:22:31.169635	7.0741
16684	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:22:31.169635	20.3067
16685	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:22:31.169635	18.208
16686	Q4	ЗУ	BG 1	062	2026-05-10 01:22:38.166938	20.1093
16687	Q9	ЗУ	BG 2	063	2026-05-10 01:22:38.166938	32.7464
16688	TP3	ЗУ	CP-300 New	078	2026-05-10 01:22:38.629219	6.9655
16689	Q10	ЗУ	SM 2	064	2026-05-10 01:22:38.646014	18.3041
16690	Q11	ЗУ	SM 3	065	2026-05-10 01:22:38.646014	21.9823
16691	Q12	ЗУ	SM 4	066	2026-05-10 01:22:38.646014	0.6411
16692	Q13	ЗУ	SM 5	067	2026-05-10 01:22:38.646014	1.44
16693	Q14	ЗУ	SM 6	068	2026-05-10 01:22:38.646014	1.5349
16694	Q15	ЗУ	SM 7	069	2026-05-10 01:22:38.646014	1.1056
16695	Q16	ЗУ	SM 8	070	2026-05-10 01:22:38.646014	2.8223
16696	QF 1,20	ЗУ	China 1	044	2026-05-10 01:23:02.582477	10.9183
16697	QF 1,21	ЗУ	China 2	045	2026-05-10 01:23:02.582477	9.911
16698	QF 1,22	ЗУ	China 3	046	2026-05-10 01:23:02.582477	13.1783
16699	QF 2,20	ЗУ	China 4	047	2026-05-10 01:23:02.582477	18.0437
16700	QF 2,21	ЗУ	China 5	048	2026-05-10 01:23:02.582477	20.4606
16701	QF 2,22	ЗУ	China 6	049	2026-05-10 01:23:02.582477	19.0205
16702	QF 2,23	ЗУ	China 7	050	2026-05-10 01:23:02.582477	8.919
16703	QF 2,19	ЗУ	China 8	051	2026-05-10 01:23:02.582477	15.3028
16704	Q8	ЗУ	DIG	061	2026-05-10 01:23:03.269658	46.524
16705	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:23:06.203128	21.1921
16706	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:23:06.203128	8.9128
16707	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:23:06.203128	16.3649
16708	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:23:06.203128	8.6267
16709	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:23:06.203128	20.5235
16710	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:23:06.203128	19.3051
16711	TP3	ЗУ	CP-300 New	078	2026-05-10 01:23:08.647413	6.232
16712	Q17	ЗУ	MO 9	071	2026-05-10 01:23:19.735587	1.0134
16714	Q21	ЗУ	MO 11	073	2026-05-10 01:23:19.735587	1.1872
16716	Q23	ЗУ	MO 13	075	2026-05-10 01:23:19.735587	1.1267
16718	Q25	ЗУ	MO 15	077	2026-05-10 01:23:19.735587	1.1382
16719	Q4	ЗУ	BG 1	062	2026-05-10 01:23:23.189321	20.731
16721	Q10	ЗУ	SM 2	064	2026-05-10 01:23:23.683253	18.472
16723	Q12	ЗУ	SM 4	066	2026-05-10 01:23:23.683253	0.4519
16725	Q14	ЗУ	SM 6	068	2026-05-10 01:23:23.683253	0.771
16727	Q16	ЗУ	SM 8	070	2026-05-10 01:23:23.683253	2.6418
16729	TP3	ЗУ	CP-300 New	078	2026-05-10 01:23:38.669418	6.9165
16731	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:23:41.23968	9.3923
16733	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:23:41.23968	7.4008
16735	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:23:41.23968	17.9445
16736	QF 1,20	ЗУ	China 1	044	2026-05-10 01:23:42.637074	11.1974
16738	QF 1,22	ЗУ	China 3	046	2026-05-10 01:23:42.637074	14.1722
16740	QF 2,21	ЗУ	China 5	048	2026-05-10 01:23:42.637074	20.9187
16742	QF 2,23	ЗУ	China 7	050	2026-05-10 01:23:42.637074	10.0059
16745	Q9	ЗУ	BG 2	063	2026-05-10 01:24:08.228627	33.2817
16748	Q11	ЗУ	SM 3	065	2026-05-10 01:24:08.736243	21.6397
16751	Q14	ЗУ	SM 6	068	2026-05-10 01:24:08.736243	1.0969
16754	Q17	ЗУ	MO 9	071	2026-05-10 01:24:09.772163	0.5913
16757	Q22	ЗУ	MO 12	074	2026-05-10 01:24:09.772163	0.5268
16760	Q25	ЗУ	MO 15	077	2026-05-10 01:24:09.772163	1.0005
16764	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:24:16.266709	17.5824
16767	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:24:16.266709	19.0151
16768	QF 1,20	ЗУ	China 1	044	2026-05-10 01:24:22.675397	11.7639
16771	QF 2,20	ЗУ	China 4	047	2026-05-10 01:24:22.675397	18.0363
16774	QF 2,23	ЗУ	China 7	050	2026-05-10 01:24:22.675397	9.3441
16777	Q8	ЗУ	DIG	061	2026-05-10 01:24:48.325988	46.3404
16779	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:24:51.304674	8.9605
16782	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:24:51.304674	19.936
16785	Q9	ЗУ	BG 2	063	2026-05-10 01:24:53.320428	32.5885
16788	Q12	ЗУ	SM 4	066	2026-05-10 01:24:53.77474	1.4463
16791	Q15	ЗУ	SM 7	069	2026-05-10 01:24:53.77474	1.4537
16793	Q17	ЗУ	MO 9	071	2026-05-10 01:24:59.806688	1.2416
16796	Q22	ЗУ	MO 12	074	2026-05-10 01:24:59.806688	1.2855
16799	Q25	ЗУ	MO 15	077	2026-05-10 01:24:59.806688	0.5429
16800	QF 1,20	ЗУ	China 1	044	2026-05-10 01:25:02.719324	12.1898
16803	QF 2,20	ЗУ	China 4	047	2026-05-10 01:25:02.719324	19.3421
16806	QF 2,23	ЗУ	China 7	050	2026-05-10 01:25:02.719324	9.346
16808	TP3	ЗУ	CP-300 New	078	2026-05-10 01:25:08.732384	5.8152
16812	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:25:26.346653	16.099
16815	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:25:26.346653	17.9344
16816	Q4	ЗУ	BG 1	062	2026-05-10 01:25:38.484705	20.8617
16819	Q10	ЗУ	SM 2	064	2026-05-10 01:25:38.863212	18.5602
16822	Q13	ЗУ	SM 5	067	2026-05-10 01:25:38.863212	1.2915
16825	Q16	ЗУ	SM 8	070	2026-05-10 01:25:38.863212	2.5268
16826	QF 1,20	ЗУ	China 1	044	2026-05-10 01:25:42.754074	12.3238
16829	QF 2,20	ЗУ	China 4	047	2026-05-10 01:25:42.754074	19.2642
16832	QF 2,23	ЗУ	China 7	050	2026-05-10 01:25:42.754074	9.0022
16834	Q17	ЗУ	MO 9	071	2026-05-10 01:25:49.867719	0.6309
16837	Q22	ЗУ	MO 12	074	2026-05-10 01:25:49.867719	0.5989
16840	Q25	ЗУ	MO 15	077	2026-05-10 01:25:49.867719	0.5846
16841	Q8	ЗУ	DIG	061	2026-05-10 01:25:58.371345	45.916
16842	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:26:01.375827	19.9569
16845	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:26:01.375827	7.9669
16849	QF 1,20	ЗУ	China 1	044	2026-05-10 01:26:22.787853	11.6597
16852	QF 2,20	ЗУ	China 4	047	2026-05-10 01:26:22.787853	18.5028
16855	QF 2,23	ЗУ	China 7	050	2026-05-10 01:26:22.787853	9.0704
16858	Q9	ЗУ	BG 2	063	2026-05-10 01:26:23.51052	31.9563
16861	Q12	ЗУ	SM 4	066	2026-05-10 01:26:23.88822	0.8094
16864	Q15	ЗУ	SM 7	069	2026-05-10 01:26:23.88822	1.3585
16713	Q20	ЗУ	MO 10	072	2026-05-10 01:23:19.735587	12.94
16715	Q22	ЗУ	MO 12	074	2026-05-10 01:23:19.735587	0.878
16717	Q24	ЗУ	MO 14	076	2026-05-10 01:23:19.735587	0.9109
16720	Q9	ЗУ	BG 2	063	2026-05-10 01:23:23.189321	32.3771
16722	Q11	ЗУ	SM 3	065	2026-05-10 01:23:23.683253	21.3421
16724	Q13	ЗУ	SM 5	067	2026-05-10 01:23:23.683253	0.5922
16726	Q15	ЗУ	SM 7	069	2026-05-10 01:23:23.683253	0.5751
16728	Q8	ЗУ	DIG	061	2026-05-10 01:23:38.287379	44.879
16730	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:23:41.23968	21.0106
16732	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:23:41.23968	16.8062
16734	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:23:41.23968	19.6161
16737	QF 1,21	ЗУ	China 2	045	2026-05-10 01:23:42.637074	10.4967
16739	QF 2,20	ЗУ	China 4	047	2026-05-10 01:23:42.637074	18.4011
16741	QF 2,22	ЗУ	China 6	049	2026-05-10 01:23:42.637074	19.0753
16743	QF 2,19	ЗУ	China 8	051	2026-05-10 01:23:42.637074	14.7872
16746	TP3	ЗУ	CP-300 New	078	2026-05-10 01:24:08.692729	6.8123
16749	Q12	ЗУ	SM 4	066	2026-05-10 01:24:08.736243	1.0181
16752	Q15	ЗУ	SM 7	069	2026-05-10 01:24:08.736243	1.1579
16755	Q20	ЗУ	MO 10	072	2026-05-10 01:24:09.772163	13.7446
16758	Q23	ЗУ	MO 13	075	2026-05-10 01:24:09.772163	1.275
16762	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:24:16.266709	21.5837
16765	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:24:16.266709	6.998
16769	QF 1,21	ЗУ	China 2	045	2026-05-10 01:24:22.675397	11.2233
16772	QF 2,21	ЗУ	China 5	048	2026-05-10 01:24:22.675397	20.2005
16775	QF 2,19	ЗУ	China 8	051	2026-05-10 01:24:22.675397	14.5508
16780	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:24:51.304674	17.4602
16783	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:24:51.304674	19.1552
16786	Q10	ЗУ	SM 2	064	2026-05-10 01:24:53.77474	18.3977
16789	Q13	ЗУ	SM 5	067	2026-05-10 01:24:53.77474	1.2588
16792	Q16	ЗУ	SM 8	070	2026-05-10 01:24:53.77474	2.1405
16794	Q20	ЗУ	MO 10	072	2026-05-10 01:24:59.806688	12.981
16797	Q23	ЗУ	MO 13	075	2026-05-10 01:24:59.806688	0.5864
16801	QF 1,21	ЗУ	China 2	045	2026-05-10 01:25:02.719324	11.0693
16804	QF 2,21	ЗУ	China 5	048	2026-05-10 01:25:02.719324	19.8837
16807	QF 2,19	ЗУ	China 8	051	2026-05-10 01:25:02.719324	14.179
16810	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:25:26.346653	20.6608
16813	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:25:26.346653	8.6007
16817	Q9	ЗУ	BG 2	063	2026-05-10 01:25:38.484705	32.6063
16820	Q11	ЗУ	SM 3	065	2026-05-10 01:25:38.863212	20.9229
16823	Q14	ЗУ	SM 6	068	2026-05-10 01:25:38.863212	1.1447
16827	QF 1,21	ЗУ	China 2	045	2026-05-10 01:25:42.754074	10.4992
16830	QF 2,21	ЗУ	China 5	048	2026-05-10 01:25:42.754074	20.5285
16833	QF 2,19	ЗУ	China 8	051	2026-05-10 01:25:42.754074	14.9708
16835	Q20	ЗУ	MO 10	072	2026-05-10 01:25:49.867719	13.1666
16838	Q23	ЗУ	MO 13	075	2026-05-10 01:25:49.867719	0.5997
16843	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:26:01.375827	7.9118
16846	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:26:01.375827	19.1228
16848	TP3	ЗУ	CP-300 New	078	2026-05-10 01:26:08.76008	6.6234
16850	QF 1,21	ЗУ	China 2	045	2026-05-10 01:26:22.787853	10.9567
16853	QF 2,21	ЗУ	China 5	048	2026-05-10 01:26:22.787853	20.5449
16856	QF 2,19	ЗУ	China 8	051	2026-05-10 01:26:22.787853	14.2096
16859	Q10	ЗУ	SM 2	064	2026-05-10 01:26:23.88822	18.8121
16862	Q13	ЗУ	SM 5	067	2026-05-10 01:26:23.88822	1.2119
16865	Q16	ЗУ	SM 8	070	2026-05-10 01:26:23.88822	2.196
16744	Q4	ЗУ	BG 1	062	2026-05-10 01:24:08.228627	20.9681
16747	Q10	ЗУ	SM 2	064	2026-05-10 01:24:08.736243	18.8175
16750	Q13	ЗУ	SM 5	067	2026-05-10 01:24:08.736243	0.6042
16753	Q16	ЗУ	SM 8	070	2026-05-10 01:24:08.736243	3.0213
16756	Q21	ЗУ	MO 11	073	2026-05-10 01:24:09.772163	0.4873
16759	Q24	ЗУ	MO 14	076	2026-05-10 01:24:09.772163	0.8957
16761	Q8	ЗУ	DIG	061	2026-05-10 01:24:13.306178	45.1462
16763	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:24:16.266709	8.2061
16766	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:24:16.266709	19.3629
16770	QF 1,22	ЗУ	China 3	046	2026-05-10 01:24:22.675397	12.9727
16773	QF 2,22	ЗУ	China 6	049	2026-05-10 01:24:22.675397	19.2388
16776	TP3	ЗУ	CP-300 New	078	2026-05-10 01:24:38.706498	5.3525
16778	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:24:51.304674	20.5382
16781	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:24:51.304674	8.6351
16784	Q4	ЗУ	BG 1	062	2026-05-10 01:24:53.320428	20.9728
16787	Q11	ЗУ	SM 3	065	2026-05-10 01:24:53.77474	21.7255
16790	Q14	ЗУ	SM 6	068	2026-05-10 01:24:53.77474	1.0443
16795	Q21	ЗУ	MO 11	073	2026-05-10 01:24:59.806688	0.7562
16798	Q24	ЗУ	MO 14	076	2026-05-10 01:24:59.806688	1.237
16802	QF 1,22	ЗУ	China 3	046	2026-05-10 01:25:02.719324	13.6672
16805	QF 2,22	ЗУ	China 6	049	2026-05-10 01:25:02.719324	19.295
16809	Q8	ЗУ	DIG	061	2026-05-10 01:25:23.349967	46.1316
16811	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:25:26.346653	8.815
16814	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:25:26.346653	20.691
16818	TP3	ЗУ	CP-300 New	078	2026-05-10 01:25:38.744641	6.801
16821	Q12	ЗУ	SM 4	066	2026-05-10 01:25:38.863212	1.4277
16824	Q15	ЗУ	SM 7	069	2026-05-10 01:25:38.863212	0.8893
16828	QF 1,22	ЗУ	China 3	046	2026-05-10 01:25:42.754074	14.2636
16831	QF 2,22	ЗУ	China 6	049	2026-05-10 01:25:42.754074	19.2208
16836	Q21	ЗУ	MO 11	073	2026-05-10 01:25:49.867719	0.9937
16839	Q24	ЗУ	MO 14	076	2026-05-10 01:25:49.867719	1.0781
16844	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:26:01.375827	16.9104
16847	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:26:01.375827	18.2194
16851	QF 1,22	ЗУ	China 3	046	2026-05-10 01:26:22.787853	14.3638
16854	QF 2,22	ЗУ	China 6	049	2026-05-10 01:26:22.787853	19.5373
16857	Q4	ЗУ	BG 1	062	2026-05-10 01:26:23.51052	20.5701
16860	Q11	ЗУ	SM 3	065	2026-05-10 01:26:23.88822	21.628
16863	Q14	ЗУ	SM 6	068	2026-05-10 01:26:23.88822	0.4338
16866	TP3	ЗУ	CP-300 New	078	2026-05-10 01:26:38.77409	7.2533
16867	Q17	ЗУ	MO 9	071	2026-05-10 01:26:39.912575	1.0972
16868	Q20	ЗУ	MO 10	072	2026-05-10 01:26:39.912575	13.4385
16869	Q21	ЗУ	MO 11	073	2026-05-10 01:26:39.912575	1.2077
16870	Q22	ЗУ	MO 12	074	2026-05-10 01:26:39.912575	1.0046
16871	Q23	ЗУ	MO 13	075	2026-05-10 01:26:39.912575	0.6653
16872	Q24	ЗУ	MO 14	076	2026-05-10 01:26:39.912575	0.7283
16873	Q25	ЗУ	MO 15	077	2026-05-10 01:26:39.912575	0.8332
16874	QF 1,20	ЗУ	China 1	044	2026-05-10 01:27:02.837105	11.2705
16875	QF 1,21	ЗУ	China 2	045	2026-05-10 01:27:02.837105	11.168
16876	QF 1,22	ЗУ	China 3	046	2026-05-10 01:27:02.837105	14.339
16877	QF 2,20	ЗУ	China 4	047	2026-05-10 01:27:02.837105	18.9359
16878	QF 2,21	ЗУ	China 5	048	2026-05-10 01:27:02.837105	20.5784
16879	QF 2,22	ЗУ	China 6	049	2026-05-10 01:27:02.837105	20.277
16880	QF 2,23	ЗУ	China 7	050	2026-05-10 01:27:02.837105	9.4329
16881	QF 2,19	ЗУ	China 8	051	2026-05-10 01:27:02.837105	14.849
16882	Q8	ЗУ	DIG	061	2026-05-10 01:27:08.39347	46.4198
16883	Q4	ЗУ	BG 1	062	2026-05-10 01:27:08.536123	20.2707
16884	Q9	ЗУ	BG 2	063	2026-05-10 01:27:08.536123	33.065
16885	TP3	ЗУ	CP-300 New	078	2026-05-10 01:27:08.794035	5.499
16886	Q10	ЗУ	SM 2	064	2026-05-10 01:27:08.931031	18.1231
16887	Q11	ЗУ	SM 3	065	2026-05-10 01:27:08.931031	21.8344
16888	Q12	ЗУ	SM 4	066	2026-05-10 01:27:08.931031	1.0094
16889	Q13	ЗУ	SM 5	067	2026-05-10 01:27:08.931031	1.3123
16890	Q14	ЗУ	SM 6	068	2026-05-10 01:27:08.931031	1.2475
16891	Q15	ЗУ	SM 7	069	2026-05-10 01:27:08.931031	0.6661
16892	Q16	ЗУ	SM 8	070	2026-05-10 01:27:08.931031	2.0041
16893	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:27:11.449499	20.9195
16894	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:27:11.449499	9.2618
16895	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:27:11.449499	17.2363
16896	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:27:11.449499	7.8416
16897	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:27:11.449499	20.1951
16898	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:27:11.449499	18.6953
16899	Q17	ЗУ	MO 9	071	2026-05-10 01:27:29.937282	0.9255
16900	Q20	ЗУ	MO 10	072	2026-05-10 01:27:29.937282	13.6318
16901	Q21	ЗУ	MO 11	073	2026-05-10 01:27:29.937282	0.6853
16902	Q22	ЗУ	MO 12	074	2026-05-10 01:27:29.937282	0.7262
16903	Q23	ЗУ	MO 13	075	2026-05-10 01:27:29.937282	1.0903
16904	Q24	ЗУ	MO 14	076	2026-05-10 01:27:29.937282	0.4431
16905	Q25	ЗУ	MO 15	077	2026-05-10 01:27:29.937282	0.3681
16906	TP3	ЗУ	CP-300 New	078	2026-05-10 01:27:38.809813	5.3129
16907	QF 1,20	ЗУ	China 1	044	2026-05-10 01:27:42.891099	11.1068
16908	QF 1,21	ЗУ	China 2	045	2026-05-10 01:27:42.891099	10.8723
16909	QF 1,22	ЗУ	China 3	046	2026-05-10 01:27:42.891099	13.2762
16910	QF 2,20	ЗУ	China 4	047	2026-05-10 01:27:42.891099	18.7972
16911	QF 2,21	ЗУ	China 5	048	2026-05-10 01:27:42.891099	21.3524
16912	QF 2,22	ЗУ	China 6	049	2026-05-10 01:27:42.891099	19.2901
16913	QF 2,23	ЗУ	China 7	050	2026-05-10 01:27:42.891099	10.2198
16914	QF 2,19	ЗУ	China 8	051	2026-05-10 01:27:42.891099	14.0401
16915	Q8	ЗУ	DIG	061	2026-05-10 01:27:43.414507	45.0259
16916	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:27:46.484859	21.288
16917	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:27:46.484859	7.8824
16918	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:27:46.484859	17.0035
16919	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:27:46.484859	7.8117
16920	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:27:46.484859	20.4927
16921	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:27:46.484859	18.7239
16922	Q4	ЗУ	BG 1	062	2026-05-10 01:27:53.558935	20.1553
16923	Q9	ЗУ	BG 2	063	2026-05-10 01:27:53.558935	32.0995
16924	Q10	ЗУ	SM 2	064	2026-05-10 01:27:53.966036	18.9819
16925	Q11	ЗУ	SM 3	065	2026-05-10 01:27:53.966036	21.4992
16926	Q12	ЗУ	SM 4	066	2026-05-10 01:27:53.966036	1.2142
16927	Q13	ЗУ	SM 5	067	2026-05-10 01:27:53.966036	1.2045
16928	Q14	ЗУ	SM 6	068	2026-05-10 01:27:53.966036	1.2101
16929	Q15	ЗУ	SM 7	069	2026-05-10 01:27:53.966036	0.4665
16930	Q16	ЗУ	SM 8	070	2026-05-10 01:27:53.966036	2.7738
16931	TP3	ЗУ	CP-300 New	078	2026-05-10 01:28:08.824993	6.6703
16932	Q8	ЗУ	DIG	061	2026-05-10 01:28:18.433369	44.9098
16933	Q17	ЗУ	MO 9	071	2026-05-10 01:28:19.977434	0.8021
16934	Q20	ЗУ	MO 10	072	2026-05-10 01:28:19.977434	13.7426
16935	Q21	ЗУ	MO 11	073	2026-05-10 01:28:19.977434	1.1293
16936	Q22	ЗУ	MO 12	074	2026-05-10 01:28:19.977434	1.0749
16937	Q23	ЗУ	MO 13	075	2026-05-10 01:28:19.977434	1.2959
16938	Q24	ЗУ	MO 14	076	2026-05-10 01:28:19.977434	0.3385
16939	Q25	ЗУ	MO 15	077	2026-05-10 01:28:19.977434	0.6023
16940	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:28:21.57333	20.1146
16941	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:28:21.57333	9.2952
16942	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:28:21.57333	16.0089
16943	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:28:21.57333	8.0195
16944	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:28:21.57333	19.1171
16945	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:28:21.57333	18.5034
16946	QF 1,20	ЗУ	China 1	044	2026-05-10 01:28:22.935789	11.5273
16947	QF 1,21	ЗУ	China 2	045	2026-05-10 01:28:22.935789	10.9918
16948	QF 1,22	ЗУ	China 3	046	2026-05-10 01:28:22.935789	14.277
16949	QF 2,20	ЗУ	China 4	047	2026-05-10 01:28:22.935789	18.1884
16950	QF 2,21	ЗУ	China 5	048	2026-05-10 01:28:22.935789	20.909
16951	QF 2,22	ЗУ	China 6	049	2026-05-10 01:28:22.935789	19.6863
16952	QF 2,23	ЗУ	China 7	050	2026-05-10 01:28:22.935789	9.1578
16953	QF 2,19	ЗУ	China 8	051	2026-05-10 01:28:22.935789	14.028
16954	Q4	ЗУ	BG 1	062	2026-05-10 01:28:38.581283	19.9465
16955	Q9	ЗУ	BG 2	063	2026-05-10 01:28:38.581283	32.4958
16956	TP3	ЗУ	CP-300 New	078	2026-05-10 01:28:38.842304	5.3429
16957	Q10	ЗУ	SM 2	064	2026-05-10 01:28:39.006441	18.1574
16958	Q11	ЗУ	SM 3	065	2026-05-10 01:28:39.006441	22.0506
16959	Q12	ЗУ	SM 4	066	2026-05-10 01:28:39.006441	1.2477
16960	Q13	ЗУ	SM 5	067	2026-05-10 01:28:39.006441	1.5451
16961	Q14	ЗУ	SM 6	068	2026-05-10 01:28:39.006441	0.9832
16962	Q15	ЗУ	SM 7	069	2026-05-10 01:28:39.006441	1.3115
16963	Q16	ЗУ	SM 8	070	2026-05-10 01:28:39.006441	1.949
16964	Q8	ЗУ	DIG	061	2026-05-10 01:28:53.444091	45.3773
16965	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:28:56.604282	21.2169
16966	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:28:56.604282	8.6871
16967	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:28:56.604282	16.478
16968	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:28:56.604282	8.0615
16969	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:28:56.604282	20.2812
16970	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:28:56.604282	19.3507
16971	QF 1,20	ЗУ	China 1	044	2026-05-10 01:29:02.980735	11.494
16972	QF 1,21	ЗУ	China 2	045	2026-05-10 01:29:02.980735	10.8796
16973	QF 1,22	ЗУ	China 3	046	2026-05-10 01:29:02.980735	13.0111
16974	QF 2,20	ЗУ	China 4	047	2026-05-10 01:29:02.980735	18.0471
16975	QF 2,21	ЗУ	China 5	048	2026-05-10 01:29:02.980735	20.5137
16976	QF 2,22	ЗУ	China 6	049	2026-05-10 01:29:02.980735	19.8804
16977	QF 2,23	ЗУ	China 7	050	2026-05-10 01:29:02.980735	9.5838
16978	QF 2,19	ЗУ	China 8	051	2026-05-10 01:29:02.980735	14.414
16979	TP3	ЗУ	CP-300 New	078	2026-05-10 01:29:08.854582	6.2278
16980	Q17	ЗУ	MO 9	071	2026-05-10 01:29:10.013238	0.5061
16981	Q20	ЗУ	MO 10	072	2026-05-10 01:29:10.013238	13.0225
16982	Q21	ЗУ	MO 11	073	2026-05-10 01:29:10.013238	1.0162
16983	Q22	ЗУ	MO 12	074	2026-05-10 01:29:10.013238	1.1295
16984	Q23	ЗУ	MO 13	075	2026-05-10 01:29:10.013238	0.9443
16985	Q24	ЗУ	MO 14	076	2026-05-10 01:29:10.013238	0.7635
16986	Q25	ЗУ	MO 15	077	2026-05-10 01:29:10.013238	1.0233
16987	Q4	ЗУ	BG 1	062	2026-05-10 01:29:23.601899	20.4821
16988	Q9	ЗУ	BG 2	063	2026-05-10 01:29:23.601899	32.0891
16989	Q10	ЗУ	SM 2	064	2026-05-10 01:29:24.046244	19.0645
16990	Q11	ЗУ	SM 3	065	2026-05-10 01:29:24.046244	21.9597
16991	Q12	ЗУ	SM 4	066	2026-05-10 01:29:24.046244	0.8734
16992	Q13	ЗУ	SM 5	067	2026-05-10 01:29:24.046244	0.5616
16993	Q14	ЗУ	SM 6	068	2026-05-10 01:29:24.046244	0.5482
16994	Q15	ЗУ	SM 7	069	2026-05-10 01:29:24.046244	1.1297
16995	Q16	ЗУ	SM 8	070	2026-05-10 01:29:24.046244	2.0267
16996	Q8	ЗУ	DIG	061	2026-05-10 01:29:28.455194	45.6668
16997	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:29:31.634702	20.0355
16998	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:29:31.634702	8.3245
16999	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:29:31.634702	17.4602
17000	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:29:31.634702	7.5526
17001	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:29:31.634702	18.9666
17002	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:29:31.634702	19.4166
17003	TP3	ЗУ	CP-300 New	078	2026-05-10 01:29:38.867002	5.977
17004	QF 1,20	ЗУ	China 1	044	2026-05-10 01:29:43.02241	11.118
17005	QF 1,21	ЗУ	China 2	045	2026-05-10 01:29:43.02241	10.3626
17006	QF 1,22	ЗУ	China 3	046	2026-05-10 01:29:43.02241	13.6188
17007	QF 2,20	ЗУ	China 4	047	2026-05-10 01:29:43.02241	18.0642
17008	QF 2,21	ЗУ	China 5	048	2026-05-10 01:29:43.02241	20.0586
17009	QF 2,22	ЗУ	China 6	049	2026-05-10 01:29:43.02241	19.7824
17010	QF 2,23	ЗУ	China 7	050	2026-05-10 01:29:43.02241	10.0977
17011	QF 2,19	ЗУ	China 8	051	2026-05-10 01:29:43.02241	14.4135
17012	Q17	ЗУ	MO 9	071	2026-05-10 01:30:00.046943	1.2566
17013	Q20	ЗУ	MO 10	072	2026-05-10 01:30:00.046943	13.2205
17014	Q21	ЗУ	MO 11	073	2026-05-10 01:30:00.046943	1.1544
17015	Q22	ЗУ	MO 12	074	2026-05-10 01:30:00.046943	0.3173
17016	Q23	ЗУ	MO 13	075	2026-05-10 01:30:00.046943	0.7194
17017	Q24	ЗУ	MO 14	076	2026-05-10 01:30:00.046943	0.965
17018	Q25	ЗУ	MO 15	077	2026-05-10 01:30:00.046943	0.3601
17019	QF 1,20	ЗУ	China 1	044	2026-05-10 01:30:23.10066	11.1036
17020	QF 1,21	ЗУ	China 2	045	2026-05-10 01:30:23.10066	11.0213
17021	QF 1,22	ЗУ	China 3	046	2026-05-10 01:30:23.10066	13.3677
17022	QF 2,20	ЗУ	China 4	047	2026-05-10 01:30:23.10066	18.8261
17023	QF 2,21	ЗУ	China 5	048	2026-05-10 01:30:23.10066	20.3291
17024	QF 2,22	ЗУ	China 6	049	2026-05-10 01:30:23.10066	19.5732
17025	QF 2,23	ЗУ	China 7	050	2026-05-10 01:30:23.10066	8.8708
17026	QF 2,19	ЗУ	China 8	051	2026-05-10 01:30:23.10066	14.269
17027	Q8	ЗУ	DIG	061	2026-05-10 01:30:38.483143	46.3426
17028	TP3	ЗУ	CP-300 New	078	2026-05-10 01:30:38.893637	6.4338
17029	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:30:41.682107	20.6297
17030	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:30:41.682107	8.3824
17031	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:30:41.682107	15.8944
17032	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:30:41.682107	8.0417
17033	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:30:41.682107	19.6135
17034	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:30:41.682107	19.588
17035	Q17	ЗУ	MO 9	071	2026-05-10 01:30:50.08593	0.6497
17036	Q20	ЗУ	MO 10	072	2026-05-10 01:30:50.08593	13.1342
17037	Q21	ЗУ	MO 11	073	2026-05-10 01:30:50.08593	1.107
17038	Q22	ЗУ	MO 12	074	2026-05-10 01:30:50.08593	0.9801
17039	Q23	ЗУ	MO 13	075	2026-05-10 01:30:50.08593	0.6058
17040	Q24	ЗУ	MO 14	076	2026-05-10 01:30:50.08593	0.7443
17041	Q25	ЗУ	MO 15	077	2026-05-10 01:30:50.08593	0.843
17042	Q4	ЗУ	BG 1	062	2026-05-10 01:30:53.629507	20.0042
17043	Q9	ЗУ	BG 2	063	2026-05-10 01:30:53.629507	32.3856
17044	Q10	ЗУ	SM 2	064	2026-05-10 01:30:54.095364	18.1828
17045	Q11	ЗУ	SM 3	065	2026-05-10 01:30:54.095364	21.3509
17046	Q12	ЗУ	SM 4	066	2026-05-10 01:30:54.095364	0.9906
17047	Q13	ЗУ	SM 5	067	2026-05-10 01:30:54.095364	0.5044
17048	Q14	ЗУ	SM 6	068	2026-05-10 01:30:54.095364	1.4685
17049	Q15	ЗУ	SM 7	069	2026-05-10 01:30:54.095364	1.2111
17050	Q16	ЗУ	SM 8	070	2026-05-10 01:30:54.095364	1.9509
17051	QF 1,20	ЗУ	China 1	044	2026-05-10 01:31:03.157074	12.1552
17052	QF 1,21	ЗУ	China 2	045	2026-05-10 01:31:03.157074	10.609
17053	QF 1,22	ЗУ	China 3	046	2026-05-10 01:31:03.157074	13.9986
17054	QF 2,20	ЗУ	China 4	047	2026-05-10 01:31:03.157074	18.0059
17055	QF 2,21	ЗУ	China 5	048	2026-05-10 01:31:03.157074	19.9393
17056	QF 2,22	ЗУ	China 6	049	2026-05-10 01:31:03.157074	19.7223
17057	QF 2,23	ЗУ	China 7	050	2026-05-10 01:31:03.157074	9.8437
17058	QF 2,19	ЗУ	China 8	051	2026-05-10 01:31:03.157074	15.2806
17059	TP3	ЗУ	CP-300 New	078	2026-05-10 01:31:08.909907	6.8026
17060	Q8	ЗУ	DIG	061	2026-05-10 01:31:13.49512	46.5109
17061	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:31:16.715208	19.8913
17062	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:31:16.715208	9.0658
17063	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:31:16.715208	15.8837
17064	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:31:16.715208	7.3386
17065	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:31:16.715208	19.1529
17066	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:31:16.715208	18.9396
17067	QF 1,20	ЗУ	China 1	044	2026-05-10 01:31:43.20502	11.3194
17068	QF 1,21	ЗУ	China 2	045	2026-05-10 01:31:43.20502	11.3091
17069	QF 1,22	ЗУ	China 3	046	2026-05-10 01:31:43.20502	13.2322
17070	QF 2,20	ЗУ	China 4	047	2026-05-10 01:31:43.20502	18.9812
17071	QF 2,21	ЗУ	China 5	048	2026-05-10 01:31:43.20502	20.1279
17072	QF 2,22	ЗУ	China 6	049	2026-05-10 01:31:43.20502	18.8295
17073	QF 2,23	ЗУ	China 7	050	2026-05-10 01:31:43.20502	9.5882
17074	QF 2,19	ЗУ	China 8	051	2026-05-10 01:31:43.20502	14.4989
17075	Q8	ЗУ	DIG	061	2026-05-10 01:31:48.5152	45.4718
17076	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:31:51.787977	21.4049
17077	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:31:51.787977	8.7048
17078	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:31:51.787977	16.1816
17079	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:31:51.787977	7.8785
17080	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:31:51.787977	20.5475
17081	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:31:51.787977	18.3767
17082	TP3	ЗУ	CP-300 New	078	2026-05-10 01:32:08.932935	5.8475
17083	QF 1,20	ЗУ	China 1	044	2026-05-10 01:32:23.252409	11.924
17084	QF 1,21	ЗУ	China 2	045	2026-05-10 01:32:23.252409	10.9737
17085	QF 1,22	ЗУ	China 3	046	2026-05-10 01:32:23.252409	13.3666
17086	QF 2,20	ЗУ	China 4	047	2026-05-10 01:32:23.252409	18.8284
17087	QF 2,21	ЗУ	China 5	048	2026-05-10 01:32:23.252409	19.9938
17088	QF 2,22	ЗУ	China 6	049	2026-05-10 01:32:23.252409	19.5353
17089	QF 2,23	ЗУ	China 7	050	2026-05-10 01:32:23.252409	9.9792
17090	QF 2,19	ЗУ	China 8	051	2026-05-10 01:32:23.252409	14.5482
17091	Q8	ЗУ	DIG	061	2026-05-10 01:32:23.550324	45.9474
17092	Q4	ЗУ	BG 1	062	2026-05-10 01:32:23.727855	21.1693
17093	Q9	ЗУ	BG 2	063	2026-05-10 01:32:23.727855	32.1677
17094	Q10	ЗУ	SM 2	064	2026-05-10 01:32:24.237122	18.3127
17095	Q11	ЗУ	SM 3	065	2026-05-10 01:32:24.237122	21.7316
17096	Q12	ЗУ	SM 4	066	2026-05-10 01:32:24.237122	1.3221
17097	Q13	ЗУ	SM 5	067	2026-05-10 01:32:24.237122	0.4463
17098	Q14	ЗУ	SM 6	068	2026-05-10 01:32:24.237122	1.2252
17099	Q15	ЗУ	SM 7	069	2026-05-10 01:32:24.237122	1.3779
17100	Q16	ЗУ	SM 8	070	2026-05-10 01:32:24.237122	1.9952
17101	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:32:26.938567	19.8426
17102	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:32:26.938567	9.5361
17103	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:32:26.938567	16.7347
17104	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:32:26.938567	8.3741
17105	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:32:26.938567	20.3584
17106	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:32:26.938567	18.1444
17107	Q17	ЗУ	MO 9	071	2026-05-10 01:32:30.149994	0.6645
17108	Q20	ЗУ	MO 10	072	2026-05-10 01:32:30.149994	13.516
17109	Q21	ЗУ	MO 11	073	2026-05-10 01:32:30.149994	1.1149
17110	Q22	ЗУ	MO 12	074	2026-05-10 01:32:30.149994	0.3325
17111	Q23	ЗУ	MO 13	075	2026-05-10 01:32:30.149994	0.3653
17112	Q24	ЗУ	MO 14	076	2026-05-10 01:32:30.149994	0.8115
17113	Q25	ЗУ	MO 15	077	2026-05-10 01:32:30.149994	0.5503
17114	TP3	ЗУ	CP-300 New	078	2026-05-10 01:32:38.954972	6.4867
17115	Q8	ЗУ	DIG	061	2026-05-10 01:32:58.570709	47.088
17116	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:33:01.977196	21.2698
17117	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:33:01.977196	8.49
17118	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:33:01.977196	17.1654
17119	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:33:01.977196	7.005
17120	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:33:01.977196	20.167
17121	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:33:01.977196	19.0432
17122	QF 1,20	ЗУ	China 1	044	2026-05-10 01:33:03.298749	11.9108
17123	QF 1,21	ЗУ	China 2	045	2026-05-10 01:33:03.298749	11.0278
17124	QF 1,22	ЗУ	China 3	046	2026-05-10 01:33:03.298749	13.6388
17125	QF 2,20	ЗУ	China 4	047	2026-05-10 01:33:03.298749	19.1276
17126	QF 2,21	ЗУ	China 5	048	2026-05-10 01:33:03.298749	20.6907
17127	QF 2,22	ЗУ	China 6	049	2026-05-10 01:33:03.298749	20.1813
17128	QF 2,23	ЗУ	China 7	050	2026-05-10 01:33:03.298749	8.8476
17129	QF 2,19	ЗУ	China 8	051	2026-05-10 01:33:03.298749	14.1808
17130	Q4	ЗУ	BG 1	062	2026-05-10 01:33:08.755814	20.7717
17131	Q9	ЗУ	BG 2	063	2026-05-10 01:33:08.755814	32.0641
17132	TP3	ЗУ	CP-300 New	078	2026-05-10 01:33:08.971076	5.4641
17133	Q10	ЗУ	SM 2	064	2026-05-10 01:33:09.279264	18.9175
17134	Q11	ЗУ	SM 3	065	2026-05-10 01:33:09.279264	20.9711
17135	Q12	ЗУ	SM 4	066	2026-05-10 01:33:09.279264	1.0553
17136	Q13	ЗУ	SM 5	067	2026-05-10 01:33:09.279264	1.0395
17137	Q14	ЗУ	SM 6	068	2026-05-10 01:33:09.279264	0.9318
17138	Q15	ЗУ	SM 7	069	2026-05-10 01:33:09.279264	1.2891
17139	Q16	ЗУ	SM 8	070	2026-05-10 01:33:09.279264	2.1655
17140	Q17	ЗУ	MO 9	071	2026-05-10 01:33:20.19174	1.2736
17141	Q20	ЗУ	MO 10	072	2026-05-10 01:33:20.19174	13.4771
17142	Q21	ЗУ	MO 11	073	2026-05-10 01:33:20.19174	1.2374
17143	Q22	ЗУ	MO 12	074	2026-05-10 01:33:20.19174	1.1788
17144	Q23	ЗУ	MO 13	075	2026-05-10 01:33:20.19174	1.0425
17145	Q24	ЗУ	MO 14	076	2026-05-10 01:33:20.19174	0.5333
17146	Q25	ЗУ	MO 15	077	2026-05-10 01:33:20.19174	1.123
17147	Q8	ЗУ	DIG	061	2026-05-10 01:33:33.596954	45.3004
17148	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:33:37.018967	20.6308
17149	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:33:37.018967	9.2003
17150	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:33:37.018967	17.2135
17151	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:33:37.018967	8.1914
17152	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:33:37.018967	20.0123
17153	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:33:37.018967	18.8356
17154	TP3	ЗУ	CP-300 New	078	2026-05-10 01:33:38.991719	6.542
17155	QF 1,20	ЗУ	China 1	044	2026-05-10 01:33:43.352356	11.5744
17156	QF 1,21	ЗУ	China 2	045	2026-05-10 01:33:43.352356	11.0186
17157	QF 1,22	ЗУ	China 3	046	2026-05-10 01:33:43.352356	13.6684
17158	QF 2,20	ЗУ	China 4	047	2026-05-10 01:33:43.352356	18.1625
17159	QF 2,21	ЗУ	China 5	048	2026-05-10 01:33:43.352356	20.7383
17160	QF 2,22	ЗУ	China 6	049	2026-05-10 01:33:43.352356	19.9346
17161	QF 2,23	ЗУ	China 7	050	2026-05-10 01:33:43.352356	9.6563
17162	QF 2,19	ЗУ	China 8	051	2026-05-10 01:33:43.352356	14.1602
17163	Q4	ЗУ	BG 1	062	2026-05-10 01:33:53.776898	20.0828
17164	Q9	ЗУ	BG 2	063	2026-05-10 01:33:53.776898	31.9921
17165	Q10	ЗУ	SM 2	064	2026-05-10 01:33:54.322622	18.5921
17166	Q11	ЗУ	SM 3	065	2026-05-10 01:33:54.322622	21.6028
17167	Q12	ЗУ	SM 4	066	2026-05-10 01:33:54.322622	0.4442
17168	Q13	ЗУ	SM 5	067	2026-05-10 01:33:54.322622	0.8909
17169	Q14	ЗУ	SM 6	068	2026-05-10 01:33:54.322622	0.6097
17170	Q15	ЗУ	SM 7	069	2026-05-10 01:33:54.322622	0.4508
17171	Q16	ЗУ	SM 8	070	2026-05-10 01:33:54.322622	3.0267
17230	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:35:22.123737	9.48
17233	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:35:22.123737	20.4381
17236	Q9	ЗУ	BG 2	063	2026-05-10 01:35:23.853386	32.4878
17239	Q12	ЗУ	SM 4	066	2026-05-10 01:35:24.400209	0.8953
17242	Q15	ЗУ	SM 7	069	2026-05-10 01:35:24.400209	1.0888
17246	QF 1,21	ЗУ	China 2	045	2026-05-10 01:35:43.486249	10.5618
17249	QF 2,21	ЗУ	China 5	048	2026-05-10 01:35:43.486249	20.9024
17252	QF 2,19	ЗУ	China 8	051	2026-05-10 01:35:43.486249	14.2843
17173	TP3	ЗУ	CP-300 New	078	2026-05-10 01:34:09.005077	6.3619
17174	Q17	ЗУ	MO 9	071	2026-05-10 01:34:10.219318	0.9539
17175	Q20	ЗУ	MO 10	072	2026-05-10 01:34:10.219318	13.3671
17176	Q21	ЗУ	MO 11	073	2026-05-10 01:34:10.219318	1.2737
17177	Q22	ЗУ	MO 12	074	2026-05-10 01:34:10.219318	0.7779
17178	Q23	ЗУ	MO 13	075	2026-05-10 01:34:10.219318	0.6793
17179	Q24	ЗУ	MO 14	076	2026-05-10 01:34:10.219318	0.3641
17180	Q25	ЗУ	MO 15	077	2026-05-10 01:34:10.219318	1.0242
17181	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:34:12.057825	20.5518
17182	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:34:12.057825	9.5937
17183	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:34:12.057825	16.8972
17184	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:34:12.057825	7.9392
17185	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:34:12.057825	19.1431
17186	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:34:12.057825	19.289
17187	QF 1,20	ЗУ	China 1	044	2026-05-10 01:34:23.402172	11.3454
17188	QF 1,21	ЗУ	China 2	045	2026-05-10 01:34:23.402172	10.642
17189	QF 1,22	ЗУ	China 3	046	2026-05-10 01:34:23.402172	12.8574
17190	QF 2,20	ЗУ	China 4	047	2026-05-10 01:34:23.402172	19.058
17191	QF 2,21	ЗУ	China 5	048	2026-05-10 01:34:23.402172	20.0805
17192	QF 2,22	ЗУ	China 6	049	2026-05-10 01:34:23.402172	20.0663
17193	QF 2,23	ЗУ	China 7	050	2026-05-10 01:34:23.402172	10.0083
17194	QF 2,19	ЗУ	China 8	051	2026-05-10 01:34:23.402172	13.9243
17195	Q4	ЗУ	BG 1	062	2026-05-10 01:34:38.797131	20.5727
17196	Q9	ЗУ	BG 2	063	2026-05-10 01:34:38.797131	32.7883
17197	TP3	ЗУ	CP-300 New	078	2026-05-10 01:34:39.019221	6.8548
17198	Q10	ЗУ	SM 2	064	2026-05-10 01:34:39.359336	18.3602
17199	Q11	ЗУ	SM 3	065	2026-05-10 01:34:39.359336	21.1219
17200	Q12	ЗУ	SM 4	066	2026-05-10 01:34:39.359336	1.4199
17201	Q13	ЗУ	SM 5	067	2026-05-10 01:34:39.359336	0.4942
17202	Q14	ЗУ	SM 6	068	2026-05-10 01:34:39.359336	0.7311
17203	Q15	ЗУ	SM 7	069	2026-05-10 01:34:39.359336	1.3721
17204	Q16	ЗУ	SM 8	070	2026-05-10 01:34:39.359336	3.0217
17205	Q8	ЗУ	DIG	061	2026-05-10 01:34:43.628291	45.9902
17206	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:34:47.084692	20.2509
17207	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:34:47.084692	9.5437
17208	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:34:47.084692	16.8199
17209	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:34:47.084692	7.4447
17210	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:34:47.084692	20.5044
17211	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:34:47.084692	18.1537
17212	Q17	ЗУ	MO 9	071	2026-05-10 01:35:00.242653	0.8113
17213	Q20	ЗУ	MO 10	072	2026-05-10 01:35:00.242653	12.9456
17214	Q21	ЗУ	MO 11	073	2026-05-10 01:35:00.242653	0.6123
17215	Q22	ЗУ	MO 12	074	2026-05-10 01:35:00.242653	1.2243
17216	Q23	ЗУ	MO 13	075	2026-05-10 01:35:00.242653	0.8836
17217	Q24	ЗУ	MO 14	076	2026-05-10 01:35:00.242653	0.6748
17218	Q25	ЗУ	MO 15	077	2026-05-10 01:35:00.242653	0.8413
17219	QF 1,20	ЗУ	China 1	044	2026-05-10 01:35:03.437564	12.0053
17220	QF 1,21	ЗУ	China 2	045	2026-05-10 01:35:03.437564	10.75
17221	QF 1,22	ЗУ	China 3	046	2026-05-10 01:35:03.437564	14.2414
17222	QF 2,20	ЗУ	China 4	047	2026-05-10 01:35:03.437564	17.9807
17223	QF 2,21	ЗУ	China 5	048	2026-05-10 01:35:03.437564	21.0198
17224	QF 2,22	ЗУ	China 6	049	2026-05-10 01:35:03.437564	20.0705
17225	QF 2,23	ЗУ	China 7	050	2026-05-10 01:35:03.437564	8.9055
17226	QF 2,19	ЗУ	China 8	051	2026-05-10 01:35:03.437564	14.9959
17227	TP3	ЗУ	CP-300 New	078	2026-05-10 01:35:09.035397	6.6093
17231	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:35:22.123737	16.0591
17234	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:35:22.123737	17.8904
17237	Q10	ЗУ	SM 2	064	2026-05-10 01:35:24.400209	18.5907
17240	Q13	ЗУ	SM 5	067	2026-05-10 01:35:24.400209	1.4363
17243	Q16	ЗУ	SM 8	070	2026-05-10 01:35:24.400209	2.6116
17247	QF 1,22	ЗУ	China 3	046	2026-05-10 01:35:43.486249	13.5242
17250	QF 2,22	ЗУ	China 6	049	2026-05-10 01:35:43.486249	20.3071
17229	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:35:22.123737	19.8958
17232	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:35:22.123737	7.1764
17235	Q4	ЗУ	BG 1	062	2026-05-10 01:35:23.853386	20.6646
17238	Q11	ЗУ	SM 3	065	2026-05-10 01:35:24.400209	21.8276
17241	Q14	ЗУ	SM 6	068	2026-05-10 01:35:24.400209	0.4371
17244	TP3	ЗУ	CP-300 New	078	2026-05-10 01:35:39.085142	6.7228
17245	QF 1,20	ЗУ	China 1	044	2026-05-10 01:35:43.486249	11.4642
17248	QF 2,20	ЗУ	China 4	047	2026-05-10 01:35:43.486249	18.0901
17251	QF 2,23	ЗУ	China 7	050	2026-05-10 01:35:43.486249	9.804
17253	Q4	ЗУ	BG 1	062	2026-05-10 01:36:08.897216	19.8969
17254	Q9	ЗУ	BG 2	063	2026-05-10 01:36:08.897216	32.4234
17255	TP3	ЗУ	CP-300 New	078	2026-05-10 01:36:09.130094	5.8892
17256	Q10	ЗУ	SM 2	064	2026-05-10 01:36:09.436698	18.9222
17257	Q11	ЗУ	SM 3	065	2026-05-10 01:36:09.436698	20.9672
17258	Q12	ЗУ	SM 4	066	2026-05-10 01:36:09.436698	0.7399
17259	Q13	ЗУ	SM 5	067	2026-05-10 01:36:09.436698	1.4012
17260	Q14	ЗУ	SM 6	068	2026-05-10 01:36:09.436698	0.5614
17261	Q15	ЗУ	SM 7	069	2026-05-10 01:36:09.436698	1.2891
17262	Q16	ЗУ	SM 8	070	2026-05-10 01:36:09.436698	2.6183
17263	QF 1,20	ЗУ	China 1	044	2026-05-10 01:36:23.566076	11.8351
17264	QF 1,21	ЗУ	China 2	045	2026-05-10 01:36:23.566076	10.8932
17265	QF 1,22	ЗУ	China 3	046	2026-05-10 01:36:23.566076	14.2719
17266	QF 2,20	ЗУ	China 4	047	2026-05-10 01:36:23.566076	18.2439
17267	QF 2,21	ЗУ	China 5	048	2026-05-10 01:36:23.566076	20.5417
17268	QF 2,22	ЗУ	China 6	049	2026-05-10 01:36:23.566076	19.5002
17269	QF 2,23	ЗУ	China 7	050	2026-05-10 01:36:23.566076	10.2386
17270	QF 2,19	ЗУ	China 8	051	2026-05-10 01:36:23.566076	15.2904
17271	Q8	ЗУ	DIG	061	2026-05-10 01:36:28.831411	46.2417
17272	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:36:32.175951	21.035
17273	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:36:32.175951	8.0794
17274	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:36:32.175951	15.8909
17275	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:36:32.175951	7.446
17276	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:36:32.175951	20.084
17277	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:36:32.175951	18.9204
17278	TP3	ЗУ	CP-300 New	078	2026-05-10 01:36:39.149747	6.6671
17279	Q17	ЗУ	MO 9	071	2026-05-10 01:36:40.326171	1.1779
17280	Q20	ЗУ	MO 10	072	2026-05-10 01:36:40.326171	13.4922
17281	Q21	ЗУ	MO 11	073	2026-05-10 01:36:40.326171	0.3013
17282	Q22	ЗУ	MO 12	074	2026-05-10 01:36:40.326171	1.2116
17283	Q23	ЗУ	MO 13	075	2026-05-10 01:36:40.326171	0.5477
17284	Q24	ЗУ	MO 14	076	2026-05-10 01:36:40.326171	0.972
17285	Q25	ЗУ	MO 15	077	2026-05-10 01:36:40.326171	0.5877
17286	Q4	ЗУ	BG 1	062	2026-05-10 01:36:53.953069	20.4244
17287	Q9	ЗУ	BG 2	063	2026-05-10 01:36:53.953069	32.0955
17288	Q10	ЗУ	SM 2	064	2026-05-10 01:36:54.476748	18.759
17289	Q11	ЗУ	SM 3	065	2026-05-10 01:36:54.476748	21.6707
17290	Q12	ЗУ	SM 4	066	2026-05-10 01:36:54.476748	0.4087
17291	Q13	ЗУ	SM 5	067	2026-05-10 01:36:54.476748	1.0638
17292	Q14	ЗУ	SM 6	068	2026-05-10 01:36:54.476748	1.0884
17293	Q15	ЗУ	SM 7	069	2026-05-10 01:36:54.476748	0.9576
17294	Q16	ЗУ	SM 8	070	2026-05-10 01:36:54.476748	2.6171
17295	QF 1,20	ЗУ	China 1	044	2026-05-10 01:37:03.613761	11.724
17296	QF 1,21	ЗУ	China 2	045	2026-05-10 01:37:03.613761	10.3969
17297	QF 1,22	ЗУ	China 3	046	2026-05-10 01:37:03.613761	13.06
17298	QF 2,20	ЗУ	China 4	047	2026-05-10 01:37:03.613761	19.242
17299	QF 2,21	ЗУ	China 5	048	2026-05-10 01:37:03.613761	20.3553
17300	QF 2,22	ЗУ	China 6	049	2026-05-10 01:37:03.613761	19.7351
17301	QF 2,23	ЗУ	China 7	050	2026-05-10 01:37:03.613761	9.6812
17302	QF 2,19	ЗУ	China 8	051	2026-05-10 01:37:03.613761	14.0135
17303	Q8	ЗУ	DIG	061	2026-05-10 01:37:03.845767	45.2967
17304	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:37:07.226478	20.3719
17305	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:37:07.226478	9.0372
17306	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:37:07.226478	17.4343
17307	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:37:07.226478	8.5079
17308	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:37:07.226478	19.2933
17309	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:37:07.226478	18.2923
17310	TP3	ЗУ	CP-300 New	078	2026-05-10 01:37:09.171548	6.936
17311	Q17	ЗУ	MO 9	071	2026-05-10 01:37:30.372141	0.664
17312	Q20	ЗУ	MO 10	072	2026-05-10 01:37:30.372141	13.6872
17313	Q21	ЗУ	MO 11	073	2026-05-10 01:37:30.372141	0.3221
17314	Q22	ЗУ	MO 12	074	2026-05-10 01:37:30.372141	0.4781
17315	Q23	ЗУ	MO 13	075	2026-05-10 01:37:30.372141	0.56
17316	Q24	ЗУ	MO 14	076	2026-05-10 01:37:30.372141	1.144
17317	Q25	ЗУ	MO 15	077	2026-05-10 01:37:30.372141	0.5232
17344	Q8	ЗУ	DIG	061	2026-05-10 01:38:13.879131	45.2231
17346	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:38:17.364036	8.243
17349	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:38:17.364036	19.8478
17351	Q17	ЗУ	MO 9	071	2026-05-10 01:38:20.401429	0.6485
17354	Q22	ЗУ	MO 12	074	2026-05-10 01:38:20.401429	1.0832
17357	Q25	ЗУ	MO 15	077	2026-05-10 01:38:20.401429	1.1389
17359	QF 1,21	ЗУ	China 2	045	2026-05-10 01:38:23.706229	10.2027
17362	QF 2,21	ЗУ	China 5	048	2026-05-10 01:38:23.706229	20.0723
17365	QF 2,19	ЗУ	China 8	051	2026-05-10 01:38:23.706229	14.6527
17368	Q10	ЗУ	SM 2	064	2026-05-10 01:38:24.556299	18.1964
17371	Q13	ЗУ	SM 5	067	2026-05-10 01:38:24.556299	1.0554
17374	Q16	ЗУ	SM 8	070	2026-05-10 01:38:24.556299	2.7362
17319	Q4	ЗУ	BG 1	062	2026-05-10 01:37:38.967018	20.7646
17320	Q9	ЗУ	BG 2	063	2026-05-10 01:37:38.967018	32.765
17321	TP3	ЗУ	CP-300 New	078	2026-05-10 01:37:39.188346	5.8179
17322	Q10	ЗУ	SM 2	064	2026-05-10 01:37:39.512601	17.8986
17323	Q11	ЗУ	SM 3	065	2026-05-10 01:37:39.512601	21.163
17324	Q12	ЗУ	SM 4	066	2026-05-10 01:37:39.512601	0.9307
17325	Q13	ЗУ	SM 5	067	2026-05-10 01:37:39.512601	0.3853
17326	Q14	ЗУ	SM 6	068	2026-05-10 01:37:39.512601	0.3855
17327	Q15	ЗУ	SM 7	069	2026-05-10 01:37:39.512601	0.6973
17328	Q16	ЗУ	SM 8	070	2026-05-10 01:37:39.512601	2.815
17329	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:37:42.321529	20.6639
17330	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:37:42.321529	9.5399
17331	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:37:42.321529	17.402
17332	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:37:42.321529	7.0854
17333	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:37:42.321529	20.5765
17334	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:37:42.321529	19.0807
17335	QF 1,20	ЗУ	China 1	044	2026-05-10 01:37:43.661313	10.8151
17336	QF 1,21	ЗУ	China 2	045	2026-05-10 01:37:43.661313	10.7721
17337	QF 1,22	ЗУ	China 3	046	2026-05-10 01:37:43.661313	13.2218
17338	QF 2,20	ЗУ	China 4	047	2026-05-10 01:37:43.661313	18.7628
17339	QF 2,21	ЗУ	China 5	048	2026-05-10 01:37:43.661313	20.2048
17340	QF 2,22	ЗУ	China 6	049	2026-05-10 01:37:43.661313	18.7304
17341	QF 2,23	ЗУ	China 7	050	2026-05-10 01:37:43.661313	9.6186
17342	QF 2,19	ЗУ	China 8	051	2026-05-10 01:37:43.661313	14.9285
17343	TP3	ЗУ	CP-300 New	078	2026-05-10 01:38:09.19854	5.2366
17345	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:38:17.364036	20.1404
17347	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:38:17.364036	16.2187
17348	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:38:17.364036	7.7041
17350	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:38:17.364036	18.1434
17352	Q20	ЗУ	MO 10	072	2026-05-10 01:38:20.401429	13.1348
17353	Q21	ЗУ	MO 11	073	2026-05-10 01:38:20.401429	0.8285
17355	Q23	ЗУ	MO 13	075	2026-05-10 01:38:20.401429	1.0504
17356	Q24	ЗУ	MO 14	076	2026-05-10 01:38:20.401429	1.1079
17358	QF 1,20	ЗУ	China 1	044	2026-05-10 01:38:23.706229	10.8474
17360	QF 1,22	ЗУ	China 3	046	2026-05-10 01:38:23.706229	13.7518
17361	QF 2,20	ЗУ	China 4	047	2026-05-10 01:38:23.706229	18.9789
17363	QF 2,22	ЗУ	China 6	049	2026-05-10 01:38:23.706229	18.8802
17364	QF 2,23	ЗУ	China 7	050	2026-05-10 01:38:23.706229	9.3952
17366	Q4	ЗУ	BG 1	062	2026-05-10 01:38:23.988723	20.4719
17367	Q9	ЗУ	BG 2	063	2026-05-10 01:38:23.988723	33.0771
17369	Q11	ЗУ	SM 3	065	2026-05-10 01:38:24.556299	21.7419
17370	Q12	ЗУ	SM 4	066	2026-05-10 01:38:24.556299	0.9483
17372	Q14	ЗУ	SM 6	068	2026-05-10 01:38:24.556299	0.6224
17373	Q15	ЗУ	SM 7	069	2026-05-10 01:38:24.556299	0.428
17376	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:38:52.400201	21.0048
17377	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:38:52.400201	8.142
17378	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:38:52.400201	16.7704
17379	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:38:52.400201	7.3446
17380	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:38:52.400201	18.8782
17381	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:38:52.400201	19.5633
17382	QF 1,20	ЗУ	China 1	044	2026-05-10 01:39:03.783989	12.0315
17383	QF 1,21	ЗУ	China 2	045	2026-05-10 01:39:03.783989	10.4866
17384	QF 1,22	ЗУ	China 3	046	2026-05-10 01:39:03.783989	13.7403
17385	QF 2,20	ЗУ	China 4	047	2026-05-10 01:39:03.783989	18.1668
17386	QF 2,21	ЗУ	China 5	048	2026-05-10 01:39:03.783989	20.7611
17387	QF 2,22	ЗУ	China 6	049	2026-05-10 01:39:03.783989	20.0985
17388	QF 2,23	ЗУ	China 7	050	2026-05-10 01:39:03.783989	10.1641
17389	QF 2,19	ЗУ	China 8	051	2026-05-10 01:39:03.783989	14.5842
17390	Q4	ЗУ	BG 1	062	2026-05-10 01:39:09.008206	20.0345
17391	Q9	ЗУ	BG 2	063	2026-05-10 01:39:09.008206	31.9191
17392	TP3	ЗУ	CP-300 New	078	2026-05-10 01:39:09.24113	5.6741
17393	Q10	ЗУ	SM 2	064	2026-05-10 01:39:09.607637	18.683
17394	Q11	ЗУ	SM 3	065	2026-05-10 01:39:09.607637	21.5056
17395	Q12	ЗУ	SM 4	066	2026-05-10 01:39:09.607637	0.5249
17396	Q13	ЗУ	SM 5	067	2026-05-10 01:39:09.607637	0.3742
17397	Q14	ЗУ	SM 6	068	2026-05-10 01:39:09.607637	0.4685
17398	Q15	ЗУ	SM 7	069	2026-05-10 01:39:09.607637	0.8949
17399	Q16	ЗУ	SM 8	070	2026-05-10 01:39:09.607637	2.462
17400	Q17	ЗУ	MO 9	071	2026-05-10 01:39:10.433286	0.5272
17401	Q20	ЗУ	MO 10	072	2026-05-10 01:39:10.433286	12.9868
17402	Q21	ЗУ	MO 11	073	2026-05-10 01:39:10.433286	1.1782
17403	Q22	ЗУ	MO 12	074	2026-05-10 01:39:10.433286	0.7876
17404	Q23	ЗУ	MO 13	075	2026-05-10 01:39:10.433286	1.0353
17405	Q24	ЗУ	MO 14	076	2026-05-10 01:39:10.433286	1.1426
17406	Q25	ЗУ	MO 15	077	2026-05-10 01:39:10.433286	1.1358
17407	Q8	ЗУ	DIG	061	2026-05-10 01:39:23.940118	46.9769
17408	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:39:27.44045	21.2719
17409	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:39:27.44045	9.48
17410	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:39:27.44045	16.9786
17411	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:39:27.44045	8.0542
17412	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:39:27.44045	18.9652
17413	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:39:27.44045	18.2215
17414	TP3	ЗУ	CP-300 New	078	2026-05-10 01:39:39.257138	5.811
17415	QF 1,20	ЗУ	China 1	044	2026-05-10 01:39:43.827321	11.7405
17416	QF 1,21	ЗУ	China 2	045	2026-05-10 01:39:43.827321	11.2332
17417	QF 1,22	ЗУ	China 3	046	2026-05-10 01:39:43.827321	13.1298
17418	QF 2,20	ЗУ	China 4	047	2026-05-10 01:39:43.827321	18.0244
17419	QF 2,21	ЗУ	China 5	048	2026-05-10 01:39:43.827321	20.4033
17420	QF 2,22	ЗУ	China 6	049	2026-05-10 01:39:43.827321	19.7446
17421	QF 2,23	ЗУ	China 7	050	2026-05-10 01:39:43.827321	10.0942
17422	QF 2,19	ЗУ	China 8	051	2026-05-10 01:39:43.827321	13.9775
17423	Q4	ЗУ	BG 1	062	2026-05-10 01:39:54.037677	21.2571
17424	Q9	ЗУ	BG 2	063	2026-05-10 01:39:54.037677	32.978
17425	Q10	ЗУ	SM 2	064	2026-05-10 01:39:54.64998	17.913
17426	Q11	ЗУ	SM 3	065	2026-05-10 01:39:54.64998	21.9089
17427	Q12	ЗУ	SM 4	066	2026-05-10 01:39:54.64998	0.7439
17428	Q13	ЗУ	SM 5	067	2026-05-10 01:39:54.64998	0.6737
17429	Q14	ЗУ	SM 6	068	2026-05-10 01:39:54.64998	0.6477
17430	Q15	ЗУ	SM 7	069	2026-05-10 01:39:54.64998	1.1698
17431	Q16	ЗУ	SM 8	070	2026-05-10 01:39:54.64998	2.4718
17432	Q8	ЗУ	DIG	061	2026-05-10 01:39:58.979113	46.2922
17433	Q17	ЗУ	MO 9	071	2026-05-10 01:40:00.687482	0.5645
17434	Q20	ЗУ	MO 10	072	2026-05-10 01:40:00.687482	12.7971
17435	Q21	ЗУ	MO 11	073	2026-05-10 01:40:00.687482	0.8755
17436	Q22	ЗУ	MO 12	074	2026-05-10 01:40:00.687482	1.2646
17437	Q23	ЗУ	MO 13	075	2026-05-10 01:40:00.687482	0.3614
17438	Q24	ЗУ	MO 14	076	2026-05-10 01:40:00.687482	0.3409
17439	Q25	ЗУ	MO 15	077	2026-05-10 01:40:00.687482	0.6779
17440	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:40:02.485915	21.3872
17441	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:40:02.485915	9.3137
17442	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:40:02.485915	16.7371
17443	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:40:02.485915	8.1044
17444	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:40:02.485915	19.0202
17445	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:40:02.485915	18.5425
17446	TP3	ЗУ	CP-300 New	078	2026-05-10 01:40:09.296027	5.7734
17447	QF 1,20	ЗУ	China 1	044	2026-05-10 01:40:23.880195	11.6165
17448	QF 1,21	ЗУ	China 2	045	2026-05-10 01:40:23.880195	9.9148
17449	QF 1,22	ЗУ	China 3	046	2026-05-10 01:40:23.880195	13.769
17450	QF 2,20	ЗУ	China 4	047	2026-05-10 01:40:23.880195	18.2397
17451	QF 2,21	ЗУ	China 5	048	2026-05-10 01:40:23.880195	21.0278
17452	QF 2,22	ЗУ	China 6	049	2026-05-10 01:40:23.880195	19.8844
17453	QF 2,23	ЗУ	China 7	050	2026-05-10 01:40:23.880195	9.1863
17454	QF 2,19	ЗУ	China 8	051	2026-05-10 01:40:23.880195	14.1647
17455	Q8	ЗУ	DIG	061	2026-05-10 01:40:34.176275	45.4749
17456	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:40:37.53767	20.723
17457	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:40:37.53767	7.7694
17458	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:40:37.53767	16.1876
17459	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:40:37.53767	7.601
17460	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:40:37.53767	20.0905
17461	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:40:37.53767	18.5064
17462	Q4	ЗУ	BG 1	062	2026-05-10 01:40:39.067979	21.2516
17463	Q9	ЗУ	BG 2	063	2026-05-10 01:40:39.067979	33.0399
17464	TP3	ЗУ	CP-300 New	078	2026-05-10 01:40:39.310401	6.4615
17465	Q10	ЗУ	SM 2	064	2026-05-10 01:40:39.697524	18.7172
17466	Q11	ЗУ	SM 3	065	2026-05-10 01:40:39.697524	21.8841
17467	Q12	ЗУ	SM 4	066	2026-05-10 01:40:39.697524	0.8775
17468	Q13	ЗУ	SM 5	067	2026-05-10 01:40:39.697524	0.3458
17469	Q14	ЗУ	SM 6	068	2026-05-10 01:40:39.697524	1.2063
17470	Q15	ЗУ	SM 7	069	2026-05-10 01:40:39.697524	0.9896
17471	Q16	ЗУ	SM 8	070	2026-05-10 01:40:39.697524	2.0464
17472	Q17	ЗУ	MO 9	071	2026-05-10 01:40:50.740419	0.9777
17473	Q20	ЗУ	MO 10	072	2026-05-10 01:40:50.740419	12.9907
17474	Q21	ЗУ	MO 11	073	2026-05-10 01:40:50.740419	0.8008
17475	Q22	ЗУ	MO 12	074	2026-05-10 01:40:50.740419	0.4921
17476	Q23	ЗУ	MO 13	075	2026-05-10 01:40:50.740419	0.8297
17477	Q24	ЗУ	MO 14	076	2026-05-10 01:40:50.740419	0.6641
17478	Q25	ЗУ	MO 15	077	2026-05-10 01:40:50.740419	0.5527
17480	QF 1,21	ЗУ	China 2	045	2026-05-10 01:41:03.938146	10.6071
17482	QF 2,20	ЗУ	China 4	047	2026-05-10 01:41:03.938146	18.1566
17484	QF 2,22	ЗУ	China 6	049	2026-05-10 01:41:03.938146	19.3451
17486	QF 2,19	ЗУ	China 8	051	2026-05-10 01:41:03.938146	14.0895
17487	Q8	ЗУ	DIG	061	2026-05-10 01:41:09.205613	45.9561
17490	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:41:12.572697	8.8276
17492	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:41:12.572697	7.9951
17494	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:41:12.572697	19.1254
17495	Q4	ЗУ	BG 1	062	2026-05-10 01:41:24.094468	19.8506
17497	Q10	ЗУ	SM 2	064	2026-05-10 01:41:24.729333	18.9037
17499	Q12	ЗУ	SM 4	066	2026-05-10 01:41:24.729333	0.7716
17501	Q14	ЗУ	SM 6	068	2026-05-10 01:41:24.729333	1.1909
17503	Q16	ЗУ	SM 8	070	2026-05-10 01:41:24.729333	2.9978
17504	TP3	ЗУ	CP-300 New	078	2026-05-10 01:41:39.343768	5.2082
17506	Q20	ЗУ	MO 10	072	2026-05-10 01:41:40.779655	13.614
17508	Q22	ЗУ	MO 12	074	2026-05-10 01:41:40.779655	0.3966
17510	Q24	ЗУ	MO 14	076	2026-05-10 01:41:40.779655	1.1524
17512	QF 1,20	ЗУ	China 1	044	2026-05-10 01:41:44.003637	11.4687
17514	QF 1,22	ЗУ	China 3	046	2026-05-10 01:41:44.003637	14.0217
17516	QF 2,21	ЗУ	China 5	048	2026-05-10 01:41:44.003637	21.0634
17518	QF 2,23	ЗУ	China 7	050	2026-05-10 01:41:44.003637	10.2209
17520	Q8	ЗУ	DIG	061	2026-05-10 01:41:44.233066	45.4605
17521	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:41:47.616332	20.6434
17523	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:41:47.616332	16.46
17525	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:41:47.616332	19.8576
17528	Q9	ЗУ	BG 2	063	2026-05-10 01:42:09.128311	32.2476
17530	Q10	ЗУ	SM 2	064	2026-05-10 01:42:09.762337	18.9202
17532	Q12	ЗУ	SM 4	066	2026-05-10 01:42:09.762337	0.9973
17534	Q14	ЗУ	SM 6	068	2026-05-10 01:42:09.762337	0.5104
17536	Q16	ЗУ	SM 8	070	2026-05-10 01:42:09.762337	2.6985
17479	QF 1,20	ЗУ	China 1	044	2026-05-10 01:41:03.938146	11.1146
17481	QF 1,22	ЗУ	China 3	046	2026-05-10 01:41:03.938146	12.9619
17483	QF 2,21	ЗУ	China 5	048	2026-05-10 01:41:03.938146	21.1783
17485	QF 2,23	ЗУ	China 7	050	2026-05-10 01:41:03.938146	9.0296
17488	TP3	ЗУ	CP-300 New	078	2026-05-10 01:41:09.328581	5.9367
17489	QF 1,26	ЗУ	PzS 12V 1	038	2026-05-10 01:41:12.572697	20.3231
17491	QF 1,28	ЗУ	PzS 12V 3	040	2026-05-10 01:41:12.572697	16.5318
17493	QF 2,27	ЗУ	PzS 12V 5	042	2026-05-10 01:41:12.572697	19.479
17496	Q9	ЗУ	BG 2	063	2026-05-10 01:41:24.094468	32.527
17498	Q11	ЗУ	SM 3	065	2026-05-10 01:41:24.729333	21.2491
17500	Q13	ЗУ	SM 5	067	2026-05-10 01:41:24.729333	0.7617
17502	Q15	ЗУ	SM 7	069	2026-05-10 01:41:24.729333	0.7547
17505	Q17	ЗУ	MO 9	071	2026-05-10 01:41:40.779655	0.8959
17507	Q21	ЗУ	MO 11	073	2026-05-10 01:41:40.779655	0.4393
17509	Q23	ЗУ	MO 13	075	2026-05-10 01:41:40.779655	0.413
17511	Q25	ЗУ	MO 15	077	2026-05-10 01:41:40.779655	0.7678
17513	QF 1,21	ЗУ	China 2	045	2026-05-10 01:41:44.003637	9.9313
17515	QF 2,20	ЗУ	China 4	047	2026-05-10 01:41:44.003637	18.1437
17517	QF 2,22	ЗУ	China 6	049	2026-05-10 01:41:44.003637	20.223
17519	QF 2,19	ЗУ	China 8	051	2026-05-10 01:41:44.003637	15.267
17522	QF 1,27	ЗУ	PzS 12V 2	039	2026-05-10 01:41:47.616332	9.4822
17524	QF 2,28	ЗУ	PzS 12V 4	041	2026-05-10 01:41:47.616332	7.0873
17526	QF 2,26	ЗУ	PzS 12V 6	043	2026-05-10 01:41:47.616332	19.2923
17527	Q4	ЗУ	BG 1	062	2026-05-10 01:42:09.128311	19.8854
17529	TP3	ЗУ	CP-300 New	078	2026-05-10 01:42:09.372189	5.2089
17531	Q11	ЗУ	SM 3	065	2026-05-10 01:42:09.762337	22.0014
17533	Q13	ЗУ	SM 5	067	2026-05-10 01:42:09.762337	1.0545
17535	Q15	ЗУ	SM 7	069	2026-05-10 01:42:09.762337	1.291
17537	Q8	ЗУ	DIG	061	2026-05-10 01:42:19.247659	44.7833
\.


--
-- Data for Name: incident_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.incident_logs (id, occurred_at, incident_type, severity, group_id, title, description, created_by_user_id, created_at) FROM stdin;
\.


--
-- Data for Name: report_dispatch_queue; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.report_dispatch_queue (id, recipient_email, report_date, group_id, export_format, template_mode, status, attempts, max_attempts, next_attempt_at, last_error, requested_by_user_id, schedule_id, sent_at, created_at) FROM stdin;
1	demo@example.com	2025-04-01	all	pdf	brief	sent	0	3	2026-05-09 21:12:34.238656	\N	1	\N	2026-05-09 21:12:52.115659	2026-05-09 21:12:34.239524
2	retry@example.com	2025-04-01	all	pdf	brief	sent	0	3	2026-05-09 21:15:28.515892	\N	1	\N	2026-05-09 21:15:34.305732	2026-05-09 21:15:22.652685
\.


--
-- Data for Name: report_schedules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.report_schedules (id, recipient_email, group_id, export_format, template_mode, send_time, is_enabled, created_by_user_id, last_run_on, created_at) FROM stdin;
1	demo@example.com	all	both	detailed	08:00	t	1	\N	2026-05-09 21:12:34.258701
3	panel@example.com	all	both	detailed	08:00	f	1	\N	2026-05-09 21:22:50.175006
2	demo@example.com	all	both	detailed	08:00	f	1	\N	2026-05-09 21:15:17.560178
\.


--
-- Name: admin_invite_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_invite_codes_id_seq', 1, false);


--
-- Name: app_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.app_users_id_seq', 2, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 24, true);


--
-- Name: email_report_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.email_report_logs_id_seq', 5, true);


--
-- Name: energy_consumption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.energy_consumption_id_seq', 17537, true);


--
-- Name: incident_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.incident_logs_id_seq', 1, false);


--
-- Name: report_dispatch_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.report_dispatch_queue_id_seq', 2, true);


--
-- Name: report_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.report_schedules_id_seq', 3, true);


--
-- Name: admin_invite_codes admin_invite_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_invite_codes
    ADD CONSTRAINT admin_invite_codes_pkey PRIMARY KEY (id);


--
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (key);


--
-- Name: app_users app_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: email_report_logs email_report_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_report_logs
    ADD CONSTRAINT email_report_logs_pkey PRIMARY KEY (id);


--
-- Name: energy_consumption energy_consumption_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.energy_consumption
    ADD CONSTRAINT energy_consumption_pkey PRIMARY KEY (id);


--
-- Name: incident_logs incident_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incident_logs
    ADD CONSTRAINT incident_logs_pkey PRIMARY KEY (id);


--
-- Name: report_dispatch_queue report_dispatch_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_dispatch_queue
    ADD CONSTRAINT report_dispatch_queue_pkey PRIMARY KEY (id);


--
-- Name: report_schedules report_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_schedules
    ADD CONSTRAINT report_schedules_pkey PRIMARY KEY (id);


--
-- Name: ix_admin_invite_codes_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_admin_invite_codes_code ON public.admin_invite_codes USING btree (code);


--
-- Name: ix_app_users_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_app_users_username ON public.app_users USING btree (username);


--
-- Name: admin_invite_codes admin_invite_codes_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_invite_codes
    ADD CONSTRAINT admin_invite_codes_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.app_users(id);


--
-- Name: admin_invite_codes admin_invite_codes_used_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_invite_codes
    ADD CONSTRAINT admin_invite_codes_used_by_user_id_fkey FOREIGN KEY (used_by_user_id) REFERENCES public.app_users(id);


--
-- Name: audit_logs audit_logs_actor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_actor_user_id_fkey FOREIGN KEY (actor_user_id) REFERENCES public.app_users(id);


--
-- Name: email_report_logs email_report_logs_queue_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_report_logs
    ADD CONSTRAINT email_report_logs_queue_item_id_fkey FOREIGN KEY (queue_item_id) REFERENCES public.report_dispatch_queue(id);


--
-- Name: email_report_logs email_report_logs_requested_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_report_logs
    ADD CONSTRAINT email_report_logs_requested_by_user_id_fkey FOREIGN KEY (requested_by_user_id) REFERENCES public.app_users(id);


--
-- Name: incident_logs incident_logs_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incident_logs
    ADD CONSTRAINT incident_logs_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.app_users(id);


--
-- Name: report_dispatch_queue report_dispatch_queue_requested_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_dispatch_queue
    ADD CONSTRAINT report_dispatch_queue_requested_by_user_id_fkey FOREIGN KEY (requested_by_user_id) REFERENCES public.app_users(id);


--
-- Name: report_dispatch_queue report_dispatch_queue_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_dispatch_queue
    ADD CONSTRAINT report_dispatch_queue_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.report_schedules(id);


--
-- Name: report_schedules report_schedules_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_schedules
    ADD CONSTRAINT report_schedules_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.app_users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 5ZlTa6haS8YHsvwGfuEpnKz5UVC1Zue16wWa1u6DMBgkjA45Uljj2HZejyTVmWu

