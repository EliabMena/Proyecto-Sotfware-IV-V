--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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
-- Name: beneficiarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.beneficiarios (
    id_beneficiario integer NOT NULL,
    id_usuario integer,
    nombre_beneficiario character varying(100) NOT NULL,
    relacion character varying(50),
    porcentaje_asignado numeric(5,2),
    CONSTRAINT beneficiarios_porcentaje_asignado_check CHECK (((porcentaje_asignado <= (100)::numeric) AND (porcentaje_asignado >= (0)::numeric)))
);


ALTER TABLE public.beneficiarios OWNER TO postgres;

--
-- Name: beneficiarios_id_beneficiario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.beneficiarios_id_beneficiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.beneficiarios_id_beneficiario_seq OWNER TO postgres;

--
-- Name: beneficiarios_id_beneficiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.beneficiarios_id_beneficiario_seq OWNED BY public.beneficiarios.id_beneficiario;


--
-- Name: estados_de_cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados_de_cuenta (
    id_estado integer NOT NULL,
    id_usuario integer,
    saldo_actual numeric(12,2) DEFAULT 0,
    aportaciones_realizadas numeric(12,2) DEFAULT 0,
    intereses_acumulados numeric(12,2) DEFAULT 0,
    ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.estados_de_cuenta OWNER TO postgres;

--
-- Name: estados_de_cuenta_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_de_cuenta_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_de_cuenta_id_estado_seq OWNER TO postgres;

--
-- Name: estados_de_cuenta_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_de_cuenta_id_estado_seq OWNED BY public.estados_de_cuenta.id_estado;


--
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    id_pago integer NOT NULL,
    id_usuario integer,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    monto numeric(10,2) NOT NULL,
    metodo_pago character varying(50),
    estado character varying(20) NOT NULL,
    CONSTRAINT pagos_estado_check CHECK (((estado)::text = ANY ((ARRAY['completado'::character varying, 'pendiente'::character varying])::text[])))
);


ALTER TABLE public.pagos OWNER TO postgres;

--
-- Name: pagos_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_id_pago_seq OWNER TO postgres;

--
-- Name: pagos_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_id_pago_seq OWNED BY public.pagos.id_pago;


--
-- Name: planes_de_jubilacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planes_de_jubilacion (
    id_plan integer NOT NULL,
    tipo_plan character varying(50) NOT NULL,
    monto_minimo_aportacion numeric(10,2) NOT NULL,
    tasa_interes numeric(5,2) NOT NULL,
    descripcion text
);


ALTER TABLE public.planes_de_jubilacion OWNER TO postgres;

--
-- Name: planes_de_jubilacion_id_plan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planes_de_jubilacion_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.planes_de_jubilacion_id_plan_seq OWNER TO postgres;

--
-- Name: planes_de_jubilacion_id_plan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planes_de_jubilacion_id_plan_seq OWNED BY public.planes_de_jubilacion.id_plan;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion text,
    contacto character varying(50),
    datos_financieros bytea,
    rol character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['administrador'::character varying, 'usuario'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- Name: vista_administrador; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_administrador AS
 SELECT u.id_usuario AS usuario_id,
    u.nombre AS usuario_nombre,
    u.direccion,
    u.contacto,
    u.datos_financieros,
    u.rol,
    u.fecha_registro,
    pl.id_plan AS plan_id,
    pl.tipo_plan,
    pl.monto_minimo_aportacion,
    pl.tasa_interes,
    pl.descripcion,
    e.id_estado AS estado_id,
    e.saldo_actual,
    e.aportaciones_realizadas,
    e.intereses_acumulados,
    e.ultima_actualizacion,
    b.id_beneficiario AS beneficiario_id,
    b.nombre_beneficiario,
    b.relacion,
    b.porcentaje_asignado,
    pa.id_pago AS pago_id,
    pa.fecha_pago,
    pa.monto,
    pa.metodo_pago,
    pa.estado
   FROM ((((public.usuarios u
     LEFT JOIN public.planes_de_jubilacion pl ON ((u.id_usuario = pl.id_plan)))
     LEFT JOIN public.estados_de_cuenta e ON ((u.id_usuario = e.id_usuario)))
     LEFT JOIN public.beneficiarios b ON ((u.id_usuario = b.id_usuario)))
     LEFT JOIN public.pagos pa ON ((u.id_usuario = pa.id_usuario)));


ALTER VIEW public.vista_administrador OWNER TO postgres;

--
-- Name: vista_pagos_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_pagos_usuario AS
 SELECT p.id_pago,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado
   FROM (public.pagos p
     JOIN public.usuarios u ON ((p.id_usuario = u.id_usuario)))
  WHERE ((u.nombre)::text = CURRENT_USER);


ALTER VIEW public.vista_pagos_usuario OWNER TO postgres;

--
-- Name: vista_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_usuario AS
 SELECT u.id_usuario,
    u.nombre,
    p.tipo_plan,
    p.monto_minimo_aportacion,
    p.tasa_interes,
    e.saldo_actual,
    e.aportaciones_realizadas,
    e.intereses_acumulados,
    b.nombre_beneficiario,
    b.relacion,
    b.porcentaje_asignado
   FROM (((public.usuarios u
     JOIN public.planes_de_jubilacion p ON ((u.id_usuario = p.id_plan)))
     JOIN public.estados_de_cuenta e ON ((u.id_usuario = e.id_usuario)))
     JOIN public.beneficiarios b ON ((u.id_usuario = b.id_usuario)))
  WHERE ((u.nombre)::text = CURRENT_USER);


ALTER VIEW public.vista_usuario OWNER TO postgres;

--
-- Name: beneficiarios id_beneficiario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiarios ALTER COLUMN id_beneficiario SET DEFAULT nextval('public.beneficiarios_id_beneficiario_seq'::regclass);


--
-- Name: estados_de_cuenta id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_de_cuenta ALTER COLUMN id_estado SET DEFAULT nextval('public.estados_de_cuenta_id_estado_seq'::regclass);


--
-- Name: pagos id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos ALTER COLUMN id_pago SET DEFAULT nextval('public.pagos_id_pago_seq'::regclass);


--
-- Name: planes_de_jubilacion id_plan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes_de_jubilacion ALTER COLUMN id_plan SET DEFAULT nextval('public.planes_de_jubilacion_id_plan_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- Data for Name: beneficiarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.beneficiarios (id_beneficiario, id_usuario, nombre_beneficiario, relacion, porcentaje_asignado) FROM stdin;
\.


--
-- Data for Name: estados_de_cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estados_de_cuenta (id_estado, id_usuario, saldo_actual, aportaciones_realizadas, intereses_acumulados, ultima_actualizacion) FROM stdin;
\.


--
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos (id_pago, id_usuario, fecha_pago, monto, metodo_pago, estado) FROM stdin;
\.


--
-- Data for Name: planes_de_jubilacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planes_de_jubilacion (id_plan, tipo_plan, monto_minimo_aportacion, tasa_interes, descripcion) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre, direccion, contacto, datos_financieros, rol, fecha_registro) FROM stdin;
\.


--
-- Name: beneficiarios_id_beneficiario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.beneficiarios_id_beneficiario_seq', 1, false);


--
-- Name: estados_de_cuenta_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_de_cuenta_id_estado_seq', 1, false);


--
-- Name: pagos_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_id_pago_seq', 1, false);


--
-- Name: planes_de_jubilacion_id_plan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planes_de_jubilacion_id_plan_seq', 1, false);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 1, false);


--
-- Name: beneficiarios beneficiarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_pkey PRIMARY KEY (id_beneficiario);


--
-- Name: estados_de_cuenta estados_de_cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_pkey PRIMARY KEY (id_estado);


--
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);


--
-- Name: planes_de_jubilacion planes_de_jubilacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planes_de_jubilacion
    ADD CONSTRAINT planes_de_jubilacion_pkey PRIMARY KEY (id_plan);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: beneficiarios beneficiarios_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;


--
-- Name: estados_de_cuenta estados_de_cuenta_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;


--
-- Name: pagos pagos_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;


--
-- Name: TABLE beneficiarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.beneficiarios TO administrador;


--
-- Name: TABLE estados_de_cuenta; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.estados_de_cuenta TO administrador;


--
-- Name: TABLE pagos; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pagos TO administrador;


--
-- Name: TABLE planes_de_jubilacion; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.planes_de_jubilacion TO administrador;


--
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usuarios TO administrador;


--
-- Name: TABLE vista_administrador; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.vista_administrador TO administrador;


--
-- Name: TABLE vista_pagos_usuario; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.vista_pagos_usuario TO usuario;


--
-- Name: TABLE vista_usuario; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.vista_usuario TO usuario;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO administrador;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO administrador;


--
-- PostgreSQL database dump complete
--

