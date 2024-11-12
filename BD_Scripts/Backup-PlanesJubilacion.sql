PGDMP  /                
    |            PlanesDeJubilacion    16.4    16.4 7    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16413    PlanesDeJubilacion    DATABASE     �   CREATE DATABASE "PlanesDeJubilacion" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 $   DROP DATABASE "PlanesDeJubilacion";
                postgres    false            �            1259    16435    beneficiarios    TABLE     {  CREATE TABLE public.beneficiarios (
    id_beneficiario integer NOT NULL,
    id_usuario integer,
    nombre_beneficiario character varying(100) NOT NULL,
    relacion character varying(50),
    porcentaje_asignado numeric(5,2),
    CONSTRAINT beneficiarios_porcentaje_asignado_check CHECK (((porcentaje_asignado <= (100)::numeric) AND (porcentaje_asignado >= (0)::numeric)))
);
 !   DROP TABLE public.beneficiarios;
       public         heap    postgres    false            �           0    0    TABLE beneficiarios    ACL     R   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.beneficiarios TO administrador;
          public          postgres    false    220            �            1259    16434 !   beneficiarios_id_beneficiario_seq    SEQUENCE     �   CREATE SEQUENCE public.beneficiarios_id_beneficiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.beneficiarios_id_beneficiario_seq;
       public          postgres    false    220            �           0    0 !   beneficiarios_id_beneficiario_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.beneficiarios_id_beneficiario_seq OWNED BY public.beneficiarios.id_beneficiario;
          public          postgres    false    219            �            1259    16462    estados_de_cuenta    TABLE     C  CREATE TABLE public.estados_de_cuenta (
    id_estado integer NOT NULL,
    id_usuario integer,
    saldo_actual numeric(12,2) DEFAULT 0,
    aportaciones_realizadas numeric(12,2) DEFAULT 0,
    intereses_acumulados numeric(12,2) DEFAULT 0,
    ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 %   DROP TABLE public.estados_de_cuenta;
       public         heap    postgres    false            �           0    0    TABLE estados_de_cuenta    ACL     V   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.estados_de_cuenta TO administrador;
          public          postgres    false    224            �            1259    16461    estados_de_cuenta_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE public.estados_de_cuenta_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.estados_de_cuenta_id_estado_seq;
       public          postgres    false    224            �           0    0    estados_de_cuenta_id_estado_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.estados_de_cuenta_id_estado_seq OWNED BY public.estados_de_cuenta.id_estado;
          public          postgres    false    223            �            1259    16448    pagos    TABLE     �  CREATE TABLE public.pagos (
    id_pago integer NOT NULL,
    id_usuario integer,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    monto numeric(10,2) NOT NULL,
    metodo_pago character varying(50),
    estado character varying(20) NOT NULL,
    CONSTRAINT pagos_estado_check CHECK (((estado)::text = ANY ((ARRAY['completado'::character varying, 'pendiente'::character varying])::text[])))
);
    DROP TABLE public.pagos;
       public         heap    postgres    false            �           0    0    TABLE pagos    ACL     J   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pagos TO administrador;
          public          postgres    false    222            �            1259    16447    pagos_id_pago_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pagos_id_pago_seq;
       public          postgres    false    222            �           0    0    pagos_id_pago_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pagos_id_pago_seq OWNED BY public.pagos.id_pago;
          public          postgres    false    221            �            1259    16426    planes_de_jubilacion    TABLE     �   CREATE TABLE public.planes_de_jubilacion (
    id_plan integer NOT NULL,
    tipo_plan character varying(50) NOT NULL,
    monto_minimo_aportacion numeric(10,2) NOT NULL,
    tasa_interes numeric(5,2) NOT NULL,
    descripcion text
);
 (   DROP TABLE public.planes_de_jubilacion;
       public         heap    postgres    false            �           0    0    TABLE planes_de_jubilacion    ACL     Y   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.planes_de_jubilacion TO administrador;
          public          postgres    false    218            �            1259    16425     planes_de_jubilacion_id_plan_seq    SEQUENCE     �   CREATE SEQUENCE public.planes_de_jubilacion_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.planes_de_jubilacion_id_plan_seq;
       public          postgres    false    218                        0    0     planes_de_jubilacion_id_plan_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.planes_de_jubilacion_id_plan_seq OWNED BY public.planes_de_jubilacion.id_plan;
          public          postgres    false    217            �            1259    16415    usuarios    TABLE     �  CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion text,
    contacto character varying(50),
    datos_financieros bytea,
    rol character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['administrador'::character varying, 'usuario'::character varying])::text[])))
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false                       0    0    TABLE usuarios    ACL     M   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usuarios TO administrador;
          public          postgres    false    216            �            1259    16414    usuarios_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_id_usuario_seq;
       public          postgres    false    216                       0    0    usuarios_id_usuario_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;
          public          postgres    false    215            �            1259    16498    vista_administrador    VIEW     �  CREATE VIEW public.vista_administrador AS
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
 &   DROP VIEW public.vista_administrador;
       public          postgres    false    220    218    222    222    218    218    222    222    222    220    216    220    220    220    224    224    224    224    222    216    216    224    216    224    216    218    218    216    216                       0    0    TABLE vista_administrador    ACL     X   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.vista_administrador TO administrador;
          public          postgres    false    227            �            1259    16494    vista_pagos_usuario    VIEW     �   CREATE VIEW public.vista_pagos_usuario AS
 SELECT p.id_pago,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado
   FROM (public.pagos p
     JOIN public.usuarios u ON ((p.id_usuario = u.id_usuario)))
  WHERE ((u.nombre)::text = CURRENT_USER);
 &   DROP VIEW public.vista_pagos_usuario;
       public          postgres    false    216    222    222    222    222    222    216    222                       0    0    TABLE vista_pagos_usuario    ACL     =   GRANT SELECT ON TABLE public.vista_pagos_usuario TO usuario;
          public          postgres    false    226            �            1259    16489    vista_usuario    VIEW     ?  CREATE VIEW public.vista_usuario AS
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
     DROP VIEW public.vista_usuario;
       public          postgres    false    218    224    224    224    224    220    220    220    220    218    218    218    216    216                       0    0    TABLE vista_usuario    ACL     7   GRANT SELECT ON TABLE public.vista_usuario TO usuario;
          public          postgres    false    225            ?           2604    16438    beneficiarios id_beneficiario    DEFAULT     �   ALTER TABLE ONLY public.beneficiarios ALTER COLUMN id_beneficiario SET DEFAULT nextval('public.beneficiarios_id_beneficiario_seq'::regclass);
 L   ALTER TABLE public.beneficiarios ALTER COLUMN id_beneficiario DROP DEFAULT;
       public          postgres    false    219    220    220            B           2604    16465    estados_de_cuenta id_estado    DEFAULT     �   ALTER TABLE ONLY public.estados_de_cuenta ALTER COLUMN id_estado SET DEFAULT nextval('public.estados_de_cuenta_id_estado_seq'::regclass);
 J   ALTER TABLE public.estados_de_cuenta ALTER COLUMN id_estado DROP DEFAULT;
       public          postgres    false    224    223    224            @           2604    16451    pagos id_pago    DEFAULT     n   ALTER TABLE ONLY public.pagos ALTER COLUMN id_pago SET DEFAULT nextval('public.pagos_id_pago_seq'::regclass);
 <   ALTER TABLE public.pagos ALTER COLUMN id_pago DROP DEFAULT;
       public          postgres    false    221    222    222            >           2604    16429    planes_de_jubilacion id_plan    DEFAULT     �   ALTER TABLE ONLY public.planes_de_jubilacion ALTER COLUMN id_plan SET DEFAULT nextval('public.planes_de_jubilacion_id_plan_seq'::regclass);
 K   ALTER TABLE public.planes_de_jubilacion ALTER COLUMN id_plan DROP DEFAULT;
       public          postgres    false    217    218    218            <           2604    16418    usuarios id_usuario    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
       public          postgres    false    215    216    216            �          0    16435    beneficiarios 
   TABLE DATA           x   COPY public.beneficiarios (id_beneficiario, id_usuario, nombre_beneficiario, relacion, porcentaje_asignado) FROM stdin;
    public          postgres    false    220   %J       �          0    16462    estados_de_cuenta 
   TABLE DATA           �   COPY public.estados_de_cuenta (id_estado, id_usuario, saldo_actual, aportaciones_realizadas, intereses_acumulados, ultima_actualizacion) FROM stdin;
    public          postgres    false    224   BJ       �          0    16448    pagos 
   TABLE DATA           \   COPY public.pagos (id_pago, id_usuario, fecha_pago, monto, metodo_pago, estado) FROM stdin;
    public          postgres    false    222   _J       �          0    16426    planes_de_jubilacion 
   TABLE DATA           v   COPY public.planes_de_jubilacion (id_plan, tipo_plan, monto_minimo_aportacion, tasa_interes, descripcion) FROM stdin;
    public          postgres    false    218   |J       �          0    16415    usuarios 
   TABLE DATA           s   COPY public.usuarios (id_usuario, nombre, direccion, contacto, datos_financieros, rol, fecha_registro) FROM stdin;
    public          postgres    false    216   �J                  0    0 !   beneficiarios_id_beneficiario_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.beneficiarios_id_beneficiario_seq', 1, false);
          public          postgres    false    219                       0    0    estados_de_cuenta_id_estado_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.estados_de_cuenta_id_estado_seq', 1, false);
          public          postgres    false    223                       0    0    pagos_id_pago_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.pagos_id_pago_seq', 1, false);
          public          postgres    false    221            	           0    0     planes_de_jubilacion_id_plan_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.planes_de_jubilacion_id_plan_seq', 1, false);
          public          postgres    false    217            
           0    0    usuarios_id_usuario_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 1, false);
          public          postgres    false    215            O           2606    16441     beneficiarios beneficiarios_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_pkey PRIMARY KEY (id_beneficiario);
 J   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT beneficiarios_pkey;
       public            postgres    false    220            S           2606    16471 (   estados_de_cuenta estados_de_cuenta_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_pkey PRIMARY KEY (id_estado);
 R   ALTER TABLE ONLY public.estados_de_cuenta DROP CONSTRAINT estados_de_cuenta_pkey;
       public            postgres    false    224            Q           2606    16455    pagos pagos_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);
 :   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_pkey;
       public            postgres    false    222            M           2606    16433 .   planes_de_jubilacion planes_de_jubilacion_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.planes_de_jubilacion
    ADD CONSTRAINT planes_de_jubilacion_pkey PRIMARY KEY (id_plan);
 X   ALTER TABLE ONLY public.planes_de_jubilacion DROP CONSTRAINT planes_de_jubilacion_pkey;
       public            postgres    false    218            K           2606    16424    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    216            T           2606    16442 +   beneficiarios beneficiarios_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT beneficiarios_id_usuario_fkey;
       public          postgres    false    216    220    4683            V           2606    16472 3   estados_de_cuenta estados_de_cuenta_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.estados_de_cuenta DROP CONSTRAINT estados_de_cuenta_id_usuario_fkey;
       public          postgres    false    216    4683    224            U           2606    16456    pagos pagos_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_id_usuario_fkey;
       public          postgres    false    4683    222    216                       826    16504     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     e   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO administrador;
          public          postgres    false                       826    16503    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     b   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO administrador;
          public          postgres    false            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     