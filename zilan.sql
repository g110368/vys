--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12rc1

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
-- Name: isme_saygi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isme_saygi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."adSoyad" = UPPER(NEW."adSoyad");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.isme_saygi() OWNER TO postgres;

--
-- Name: kategoridekikitaplar(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kategoridekikitaplar() RETURNS TABLE(kategorino integer, kitapadi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Kategori"."kategoriNo","Kitap"."kitapAdi"
FROM "Kategori"
INNER JOIN "KitapKategori"
ON "Kategori"."kategoriNo"="KitapKategori"."kategoriNo"
INNER JOIN "Kitap"
ON "Kitap"."kitapNo" = "KitapKategori"."kitapNo"
ORDER BY "Kategori"."kategoriNo" ASC;
END;
$$;


ALTER FUNCTION public.kategoridekikitaplar() OWNER TO postgres;

--
-- Name: last_seen(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_seen() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE

BEGIN

    UPDATE "Mesaj" SET tarih=now() WHERE "mesajNo" = NEW."mesajNo";

    RETURN NEW;
END;

$$;


ALTER FUNCTION public.last_seen() OWNER TO postgres;

--
-- Name: message_stamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.message_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.baslik IS NULL THEN
            RAISE EXCEPTION 'baslik bos olamaz';
        END IF;
        IF NEW.govde IS NULL THEN
            RAISE EXCEPTION '% Govde bos olamaz', NEW.govde;
        END IF;


    END;
$$;


ALTER FUNCTION public.message_stamp() OWNER TO postgres;

--
-- Name: on_arka_bosalt(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.on_arka_bosalt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."govde" = LTRIM(NEW."govde");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.on_arka_bosalt() OWNER TO postgres;

--
-- Name: secilen_kullanici(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.secilen_kullanici(number integer) RETURNS void
    LANGUAGE sql
    AS $$
  SELECT * FROM "Kullanici" where "KullaniciNo" = number;
$$;


ALTER FUNCTION public.secilen_kullanici(number integer) OWNER TO postgres;

--
-- Name: toplam_kullanici(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.toplam_kullanici()
    LANGUAGE plpgsql
    AS $$
	 DECLARE BEGIN
	END; 
	$$;


ALTER PROCEDURE public.toplam_kullanici() OWNER TO postgres;

--
-- Name: yazareserlistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yazareserlistele() RETURNS TABLE(yazaradi character varying, kitapadi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Yazar"."adSoyad", "Kitap"."kitapAdi"
FROM "Kitap"
INNER JOIN "KitapYazar"
ON "Kitap"."kitapNo"="KitapYazar"."kitapNo"
inner join "Yazar"
on "Yazar"."yazarNo" = "KitapYazar"."yazarNo"
order by "Yazar"."adSoyad" asc;
END;
$$;


ALTER FUNCTION public.yazareserlistele() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Admin" (
    "KullaniciNo" integer NOT NULL
);


ALTER TABLE public."Admin" OWNER TO postgres;

--
-- Name: Admin_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Admin_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Admin_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: Admin_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Admin_KullaniciNo_seq" OWNED BY public."Admin"."KullaniciNo";


--
-- Name: FavoriKitaplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FavoriKitaplar" (
    "favKitapListeNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL
);


ALTER TABLE public."FavoriKitaplar" OWNER TO postgres;

--
-- Name: FavoriKitaplar_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FavoriKitaplar_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FavoriKitaplar_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: FavoriKitaplar_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FavoriKitaplar_KullaniciNo_seq" OWNED BY public."FavoriKitaplar"."KullaniciNo";


--
-- Name: FavoriKitaplar_favKitapListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FavoriKitaplar_favKitapListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FavoriKitaplar_favKitapListeNo_seq" OWNER TO postgres;

--
-- Name: FavoriKitaplar_favKitapListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FavoriKitaplar_favKitapListeNo_seq" OWNED BY public."FavoriKitaplar"."favKitapListeNo";


--
-- Name: FavoriYazarlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FavoriYazarlar" (
    "favYazarListeNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL
);


ALTER TABLE public."FavoriYazarlar" OWNER TO postgres;

--
-- Name: FavoriYazarlar_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FavoriYazarlar_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FavoriYazarlar_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: FavoriYazarlar_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FavoriYazarlar_KullaniciNo_seq" OWNED BY public."FavoriYazarlar"."KullaniciNo";


--
-- Name: FavoriYazarlar_favYazarListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FavoriYazarlar_favYazarListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FavoriYazarlar_favYazarListeNo_seq" OWNER TO postgres;

--
-- Name: FavoriYazarlar_favYazarListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FavoriYazarlar_favYazarListeNo_seq" OWNED BY public."FavoriYazarlar"."favYazarListeNo";


--
-- Name: IstekKitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IstekKitap" (
    "istekListeNo" integer NOT NULL,
    "kitapNo" integer NOT NULL
);


ALTER TABLE public."IstekKitap" OWNER TO postgres;

--
-- Name: IstekKitap_istekListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IstekKitap_istekListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IstekKitap_istekListeNo_seq" OWNER TO postgres;

--
-- Name: IstekKitap_istekListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IstekKitap_istekListeNo_seq" OWNED BY public."IstekKitap"."istekListeNo";


--
-- Name: IstekKitap_kitapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IstekKitap_kitapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IstekKitap_kitapNo_seq" OWNER TO postgres;

--
-- Name: IstekKitap_kitapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IstekKitap_kitapNo_seq" OWNED BY public."IstekKitap"."kitapNo";


--
-- Name: IstekListesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IstekListesi" (
    "istekListeNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL
);


ALTER TABLE public."IstekListesi" OWNER TO postgres;

--
-- Name: IstekListesi_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IstekListesi_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IstekListesi_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: IstekListesi_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IstekListesi_KullaniciNo_seq" OWNED BY public."IstekListesi"."KullaniciNo";


--
-- Name: IstekListesi_istekListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IstekListesi_istekListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IstekListesi_istekListeNo_seq" OWNER TO postgres;

--
-- Name: IstekListesi_istekListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IstekListesi_istekListeNo_seq" OWNED BY public."IstekListesi"."istekListeNo";


--
-- Name: Kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kategori" (
    "kategoriNo" integer NOT NULL,
    tur character varying(10) NOT NULL
);


ALTER TABLE public."Kategori" OWNER TO postgres;

--
-- Name: Kategori_kategoriNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kategori_kategoriNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kategori_kategoriNo_seq" OWNER TO postgres;

--
-- Name: Kategori_kategoriNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kategori_kategoriNo_seq" OWNED BY public."Kategori"."kategoriNo";


--
-- Name: KitapFavori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapFavori" (
    "favKitapListeNo" integer NOT NULL,
    "kitapNo" integer NOT NULL
);


ALTER TABLE public."KitapFavori" OWNER TO postgres;

--
-- Name: KitapFavori_favKitapListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapFavori_favKitapListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapFavori_favKitapListeNo_seq" OWNER TO postgres;

--
-- Name: KitapFavori_favKitapListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapFavori_favKitapListeNo_seq" OWNED BY public."KitapFavori"."favKitapListeNo";


--
-- Name: KitapFavori_kitapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapFavori_kitapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapFavori_kitapNo_seq" OWNER TO postgres;

--
-- Name: KitapFavori_kitapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapFavori_kitapNo_seq" OWNED BY public."KitapFavori"."kitapNo";


--
-- Name: KitapKategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapKategori" (
    "kitapNo" integer NOT NULL,
    "kategoriNo" integer NOT NULL
);


ALTER TABLE public."KitapKategori" OWNER TO postgres;

--
-- Name: KitapKategori_kategoriNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapKategori_kategoriNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapKategori_kategoriNo_seq" OWNER TO postgres;

--
-- Name: KitapKategori_kategoriNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapKategori_kategoriNo_seq" OWNED BY public."KitapKategori"."kategoriNo";


--
-- Name: KitapKategori_kitapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapKategori_kitapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapKategori_kitapNo_seq" OWNER TO postgres;

--
-- Name: KitapKategori_kitapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapKategori_kitapNo_seq" OWNED BY public."KitapKategori"."kitapNo";


--
-- Name: KitapYazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapYazar" (
    "kitapNo" integer NOT NULL,
    "yazarNo" integer NOT NULL
);


ALTER TABLE public."KitapYazar" OWNER TO postgres;

--
-- Name: KitapYazar_kitapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapYazar_kitapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapYazar_kitapNo_seq" OWNER TO postgres;

--
-- Name: KitapYazar_kitapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapYazar_kitapNo_seq" OWNED BY public."KitapYazar"."kitapNo";


--
-- Name: KitapYazar_yazarNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapYazar_yazarNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapYazar_yazarNo_seq" OWNER TO postgres;

--
-- Name: KitapYazar_yazarNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapYazar_yazarNo_seq" OWNED BY public."KitapYazar"."yazarNo";


--
-- Name: kitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kitap (
    "kitapNo" integer NOT NULL,
    kitapadi character varying(30) NOT NULL,
    sayfasayisi integer NOT NULL,
    "basimYili" character(4) NOT NULL
);


ALTER TABLE public.kitap OWNER TO postgres;

--
-- Name: Kitap_kitapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kitap_kitapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kitap_kitapNo_seq" OWNER TO postgres;

--
-- Name: Kitap_kitapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kitap_kitapNo_seq" OWNED BY public.kitap."kitapNo";


--
-- Name: kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kullanici (
    adsoyad character varying(25) NOT NULL,
    sifre character varying(16) NOT NULL,
    email character varying(40) NOT NULL,
    favkitaplisteno integer NOT NULL,
    favyazarlisteno integer NOT NULL,
    isteklisteno integer NOT NULL,
    kullanicino integer NOT NULL
);


ALTER TABLE public.kullanici OWNER TO postgres;

--
-- Name: Kullanici_IstekListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kullanici_IstekListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kullanici_IstekListeNo_seq" OWNER TO postgres;

--
-- Name: Kullanici_IstekListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kullanici_IstekListeNo_seq" OWNED BY public.kullanici.isteklisteno;


--
-- Name: Kullanici_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kullanici_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kullanici_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: Kullanici_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kullanici_KullaniciNo_seq" OWNED BY public.kullanici.kullanicino;


--
-- Name: Kullanici_favKitapListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kullanici_favKitapListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kullanici_favKitapListeNo_seq" OWNER TO postgres;

--
-- Name: Kullanici_favKitapListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kullanici_favKitapListeNo_seq" OWNED BY public.kullanici.favkitaplisteno;


--
-- Name: Kullanici_favYazarListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kullanici_favYazarListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kullanici_favYazarListeNo_seq" OWNER TO postgres;

--
-- Name: Kullanici_favYazarListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kullanici_favYazarListeNo_seq" OWNED BY public.kullanici.favyazarlisteno;


--
-- Name: Mesaj; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Mesaj" (
    "mesajNo" integer NOT NULL,
    baslik character varying(25) NOT NULL,
    govde character varying(140) NOT NULL,
    tarih date
);


ALTER TABLE public."Mesaj" OWNER TO postgres;

--
-- Name: MesajKutusu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MesajKutusu" (
    "mesajNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL
);


ALTER TABLE public."MesajKutusu" OWNER TO postgres;

--
-- Name: MesajKutusu_mesajNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MesajKutusu_mesajNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MesajKutusu_mesajNo_seq" OWNER TO postgres;

--
-- Name: MesajKutusu_mesajNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MesajKutusu_mesajNo_seq" OWNED BY public."MesajKutusu"."mesajNo";


--
-- Name: Mesaj_mesajNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Mesaj_mesajNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Mesaj_mesajNo_seq" OWNER TO postgres;

--
-- Name: Mesaj_mesajNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Mesaj_mesajNo_seq" OWNED BY public."Mesaj"."mesajNo";


--
-- Name: Uye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Uye" (
    "KullaniciNo" integer NOT NULL
);


ALTER TABLE public."Uye" OWNER TO postgres;

--
-- Name: Uye_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Uye_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Uye_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: Uye_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Uye_KullaniciNo_seq" OWNED BY public."Uye"."KullaniciNo";


--
-- Name: Yazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yazar" (
    "yazarNo" integer NOT NULL,
    "adSoyad" character varying(25) NOT NULL
);


ALTER TABLE public."Yazar" OWNER TO postgres;

--
-- Name: YazarFavori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."YazarFavori" (
    "yazarNo" integer NOT NULL,
    "favYazarListeNo" integer NOT NULL
);


ALTER TABLE public."YazarFavori" OWNER TO postgres;

--
-- Name: YazarFavori_favYazarListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."YazarFavori_favYazarListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."YazarFavori_favYazarListeNo_seq" OWNER TO postgres;

--
-- Name: YazarFavori_favYazarListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."YazarFavori_favYazarListeNo_seq" OWNED BY public."YazarFavori"."favYazarListeNo";


--
-- Name: YazarFavori_yazarNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."YazarFavori_yazarNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."YazarFavori_yazarNo_seq" OWNER TO postgres;

--
-- Name: YazarFavori_yazarNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."YazarFavori_yazarNo_seq" OWNED BY public."YazarFavori"."yazarNo";


--
-- Name: Yazar_yazarNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Yazar_yazarNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Yazar_yazarNo_seq" OWNER TO postgres;

--
-- Name: Yazar_yazarNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Yazar_yazarNo_seq" OWNED BY public."Yazar"."yazarNo";


--
-- Name: Admin KullaniciNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin" ALTER COLUMN "KullaniciNo" SET DEFAULT nextval('public."Admin_KullaniciNo_seq"'::regclass);


--
-- Name: FavoriKitaplar favKitapListeNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriKitaplar" ALTER COLUMN "favKitapListeNo" SET DEFAULT nextval('public."FavoriKitaplar_favKitapListeNo_seq"'::regclass);


--
-- Name: FavoriYazarlar favYazarListeNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriYazarlar" ALTER COLUMN "favYazarListeNo" SET DEFAULT nextval('public."FavoriYazarlar_favYazarListeNo_seq"'::regclass);


--
-- Name: IstekListesi istekListeNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstekListesi" ALTER COLUMN "istekListeNo" SET DEFAULT nextval('public."IstekListesi_istekListeNo_seq"'::regclass);


--
-- Name: Kategori kategoriNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategori" ALTER COLUMN "kategoriNo" SET DEFAULT nextval('public."Kategori_kategoriNo_seq"'::regclass);


--
-- Name: Mesaj mesajNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Mesaj" ALTER COLUMN "mesajNo" SET DEFAULT nextval('public."Mesaj_mesajNo_seq"'::regclass);


--
-- Name: MesajKutusu mesajNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MesajKutusu" ALTER COLUMN "mesajNo" SET DEFAULT nextval('public."MesajKutusu_mesajNo_seq"'::regclass);


--
-- Name: Uye KullaniciNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye" ALTER COLUMN "KullaniciNo" SET DEFAULT nextval('public."Uye_KullaniciNo_seq"'::regclass);


--
-- Name: Yazar yazarNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar" ALTER COLUMN "yazarNo" SET DEFAULT nextval('public."Yazar_yazarNo_seq"'::regclass);


--
-- Name: kitap kitapNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitap ALTER COLUMN "kitapNo" SET DEFAULT nextval('public."Kitap_kitapNo_seq"'::regclass);


--
-- Name: kullanici kullanicino; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici ALTER COLUMN kullanicino SET DEFAULT nextval('public."Kullanici_KullaniciNo_seq"'::regclass);


--
-- Data for Name: Admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Admin" VALUES
	(2),
	(3),
	(4);


--
-- Data for Name: FavoriKitaplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."FavoriKitaplar" VALUES
	(1, 1),
	(2, 4),
	(3, 2),
	(5, 6),
	(6, 3),
	(4, 5),
	(0, 0);


--
-- Data for Name: FavoriYazarlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."FavoriYazarlar" VALUES
	(1, 1),
	(2, 1),
	(3, 3),
	(4, 2),
	(0, 0);


--
-- Data for Name: IstekKitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."IstekKitap" VALUES
	(1, 2),
	(2, 4),
	(3, 5),
	(4, 7);


--
-- Data for Name: IstekListesi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."IstekListesi" VALUES
	(1, 1),
	(2, 2),
	(3, 2),
	(4, 4),
	(0, 0);


--
-- Data for Name: Kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kategori" VALUES
	(1, 'Deneme'),
	(3, 'Siir'),
	(4, 'Gezi'),
	(2, 'Roman');


--
-- Data for Name: KitapFavori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KitapFavori" VALUES
	(1, 2),
	(2, 4),
	(3, 3),
	(4, 7),
	(5, 1),
	(6, 9);


--
-- Data for Name: KitapKategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KitapKategori" VALUES
	(4, 1),
	(1, 2),
	(2, 2),
	(3, 2),
	(6, 2),
	(7, 2),
	(8, 3),
	(5, 4);


--
-- Data for Name: KitapYazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KitapYazar" VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 3),
	(5, 3),
	(6, 2),
	(7, 2),
	(8, 2);


--
-- Data for Name: Mesaj; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Mesaj" VALUES
	(1, 'Hello World', 'System.out.println("Hello World!");', NULL),
	(2, 'Merhaba', 'Merhaba arkadaşım nasılsın ?', NULL),
	(3, 'Teşekkürler', 'Seni Sormalı ?', NULL);


--
-- Data for Name: MesajKutusu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."MesajKutusu" VALUES
	(1, 2),
	(2, 4),
	(3, 1);


--
-- Data for Name: Uye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Uye" VALUES
	(2),
	(3),
	(4);


--
-- Data for Name: Yazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yazar" VALUES
	(1, 'Dostoyevski'),
	(2, 'Turgut Uyar'),
	(3, 'Montaigne');


--
-- Data for Name: YazarFavori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."YazarFavori" VALUES
	(1, 2),
	(2, 4);


--
-- Data for Name: kitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kitap VALUES
	(1, 'Suc Ve Ceza', 600, '2006'),
	(2, 'insanciklar', 200, '2004'),
	(3, 'yer altindan notlar', 150, '1999'),
	(4, 'denemeler', 180, '2008'),
	(5, 'Yol Gunlugu', 130, '2011'),
	(6, 'Tutunamayanlar', 550, '2012'),
	(7, 'Veys', 335, '2019'),
	(8, 'Bir Siirden', 248, '2009'),
	(9, '1982', 513, '1982');


--
-- Data for Name: kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kullanici VALUES
	('Muhtar Kent', '213', 'muhtarkent@gmail.com', 3, 3, 3, 3),
	('Mehmet Öz', '132', 'mö@gmail.com', 4, 4, 4, 4),
	('boş', 'boş', 'boş', 0, 0, 0, 0),
	('ARİF MARDİN', '321', 'arifmardin@hotmail.com', 2, 2, 2, 2),
	('Zilan', '123', 'zilan@hotmail.com', 1, 1, 1, 7);


--
-- Name: Admin_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Admin_KullaniciNo_seq"', 2, true);


--
-- Name: FavoriKitaplar_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FavoriKitaplar_KullaniciNo_seq"', 6, true);


--
-- Name: FavoriKitaplar_favKitapListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FavoriKitaplar_favKitapListeNo_seq"', 6, true);


--
-- Name: FavoriYazarlar_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FavoriYazarlar_KullaniciNo_seq"', 1, true);


--
-- Name: FavoriYazarlar_favYazarListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FavoriYazarlar_favYazarListeNo_seq"', 4, true);


--
-- Name: IstekKitap_istekListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."IstekKitap_istekListeNo_seq"', 1, false);


--
-- Name: IstekKitap_kitapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."IstekKitap_kitapNo_seq"', 1, false);


--
-- Name: IstekListesi_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."IstekListesi_KullaniciNo_seq"', 1, false);


--
-- Name: IstekListesi_istekListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."IstekListesi_istekListeNo_seq"', 4, true);


--
-- Name: Kategori_kategoriNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kategori_kategoriNo_seq"', 1, false);


--
-- Name: KitapFavori_favKitapListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapFavori_favKitapListeNo_seq"', 1, false);


--
-- Name: KitapFavori_kitapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapFavori_kitapNo_seq"', 1, false);


--
-- Name: KitapKategori_kategoriNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapKategori_kategoriNo_seq"', 1, false);


--
-- Name: KitapKategori_kitapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapKategori_kitapNo_seq"', 1, false);


--
-- Name: KitapYazar_kitapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapYazar_kitapNo_seq"', 1, false);


--
-- Name: KitapYazar_yazarNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapYazar_yazarNo_seq"', 1, false);


--
-- Name: Kitap_kitapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kitap_kitapNo_seq"', 1, false);


--
-- Name: Kullanici_IstekListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_IstekListeNo_seq"', 1, false);


--
-- Name: Kullanici_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_KullaniciNo_seq"', 7, true);


--
-- Name: Kullanici_favKitapListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_favKitapListeNo_seq"', 1, false);


--
-- Name: Kullanici_favYazarListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_favYazarListeNo_seq"', 1, false);


--
-- Name: MesajKutusu_mesajNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MesajKutusu_mesajNo_seq"', 1, false);


--
-- Name: Mesaj_mesajNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Mesaj_mesajNo_seq"', 1, true);


--
-- Name: Uye_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Uye_KullaniciNo_seq"', 8, true);


--
-- Name: YazarFavori_favYazarListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."YazarFavori_favYazarListeNo_seq"', 1, false);


--
-- Name: YazarFavori_yazarNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."YazarFavori_yazarNo_seq"', 1, false);


--
-- Name: Yazar_yazarNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Yazar_yazarNo_seq"', 1, false);


--
-- Name: Admin Admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "Admin_pkey" PRIMARY KEY ("KullaniciNo");


--
-- Name: FavoriKitaplar FavoriKitaplar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriKitaplar"
    ADD CONSTRAINT "FavoriKitaplar_pkey" PRIMARY KEY ("favKitapListeNo");


--
-- Name: FavoriYazarlar FavoriYazarlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FavoriYazarlar"
    ADD CONSTRAINT "FavoriYazarlar_pkey" PRIMARY KEY ("favYazarListeNo");


--
-- Name: IstekKitap IstekKitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstekKitap"
    ADD CONSTRAINT "IstekKitap_pkey" PRIMARY KEY ("istekListeNo", "kitapNo");


--
-- Name: IstekListesi IstekListesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstekListesi"
    ADD CONSTRAINT "IstekListesi_pkey" PRIMARY KEY ("istekListeNo");


--
-- Name: Kategori Kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kategori"
    ADD CONSTRAINT "Kategori_pkey" PRIMARY KEY ("kategoriNo");


--
-- Name: KitapFavori KitapFavori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapFavori"
    ADD CONSTRAINT "KitapFavori_pkey" PRIMARY KEY ("favKitapListeNo", "kitapNo");


--
-- Name: KitapKategori KitapKategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapKategori"
    ADD CONSTRAINT "KitapKategori_pkey" PRIMARY KEY ("kategoriNo", "kitapNo");


--
-- Name: KitapYazar KitapYazar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapYazar"
    ADD CONSTRAINT "KitapYazar_pkey" PRIMARY KEY ("kitapNo", "yazarNo");


--
-- Name: kitap Kitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitap
    ADD CONSTRAINT "Kitap_pkey" PRIMARY KEY ("kitapNo");


--
-- Name: kullanici Kullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT "Kullanici_pkey" PRIMARY KEY (kullanicino);


--
-- Name: MesajKutusu MesajKutusu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MesajKutusu"
    ADD CONSTRAINT "MesajKutusu_pkey" PRIMARY KEY ("mesajNo");


--
-- Name: Mesaj Mesaj_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Mesaj"
    ADD CONSTRAINT "Mesaj_pkey" PRIMARY KEY ("mesajNo");


--
-- Name: Uye Uye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "Uye_pkey" PRIMARY KEY ("KullaniciNo");


--
-- Name: YazarFavori YazarFavori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarFavori"
    ADD CONSTRAINT "YazarFavori_pkey" PRIMARY KEY ("yazarNo", "favYazarListeNo");


--
-- Name: Yazar Yazar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar"
    ADD CONSTRAINT "Yazar_pkey" PRIMARY KEY ("yazarNo");


--
-- Name: Yazar isme_saygi; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER isme_saygi BEFORE INSERT ON public."Yazar" FOR EACH ROW EXECUTE FUNCTION public.isme_saygi();


--
-- Name: Mesaj last_seen; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER last_seen BEFORE INSERT ON public."Mesaj" FOR EACH ROW EXECUTE FUNCTION public.last_seen();


--
-- Name: Mesaj mesaji_temizle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER mesaji_temizle BEFORE INSERT ON public."Mesaj" FOR EACH ROW EXECUTE FUNCTION public.on_arka_bosalt();


--
-- Name: Mesaj message_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER message_stamp BEFORE INSERT OR UPDATE ON public."Mesaj" FOR EACH ROW EXECUTE FUNCTION public.message_stamp();


--
-- Name: KitapFavori lnk_FavoriKitaplar_KitapFavori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapFavori"
    ADD CONSTRAINT "lnk_FavoriKitaplar_KitapFavori" FOREIGN KEY ("favKitapListeNo") REFERENCES public."FavoriKitaplar"("favKitapListeNo") MATCH FULL;


--
-- Name: kullanici lnk_FavoriKitaplar_Kullanici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT "lnk_FavoriKitaplar_Kullanici" FOREIGN KEY (favkitaplisteno) REFERENCES public."FavoriKitaplar"("favKitapListeNo") MATCH FULL;


--
-- Name: YazarFavori lnk_FavoriYazarlar_YazarFavori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarFavori"
    ADD CONSTRAINT "lnk_FavoriYazarlar_YazarFavori" FOREIGN KEY ("favYazarListeNo") REFERENCES public."FavoriYazarlar"("favYazarListeNo") MATCH FULL;


--
-- Name: kullanici lnk_FavoriYazarlar_kullanici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT "lnk_FavoriYazarlar_kullanici" FOREIGN KEY (favyazarlisteno) REFERENCES public."FavoriYazarlar"("favYazarListeNo") MATCH FULL;


--
-- Name: IstekKitap lnk_IstekListesi_IstekKitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstekKitap"
    ADD CONSTRAINT "lnk_IstekListesi_IstekKitap" FOREIGN KEY ("istekListeNo") REFERENCES public."IstekListesi"("istekListeNo") MATCH FULL;


--
-- Name: kullanici lnk_IstekListesi_Kullanici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT "lnk_IstekListesi_Kullanici" FOREIGN KEY (isteklisteno) REFERENCES public."IstekListesi"("istekListeNo") MATCH FULL;


--
-- Name: KitapKategori lnk_Kategori_KitapKategori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapKategori"
    ADD CONSTRAINT "lnk_Kategori_KitapKategori" FOREIGN KEY ("kategoriNo") REFERENCES public."Kategori"("kategoriNo") MATCH FULL;


--
-- Name: IstekKitap lnk_Kitap_IstekKitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IstekKitap"
    ADD CONSTRAINT "lnk_Kitap_IstekKitap" FOREIGN KEY ("kitapNo") REFERENCES public.kitap("kitapNo") MATCH FULL;


--
-- Name: KitapFavori lnk_Kitap_KitapFavori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapFavori"
    ADD CONSTRAINT "lnk_Kitap_KitapFavori" FOREIGN KEY ("kitapNo") REFERENCES public.kitap("kitapNo") MATCH FULL;


--
-- Name: KitapKategori lnk_Kitap_KitapKategori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapKategori"
    ADD CONSTRAINT "lnk_Kitap_KitapKategori" FOREIGN KEY ("kitapNo") REFERENCES public.kitap("kitapNo") MATCH FULL;


--
-- Name: KitapYazar lnk_Kitap_KitapYazar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapYazar"
    ADD CONSTRAINT "lnk_Kitap_KitapYazar" FOREIGN KEY ("kitapNo") REFERENCES public.kitap("kitapNo") MATCH FULL;


--
-- Name: Admin lnk_Kullanici_Admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "lnk_Kullanici_Admin" FOREIGN KEY ("KullaniciNo") REFERENCES public.kullanici(kullanicino) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Uye lnk_Kullanici_Uye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "lnk_Kullanici_Uye" FOREIGN KEY ("KullaniciNo") REFERENCES public.kullanici(kullanicino) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MesajKutusu lnk_Mesaj_MesajKutusu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MesajKutusu"
    ADD CONSTRAINT "lnk_Mesaj_MesajKutusu" FOREIGN KEY ("mesajNo") REFERENCES public."Mesaj"("mesajNo") MATCH FULL;


--
-- Name: KitapYazar lnk_Yazar_KitapYazar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapYazar"
    ADD CONSTRAINT "lnk_Yazar_KitapYazar" FOREIGN KEY ("yazarNo") REFERENCES public."Yazar"("yazarNo") MATCH FULL;


--
-- Name: YazarFavori lnk_Yazar_YazarFavori; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YazarFavori"
    ADD CONSTRAINT "lnk_Yazar_YazarFavori" FOREIGN KEY ("yazarNo") REFERENCES public."Yazar"("yazarNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

