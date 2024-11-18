PGDMP                  
    |            PRUEBAS    17.0    17.0 E               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    25602    PRUEBAS    DATABASE     |   CREATE DATABASE "PRUEBAS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "PRUEBAS";
                     postgres    false            �            1259    25626    beneficiarios    TABLE     �  CREATE TABLE public.beneficiarios (
    id_beneficiario integer NOT NULL,
    id_usuario integer,
    nombre_beneficiario character varying(100) NOT NULL,
    relacion character varying(50),
    porcentaje_asignado numeric(5,2),
    cedula_beneficiario character varying(50) NOT NULL,
    CONSTRAINT beneficiarios_porcentaje_asignado_check CHECK (((porcentaje_asignado <= (100)::numeric) AND (porcentaje_asignado >= (0)::numeric)))
);
 !   DROP TABLE public.beneficiarios;
       public         heap r       postgres    false                       0    0    TABLE beneficiarios    ACL     V   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.beneficiarios TO administrador_api;
          public               postgres    false    222            �            1259    25625 !   beneficiarios_id_beneficiario_seq    SEQUENCE     �   CREATE SEQUENCE public.beneficiarios_id_beneficiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.beneficiarios_id_beneficiario_seq;
       public               postgres    false    222                       0    0 !   beneficiarios_id_beneficiario_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.beneficiarios_id_beneficiario_seq OWNED BY public.beneficiarios.id_beneficiario;
          public               postgres    false    221            �            1259    25675    estados_de_cuenta    TABLE     h  CREATE TABLE public.estados_de_cuenta (
    id_estado integer NOT NULL,
    id_usuario integer,
    saldo_actual numeric(12,2) DEFAULT 0,
    aportaciones_realizadas numeric(12,2) DEFAULT 0,
    intereses_acumulados numeric(12,2) DEFAULT 0,
    ultima_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cuotas_pagadas integer NOT NULL
);
 %   DROP TABLE public.estados_de_cuenta;
       public         heap r       postgres    false                       0    0    TABLE estados_de_cuenta    ACL     Z   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.estados_de_cuenta TO administrador_api;
          public               postgres    false    228            �            1259    25674    estados_de_cuenta_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE public.estados_de_cuenta_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.estados_de_cuenta_id_estado_seq;
       public               postgres    false    228                       0    0    estados_de_cuenta_id_estado_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.estados_de_cuenta_id_estado_seq OWNED BY public.estados_de_cuenta.id_estado;
          public               postgres    false    227            �            1259    25661    pagos    TABLE     �  CREATE TABLE public.pagos (
    id_pago integer NOT NULL,
    id_usuario integer,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    monto numeric(10,2) NOT NULL,
    metodo_pago character varying(50),
    estado character varying(20) NOT NULL,
    CONSTRAINT pagos_estado_check CHECK (((estado)::text = ANY ((ARRAY['completado'::character varying, 'pendiente'::character varying])::text[])))
);
    DROP TABLE public.pagos;
       public         heap r       postgres    false                       0    0    TABLE pagos    ACL     N   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pagos TO administrador_api;
          public               postgres    false    226            �            1259    25660    pagos_id_pago_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pagos_id_pago_seq;
       public               postgres    false    226                       0    0    pagos_id_pago_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pagos_id_pago_seq OWNED BY public.pagos.id_pago;
          public               postgres    false    225            �            1259    25617    planes_de_jubilacion    TABLE       CREATE TABLE public.planes_de_jubilacion (
    id_plan integer NOT NULL,
    tipo_plan character varying(50) NOT NULL,
    monto_minimo_aportacion numeric(10,2) NOT NULL,
    tasa_interes numeric(5,2) NOT NULL,
    descripcion text,
    cuotas_necesarias integer NOT NULL
);
 (   DROP TABLE public.planes_de_jubilacion;
       public         heap r       postgres    false                       0    0    TABLE planes_de_jubilacion    ACL     ]   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.planes_de_jubilacion TO administrador_api;
          public               postgres    false    220            �            1259    25616     planes_de_jubilacion_id_plan_seq    SEQUENCE     �   CREATE SEQUENCE public.planes_de_jubilacion_id_plan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.planes_de_jubilacion_id_plan_seq;
       public               postgres    false    220                       0    0     planes_de_jubilacion_id_plan_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.planes_de_jubilacion_id_plan_seq OWNED BY public.planes_de_jubilacion.id_plan;
          public               postgres    false    219            �            1259    25639    planes_usuarios    TABLE     �   CREATE TABLE public.planes_usuarios (
    id_plan_usuario integer NOT NULL,
    id_usuario integer,
    id_plan integer,
    id_beneficiario integer
);
 #   DROP TABLE public.planes_usuarios;
       public         heap r       postgres    false                       0    0    TABLE planes_usuarios    ACL     X   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.planes_usuarios TO administrador_api;
          public               postgres    false    224            �            1259    25638 #   planes_usuarios_id_plan_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.planes_usuarios_id_plan_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.planes_usuarios_id_plan_usuario_seq;
       public               postgres    false    224                       0    0 #   planes_usuarios_id_plan_usuario_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.planes_usuarios_id_plan_usuario_seq OWNED BY public.planes_usuarios.id_plan_usuario;
          public               postgres    false    223            �            1259    25604    usuarios    TABLE     5  CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    cedula character varying(50) NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion text NOT NULL,
    contacto character varying(50) NOT NULL,
    rol character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "contraseña_hash" character varying(255) NOT NULL,
    id_plan integer,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['administrador'::character varying, 'usuario'::character varying])::text[])))
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false                       0    0    TABLE usuarios    ACL     Q   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usuarios TO administrador_api;
          public               postgres    false    218            �            1259    25603    usuarios_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_id_usuario_seq;
       public               postgres    false    218                       0    0    usuarios_id_usuario_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;
          public               postgres    false    217            �            1259    25737    vista_beneficiarios    VIEW       CREATE VIEW public.vista_beneficiarios AS
 SELECT u.id_usuario,
    b.cedula_beneficiario,
    b.nombre_beneficiario,
    b.relacion,
    b.porcentaje_asignado
   FROM (public.usuarios u
     LEFT JOIN public.beneficiarios b ON ((u.id_usuario = b.id_usuario)));
 &   DROP VIEW public.vista_beneficiarios;
       public       v       postgres    false    222    222    222    222    218    222                        0    0    TABLE vista_beneficiarios    ACL     D   GRANT ALL ON TABLE public.vista_beneficiarios TO administrador_api;
          public               postgres    false    230            �            1259    25695    vista_pagos_usuario    VIEW     �   CREATE VIEW public.vista_pagos_usuario AS
 SELECT u.id_usuario,
    p.id_pago,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado
   FROM (public.pagos p
     JOIN public.usuarios u ON ((p.id_usuario = u.id_usuario)));
 &   DROP VIEW public.vista_pagos_usuario;
       public       v       postgres    false    226    226    226    226    226    226    218            !           0    0    TABLE vista_pagos_usuario    ACL     A   GRANT SELECT ON TABLE public.vista_pagos_usuario TO usuario_api;
          public               postgres    false    229            �            1259    25789    vista_usuario    VIEW     9  CREATE VIEW public.vista_usuario AS
 SELECT DISTINCT u.cedula,
    u.id_usuario,
    u.nombre,
    COALESCE(pj.tipo_plan, 'Sin Plan'::character varying) AS tipo_plan,
    COALESCE(pj.monto_minimo_aportacion, (0)::numeric) AS monto_minimo_aportacion,
    COALESCE(pj.tasa_interes, (0)::numeric) AS tasa_interes,
    COALESCE(pj.cuotas_necesarias, 0) AS cuotas_necesarias,
    COALESCE(e.saldo_actual, (0)::numeric) AS saldo_actual,
    COALESCE(e.aportaciones_realizadas, (0)::numeric) AS aportaciones_realizadas,
    COALESCE(e.intereses_acumulados, (0)::numeric) AS intereses_acumulados,
    COALESCE(e.cuotas_pagadas, 0) AS cuotas_pagadas
   FROM ((public.usuarios u
     LEFT JOIN public.planes_de_jubilacion pj ON ((u.id_plan = pj.id_plan)))
     LEFT JOIN public.estados_de_cuenta e ON ((u.id_usuario = e.id_usuario)));
     DROP VIEW public.vista_usuario;
       public       v       postgres    false    218    218    218    220    220    220    220    228    228    228    220    228    228    218            "           0    0    TABLE vista_usuario    ACL     >   GRANT ALL ON TABLE public.vista_usuario TO administrador_api;
          public               postgres    false    231            K           2604    25629    beneficiarios id_beneficiario    DEFAULT     �   ALTER TABLE ONLY public.beneficiarios ALTER COLUMN id_beneficiario SET DEFAULT nextval('public.beneficiarios_id_beneficiario_seq'::regclass);
 L   ALTER TABLE public.beneficiarios ALTER COLUMN id_beneficiario DROP DEFAULT;
       public               postgres    false    222    221    222            O           2604    25678    estados_de_cuenta id_estado    DEFAULT     �   ALTER TABLE ONLY public.estados_de_cuenta ALTER COLUMN id_estado SET DEFAULT nextval('public.estados_de_cuenta_id_estado_seq'::regclass);
 J   ALTER TABLE public.estados_de_cuenta ALTER COLUMN id_estado DROP DEFAULT;
       public               postgres    false    227    228    228            M           2604    25664    pagos id_pago    DEFAULT     n   ALTER TABLE ONLY public.pagos ALTER COLUMN id_pago SET DEFAULT nextval('public.pagos_id_pago_seq'::regclass);
 <   ALTER TABLE public.pagos ALTER COLUMN id_pago DROP DEFAULT;
       public               postgres    false    225    226    226            J           2604    25620    planes_de_jubilacion id_plan    DEFAULT     �   ALTER TABLE ONLY public.planes_de_jubilacion ALTER COLUMN id_plan SET DEFAULT nextval('public.planes_de_jubilacion_id_plan_seq'::regclass);
 K   ALTER TABLE public.planes_de_jubilacion ALTER COLUMN id_plan DROP DEFAULT;
       public               postgres    false    220    219    220            L           2604    25642    planes_usuarios id_plan_usuario    DEFAULT     �   ALTER TABLE ONLY public.planes_usuarios ALTER COLUMN id_plan_usuario SET DEFAULT nextval('public.planes_usuarios_id_plan_usuario_seq'::regclass);
 N   ALTER TABLE public.planes_usuarios ALTER COLUMN id_plan_usuario DROP DEFAULT;
       public               postgres    false    224    223    224            H           2604    25607    usuarios id_usuario    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN id_usuario DROP DEFAULT;
       public               postgres    false    218    217    218                      0    25626    beneficiarios 
   TABLE DATA           �   COPY public.beneficiarios (id_beneficiario, id_usuario, nombre_beneficiario, relacion, porcentaje_asignado, cedula_beneficiario) FROM stdin;
    public               postgres    false    222   l]                 0    25675    estados_de_cuenta 
   TABLE DATA           �   COPY public.estados_de_cuenta (id_estado, id_usuario, saldo_actual, aportaciones_realizadas, intereses_acumulados, ultima_actualizacion, cuotas_pagadas) FROM stdin;
    public               postgres    false    228   M^                 0    25661    pagos 
   TABLE DATA           \   COPY public.pagos (id_pago, id_usuario, fecha_pago, monto, metodo_pago, estado) FROM stdin;
    public               postgres    false    226   �^                 0    25617    planes_de_jubilacion 
   TABLE DATA           �   COPY public.planes_de_jubilacion (id_plan, tipo_plan, monto_minimo_aportacion, tasa_interes, descripcion, cuotas_necesarias) FROM stdin;
    public               postgres    false    220   l_       	          0    25639    planes_usuarios 
   TABLE DATA           `   COPY public.planes_usuarios (id_plan_usuario, id_usuario, id_plan, id_beneficiario) FROM stdin;
    public               postgres    false    224   `                 0    25604    usuarios 
   TABLE DATA           �   COPY public.usuarios (id_usuario, cedula, nombre, direccion, contacto, rol, fecha_registro, "contraseña_hash", id_plan) FROM stdin;
    public               postgres    false    218   <`       #           0    0 !   beneficiarios_id_beneficiario_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.beneficiarios_id_beneficiario_seq', 8, true);
          public               postgres    false    221            $           0    0    estados_de_cuenta_id_estado_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.estados_de_cuenta_id_estado_seq', 5, true);
          public               postgres    false    227            %           0    0    pagos_id_pago_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.pagos_id_pago_seq', 5, true);
          public               postgres    false    225            &           0    0     planes_de_jubilacion_id_plan_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.planes_de_jubilacion_id_plan_seq', 3, true);
          public               postgres    false    219            '           0    0 #   planes_usuarios_id_plan_usuario_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.planes_usuarios_id_plan_usuario_seq', 5, true);
          public               postgres    false    223            (           0    0    usuarios_id_usuario_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 20, true);
          public               postgres    false    217            ^           2606    25632     beneficiarios beneficiarios_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_pkey PRIMARY KEY (id_beneficiario);
 J   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT beneficiarios_pkey;
       public                 postgres    false    222            f           2606    25684 (   estados_de_cuenta estados_de_cuenta_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_pkey PRIMARY KEY (id_estado);
 R   ALTER TABLE ONLY public.estados_de_cuenta DROP CONSTRAINT estados_de_cuenta_pkey;
       public                 postgres    false    228            d           2606    25668    pagos pagos_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);
 :   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_pkey;
       public                 postgres    false    226            \           2606    25624 .   planes_de_jubilacion planes_de_jubilacion_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.planes_de_jubilacion
    ADD CONSTRAINT planes_de_jubilacion_pkey PRIMARY KEY (id_plan);
 X   ALTER TABLE ONLY public.planes_de_jubilacion DROP CONSTRAINT planes_de_jubilacion_pkey;
       public                 postgres    false    220            b           2606    25644 $   planes_usuarios planes_usuarios_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.planes_usuarios
    ADD CONSTRAINT planes_usuarios_pkey PRIMARY KEY (id_plan_usuario);
 N   ALTER TABLE ONLY public.planes_usuarios DROP CONSTRAINT planes_usuarios_pkey;
       public                 postgres    false    224            `           2606    25736 (   beneficiarios unique_cedula_beneficiario 
   CONSTRAINT     r   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT unique_cedula_beneficiario UNIQUE (cedula_beneficiario);
 R   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT unique_cedula_beneficiario;
       public                 postgres    false    222            X           2606    25615     usuarios usuarios_id_usuario_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_usuario_key UNIQUE (id_usuario);
 J   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_id_usuario_key;
       public                 postgres    false    218            Z           2606    25613    usuarios usuarios_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (cedula);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    218            h           2606    25633 +   beneficiarios beneficiarios_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.beneficiarios
    ADD CONSTRAINT beneficiarios_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.beneficiarios DROP CONSTRAINT beneficiarios_id_usuario_fkey;
       public               postgres    false    218    4696    222            m           2606    25685 3   estados_de_cuenta estados_de_cuenta_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estados_de_cuenta
    ADD CONSTRAINT estados_de_cuenta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.estados_de_cuenta DROP CONSTRAINT estados_de_cuenta_id_usuario_fkey;
       public               postgres    false    218    4696    228            g           2606    25757    usuarios fk_usuarios_planes    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_planes FOREIGN KEY (id_plan) REFERENCES public.planes_de_jubilacion(id_plan) ON DELETE SET NULL;
 E   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT fk_usuarios_planes;
       public               postgres    false    4700    220    218            l           2606    25669    pagos pagos_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_id_usuario_fkey;
       public               postgres    false    218    226    4696            i           2606    25655 4   planes_usuarios planes_usuarios_id_beneficiario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.planes_usuarios
    ADD CONSTRAINT planes_usuarios_id_beneficiario_fkey FOREIGN KEY (id_beneficiario) REFERENCES public.beneficiarios(id_beneficiario) ON DELETE SET NULL;
 ^   ALTER TABLE ONLY public.planes_usuarios DROP CONSTRAINT planes_usuarios_id_beneficiario_fkey;
       public               postgres    false    224    222    4702            j           2606    25650 ,   planes_usuarios planes_usuarios_id_plan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.planes_usuarios
    ADD CONSTRAINT planes_usuarios_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES public.planes_de_jubilacion(id_plan) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.planes_usuarios DROP CONSTRAINT planes_usuarios_id_plan_fkey;
       public               postgres    false    224    4700    220            k           2606    25645 /   planes_usuarios planes_usuarios_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.planes_usuarios
    ADD CONSTRAINT planes_usuarios_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.planes_usuarios DROP CONSTRAINT planes_usuarios_id_usuario_fkey;
       public               postgres    false    4696    218    224            "           826    25705     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     i   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO administrador_api;
          public               postgres    false            !           826    25704    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     f   ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO administrador_api;
          public               postgres    false               �   x�U�=n�@F�oN�0��H	ȊA8�H�4X�D��C�ۤLA�#��b@B�b��7�+P�f�'VM�����=��<�δ�ih4~'A���vષ� �P��|Vn��쫼��1t�Z��X�B�������N<l�9rp��OVO���e}��1M�)��r]*���Գ�G���MQX���5�z�	�����XG㛥�Y��	�����M�         b   x��˻� ���7E:��d�9	�����G��E�Y���ɛ~G��Zz}j6P�`�m�!���c��91����g�=B�D�7�%�C�""D�2.         �   x�}�;�0�z}
_ Ѯ?��$��4��F`c���b "�ۑ��(T�#�HKEk3�	{3ؕ�`{Dعr��d`9��#Ě���|z�!���O).]'.�|tr�w%�%�A7!�@ۉ}��3�9UL�������/'-��j~���B��U�         �   x�3��I�Sp�4400�30�4`���<��Ĭ|�̼�Ԣ�+�*�JRr������42�2�(v�!��" כ���Z����0,������il�e���i5�� �%�9%�.�!&q�p��qqq 2H>�      	   )   x�3�4A.#N0�2�C.N��	�)�)Pܔ+F��� z�X         �  x��V�n�F}^@����Mo��6�d�@����P%�hH���}��c��\�vE�+��ܖ�L  e2�nV��O���|uw~�X�w���r���0�2��n��u��6$���ά����"��VL��J������u�U��cv�>�щCK��\M�S���&!�C�7�����~�N��v��=\?�������Ժ�Q9;O\�
6{��j�m��h��!a���
آ��@���T~��8����u�������nօ����p�a�;p��<pJZ0�r� 66���D���v�mL��Y��喭�"�&΍C-��w��u���n��ܰ��B�N�k�f.�Mddg�	���r��-����Ƚt��d'�ʜXe'֎C�Բ���~���H������=���,�RL��n��Ⱥ��%�L��,zM�a��޻"�#���P �' ��!J�s�GɄ�7���L�F
���c�ı��CG�[�`��O��km,�t�Z{H�� ���i��#k�W������UgԘ���~y~u-�#MC8�F����S��X�Je45�Kj�h�x���{[�tD�9vT��)'��E�&Т���!�[..�Wg�ke�;;�Lү�rdg"�)i�X4`���dL���W
�W�=�$@[k�X�*O��5�<�%� �jx�0������rqq>W��ӻ��������P�H\`(�6������V��ި<�;o����(o����5���Q_���Sm�Q��<�|� YzÐ���9�u�	��k�^�����)Fs�}�#� gDS�Cp��/��ÚSwY����y]����o�;�D��tGjT|�Z�I<ߪ��g(EH�ε2����h>r-�$���0�Qzvb��B�����~��Ks\�c�9��V��$�gZO��XvF�fȒR�-���骖P2��lJ���R�"��]�ɜu4!4���}w�杺���^��{�{��th�Xȏ�I@���_WO`�!\I&B�����O�ww��o�/���Y+��O	؈	��`� [��Y�ѳ�v}��#p�J�l�H�֣��LIv`�x�fֹ�Ϙr���g�[ �:�
�u�P��'4~�]�o���ȶ�N�,띑���|HʢT������_���bu�u1� � ��D@�!����!P$���?�o��z�ěn�m�I�l�`����L���itH"�������_�z�0     