PGDMP      .            
    |         	   PRUEBAS-3    17.0    17.0 ;               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    26025 	   PRUEBAS-3    DATABASE     ~   CREATE DATABASE "PRUEBAS-3" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "PRUEBAS-3";
                     postgres    false            �            1259    26139    beneficiarios    TABLE     �  CREATE TABLE public.beneficiarios (
    id_beneficiario integer NOT NULL,
    cedula_beneficiario character varying(50) NOT NULL,
    id_usuario integer,
    nombre_beneficiario character varying(100) NOT NULL,
    relacion character varying(50),
    porcentaje_asignado numeric(5,2),
    CONSTRAINT beneficiarios_porcentaje_asignado_check CHECK (((porcentaje_asignado <= (100)::numeric) AND (porcentaje_asignado >= (0)::numeric)))
);
 !   DROP TABLE public.beneficiarios;
       public         heap r       postgres    false                       0    0    TABLE beneficiarios    ACL     V   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.beneficiarios TO administrador_api;
          public               postgres    false    222            �            1259    26138 !   beneficiarios_id_beneficiario_seq    SEQUENCE     �   CREATE SEQUENCE public.beneficiarios_id_beneficiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.beneficiarios_id_beneficiario_seq;
       public               postgres    false    222                       0    0 !   beneficiarios_id_beneficiario_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.beneficiarios_id_beneficiario_seq OWNED BY public.beneficiarios.id_beneficiario;
          public               postgres    false    221            �            1259    26168    estados_de_cuenta    TABLE     h  CREATE TABLE public.estados_de_cuenta (
    id_estado integer NOT NULL,
    id_usuario integer,
    saldo_actual numeric(12,2) DEFAULT 0,
    aportaciones_realizadas numeric(12,2) DEFAULT 0,
    intereses_acumulados numeric(12,2) DEFAULT 0,
    ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cuotas_pagadas integer NOT NULL
);
 %   DROP TABLE public.estados_de_cuenta;
       public         heap r       postgres    false                       0    0    TABLE estados_de_cuenta    ACL     Z   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.estados_de_cuenta TO administrador_api;
          public               postgres    false    226            �            1259    26167    estados_de_cuenta_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE public.estados_de_cuenta_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.estados_de_cuenta_id_estado_seq;
       public               postgres    false    226                       0    0    estados_de_cuenta_id_estado_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.estados_de_cuenta_id_estado_seq OWNED BY public.estados_de_cuenta.id_estado;
          public               postgres    false    225            �            1259    26154    pagos    TABLE     �  CREATE TABLE public.pagos (
    id_pago integer NOT NULL,
    id_usuario integer,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    monto numeric(10,2) NOT NULL,
    metodo_pago character varying(50),
    estado character varying(20) NOT NULL,
    CONSTRAINT pagos_estado_check CHECK (((estado)::text = ANY ((ARRAY['completado'::character varying, 'pendiente'::character varying])::text[])))
);
    DROP TABLE public.pagos;
       public         heap r       postgres    false                       0    0    TABLE pagos    ACL     N   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pagos TO administrador_api;
          public               postgres    false    224            �            1259    26153    pagos_id_pago_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pagos_id_pago_seq;
       public               postgres    false    224                       0    0    pagos_id_pago_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pagos_id_pago_seq OWNED BY public.pagos.id_pago;
          public               postgres    false    223            �            1259    26112    planes_de_jubilacion    TABLE       CREATE TABLE public.planes_de_jubilacion (
    id_plan integer NOT NULL,
    tipo_plan character varying(50) NOT NULL,
    monto_minimo_aportacion numeric(10,2) NOT NULL,
    tasa_interes numeric(5,2) NOT NULL,
    descripcion text,
    cuotas_necesarias integer NOT NULL
);
 (   DROP TABLE public.planes_de_jubilacion;
       public         heap r       postgres    false                       0    0    TABLE planes_de_jubilacion    ACL     ]   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.planes_de_jubilacion TO administrador_api;
          public               postgres    false    218            �            1259    26111     planes_de_jubilacion_id_plan_seq    SEQUENCE     �   CREATE SEQUENCE public.planes_de_jubilacion_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.planes_de_jubilacion_id_plan_seq;
       public               postgres    false    218                       0    0     planes_de_jubilacion_id_plan_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.planes_de_jubilacion_id_plan_seq OWNED BY public.planes_de_jubilacion.id_plan;
          public               postgres    false    217            �            1259    26121    usuarios    TABLE     e  CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    cedula character varying(50) NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion text NOT NULL,
    gmail text NOT NULL,
    foto_perfil bytea,
    contacto character varying(50) NOT NULL,
    rol character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "contraseña_hash" character varying(255) NOT NULL,
    id_plan integer,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['administrador'::character varying, 'usuario'::character varying])::text[])))
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false                       0    0    TABLE usuarios    ACL     Q   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usuarios TO administrador_api;
          public               postgres    false    220            �            1259    26120    usuarios_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_id_usuario_seq;
       public               postgres    false    220                       0    0    usuarios_id_usuario_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;
          public               postgres    false    219            �            1259    26188    vista_beneficiarios    VIEW       CREATE VIEW public.vista_beneficiarios AS
 SELECT u.id_usuario,
    b.cedula_beneficiario,
    b.nombre_beneficiario,
    b.relacion,
    b.porcentaje_asignado
   FROM (public.usuarios u
     LEFT JOIN public.beneficiarios b ON ((u.id_usuario = b.id_usuario)));
 &   DROP VIEW public.vista_beneficiarios;
       public       v       postgres    false    222    222    222    222    222    220            �            1259    26198    vista_historial_pagos    VIEW     &  CREATE VIEW public.vista_historial_pagos AS
 SELECT u.id_usuario,
    u.nombre AS nombre_usuario,
    p.id_pago,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado
   FROM (public.pagos p
     JOIN public.usuarios u ON ((p.id_usuario = u.id_usuario)))
  ORDER BY p.fecha_pago DESC;
 (   DROP VIEW public.vista_historial_pagos;
       public       v       postgres    false    220    224    224    224    224    224    220    224                       0    0    TABLE vista_historial_pagos    ACL     F   GRANT ALL ON TABLE public.vista_historial_pagos TO administrador_api;
          public               postgres    false    230            �            1259    26192    vista_pagos_usuario    VIEW     �   CREATE VIEW public.vista_pagos_usuario AS
 SELECT u.id_usuario,
    p.id_pago,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado
   FROM (public.pagos p
     JOIN public.usuarios u ON ((p.id_usuario = u.id_usuario)));
 &   DROP VIEW public.vista_pagos_usuario;
       public       v       postgres    false    224    224    224    224    224    220    224                       0    0    TABLE vista_pagos_usuario    ACL     A   GRANT SELECT ON TABLE public.vista_pagos_usuario TO usuario_api;
          public               postgres    false    229            �            1259    26183    vista_usuario    VIEW     z  CREATE VIEW public.vista_usuario AS
 SELECT DISTINCT u.cedula,
    u.id_usuario,
    u.nombre,
    u.direccion,
    u.gmail,
    u.contacto,
    COALESCE(pj.tipo_plan, 'Sin Plan'::character varying) AS tipo_plan,
    COALESCE(pj.monto_minimo_aportacion, (0)::numeric) AS monto_minimo_aportacion,
    COALESCE(pj.tasa_interes, (0)::numeric) AS tasa_interes,
    COALESCE(pj.cuotas_necesarias, 0) AS cuotas_necesarias,
    COALESCE(e.saldo_actual, (0)::numeric) AS saldo_actual,
    COALESCE(e.aportaciones_realizadas, (0)::numeric) AS aportaciones_realizadas,
    COALESCE(e.intereses_acumulados, (0)::numeric) AS intereses_acumulados,
    COALESCE(e.cuotas_pagadas, 0) AS cuotas_pagadas,
    u.foto_perfil
   FROM ((public.usuarios u
     LEFT JOIN public.planes_de_jubilacion pj ON ((u.id_plan = pj.id_plan)))
     LEFT JOIN public.estados_de_cuenta e ON ((u.id_usuario = e.id_usuario)));
     DROP VIEW public.vista_usuario;
       public       v       postgres    false    220    226    218    218    218    218    218    220    220    220    220    220    220    220    226    226    226    226                       0    0    TABLE vista_usuario    ACL     ;   GRANT SELECT ON TABLE public.vista_usuario TO usuario_api;
          public               postgres    false    227            J           2604    26142    beneficiarios id_beneficiario    DEFAULT     �   ALTER TABLE ONLY public.beneficiarios ALTER COLUMN id_beneficiario SET DEFAULT nextval('public.beneficiarios_id_beneficiario_seq'::regclass);
 L   ALTER TABLE public.beneficiarios ALTER COLUMN id_beneficiario DROP DEFAULT;
       public               postgres    false    222    221    222            M           2604    26171    estados_de_cuenta id_estado    DEFAULT     �   ALTER TABLE ONLY public.estados_de_cuenta ALTER COLUMN id_estado SET DEFAULT nextval('public.estados_de_cuenta_id_estado_seq'::regclass);
 J   ALTER TABLE public.estados_de_cuenta ALTER COLUMN id_estado DROP DEFAULT;
       public               postgres    false    225    226    226            K           2604    26157    pagos id_pago    DEFAULT     n   ALTER TABLE ONLY public.pagos ALTER COLUMN id_pago SET DEFAULT nextval('public.pagos_id_pago_seq'::regclass);
 <   ALTER TABLE public.pagos ALTER COLUMN id_pago DROP DEFAULT;
       public               postgres    false    224    223    224            G           2604    26115    planes_de_jubilacion id_plan    DEFAULT     �   ALTER TABLE ONLY public.planes_de_jubilacion ALTER COLUMN id_plan SET DEFAULT nextval('public.planes_de_jubilacion_id_plan_seq'::regclass);
 K   ALTER TABLE public.planes_de_jubilacion ALTER COLUMN id_plan DROP DEFAULT;
       public               postgres    false    217    218    218            H           2604    26124    usuarios id_usuario    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
       public               postgres    false    219    220    220                      0    26139    beneficiarios 
   TABLE DATA           �   COPY public.beneficiarios (id_beneficiario, cedula_beneficiario, id_usuario, nombre_beneficiario, relacion, porcentaje_asignado) FROM stdin;
    public               postgres    false    222   �P                 0    26168    estados_de_cuenta 
   TABLE DATA           �   COPY public.estados_de_cuenta (id_estado, id_usuario, saldo_actual, aportaciones_realizadas, intereses_acumulados, ultima_actualizacion, cuotas_pagadas) FROM stdin;
    public               postgres    false    226   �Q                 0    26154    pagos 
   TABLE DATA           \   COPY public.pagos (id_pago, id_usuario, fecha_pago, monto, metodo_pago, estado) FROM stdin;
    public               postgres    false    224   mR       �          0    26112    planes_de_jubilacion 
   TABLE DATA           �   COPY public.planes_de_jubilacion (id_plan, tipo_plan, monto_minimo_aportacion, tasa_interes, descripcion, cuotas_necesarias) FROM stdin;
    public               postgres    false    218   S       �          0    26121    usuarios 
   TABLE DATA           �   COPY public.usuarios (id_usuario, cedula, nombre, direccion, gmail, foto_perfil, contacto, rol, fecha_registro, "contraseña_hash", id_plan) FROM stdin;
    public               postgres    false    220   �S                  0    0 !   beneficiarios_id_beneficiario_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.beneficiarios_id_beneficiario_seq', 24, true);
          public               postgres    false    221                       0    0    estados_de_cuenta_id_estado_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.estados_de_cuenta_id_estado_seq', 12, true);
          public               postgres    false    225                       0    0    pagos_id_pago_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.pagos_id_pago_seq', 15, true);
          public               postgres    false    223                       0    0     planes_de_jubilacion_id_plan_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.planes_de_jubilacion_id_plan_seq', 3, true);
          public               postgres    false    217                       0    0    usuarios_id_usuario_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 21, true);
          public               postgres    false    219            \           2606    26145     beneficiarios beneficiarios_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_pkey PRIMARY KEY (id_beneficiario);
 J   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT beneficiarios_pkey;
       public                 postgres    false    222            b           2606    26177 (   estados_de_cuenta estados_de_cuenta_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_pkey PRIMARY KEY (id_estado);
 R   ALTER TABLE ONLY public.estados_de_cuenta DROP CONSTRAINT estados_de_cuenta_pkey;
       public                 postgres    false    226            `           2606    26161    pagos pagos_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);
 :   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_pkey;
       public                 postgres    false    224            V           2606    26119 .   planes_de_jubilacion planes_de_jubilacion_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.planes_de_jubilacion
    ADD CONSTRAINT planes_de_jubilacion_pkey PRIMARY KEY (id_plan);
 X   ALTER TABLE ONLY public.planes_de_jubilacion DROP CONSTRAINT planes_de_jubilacion_pkey;
       public                 postgres    false    218            ^           2606    26147 (   beneficiarios unique_cedula_beneficiario 
   CONSTRAINT     r   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT unique_cedula_beneficiario UNIQUE (cedula_beneficiario);
 R   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT unique_cedula_beneficiario;
       public                 postgres    false    222            X           2606    26132     usuarios usuarios_id_usuario_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_usuario_key UNIQUE (id_usuario);
 J   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_id_usuario_key;
       public                 postgres    false    220            Z           2606    26130    usuarios usuarios_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (cedula);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    220            d           2606    26148 +   beneficiarios beneficiarios_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT beneficiarios_id_usuario_fkey;
       public               postgres    false    4696    222    220            f           2606    26178 3   estados_de_cuenta estados_de_cuenta_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.estados_de_cuenta DROP CONSTRAINT estados_de_cuenta_id_usuario_fkey;
       public               postgres    false    226    220    4696            e           2606    26162    pagos pagos_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_id_usuario_fkey;
       public               postgres    false    4696    220    224            c           2606    26133    usuarios usuarios_id_plan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES public.planes_de_jubilacion(id_plan) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_id_plan_fkey;
       public               postgres    false    220    4694    218            !           826    26197     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     i   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO administrador_api;
          public               postgres    false                        826    26196    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     f   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO administrador_api;
          public               postgres    false               �   x�U�=R�0���� �X�Sz(�dRdHK#�8�ZF�
8=�刡��Oh�'!�H�}t���?x���o8/D����u���=\���ĞF����\�E�T�U	�݉��D>��+Aȅm3�1���d�.�}7�&
=S�3�Pb�xݳ�_�\�/�����8�.���LR^�2��7ֱ1|g�'��h���f}����)Fq�8�s�8�r�+.��)����a�         �   x����� E��s�@��|RK��c��5"����3l�xe�K�R�)�bwx�Ŭ�
�QCxS	�� 1��g���l��Mdԙ���i2��[|����WQ�}���g�X(�zLEF�eA7U�'��,p�         �   x���A�0����)� ͛�({o��M�%�( �_�ZM�ϗ�G a�P��	7��xml�jPɚ�S�.Nqh�@�x�]�N�*IR��a:��-�Ȥ����.�}�ʚlJ�t��̟��T� ��}:B>�d�5+�fؿ~�#�w�Q+��פ.      �   �   x�e�1�0�99EN9 �Ε�s�.2�"	5a�8��{�\��H�J��mD;�WW��� �n����sՇ��*�G�)��Z��>�b�rd}Z�
dU�osD? ����;ǴQ��s��:��v����/ 내l-^TE�����'.�8ƿ�q=}y�R���Z[      �   ?  x���=n�0�k���r��ʆ�$���R�IõJ�hW.r�P��
��Xl� ��7�G�|����&�O�i,h@���z��K�{���Y	��V6f���� ]IY�.A\	qeaAF1M,��up�P�h<HM��(��4:��(���J$�0�c� &��O�=��������bJT���E�~�)���o�Dkj@h�Z-3���b��X{eT1FQ8
����E���S�Z9!�Mi<�:|�T�9i���&�|�P�X�AڨHf��$�h��º`���Zy_�| �*�6����F�9�ʩ�̀��q���𙆮�rO��� ��I�D��X*��jv?w����������+��R��n�7Q�E\�®�f�~OC��v��nm�,����&��А�Ӳo���[<���W�qʮ�oεMdsge�Wd��RΧ2�����80ZDޟ�MV{{�+�g�n�T~�i�)��>uS�k�X���&����J�2v�����iyܦ!Ty��1x�D y�]r�.uX�z�hQx�ix=�������0���{��z�[�ȋ�����p     