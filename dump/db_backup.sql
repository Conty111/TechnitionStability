--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7 (Debian 15.7-1.pgdg120+1)
-- Dumped by pg_dump version 15.7 (Debian 15.7-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
-- CREATE ROLE hello_fastapi WITH LOGIN PASSWORD 'hello_fastapi';
CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres';


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: location; Type: TYPE; Schema: public; Owner: hello_fastapi
--

CREATE TYPE public.location AS ENUM (
    'spb',
    'moscow'
);


ALTER TYPE public.location OWNER TO hello_fastapi;

--
-- Name: producttype; Type: TYPE; Schema: public; Owner: hello_fastapi
--

CREATE TYPE public.producttype AS ENUM (
    'hardware',
    'software'
);


ALTER TYPE public.producttype OWNER TO hello_fastapi;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO hello_fastapi;

--
-- Name: catalog; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.catalog (
    name character varying(50) NOT NULL,
    vendor_id uuid NOT NULL,
    support boolean NOT NULL,
    product public.producttype NOT NULL,
    version character varying NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    purchase_available boolean NOT NULL
);


ALTER TABLE public.catalog OWNER TO hello_fastapi;

--
-- Name: hardware; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.hardware (
    name character varying(50) NOT NULL,
    monitoring boolean NOT NULL,
    product_id uuid NOT NULL,
    hardware_type_id uuid NOT NULL,
    location public.location NOT NULL,
    clusters character varying(50)[],
    model character varying(150),
    ports_count integer,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    cpu_utilization double precision,
    ram_utilization double precision,
    disk_mem_utilization double precision
);


ALTER TABLE public.hardware OWNER TO hello_fastapi;

--
-- Name: hardware_tech_stability; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.hardware_tech_stability (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    info_system_id uuid NOT NULL,
    vendor_support double precision NOT NULL,
    equipment_wear double precision,
    monitoring_coverage double precision NOT NULL,
    compliance_standarts double precision,
    purchase_available double precision,
    cpu_util double precision NOT NULL,
    ram_util double precision NOT NULL,
    mem_util double precision NOT NULL
);


ALTER TABLE public.hardware_tech_stability OWNER TO hello_fastapi;

--
-- Name: hardware_tech_stability_id_seq; Type: SEQUENCE; Schema: public; Owner: hello_fastapi
--

CREATE SEQUENCE public.hardware_tech_stability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hardware_tech_stability_id_seq OWNER TO hello_fastapi;

--
-- Name: hardware_tech_stability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hello_fastapi
--

ALTER SEQUENCE public.hardware_tech_stability_id_seq OWNED BY public.hardware_tech_stability.id;


--
-- Name: hardware_types; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.hardware_types (
    name character varying(50) NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.hardware_types OWNER TO hello_fastapi;

--
-- Name: host_software; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.host_software (
    host_id uuid NOT NULL,
    software_id uuid NOT NULL
);


ALTER TABLE public.host_software OWNER TO hello_fastapi;

--
-- Name: info_system; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.info_system (
    name character varying(50) NOT NULL,
    criticality_ratio double precision,
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.info_system OWNER TO hello_fastapi;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.notes (
    title character varying(50) NOT NULL,
    description character varying(50) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.notes OWNER TO hello_fastapi;

--
-- Name: software; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.software (
    name character varying(50) NOT NULL,
    product_id uuid,
    software_type_id uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.software OWNER TO hello_fastapi;

--
-- Name: software_hardware; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.software_hardware (
    hardware_id uuid NOT NULL,
    software_id uuid NOT NULL
);


ALTER TABLE public.software_hardware OWNER TO hello_fastapi;

--
-- Name: software_tech_stability; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.software_tech_stability (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    info_system_id uuid NOT NULL,
    vendor_support double precision NOT NULL,
    monitoring_coverage double precision NOT NULL,
    compliance_standarts double precision NOT NULL,
    cpu_util double precision NOT NULL,
    ram_util double precision NOT NULL,
    mem_util double precision NOT NULL,
    srk double precision NOT NULL,
    purchase_available double precision NOT NULL
);


ALTER TABLE public.software_tech_stability OWNER TO hello_fastapi;

--
-- Name: software_tech_stability_id_seq; Type: SEQUENCE; Schema: public; Owner: hello_fastapi
--

CREATE SEQUENCE public.software_tech_stability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.software_tech_stability_id_seq OWNER TO hello_fastapi;

--
-- Name: software_tech_stability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hello_fastapi
--

ALTER SEQUENCE public.software_tech_stability_id_seq OWNED BY public.software_tech_stability.id;


--
-- Name: software_types; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.software_types (
    name character varying(50) NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.software_types OWNER TO hello_fastapi;

--
-- Name: vendors; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.vendors (
    name character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.vendors OWNER TO hello_fastapi;

--
-- Name: virtual_machine; Type: TABLE; Schema: public; Owner: hello_fastapi
--

CREATE TABLE public.virtual_machine (
    name character varying(50) NOT NULL,
    monitoring boolean NOT NULL,
    system_id uuid NOT NULL,
    srk boolean NOT NULL,
    location public.location NOT NULL,
    cluster character varying(50) NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    cpu_utilization double precision,
    ram_utilization double precision,
    disk_mem_utilization double precision
);


ALTER TABLE public.virtual_machine OWNER TO hello_fastapi;

--
-- Name: hardware_tech_stability id; Type: DEFAULT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware_tech_stability ALTER COLUMN id SET DEFAULT nextval('public.hardware_tech_stability_id_seq'::regclass);


--
-- Name: software_tech_stability id; Type: DEFAULT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_tech_stability ALTER COLUMN id SET DEFAULT nextval('public.software_tech_stability_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.alembic_version (version_num) FROM stdin;
e05690bac20b
\.


--
-- Data for Name: catalog; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.catalog (name, vendor_id, support, product, version, id, created_at, deleted_at, purchase_available) FROM stdin;
Astra Linux	d400c54e-6281-4679-996c-5320106494cd	t	software	1.7.3	a1e4dcb8-4ba2-43a1-bb97-f04bf9bd4b67	2024-06-05 16:54:06.436901	\N	t
RedOS	b06c38de-2a3f-4845-b547-743dd5fbe09d	t	software	777	f61f0275-6223-4302-9b34-5497be5e2bca	2024-06-05 16:54:06.436901	\N	t
Docker Swarm	3e13713f-fa23-4690-9d24-c5f7351c5456	f	software	1.7.3	0b1594a0-c301-4554-bbee-cfc35832b3ae	2024-06-05 16:54:06.436901	\N	f
MikroTik router	e7739970-5d8a-452a-95f3-79a14ef7608a	t	hardware	1.7.3	5e390103-18e1-4d0b-8c56-82c0f99d4be8	2024-06-05 16:54:06.436901	\N	t
MikroTik switch	e7739970-5d8a-452a-95f3-79a14ef7608a	t	hardware	1.7.3	b0fb92ea-e168-4fb3-a209-7e6ac1156395	2024-06-05 16:54:06.436901	\N	t
PostgreSQL	f4681135-86b1-4674-a522-72355093a3bd	t	software	16	8f163576-52b6-4838-821a-9df69fb05aa6	2024-06-05 17:03:39.385311	\N	t
Some Server	d400c54e-6281-4679-996c-5320106494cd	t	hardware	a	aa11566e-5671-4e50-b2d2-182f61cc1ca5	2024-06-05 17:24:38.979453	\N	f
\.


--
-- Data for Name: hardware; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.hardware (name, monitoring, product_id, hardware_type_id, location, clusters, model, ports_count, id, created_at, deleted_at, cpu_utilization, ram_utilization, disk_mem_utilization) FROM stdin;
Server 1	t	aa11566e-5671-4e50-b2d2-182f61cc1ca5	40922dcd-144d-4719-813f-ee0367aba5e9	spb	{IaaS3}	ome model	\N	b3061ef6-467e-4aa8-94fa-6786d75d1622	2024-06-05 17:57:50.411512	\N	60	75	60
Router 1	t	5e390103-18e1-4d0b-8c56-82c0f99d4be8	744b0215-1c02-460a-885d-7f175f890874	spb	{IaaS3}	ome model	16	117cfa99-5a38-4688-8507-2d8b0d1a70ff	2024-06-05 17:57:50.411512	\N	60	\N	\N
Router 2	f	5e390103-18e1-4d0b-8c56-82c0f99d4be8	744b0215-1c02-460a-885d-7f175f890874	spb	{IaaS3,IaaS4}	ome model	16	de320c3b-523a-40b1-9ec0-47534290f342	2024-06-05 17:57:50.411512	\N	80	\N	\N
Switch 1	t	b0fb92ea-e168-4fb3-a209-7e6ac1156395	5a61a88a-03a1-4afb-b5df-0d00f7380889	spb	{IaaS3}	ome model	16	e2fa847b-2376-4993-b96a-b13f2ea25ad5	2024-06-05 17:57:50.411512	\N	76	\N	\N
Switch 2	t	b0fb92ea-e168-4fb3-a209-7e6ac1156395	5a61a88a-03a1-4afb-b5df-0d00f7380889	spb	{IaaS3,IaaS4}	ome model	16	a84d2ab2-d430-47a0-8eb5-34676dbcdeb9	2024-06-05 17:57:50.411512	\N	65	\N	\N
\.


--
-- Data for Name: hardware_tech_stability; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.hardware_tech_stability (id, created_at, info_system_id, vendor_support, equipment_wear, monitoring_coverage, compliance_standarts, purchase_available, cpu_util, ram_util, mem_util) FROM stdin;
5	2024-06-05 19:14:47.243865	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
6	2024-06-05 21:55:19.453665	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
7	2024-06-05 21:56:05.815292	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
8	2024-06-06 14:52:12.987458	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
9	2024-06-06 14:52:45.644908	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
10	2024-06-06 14:54:36.368232	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
11	2024-06-06 15:28:51.808325	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
12	2024-06-06 15:32:44.16462	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
13	2024-06-06 15:33:30.319181	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
14	2024-06-06 16:07:39.168097	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
15	2024-06-06 16:07:41.947122	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
16	2024-06-06 16:09:04.304623	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
17	2024-06-06 16:09:17.185289	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
18	2024-06-06 16:09:31.391956	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
19	2024-06-06 16:10:51.061225	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
20	2024-06-06 16:11:30.386163	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
21	2024-06-06 16:28:33.325863	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
22	2024-06-06 14:08:36.300683	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
23	2024-06-06 14:09:41.829895	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.6	\N	0.8	0.6	0.4	0.6	0.8	1
\.


--
-- Data for Name: hardware_types; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.hardware_types (name, id, created_at, deleted_at) FROM stdin;
Router	744b0215-1c02-460a-885d-7f175f890874	2024-06-05 17:23:05.175457	\N
Switch	5a61a88a-03a1-4afb-b5df-0d00f7380889	2024-06-05 17:23:05.175457	\N
Server	40922dcd-144d-4719-813f-ee0367aba5e9	2024-06-05 17:23:05.175457	\N
СХД	6fb71c9d-1979-43e4-b17f-0e18ccc67d5d	2024-06-05 17:23:05.175457	\N
\.


--
-- Data for Name: host_software; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.host_software (host_id, software_id) FROM stdin;
aaf42b65-3029-4ead-a0ba-12f3d335ee02	2b9f5e66-2e82-4657-9c57-f79cb80f4a37
3cdf67f3-7888-40f0-930f-361e07edb853	b80295d5-4a53-4259-a3fe-0c431851225d
0abdff38-6e19-4de5-8912-9dd970e0c1a6	4c51597b-1fc4-4f79-9224-b8f0ef42b802
d6e9b5e2-dfca-427b-b8f2-c1bd3faa9a1c	871f6b1a-a71d-428b-9cdd-db2906dc36a2
2edfae79-ca0d-4708-ab38-f5396f5115d6	2b9f5e66-2e82-4657-9c57-f79cb80f4a37
aaf42b65-3029-4ead-a0ba-12f3d335ee02	b80295d5-4a53-4259-a3fe-0c431851225d
aaf42b65-3029-4ead-a0ba-12f3d335ee02	2b9f5e66-2e82-4657-9c57-f79cb80f4a37
\.


--
-- Data for Name: info_system; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.info_system (name, criticality_ratio, id, created_at, deleted_at) FROM stdin;
Test Info System	\N	e94873cf-ec46-44c7-94c1-6e75973df5b2	2024-06-05 16:08:51.675811	\N
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.notes (title, description, id, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: software; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.software (name, product_id, software_type_id, id, created_at, deleted_at) FROM stdin;
Astra Linux	a1e4dcb8-4ba2-43a1-bb97-f04bf9bd4b67	d0e577fb-b3f1-48d3-9a14-831593e12fe4	2b9f5e66-2e82-4657-9c57-f79cb80f4a37	2024-06-05 17:08:22.248531	\N
MongoDB	\N	43342345-1d77-43e8-9dee-7e58a8ded2d3	b80295d5-4a53-4259-a3fe-0c431851225d	2024-06-05 17:08:22.248531	\N
PostgreSQL	8f163576-52b6-4838-821a-9df69fb05aa6	43342345-1d77-43e8-9dee-7e58a8ded2d3	4c51597b-1fc4-4f79-9224-b8f0ef42b802	2024-06-05 17:08:22.248531	\N
Some strange soft	\N	c2decb2c-9bbc-4d4d-a921-27e4ce531a67	871f6b1a-a71d-428b-9cdd-db2906dc36a2	2024-06-05 17:08:22.248531	\N
\.


--
-- Data for Name: software_hardware; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.software_hardware (hardware_id, software_id) FROM stdin;
\.


--
-- Data for Name: software_tech_stability; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.software_tech_stability (id, created_at, info_system_id, vendor_support, monitoring_coverage, compliance_standarts, cpu_util, ram_util, mem_util, srk, purchase_available) FROM stdin;
1	2024-06-05 19:14:47.243912	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
2	2024-06-05 21:55:19.45373	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
3	2024-06-05 21:56:05.815336	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
4	2024-06-06 14:52:12.987538	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
5	2024-06-06 14:52:45.645028	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
6	2024-06-06 14:54:36.368281	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
7	2024-06-06 15:28:51.808447	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
8	2024-06-06 15:32:44.164719	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
9	2024-06-06 15:33:30.31923	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
10	2024-06-06 16:07:39.168196	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
11	2024-06-06 16:07:41.947208	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
12	2024-06-06 16:09:04.304726	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
13	2024-06-06 16:09:17.185366	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
14	2024-06-06 16:09:31.392039	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
15	2024-06-06 16:10:51.061273	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
16	2024-06-06 16:11:30.386237	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
17	2024-06-06 16:28:33.325953	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
18	2024-06-06 14:08:36.300832	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
19	2024-06-06 14:09:41.829948	e94873cf-ec46-44c7-94c1-6e75973df5b2	0.5	0.8	0.5	0.6	0.8	0.8	0.8	0.5
\.


--
-- Data for Name: software_types; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.software_types (name, id, created_at, deleted_at) FROM stdin;
Domain Controller	abe2daec-36e0-4018-b0a4-0a27665a2bf9	2024-06-05 17:04:41.59918	\N
Operating System	d0e577fb-b3f1-48d3-9a14-831593e12fe4	2024-06-05 17:04:41.59918	\N
Database	43342345-1d77-43e8-9dee-7e58a8ded2d3	2024-06-05 17:04:41.59918	\N
Virtualization	27e958de-4ed2-4d0a-8ebc-f064a11deba6	2024-06-05 17:04:41.59918	\N
ITSM system	c2decb2c-9bbc-4d4d-a921-27e4ce531a67	2024-06-05 17:04:41.59918	\N
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.vendors (name, country, id, created_at, deleted_at) FROM stdin;
Astra Linux	Russia	d400c54e-6281-4679-996c-5320106494cd	2024-06-05 16:50:02.479345	\N
RED SOFT	Russia	b06c38de-2a3f-4845-b547-743dd5fbe09d	2024-06-05 16:50:02.479345	\N
Postgres	Russia	f4681135-86b1-4674-a522-72355093a3bd	2024-06-05 16:50:02.479345	\N
Docker	Not Russia	3e13713f-fa23-4690-9d24-c5f7351c5456	2024-06-05 16:50:02.479345	\N
MikroTik	Not Russia or I dont know	e7739970-5d8a-452a-95f3-79a14ef7608a	2024-06-05 16:50:02.479345	\N
\.


--
-- Data for Name: virtual_machine; Type: TABLE DATA; Schema: public; Owner: hello_fastapi
--

COPY public.virtual_machine (name, monitoring, system_id, srk, location, cluster, id, created_at, deleted_at, cpu_utilization, ram_utilization, disk_mem_utilization) FROM stdin;
Host 1	t	e94873cf-ec46-44c7-94c1-6e75973df5b2	t	spb	IaaS3	aaf42b65-3029-4ead-a0ba-12f3d335ee02	2024-06-05 16:45:43.204807	\N	80	44.4	67
Host 2	t	e94873cf-ec46-44c7-94c1-6e75973df5b2	t	spb	IaaS3	d6e9b5e2-dfca-427b-b8f2-c1bd3faa9a1c	2024-06-05 16:45:43.204807	\N	70	84.4	97
Host 3	f	e94873cf-ec46-44c7-94c1-6e75973df5b2	t	spb	IaaS3	3cdf67f3-7888-40f0-930f-361e07edb853	2024-06-05 16:45:43.204807	\N	50	44.4	67
Host 4	t	e94873cf-ec46-44c7-94c1-6e75973df5b2	f	spb	IaaS3	0abdff38-6e19-4de5-8912-9dd970e0c1a6	2024-06-05 16:45:43.204807	\N	50	44.4	67
Host 5	t	e94873cf-ec46-44c7-94c1-6e75973df5b2	t	spb	IaaS3	2edfae79-ca0d-4708-ab38-f5396f5115d6	2024-06-05 16:45:43.204807	\N	80	44.4	67
\.


--
-- Name: hardware_tech_stability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hello_fastapi
--

SELECT pg_catalog.setval('public.hardware_tech_stability_id_seq', 23, true);


--
-- Name: software_tech_stability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hello_fastapi
--

SELECT pg_catalog.setval('public.software_tech_stability_id_seq', 19, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: catalog catalog_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_id_key UNIQUE (id);


--
-- Name: catalog catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_pkey PRIMARY KEY (id);


--
-- Name: hardware hardware_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware
    ADD CONSTRAINT hardware_id_key UNIQUE (id);


--
-- Name: hardware hardware_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware
    ADD CONSTRAINT hardware_pkey PRIMARY KEY (id);


--
-- Name: hardware_tech_stability hardware_tech_stability_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware_tech_stability
    ADD CONSTRAINT hardware_tech_stability_pkey PRIMARY KEY (id);


--
-- Name: hardware_types hardware_types_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware_types
    ADD CONSTRAINT hardware_types_id_key UNIQUE (id);


--
-- Name: hardware_types hardware_types_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware_types
    ADD CONSTRAINT hardware_types_pkey PRIMARY KEY (id);


--
-- Name: info_system info_system_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.info_system
    ADD CONSTRAINT info_system_id_key UNIQUE (id);


--
-- Name: info_system info_system_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.info_system
    ADD CONSTRAINT info_system_pkey PRIMARY KEY (id);


--
-- Name: notes notes_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_id_key UNIQUE (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: software software_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_id_key UNIQUE (id);


--
-- Name: software software_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pkey PRIMARY KEY (id);


--
-- Name: software_tech_stability software_tech_stability_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_tech_stability
    ADD CONSTRAINT software_tech_stability_pkey PRIMARY KEY (id);


--
-- Name: software_types software_types_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_types
    ADD CONSTRAINT software_types_id_key UNIQUE (id);


--
-- Name: software_types software_types_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_types
    ADD CONSTRAINT software_types_pkey PRIMARY KEY (id);


--
-- Name: vendors vendors_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_id_key UNIQUE (id);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: virtual_machine virtual_machine_id_key; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.virtual_machine
    ADD CONSTRAINT virtual_machine_id_key UNIQUE (id);


--
-- Name: virtual_machine virtual_machine_pkey; Type: CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.virtual_machine
    ADD CONSTRAINT virtual_machine_pkey PRIMARY KEY (id);


--
-- Name: catalog catalog_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: hardware hardware_hardware_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware
    ADD CONSTRAINT hardware_hardware_type_id_fkey FOREIGN KEY (hardware_type_id) REFERENCES public.hardware_types(id);


--
-- Name: hardware hardware_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware
    ADD CONSTRAINT hardware_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.catalog(id);


--
-- Name: hardware_tech_stability hardware_tech_stability_info_system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.hardware_tech_stability
    ADD CONSTRAINT hardware_tech_stability_info_system_id_fkey FOREIGN KEY (info_system_id) REFERENCES public.info_system(id);


--
-- Name: host_software host_software_host_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.host_software
    ADD CONSTRAINT host_software_host_id_fkey FOREIGN KEY (host_id) REFERENCES public.virtual_machine(id);


--
-- Name: host_software host_software_software_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.host_software
    ADD CONSTRAINT host_software_software_id_fkey FOREIGN KEY (software_id) REFERENCES public.software(id);


--
-- Name: software_hardware software_hardware_hardware_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_hardware
    ADD CONSTRAINT software_hardware_hardware_id_fkey FOREIGN KEY (hardware_id) REFERENCES public.hardware(id);


--
-- Name: software_hardware software_hardware_software_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_hardware
    ADD CONSTRAINT software_hardware_software_id_fkey FOREIGN KEY (software_id) REFERENCES public.software(id);


--
-- Name: software software_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.catalog(id);


--
-- Name: software software_software_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_software_type_id_fkey FOREIGN KEY (software_type_id) REFERENCES public.software_types(id);


--
-- Name: software_tech_stability software_tech_stability_info_system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.software_tech_stability
    ADD CONSTRAINT software_tech_stability_info_system_id_fkey FOREIGN KEY (info_system_id) REFERENCES public.info_system(id);


--
-- Name: virtual_machine virtual_machine_system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hello_fastapi
--

ALTER TABLE ONLY public.virtual_machine
    ADD CONSTRAINT virtual_machine_system_id_fkey FOREIGN KEY (system_id) REFERENCES public.info_system(id);


--
-- PostgreSQL database dump complete
--

