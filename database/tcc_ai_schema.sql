--
-- PostgreSQL database dump
--

\restrict FiPxrxStI0SdbaLxyYBtL6hDOjYCITlba5yboH57tl1KTOZ2STgGplMcL405PK7

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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
-- Name: bot_interactions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.bot_interactions (
    id bigint NOT NULL,
    telegram_id text,
    telegram_name text,
    trello_name text,
    trello_member_id text,
    direction text,
    action text,
    user_message text,
    bot_response text,
    trello_card_id text,
    trello_card_name text,
    trello_list_from text,
    trello_list_to text,
    raw_payload jsonb,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.bot_interactions OWNER TO admin;

--
-- Name: bot_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.bot_interactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bot_interactions_id_seq OWNER TO admin;

--
-- Name: bot_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.bot_interactions_id_seq OWNED BY public.bot_interactions.id;


--
-- Name: chat_memory; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.chat_memory (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    message jsonb NOT NULL
);


ALTER TABLE public.chat_memory OWNER TO admin;

--
-- Name: chat_memory_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.chat_memory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chat_memory_id_seq OWNER TO admin;

--
-- Name: chat_memory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.chat_memory_id_seq OWNED BY public.chat_memory.id;


--
-- Name: telegram_users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.telegram_users (
    id integer NOT NULL,
    telegram_id bigint,
    telegram_name text,
    trello_member_id text,
    trello_name text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.telegram_users OWNER TO admin;

--
-- Name: telegram_users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.telegram_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.telegram_users_id_seq OWNER TO admin;

--
-- Name: telegram_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.telegram_users_id_seq OWNED BY public.telegram_users.id;


--
-- Name: bot_interactions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bot_interactions ALTER COLUMN id SET DEFAULT nextval('public.bot_interactions_id_seq'::regclass);


--
-- Name: chat_memory id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.chat_memory ALTER COLUMN id SET DEFAULT nextval('public.chat_memory_id_seq'::regclass);


--
-- Name: telegram_users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.telegram_users ALTER COLUMN id SET DEFAULT nextval('public.telegram_users_id_seq'::regclass);


--
-- Name: bot_interactions bot_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bot_interactions
    ADD CONSTRAINT bot_interactions_pkey PRIMARY KEY (id);


--
-- Name: chat_memory chat_memory_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.chat_memory
    ADD CONSTRAINT chat_memory_pkey PRIMARY KEY (id);


--
-- Name: telegram_users telegram_users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.telegram_users
    ADD CONSTRAINT telegram_users_pkey PRIMARY KEY (id);


--
-- Name: telegram_users telegram_users_telegram_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.telegram_users
    ADD CONSTRAINT telegram_users_telegram_id_key UNIQUE (telegram_id);


--
-- PostgreSQL database dump complete
--

\unrestrict FiPxrxStI0SdbaLxyYBtL6hDOjYCITlba5yboH57tl1KTOZ2STgGplMcL405PK7

