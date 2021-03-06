--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Ubuntu 14.1-1.pgdg21.04+1)
-- Dumped by pg_dump version 14.1 (Ubuntu 14.1-1.pgdg21.04+1)

-- Started on 2021-12-26 09:52:19 +06

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16395)
-- Name: bus; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.bus (
    id integer NOT NULL,
    name character varying NOT NULL,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.bus OWNER TO "ctas-admin";

--
-- TOC entry 217 (class 1259 OID 16499)
-- Name: bus_id_seq; Type: SEQUENCE; Schema: public; Owner: ctas-admin
--

ALTER TABLE public.bus ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 16414)
-- Name: driver; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.driver (
    id integer NOT NULL,
    name character varying NOT NULL,
    address character varying,
    license boolean
);


ALTER TABLE public.driver OWNER TO "ctas-admin";

--
-- TOC entry 218 (class 1259 OID 16500)
-- Name: driver_id_seq; Type: SEQUENCE; Schema: public; Owner: ctas-admin
--

ALTER TABLE public.driver ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.driver_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 213 (class 1259 OID 16440)
-- Name: permissions; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    permission character varying NOT NULL,
    role integer
);


ALTER TABLE public.permissions OWNER TO "ctas-admin";

--
-- TOC entry 211 (class 1259 OID 16402)
-- Name: roles; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.roles OWNER TO "ctas-admin";

--
-- TOC entry 214 (class 1259 OID 16452)
-- Name: route; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.route (
    id integer NOT NULL,
    checkpoints character varying[]
);


ALTER TABLE public.route OWNER TO "ctas-admin";

--
-- TOC entry 216 (class 1259 OID 16472)
-- Name: schedule; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.schedule (
    id integer NOT NULL,
    bus integer,
    driver integer,
    route integer,
    datetime timestamp with time zone
);


ALTER TABLE public.schedule OWNER TO "ctas-admin";

--
-- TOC entry 215 (class 1259 OID 16471)
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: ctas-admin
--

CREATE SEQUENCE public.schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_id_seq OWNER TO "ctas-admin";

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 215
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ctas-admin
--

ALTER SEQUENCE public.schedule_id_seq OWNED BY public.schedule.id;


--
-- TOC entry 209 (class 1259 OID 16388)
-- Name: users; Type: TABLE; Schema: public; Owner: ctas-admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    role integer
);


ALTER TABLE public.users OWNER TO "ctas-admin";

--
-- TOC entry 3230 (class 2604 OID 16475)
-- Name: schedule id; Type: DEFAULT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.schedule ALTER COLUMN id SET DEFAULT nextval('public.schedule_id_seq'::regclass);


--
-- TOC entry 3234 (class 2606 OID 16399)
-- Name: bus bus_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT bus_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 16420)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16446)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 16408)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 16458)
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2606 OID 16477)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 16394)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 16447)
-- Name: permissions fk_permission_role; Type: FK CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT fk_permission_role FOREIGN KEY (role) REFERENCES public.roles(id);


--
-- TOC entry 3245 (class 2606 OID 16409)
-- Name: users fk_role; Type: FK CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_role FOREIGN KEY (role) REFERENCES public.roles(id);


--
-- TOC entry 3247 (class 2606 OID 16478)
-- Name: schedule schedule_bus_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_bus_fkey FOREIGN KEY (bus) REFERENCES public.bus(id);


--
-- TOC entry 3248 (class 2606 OID 16483)
-- Name: schedule schedule_driver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_driver_fkey FOREIGN KEY (driver) REFERENCES public.driver(id);


--
-- TOC entry 3249 (class 2606 OID 16488)
-- Name: schedule schedule_route_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ctas-admin
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_route_fkey FOREIGN KEY (route) REFERENCES public.route(id);


-- Completed on 2021-12-26 09:52:20 +06

--
-- PostgreSQL database dump complete
--

