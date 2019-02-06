--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 11.1 (Ubuntu 11.1-3.pgdg16.04+1)

-- Started on 2019-02-06 13:25:22 GMT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 434 (class 1255 OID 24726)
-- Name: remove_html(character varying); Type: FUNCTION; Schema: public; Owner: simon
--

CREATE FUNCTION public.remove_html(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$ select regexp_replace((select regexp_replace((select regexp_replace((select regexp_replace((select regexp_replace((select regexp_replace($1, '<sup>TN</sup>', '', 'g')), '<sup>TM</sup>', '', 'g')), '&reg;', '', 'g')), '&PLUSMN;', '', 'g')), '(&)([A-Za-z]+)(;)', E'\\2', 'g')), E'</?\\s*[A-Za-z]+[^>]*>', '', 'g'); $_$;


ALTER FUNCTION public.remove_html(character varying) OWNER TO simon;

--
-- TOC entry 435 (class 1255 OID 24727)
-- Name: remove_newline(character varying); Type: FUNCTION; Schema: public; Owner: simon
--

CREATE FUNCTION public.remove_newline(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$select regexp_replace((select regexp_replace((select regexp_replace($1, '^[\n\r]+','','g')), '[\n\r]+$','','g')), '[\n\r]',' ','g');
$_$;


ALTER FUNCTION public.remove_newline(character varying) OWNER TO simon;

--
-- TOC entry 1511 (class 1255 OID 24728)
-- Name: textcat_all(text); Type: AGGREGATE; Schema: public; Owner: simon
--

CREATE AGGREGATE public.textcat_all(text) (
    SFUNC = textcat,
    STYPE = text,
    INITCOND = ''
);


ALTER AGGREGATE public.textcat_all(text) OWNER TO simon;

--
-- TOC entry 2591 (class 3602 OID 24729)
-- Name: pg; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: simon
--

CREATE TEXT SEARCH CONFIGURATION public.pg (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR asciiword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR word WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR hword_part WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR hword_asciipart WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR asciihword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR hword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION public.pg
    ADD MAPPING FOR uint WITH simple;


ALTER TEXT SEARCH CONFIGURATION public.pg OWNER TO simon;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 24730)
-- Name: accessory_protein; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.accessory_protein (
    object_id integer NOT NULL,
    full_name character varying(1000)
);


ALTER TABLE public.accessory_protein OWNER TO simon;

--
-- TOC entry 182 (class 1259 OID 24736)
-- Name: allele_allele_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.allele_allele_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.allele_allele_id_seq OWNER TO simon;

--
-- TOC entry 183 (class 1259 OID 24738)
-- Name: allele; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.allele (
    allele_id integer DEFAULT nextval('public.allele_allele_id_seq'::regclass) NOT NULL,
    accessions character varying(100) NOT NULL,
    species_id integer DEFAULT 2 NOT NULL,
    pubmed_ids character varying(200),
    ontology_id integer DEFAULT 1 NOT NULL,
    term_id character varying(100) NOT NULL,
    allelic_composition character varying(300),
    allele_symbol character varying(300),
    genetic_background character varying(300)
);


ALTER TABLE public.allele OWNER TO simon;

--
-- TOC entry 184 (class 1259 OID 24747)
-- Name: altered_expression_altered_expression_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.altered_expression_altered_expression_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.altered_expression_altered_expression_id_seq OWNER TO simon;

--
-- TOC entry 185 (class 1259 OID 24749)
-- Name: altered_expression; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.altered_expression (
    altered_expression_id integer DEFAULT nextval('public.altered_expression_altered_expression_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    description character varying(10000),
    species_id integer NOT NULL,
    tissue character varying(1000),
    technique character varying(500),
    description_vector tsvector,
    tissue_vector tsvector,
    technique_vector tsvector
);


ALTER TABLE public.altered_expression OWNER TO simon;

--
-- TOC entry 186 (class 1259 OID 24756)
-- Name: altered_expression_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.altered_expression_refs (
    altered_expression_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.altered_expression_refs OWNER TO simon;

--
-- TOC entry 187 (class 1259 OID 24759)
-- Name: analogue_cluster; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.analogue_cluster (
    ligand_id integer NOT NULL,
    cluster character varying(10) NOT NULL
);


ALTER TABLE public.analogue_cluster OWNER TO simon;

--
-- TOC entry 188 (class 1259 OID 24762)
-- Name: associated_protein_associated_protein_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.associated_protein_associated_protein_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.associated_protein_associated_protein_id_seq OWNER TO simon;

--
-- TOC entry 189 (class 1259 OID 24764)
-- Name: associated_protein; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.associated_protein (
    associated_protein_id integer DEFAULT nextval('public.associated_protein_associated_protein_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    name character varying(1000),
    type character varying(200) NOT NULL,
    associated_object_id integer,
    effect character varying(1000),
    name_vector tsvector
);


ALTER TABLE public.associated_protein OWNER TO simon;

--
-- TOC entry 190 (class 1259 OID 24771)
-- Name: associated_protein_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.associated_protein_refs (
    associated_protein_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.associated_protein_refs OWNER TO simon;

--
-- TOC entry 191 (class 1259 OID 24774)
-- Name: binding_partner_binding_partner_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.binding_partner_binding_partner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.binding_partner_binding_partner_id_seq OWNER TO simon;

--
-- TOC entry 192 (class 1259 OID 24776)
-- Name: binding_partner; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.binding_partner (
    binding_partner_id integer DEFAULT nextval('public.binding_partner_binding_partner_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    name character varying(300) NOT NULL,
    interaction character varying(200),
    effect character varying(2000),
    partner_object_id integer,
    name_vector tsvector,
    effect_vector tsvector,
    interaction_vector tsvector
);


ALTER TABLE public.binding_partner OWNER TO simon;

--
-- TOC entry 193 (class 1259 OID 24783)
-- Name: binding_partner_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.binding_partner_refs (
    binding_partner_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.binding_partner_refs OWNER TO simon;

--
-- TOC entry 194 (class 1259 OID 24786)
-- Name: catalytic_receptor; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.catalytic_receptor (
    object_id integer NOT NULL,
    rtk_class character varying(20)
);


ALTER TABLE public.catalytic_receptor OWNER TO simon;

--
-- TOC entry 195 (class 1259 OID 24789)
-- Name: celltype_assoc_celltype_assoc_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.celltype_assoc_celltype_assoc_id_seq
    START WITH 4617
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celltype_assoc_celltype_assoc_id_seq OWNER TO simon;

--
-- TOC entry 196 (class 1259 OID 24791)
-- Name: celltype_assoc; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.celltype_assoc (
    celltype_assoc_id integer DEFAULT nextval('public.celltype_assoc_celltype_assoc_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    immuno_celltype_id integer NOT NULL,
    comment character varying(500),
    comment_vector tsvector
);


ALTER TABLE public.celltype_assoc OWNER TO simon;

--
-- TOC entry 197 (class 1259 OID 24798)
-- Name: celltype_assoc_colist; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.celltype_assoc_colist (
    celltype_assoc_id integer NOT NULL,
    co_celltype_id integer NOT NULL,
    cellonto_id character varying(50)
);


ALTER TABLE public.celltype_assoc_colist OWNER TO simon;

--
-- TOC entry 4026 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN celltype_assoc_colist.cellonto_id; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.celltype_assoc_colist.cellonto_id IS 'Cell Ontology ID ';


--
-- TOC entry 198 (class 1259 OID 24801)
-- Name: celltype_assoc_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.celltype_assoc_refs (
    celltype_assoc_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.celltype_assoc_refs OWNER TO simon;

--
-- TOC entry 199 (class 1259 OID 24804)
-- Name: cellular_location_cellular_location_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.cellular_location_cellular_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cellular_location_cellular_location_id_seq OWNER TO simon;

--
-- TOC entry 200 (class 1259 OID 24806)
-- Name: cellular_location; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.cellular_location (
    cellular_location_id integer DEFAULT nextval('public.cellular_location_cellular_location_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    location character varying(500),
    technique character varying(500),
    comments character varying(1000)
);


ALTER TABLE public.cellular_location OWNER TO simon;

--
-- TOC entry 201 (class 1259 OID 24813)
-- Name: cellular_location_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.cellular_location_refs (
    cellular_location_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.cellular_location_refs OWNER TO simon;

--
-- TOC entry 202 (class 1259 OID 24816)
-- Name: chembl_cluster; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.chembl_cluster (
    object_id integer NOT NULL,
    chembl_id character varying(50) NOT NULL,
    cluster character varying(10) NOT NULL,
    cluster_family character varying(10) NOT NULL
);


ALTER TABLE public.chembl_cluster OWNER TO simon;

--
-- TOC entry 203 (class 1259 OID 24819)
-- Name: co_celltype_co_celltype_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.co_celltype_co_celltype_id_seq
    START WITH 4617
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.co_celltype_co_celltype_id_seq OWNER TO simon;

--
-- TOC entry 204 (class 1259 OID 24821)
-- Name: co_celltype; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.co_celltype (
    co_celltype_id integer DEFAULT nextval('public.co_celltype_co_celltype_id_seq'::regclass) NOT NULL,
    name character varying(1000) NOT NULL,
    definition character varying(1500) NOT NULL,
    last_modified date,
    type character varying(50) NOT NULL,
    cellonto_id character varying(50) NOT NULL,
    name_vector tsvector,
    definition_vector tsvector,
    cellonto_id_vector tsvector
);


ALTER TABLE public.co_celltype OWNER TO simon;

--
-- TOC entry 205 (class 1259 OID 24828)
-- Name: co_celltype_isa; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.co_celltype_isa (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);


ALTER TABLE public.co_celltype_isa OWNER TO simon;

--
-- TOC entry 206 (class 1259 OID 24831)
-- Name: co_celltype_relationship_co_celltype_rel_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.co_celltype_relationship_co_celltype_rel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.co_celltype_relationship_co_celltype_rel_id_seq OWNER TO simon;

--
-- TOC entry 207 (class 1259 OID 24833)
-- Name: co_celltype_relationship; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.co_celltype_relationship (
    co_celltype_rel_id integer DEFAULT nextval('public.co_celltype_relationship_co_celltype_rel_id_seq'::regclass) NOT NULL,
    co_celltype_id integer NOT NULL,
    relationship_id character varying(50) NOT NULL,
    type character varying(100)
);


ALTER TABLE public.co_celltype_relationship OWNER TO simon;

--
-- TOC entry 208 (class 1259 OID 24837)
-- Name: cofactor_cofactor_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.cofactor_cofactor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cofactor_cofactor_id_seq OWNER TO simon;

--
-- TOC entry 209 (class 1259 OID 24839)
-- Name: cofactor; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.cofactor (
    cofactor_id integer DEFAULT nextval('public.cofactor_cofactor_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    ligand_id integer,
    name character varying(1000),
    comments character varying(1000),
    in_iuphar boolean DEFAULT true NOT NULL,
    in_grac boolean DEFAULT false NOT NULL,
    name_vector tsvector
);


ALTER TABLE public.cofactor OWNER TO simon;

--
-- TOC entry 210 (class 1259 OID 24848)
-- Name: cofactor_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.cofactor_refs (
    cofactor_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.cofactor_refs OWNER TO simon;

--
-- TOC entry 211 (class 1259 OID 24851)
-- Name: committee; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.committee (
    committee_id integer NOT NULL,
    name character varying(1000) NOT NULL,
    description character varying(2000),
    family_id integer
);


ALTER TABLE public.committee OWNER TO simon;

--
-- TOC entry 212 (class 1259 OID 24857)
-- Name: committee_committee_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.committee_committee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.committee_committee_id_seq OWNER TO simon;

--
-- TOC entry 4027 (class 0 OID 0)
-- Dependencies: 212
-- Name: committee_committee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: simon
--

ALTER SEQUENCE public.committee_committee_id_seq OWNED BY public.committee.committee_id;


--
-- TOC entry 213 (class 1259 OID 24859)
-- Name: conductance_conductance_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.conductance_conductance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conductance_conductance_id_seq OWNER TO simon;

--
-- TOC entry 214 (class 1259 OID 24861)
-- Name: conductance; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.conductance (
    conductance_id integer DEFAULT nextval('public.conductance_conductance_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    overall_channel_conductance character varying(500),
    macroscopic_current_rectification character varying(100),
    single_channel_current_rectification character varying(100),
    species_id integer NOT NULL
);


ALTER TABLE public.conductance OWNER TO simon;

--
-- TOC entry 215 (class 1259 OID 24868)
-- Name: conductance_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.conductance_refs (
    conductance_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.conductance_refs OWNER TO simon;

--
-- TOC entry 216 (class 1259 OID 24871)
-- Name: conductance_states_conductance_states_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.conductance_states_conductance_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conductance_states_conductance_states_id_seq OWNER TO simon;

--
-- TOC entry 217 (class 1259 OID 24873)
-- Name: conductance_states; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.conductance_states (
    conductance_states_id integer DEFAULT nextval('public.conductance_states_conductance_states_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    receptor character varying(100) NOT NULL,
    state1_high double precision,
    state1_low double precision,
    state2_high double precision,
    state2_low double precision,
    state3_high double precision,
    state3_low double precision,
    state4_high double precision,
    state4_low double precision,
    state5_high double precision,
    state5_low double precision,
    state6_high double precision,
    state6_low double precision,
    most_frequent_state character varying(50)
);


ALTER TABLE public.conductance_states OWNER TO simon;

--
-- TOC entry 218 (class 1259 OID 24877)
-- Name: conductance_states_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.conductance_states_refs (
    conductance_states_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.conductance_states_refs OWNER TO simon;

--
-- TOC entry 219 (class 1259 OID 24880)
-- Name: contributor_contributor_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.contributor_contributor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contributor_contributor_id_seq OWNER TO simon;

--
-- TOC entry 220 (class 1259 OID 24882)
-- Name: contributor; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor (
    contributor_id integer DEFAULT nextval('public.contributor_contributor_id_seq'::regclass) NOT NULL,
    address text,
    email character varying(500),
    first_names character varying(500) NOT NULL,
    surname character varying(500) NOT NULL,
    suffix character varying(200),
    note character varying(1000),
    orcid character varying(100),
    country character varying(50),
    description character varying(1000),
    institution character varying(1000),
    name_vector tsvector
);


ALTER TABLE public.contributor OWNER TO simon;

--
-- TOC entry 221 (class 1259 OID 24889)
-- Name: contributor2committee; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor2committee (
    contributor_id integer NOT NULL,
    committee_id integer NOT NULL,
    role character varying(200),
    display_order integer
);


ALTER TABLE public.contributor2committee OWNER TO simon;

--
-- TOC entry 222 (class 1259 OID 24892)
-- Name: contributor2family; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor2family (
    contributor_id integer NOT NULL,
    family_id integer NOT NULL,
    role character varying(50),
    display_order integer,
    old_display_order integer
);


ALTER TABLE public.contributor2family OWNER TO simon;

--
-- TOC entry 223 (class 1259 OID 24895)
-- Name: contributor2intro; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor2intro (
    contributor_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer NOT NULL
);


ALTER TABLE public.contributor2intro OWNER TO simon;

--
-- TOC entry 224 (class 1259 OID 24898)
-- Name: contributor2object; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor2object (
    contributor_id integer NOT NULL,
    object_id integer NOT NULL,
    display_order integer
);


ALTER TABLE public.contributor2object OWNER TO simon;

--
-- TOC entry 225 (class 1259 OID 24901)
-- Name: contributor_copy; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor_copy (
    contributor_id integer,
    address text,
    email character varying(500),
    first_names character varying(500),
    surname character varying(500),
    suffix character varying(200),
    note character varying(1000),
    orcid character varying(100),
    country character varying(50),
    description character varying(1000),
    institution character varying(1000)
);


ALTER TABLE public.contributor_copy OWNER TO simon;

--
-- TOC entry 226 (class 1259 OID 24907)
-- Name: contributor_link; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.contributor_link (
    contributor_id integer NOT NULL,
    url character varying(500) NOT NULL
);


ALTER TABLE public.contributor_link OWNER TO simon;

--
-- TOC entry 227 (class 1259 OID 24910)
-- Name: coregulator_coregulator_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.coregulator_coregulator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coregulator_coregulator_id_seq OWNER TO simon;

--
-- TOC entry 228 (class 1259 OID 24912)
-- Name: coregulator; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.coregulator (
    coregulator_id integer DEFAULT nextval('public.coregulator_coregulator_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    activity character varying(500),
    specific boolean,
    ligand_dependent boolean DEFAULT false NOT NULL,
    af2_dependent boolean,
    comments character varying(2000),
    coregulator_gene_id integer,
    activity_vector tsvector,
    comments_vector tsvector
);


ALTER TABLE public.coregulator OWNER TO simon;

--
-- TOC entry 229 (class 1259 OID 24920)
-- Name: coregulator_gene_coregulator_gene_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.coregulator_gene_coregulator_gene_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coregulator_gene_coregulator_gene_id_seq OWNER TO simon;

--
-- TOC entry 230 (class 1259 OID 24922)
-- Name: coregulator_gene; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.coregulator_gene (
    coregulator_gene_id integer DEFAULT nextval('public.coregulator_gene_coregulator_gene_id_seq'::regclass) NOT NULL,
    primary_name character varying(300) NOT NULL,
    official_gene_id character varying(100),
    other_names character varying(1000),
    species_id integer NOT NULL,
    nursa_id character varying(100),
    comments character varying(2000),
    gene_long_name character varying(2000),
    primary_name_vector tsvector,
    other_names_vector tsvector,
    comments_vector tsvector,
    gene_long_name_vector tsvector
);


ALTER TABLE public.coregulator_gene OWNER TO simon;

--
-- TOC entry 231 (class 1259 OID 24929)
-- Name: coregulator_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.coregulator_refs (
    coregulator_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.coregulator_refs OWNER TO simon;

--
-- TOC entry 232 (class 1259 OID 24932)
-- Name: database_database_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.database_database_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.database_database_id_seq OWNER TO simon;

--
-- TOC entry 233 (class 1259 OID 24934)
-- Name: database; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.database (
    database_id integer DEFAULT nextval('public.database_database_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    url text,
    specialist boolean DEFAULT false NOT NULL,
    prefix character varying(100)
);


ALTER TABLE public.database OWNER TO simon;

--
-- TOC entry 234 (class 1259 OID 24942)
-- Name: database_link_database_link_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.database_link_database_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.database_link_database_link_id_seq OWNER TO simon;

--
-- TOC entry 235 (class 1259 OID 24944)
-- Name: database_link; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.database_link (
    database_link_id integer DEFAULT nextval('public.database_link_database_link_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    species_id integer DEFAULT 9 NOT NULL,
    database_id integer NOT NULL,
    placeholder character varying(100) NOT NULL
);


ALTER TABLE public.database_link OWNER TO simon;

--
-- TOC entry 236 (class 1259 OID 24949)
-- Name: deleted_family; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.deleted_family (
    family_id integer NOT NULL,
    name character varying(1000) NOT NULL,
    previous_names character varying(300),
    type character varying(25) NOT NULL,
    old_family_id integer,
    new_family_id integer
);


ALTER TABLE public.deleted_family OWNER TO simon;

--
-- TOC entry 237 (class 1259 OID 24955)
-- Name: discoverx; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.discoverx (
    cat_no character varying(100) NOT NULL,
    url character varying(500) NOT NULL,
    name character varying(500) NOT NULL,
    description character varying(1000) NOT NULL,
    species_id integer NOT NULL
);


ALTER TABLE public.discoverx OWNER TO simon;

--
-- TOC entry 238 (class 1259 OID 24961)
-- Name: disease_disease_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.disease_disease_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disease_disease_id_seq OWNER TO simon;

--
-- TOC entry 239 (class 1259 OID 24963)
-- Name: disease; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.disease (
    disease_id integer DEFAULT nextval('public.disease_disease_id_seq'::regclass) NOT NULL,
    name character varying(1000) NOT NULL,
    description text,
    type character varying(30) DEFAULT NULL::character varying,
    name_vector tsvector,
    description_vector tsvector
);


ALTER TABLE public.disease OWNER TO simon;

--
-- TOC entry 240 (class 1259 OID 24971)
-- Name: disease2category; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.disease2category (
    disease_id integer NOT NULL,
    disease_category_id integer NOT NULL,
    comment character varying(500)
);


ALTER TABLE public.disease2category OWNER TO simon;

--
-- TOC entry 241 (class 1259 OID 24977)
-- Name: disease2synonym_disease2synonym_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.disease2synonym_disease2synonym_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disease2synonym_disease2synonym_id_seq OWNER TO simon;

--
-- TOC entry 242 (class 1259 OID 24979)
-- Name: disease2synonym; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.disease2synonym (
    disease2synonym_id integer DEFAULT nextval('public.disease2synonym_disease2synonym_id_seq'::regclass) NOT NULL,
    disease_id integer NOT NULL,
    synonym character varying(1000) NOT NULL,
    synonym_vector tsvector
);


ALTER TABLE public.disease2synonym OWNER TO simon;

--
-- TOC entry 243 (class 1259 OID 24986)
-- Name: disease_category_disease_category_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.disease_category_disease_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disease_category_disease_category_id_seq OWNER TO simon;

--
-- TOC entry 244 (class 1259 OID 24988)
-- Name: disease_category; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.disease_category (
    disease_category_id integer DEFAULT nextval('public.disease_category_disease_category_id_seq'::regclass) NOT NULL,
    name character varying(1000) NOT NULL,
    description text
);


ALTER TABLE public.disease_category OWNER TO simon;

--
-- TOC entry 245 (class 1259 OID 24995)
-- Name: disease_database_link_disease_database_link_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.disease_database_link_disease_database_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disease_database_link_disease_database_link_id_seq OWNER TO simon;

--
-- TOC entry 246 (class 1259 OID 24997)
-- Name: disease_database_link; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.disease_database_link (
    disease_database_link_id integer DEFAULT nextval('public.disease_database_link_disease_database_link_id_seq'::regclass) NOT NULL,
    disease_id integer NOT NULL,
    database_id integer NOT NULL,
    placeholder character varying(100) NOT NULL
);


ALTER TABLE public.disease_database_link OWNER TO simon;

--
-- TOC entry 247 (class 1259 OID 25001)
-- Name: disease_synonym2database_link; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.disease_synonym2database_link (
    disease2synonym_id integer NOT NULL,
    disease_database_link_id integer NOT NULL
);


ALTER TABLE public.disease_synonym2database_link OWNER TO simon;

--
-- TOC entry 248 (class 1259 OID 25004)
-- Name: dna_binding_dna_binding_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.dna_binding_dna_binding_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dna_binding_dna_binding_id_seq OWNER TO simon;

--
-- TOC entry 249 (class 1259 OID 25006)
-- Name: dna_binding; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.dna_binding (
    dna_binding_id integer DEFAULT nextval('public.dna_binding_dna_binding_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    structure character varying(500),
    sequence character varying(100),
    response_element character varying(500),
    structure_vector tsvector,
    sequence_vector tsvector,
    response_element_vector tsvector
);


ALTER TABLE public.dna_binding OWNER TO simon;

--
-- TOC entry 250 (class 1259 OID 25013)
-- Name: dna_binding_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.dna_binding_refs (
    dna_binding_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.dna_binding_refs OWNER TO simon;

--
-- TOC entry 251 (class 1259 OID 25016)
-- Name: do_disease_do_disease_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.do_disease_do_disease_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.do_disease_do_disease_id_seq OWNER TO simon;

--
-- TOC entry 252 (class 1259 OID 25018)
-- Name: do_disease; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.do_disease (
    do_disease_id integer DEFAULT nextval('public.do_disease_do_disease_id_seq'::regclass) NOT NULL,
    term character varying(1000) NOT NULL,
    definition character varying(1500) NOT NULL,
    last_modified date,
    do_id character varying(50) NOT NULL
);


ALTER TABLE public.do_disease OWNER TO simon;

--
-- TOC entry 253 (class 1259 OID 25025)
-- Name: do_disease_isa; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.do_disease_isa (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);


ALTER TABLE public.do_disease_isa OWNER TO simon;

--
-- TOC entry 254 (class 1259 OID 25028)
-- Name: drug2disease; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.drug2disease (
    ligand_id integer NOT NULL,
    disease_id integer NOT NULL
);


ALTER TABLE public.drug2disease OWNER TO simon;

--
-- TOC entry 255 (class 1259 OID 25031)
-- Name: enzyme; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.enzyme (
    object_id integer NOT NULL
);


ALTER TABLE public.enzyme OWNER TO simon;

--
-- TOC entry 256 (class 1259 OID 25034)
-- Name: expression_experiment_expression_experiment_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.expression_experiment_expression_experiment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expression_experiment_expression_experiment_id_seq OWNER TO simon;

--
-- TOC entry 257 (class 1259 OID 25036)
-- Name: expression_experiment; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.expression_experiment (
    expression_experiment_id integer DEFAULT nextval('public.expression_experiment_expression_experiment_id_seq'::regclass) NOT NULL,
    description character varying(1000),
    technique character varying(100),
    species_id integer NOT NULL,
    baseline double precision NOT NULL
);


ALTER TABLE public.expression_experiment OWNER TO simon;

--
-- TOC entry 258 (class 1259 OID 25043)
-- Name: expression_level; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.expression_level (
    structural_info_id integer NOT NULL,
    tissue_id integer NOT NULL,
    expression_experiment_id integer NOT NULL,
    value double precision NOT NULL
);


ALTER TABLE public.expression_level OWNER TO simon;

--
-- TOC entry 259 (class 1259 OID 25046)
-- Name: expression_pathophysiology_expression_pathophysiology_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.expression_pathophysiology_expression_pathophysiology_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expression_pathophysiology_expression_pathophysiology_id_seq OWNER TO simon;

--
-- TOC entry 260 (class 1259 OID 25048)
-- Name: expression_pathophysiology; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.expression_pathophysiology (
    expression_pathophysiology_id integer DEFAULT nextval('public.expression_pathophysiology_expression_pathophysiology_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    change text,
    pathophysiology text,
    species_id integer NOT NULL,
    tissue character varying(1000),
    technique character varying(500),
    change_vector tsvector,
    tissue_vector tsvector,
    pathophysiology_vector tsvector,
    technique_vector tsvector
);


ALTER TABLE public.expression_pathophysiology OWNER TO simon;

--
-- TOC entry 261 (class 1259 OID 25055)
-- Name: expression_pathophysiology_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.expression_pathophysiology_refs (
    expression_pathophysiology_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.expression_pathophysiology_refs OWNER TO simon;

--
-- TOC entry 262 (class 1259 OID 25058)
-- Name: family_family_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.family_family_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_family_id_seq OWNER TO simon;

--
-- TOC entry 263 (class 1259 OID 25060)
-- Name: family; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.family (
    family_id integer DEFAULT nextval('public.family_family_id_seq'::regclass) NOT NULL,
    name character varying(1000) NOT NULL,
    last_modified date,
    old_family_id integer,
    type character varying(50) NOT NULL,
    display_order integer,
    annotation_status integer DEFAULT 5 NOT NULL,
    previous_names character varying(300),
    only_grac boolean,
    only_iuphar boolean,
    in_cgtp boolean DEFAULT false NOT NULL,
    name_vector tsvector,
    previous_names_vector tsvector
);


ALTER TABLE public.family OWNER TO simon;

--
-- TOC entry 264 (class 1259 OID 25069)
-- Name: functional_assay_functional_assay_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.functional_assay_functional_assay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.functional_assay_functional_assay_id_seq OWNER TO simon;

--
-- TOC entry 265 (class 1259 OID 25071)
-- Name: functional_assay; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.functional_assay (
    functional_assay_id integer DEFAULT nextval('public.functional_assay_functional_assay_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    description character varying(1000) NOT NULL,
    response_measured character varying(1000) NOT NULL,
    species_id integer NOT NULL,
    tissue character varying(1000) NOT NULL,
    description_vector tsvector,
    tissue_vector tsvector,
    response_vector tsvector
);


ALTER TABLE public.functional_assay OWNER TO simon;

--
-- TOC entry 266 (class 1259 OID 25078)
-- Name: functional_assay_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.functional_assay_refs (
    functional_assay_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.functional_assay_refs OWNER TO simon;

--
-- TOC entry 267 (class 1259 OID 25081)
-- Name: further_reading; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.further_reading (
    object_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.further_reading OWNER TO simon;

--
-- TOC entry 268 (class 1259 OID 25084)
-- Name: go_process_go_process_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.go_process_go_process_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.go_process_go_process_seq OWNER TO simon;

--
-- TOC entry 269 (class 1259 OID 25086)
-- Name: go_process; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.go_process (
    go_process_id integer DEFAULT nextval('public.go_process_go_process_seq'::regclass) NOT NULL,
    term character varying(1000) NOT NULL,
    definition character varying(1500) NOT NULL,
    last_modified date,
    annotation character varying(200) NOT NULL,
    go_id character varying(50) NOT NULL,
    term_vector tsvector,
    definition_vector tsvector,
    go_id_vector tsvector
);


ALTER TABLE public.go_process OWNER TO simon;

--
-- TOC entry 270 (class 1259 OID 25093)
-- Name: go_process_rel; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.go_process_rel (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);


ALTER TABLE public.go_process_rel OWNER TO simon;

--
-- TOC entry 271 (class 1259 OID 25096)
-- Name: gpcr; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.gpcr (
    object_id integer NOT NULL,
    class character varying(200),
    ligand character varying(500)
);


ALTER TABLE public.gpcr OWNER TO simon;

--
-- TOC entry 272 (class 1259 OID 25102)
-- Name: grac_family_text; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.grac_family_text (
    family_id integer NOT NULL,
    overview text,
    comments text,
    last_modified date,
    overview_vector tsvector,
    comments_vector tsvector
);


ALTER TABLE public.grac_family_text OWNER TO simon;

--
-- TOC entry 273 (class 1259 OID 25108)
-- Name: grac_functional_characteristics; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.grac_functional_characteristics (
    object_id integer NOT NULL,
    functional_characteristics text NOT NULL,
    functional_characteristics_vector tsvector
);


ALTER TABLE public.grac_functional_characteristics OWNER TO simon;

--
-- TOC entry 274 (class 1259 OID 25114)
-- Name: grac_further_reading; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.grac_further_reading (
    family_id integer NOT NULL,
    reference_id integer NOT NULL,
    key_ref boolean DEFAULT false NOT NULL
);


ALTER TABLE public.grac_further_reading OWNER TO simon;

--
-- TOC entry 275 (class 1259 OID 25118)
-- Name: grac_ligand_rank_potency_grac_ligand_rank_potency_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.grac_ligand_rank_potency_grac_ligand_rank_potency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grac_ligand_rank_potency_grac_ligand_rank_potency_id_seq OWNER TO simon;

--
-- TOC entry 276 (class 1259 OID 25120)
-- Name: grac_ligand_rank_potency; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.grac_ligand_rank_potency (
    grac_ligand_rank_potency_id integer DEFAULT nextval('public.grac_ligand_rank_potency_grac_ligand_rank_potency_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    description character varying(500) NOT NULL,
    rank_potency character varying(2000) NOT NULL,
    species_id integer NOT NULL,
    in_iuphar boolean DEFAULT true NOT NULL,
    rank_potency_vector tsvector
);


ALTER TABLE public.grac_ligand_rank_potency OWNER TO simon;

--
-- TOC entry 277 (class 1259 OID 25128)
-- Name: grac_ligand_rank_potency_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.grac_ligand_rank_potency_refs (
    grac_ligand_rank_potency_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.grac_ligand_rank_potency_refs OWNER TO simon;

--
-- TOC entry 278 (class 1259 OID 25131)
-- Name: grac_transduction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.grac_transduction (
    object_id integer NOT NULL,
    transduction character varying(1000) NOT NULL
);


ALTER TABLE public.grac_transduction OWNER TO simon;

--
-- TOC entry 279 (class 1259 OID 25137)
-- Name: grouping; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public."grouping" (
    group_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer DEFAULT 1 NOT NULL
);


ALTER TABLE public."grouping" OWNER TO simon;

--
-- TOC entry 4028 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE "grouping"; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON TABLE public."grouping" IS 'groups of families and groups of groups';


--
-- TOC entry 280 (class 1259 OID 25141)
-- Name: gtip2go_process; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.gtip2go_process (
    gtip_process_id integer NOT NULL,
    go_process_id integer NOT NULL,
    comment character varying(500),
    go_id character varying(15),
    go_term character varying(500)
);


ALTER TABLE public.gtip2go_process OWNER TO simon;

--
-- TOC entry 281 (class 1259 OID 25147)
-- Name: gtip_process_gtip_process_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.gtip_process_gtip_process_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gtip_process_gtip_process_seq OWNER TO simon;

--
-- TOC entry 282 (class 1259 OID 25149)
-- Name: gtip_process; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.gtip_process (
    gtip_process_id integer DEFAULT nextval('public.gtip_process_gtip_process_seq'::regclass) NOT NULL,
    term character varying(1000) NOT NULL,
    definition character varying(1500) NOT NULL,
    last_modified date,
    short_term character varying(500),
    anchor character varying(10),
    term_vector tsvector,
    definition_vector tsvector
);


ALTER TABLE public.gtip_process OWNER TO simon;

--
-- TOC entry 4029 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN gtip_process.short_term; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.gtip_process.short_term IS 'Short term for wbe display, may contain html';


--
-- TOC entry 4030 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN gtip_process.anchor; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.gtip_process.anchor IS 'very short text to use as link anchor on webpages';


--
-- TOC entry 283 (class 1259 OID 25156)
-- Name: hottopic_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.hottopic_refs (
    reference_id integer NOT NULL,
    type character varying(50) NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.hottopic_refs OWNER TO simon;

--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN hottopic_refs.reference_id; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.hottopic_refs.reference_id IS 'ID of reference from reference table';


--
-- TOC entry 284 (class 1259 OID 25159)
-- Name: immuno2co_celltype; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immuno2co_celltype (
    immuno_celltype_id integer NOT NULL,
    cellonto_id character varying(50) NOT NULL,
    comment character varying(500)
);


ALTER TABLE public.immuno2co_celltype OWNER TO simon;

--
-- TOC entry 285 (class 1259 OID 25165)
-- Name: immuno_celltype_immuno_celltype_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.immuno_celltype_immuno_celltype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.immuno_celltype_immuno_celltype_id_seq OWNER TO simon;

--
-- TOC entry 286 (class 1259 OID 25167)
-- Name: immuno_celltype; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immuno_celltype (
    immuno_celltype_id integer DEFAULT nextval('public.immuno_celltype_immuno_celltype_id_seq'::regclass) NOT NULL,
    term character varying(1000) NOT NULL,
    definition character varying(2500) NOT NULL,
    last_modified date,
    short_term character varying(500),
    term_vector tsvector,
    definition_vector tsvector
);


ALTER TABLE public.immuno_celltype OWNER TO simon;

--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN immuno_celltype.short_term; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.immuno_celltype.short_term IS 'Short name for celltype category, may contain html';


--
-- TOC entry 287 (class 1259 OID 25174)
-- Name: immuno_disease2ligand_immuno_disease2ligand_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.immuno_disease2ligand_immuno_disease2ligand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.immuno_disease2ligand_immuno_disease2ligand_id_seq OWNER TO simon;

--
-- TOC entry 288 (class 1259 OID 25176)
-- Name: immuno_disease2ligand; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immuno_disease2ligand (
    immuno_disease2ligand_id integer DEFAULT nextval('public.immuno_disease2ligand_immuno_disease2ligand_id_seq'::regclass) NOT NULL,
    ligand_id integer NOT NULL,
    disease_id integer,
    comment character varying(500),
    immuno boolean DEFAULT true,
    comment_vector tsvector
);


ALTER TABLE public.immuno_disease2ligand OWNER TO simon;

--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN immuno_disease2ligand.immuno; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.immuno_disease2ligand.immuno IS 'indicates if the association in relevant to immunopharmacology';


--
-- TOC entry 289 (class 1259 OID 25184)
-- Name: immuno_disease2ligand_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immuno_disease2ligand_refs (
    immuno_disease2ligand_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.immuno_disease2ligand_refs OWNER TO simon;

--
-- TOC entry 290 (class 1259 OID 25187)
-- Name: immuno_disease2object_immuno_disease2object_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.immuno_disease2object_immuno_disease2object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.immuno_disease2object_immuno_disease2object_id_seq OWNER TO simon;

--
-- TOC entry 291 (class 1259 OID 25189)
-- Name: immuno_disease2object; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immuno_disease2object (
    immuno_disease2object_id integer DEFAULT nextval('public.immuno_disease2object_immuno_disease2object_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    disease_id integer,
    comment character varying(500),
    immuno boolean DEFAULT true,
    comment_vector tsvector
);


ALTER TABLE public.immuno_disease2object OWNER TO simon;

--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN immuno_disease2object.immuno; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.immuno_disease2object.immuno IS 'Indicates if association is relevant to immunopharmacology';


--
-- TOC entry 292 (class 1259 OID 25197)
-- Name: immuno_disease2object_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immuno_disease2object_refs (
    immuno_disease2object_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.immuno_disease2object_refs OWNER TO simon;

--
-- TOC entry 293 (class 1259 OID 25200)
-- Name: immunopaedia2family; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immunopaedia2family (
    immunopaedia_case_id integer NOT NULL,
    family_id integer NOT NULL,
    section character varying(50) NOT NULL,
    url character varying(150),
    comment character varying(500)
);


ALTER TABLE public.immunopaedia2family OWNER TO simon;

--
-- TOC entry 294 (class 1259 OID 25206)
-- Name: immunopaedia2ligand; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immunopaedia2ligand (
    immunopaedia_case_id integer NOT NULL,
    ligand_id integer NOT NULL,
    section character varying(50) NOT NULL,
    url character varying(150),
    comment character varying(500)
);


ALTER TABLE public.immunopaedia2ligand OWNER TO simon;

--
-- TOC entry 295 (class 1259 OID 25212)
-- Name: immunopaedia2object; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immunopaedia2object (
    immunopaedia_case_id integer NOT NULL,
    object_id integer NOT NULL,
    section character varying(50) NOT NULL,
    url character varying(150),
    comment character varying(500)
);


ALTER TABLE public.immunopaedia2object OWNER TO simon;

--
-- TOC entry 296 (class 1259 OID 25218)
-- Name: immunopaedia_cases_immunopaedia_case_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.immunopaedia_cases_immunopaedia_case_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.immunopaedia_cases_immunopaedia_case_id_seq OWNER TO simon;

--
-- TOC entry 297 (class 1259 OID 25220)
-- Name: immunopaedia_cases; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.immunopaedia_cases (
    immunopaedia_case_id integer DEFAULT nextval('public.immunopaedia_cases_immunopaedia_case_id_seq'::regclass) NOT NULL,
    title character varying(1000) NOT NULL,
    url character varying(150) NOT NULL,
    last_modified date,
    short_title character varying(500)
);


ALTER TABLE public.immunopaedia_cases OWNER TO simon;

--
-- TOC entry 4035 (class 0 OID 0)
-- Dependencies: 297
-- Name: COLUMN immunopaedia_cases.short_title; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.immunopaedia_cases.short_title IS 'Short name for case study title, may contain html';


--
-- TOC entry 298 (class 1259 OID 25227)
-- Name: inn; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.inn (
    inn_number integer NOT NULL,
    inn character varying(500) NOT NULL,
    cas character varying(100),
    smiles text,
    smiles_salts_stripped text,
    inchi_key_salts_stripped character varying(500),
    nonisomeric_smiles_salts_stripped text,
    nonisomeric_inchi_key_salts_stripped character varying(500),
    neutralised_smiles text,
    neutralised_inchi_key character varying(500),
    neutralised_nonisomeric_smiles text,
    neutralised_nonisomeric_inchi_key character varying(500),
    inn_vector tsvector
);


ALTER TABLE public.inn OWNER TO simon;

--
-- TOC entry 299 (class 1259 OID 25233)
-- Name: interaction_interaction_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.interaction_interaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interaction_interaction_id_seq OWNER TO simon;

--
-- TOC entry 300 (class 1259 OID 25235)
-- Name: interaction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.interaction (
    interaction_id integer DEFAULT nextval('public.interaction_interaction_id_seq'::regclass) NOT NULL,
    ligand_id integer NOT NULL,
    object_id integer,
    type character varying(100) NOT NULL,
    action character varying(1000) NOT NULL,
    action_comment character varying(2000),
    species_id integer NOT NULL,
    endogenous boolean DEFAULT false NOT NULL,
    selective boolean DEFAULT false NOT NULL,
    use_dependent boolean,
    voltage_dependent boolean,
    affinity_units character varying(100) DEFAULT '-'::character varying,
    affinity_high double precision,
    affinity_median double precision,
    affinity_low double precision,
    concentration_range character varying(200),
    affinity_voltage_high real,
    affinity_voltage_median real,
    affinity_voltage_low real,
    affinity_physiological_voltage boolean,
    rank integer,
    selectivity character varying(100),
    original_affinity_low_nm double precision,
    original_affinity_median_nm double precision,
    original_affinity_high_nm double precision,
    original_affinity_units character varying(20),
    original_affinity_relation character varying(10),
    assay_description character varying(1000),
    assay_conditions character varying(1000),
    from_grac boolean DEFAULT false NOT NULL,
    only_grac boolean DEFAULT false NOT NULL,
    receptor_site character varying(300),
    ligand_context character varying(300),
    percent_activity double precision,
    assay_url character varying(500),
    primary_target boolean,
    target_ligand_id integer,
    whole_organism_assay boolean,
    hide boolean DEFAULT false NOT NULL,
    type_vector tsvector
);


ALTER TABLE public.interaction OWNER TO simon;

--
-- TOC entry 4036 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN interaction.hide; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.interaction.hide IS 'Boolean to determine if interaction should be hidden in the target detailed view. Default false';


--
-- TOC entry 301 (class 1259 OID 25248)
-- Name: interaction_affinity_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.interaction_affinity_refs (
    interaction_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.interaction_affinity_refs OWNER TO simon;

--
-- TOC entry 302 (class 1259 OID 25251)
-- Name: introduction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.introduction (
    family_id integer NOT NULL,
    text text NOT NULL,
    last_modified date,
    annotation_status integer DEFAULT 5 NOT NULL,
    no_contributor_list boolean DEFAULT true NOT NULL,
    intro_vector tsvector
);


ALTER TABLE public.introduction OWNER TO simon;

--
-- TOC entry 303 (class 1259 OID 25259)
-- Name: iuphar2discoverx; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.iuphar2discoverx (
    object_id integer NOT NULL,
    cat_no character varying(100) NOT NULL
);


ALTER TABLE public.iuphar2discoverx OWNER TO simon;

--
-- TOC entry 304 (class 1259 OID 25262)
-- Name: iuphar2tocris; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.iuphar2tocris (
    ligand_id integer NOT NULL,
    cat_no character varying(100) NOT NULL,
    exact boolean
);


ALTER TABLE public.iuphar2tocris OWNER TO simon;

--
-- TOC entry 305 (class 1259 OID 25265)
-- Name: lgic; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.lgic (
    object_id integer NOT NULL,
    ligand character varying(500),
    selectivity_comments text
);


ALTER TABLE public.lgic OWNER TO simon;

--
-- TOC entry 306 (class 1259 OID 25271)
-- Name: ligand_ligand_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.ligand_ligand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ligand_ligand_id_seq OWNER TO simon;

--
-- TOC entry 307 (class 1259 OID 25273)
-- Name: ligand; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand (
    ligand_id integer DEFAULT nextval('public.ligand_ligand_id_seq'::regclass) NOT NULL,
    name character varying(1000) NOT NULL,
    pubchem_sid bigint,
    radioactive boolean DEFAULT false NOT NULL,
    old_ligand_id integer,
    type character varying(50) DEFAULT 'Synthetic organic'::character varying NOT NULL,
    approved boolean,
    approved_source character varying(100),
    iupac_name character varying(1000),
    comments character varying(4000),
    withdrawn_drug boolean,
    verified boolean,
    abbreviation character varying(300),
    clinical_use text,
    mechanism_of_action text,
    absorption_distribution text,
    metabolism text,
    elimination text,
    popn_pharmacokinetics text,
    organ_function_impairment text,
    emc_url character varying(1000),
    drugs_url character varying(1000),
    ema_url character varying(1000),
    bioactivity_comments text,
    labelled boolean,
    in_gtip boolean,
    immuno_comments text,
    in_gtmp boolean,
    gtmp_comments text,
    name_vector tsvector,
    comments_vector tsvector,
    abbreviation_vector tsvector,
    clinical_use_vector tsvector,
    mechanism_of_action_vector tsvector,
    absorption_distribution_vector tsvector,
    metabolism_vector tsvector,
    elimination_vector tsvector,
    popn_pharmacokinetics_vector tsvector,
    organ_function_impairment_vector tsvector,
    bioactivity_comments_vector tsvector,
    immuno_comments_vector tsvector
);


ALTER TABLE public.ligand OWNER TO simon;

--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN ligand.immuno_comments; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.ligand.immuno_comments IS 'Comments for Guide to IMMUNOPHARMACOLOGY specific to ligand';


--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN ligand.gtmp_comments; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.ligand.gtmp_comments IS 'Comments for Guide to MALARIA PHARMACOLOGY specific to ligand';


--
-- TOC entry 308 (class 1259 OID 25282)
-- Name: ligand2family; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand2family (
    ligand_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer NOT NULL
);


ALTER TABLE public.ligand2family OWNER TO simon;

--
-- TOC entry 309 (class 1259 OID 25285)
-- Name: ligand2inn; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand2inn (
    ligand_id integer NOT NULL,
    inn_number integer NOT NULL
);


ALTER TABLE public.ligand2inn OWNER TO simon;

--
-- TOC entry 310 (class 1259 OID 25288)
-- Name: ligand2meshpharmacology; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand2meshpharmacology (
    ligand_id integer NOT NULL,
    mesh_term character varying(1000) NOT NULL,
    type character varying(100) NOT NULL
);


ALTER TABLE public.ligand2meshpharmacology OWNER TO simon;

--
-- TOC entry 311 (class 1259 OID 25294)
-- Name: ligand2subunit; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand2subunit (
    ligand_id integer NOT NULL,
    subunit_id integer NOT NULL
);


ALTER TABLE public.ligand2subunit OWNER TO simon;

--
-- TOC entry 312 (class 1259 OID 25297)
-- Name: ligand2synonym_ligand2synonym_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.ligand2synonym_ligand2synonym_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ligand2synonym_ligand2synonym_id_seq OWNER TO simon;

--
-- TOC entry 313 (class 1259 OID 25299)
-- Name: ligand2synonym; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand2synonym (
    ligand_id integer NOT NULL,
    synonym character varying(2000) NOT NULL,
    from_grac boolean DEFAULT false NOT NULL,
    ligand2synonym_id integer DEFAULT nextval('public.ligand2synonym_ligand2synonym_id_seq'::regclass) NOT NULL,
    display boolean DEFAULT true NOT NULL,
    synonym_vector tsvector
);


ALTER TABLE public.ligand2synonym OWNER TO simon;

--
-- TOC entry 314 (class 1259 OID 25308)
-- Name: ligand2synonym_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand2synonym_refs (
    ligand2synonym_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.ligand2synonym_refs OWNER TO simon;

--
-- TOC entry 315 (class 1259 OID 25311)
-- Name: ligand_cluster; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand_cluster (
    ligand_id integer NOT NULL,
    cluster character varying(100) NOT NULL,
    distance double precision NOT NULL,
    cluster_centre integer NOT NULL
);


ALTER TABLE public.ligand_cluster OWNER TO simon;

--
-- TOC entry 316 (class 1259 OID 25314)
-- Name: ligand_database_link_ligand_database_link_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.ligand_database_link_ligand_database_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ligand_database_link_ligand_database_link_id_seq OWNER TO simon;

--
-- TOC entry 317 (class 1259 OID 25316)
-- Name: ligand_database_link; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand_database_link (
    ligand_database_link_id integer DEFAULT nextval('public.ligand_database_link_ligand_database_link_id_seq'::regclass) NOT NULL,
    ligand_id integer NOT NULL,
    database_id integer NOT NULL,
    placeholder character varying(100) NOT NULL,
    source character varying(100),
    commercial boolean DEFAULT false,
    species_id integer DEFAULT 9 NOT NULL
);


ALTER TABLE public.ligand_database_link OWNER TO simon;

--
-- TOC entry 318 (class 1259 OID 25322)
-- Name: ligand_physchem; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand_physchem (
    ligand_id integer NOT NULL,
    hydrogen_bond_acceptors integer NOT NULL,
    hydrogen_bond_donors integer NOT NULL,
    rotatable_bonds_count integer NOT NULL,
    topological_polar_surface_area double precision NOT NULL,
    molecular_weight double precision NOT NULL,
    xlogp double precision NOT NULL,
    lipinski_s_rule_of_five integer NOT NULL
);


ALTER TABLE public.ligand_physchem OWNER TO simon;

--
-- TOC entry 319 (class 1259 OID 25325)
-- Name: ligand_physchem_public; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand_physchem_public (
    ligand_id integer NOT NULL,
    hydrogen_bond_acceptors integer NOT NULL,
    hydrogen_bond_donors integer NOT NULL,
    rotatable_bonds_count integer NOT NULL,
    topological_polar_surface_area double precision NOT NULL,
    molecular_weight double precision NOT NULL,
    xlogp double precision NOT NULL,
    lipinski_s_rule_of_five integer NOT NULL
);


ALTER TABLE public.ligand_physchem_public OWNER TO simon;

--
-- TOC entry 320 (class 1259 OID 25328)
-- Name: ligand_structure; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ligand_structure (
    ligand_id integer NOT NULL,
    isomeric_smiles text NOT NULL,
    isomeric_standard_inchi text,
    isomeric_standard_inchi_key character varying(300) NOT NULL,
    nonisomeric_smiles text NOT NULL,
    nonisomeric_standard_inchi text,
    nonisomeric_standard_inchi_key character varying(300) NOT NULL
);


ALTER TABLE public.ligand_structure OWNER TO simon;

--
-- TOC entry 321 (class 1259 OID 25334)
-- Name: list_ligand; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.list_ligand (
    object_id integer NOT NULL,
    ligand_id integer NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.list_ligand OWNER TO simon;

--
-- TOC entry 322 (class 1259 OID 25338)
-- Name: malaria_stage_malaria_stage_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.malaria_stage_malaria_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.malaria_stage_malaria_stage_id_seq OWNER TO simon;

--
-- TOC entry 323 (class 1259 OID 25340)
-- Name: malaria_stage; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.malaria_stage (
    malaria_stage_id integer DEFAULT nextval('public.malaria_stage_malaria_stage_id_seq'::regclass) NOT NULL,
    name character varying(300) NOT NULL,
    description character varying,
    short_name character varying(20)
);


ALTER TABLE public.malaria_stage OWNER TO simon;

--
-- TOC entry 324 (class 1259 OID 25347)
-- Name: malaria_stage2interaction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.malaria_stage2interaction (
    interaction_id integer NOT NULL,
    malaria_stage_id integer NOT NULL
);


ALTER TABLE public.malaria_stage2interaction OWNER TO simon;

--
-- TOC entry 325 (class 1259 OID 25350)
-- Name: multimer; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.multimer (
    object_id integer NOT NULL,
    subunit_specific_agents_comments text
);


ALTER TABLE public.multimer OWNER TO simon;

--
-- TOC entry 326 (class 1259 OID 25356)
-- Name: mutation_mutation_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.mutation_mutation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mutation_mutation_id_seq OWNER TO simon;

--
-- TOC entry 327 (class 1259 OID 25358)
-- Name: mutation; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.mutation (
    mutation_id integer DEFAULT nextval('public.mutation_mutation_id_seq'::regclass) NOT NULL,
    pathophysiology_id integer,
    object_id integer NOT NULL,
    type character varying(100) NOT NULL,
    amino_acid_change character varying(100),
    species_id integer NOT NULL,
    description character varying(1000),
    nucleotide_change character varying(100)
);


ALTER TABLE public.mutation OWNER TO simon;

--
-- TOC entry 328 (class 1259 OID 25365)
-- Name: mutation_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.mutation_refs (
    mutation_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.mutation_refs OWNER TO simon;

--
-- TOC entry 329 (class 1259 OID 25368)
-- Name: nhr; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.nhr (
    object_id integer NOT NULL,
    ligand character varying(500),
    binding_partner_comments text,
    coregulator_comments text,
    dna_binding_comments text,
    target_gene_comments text
);


ALTER TABLE public.nhr OWNER TO simon;

--
-- TOC entry 330 (class 1259 OID 25374)
-- Name: object_object_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.object_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.object_object_id_seq OWNER TO simon;

--
-- TOC entry 331 (class 1259 OID 25376)
-- Name: object; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.object (
    object_id integer DEFAULT nextval('public.object_object_id_seq'::regclass) NOT NULL,
    name character varying(1000) NOT NULL,
    last_modified date,
    comments text,
    structural_info_comments text,
    old_object_id integer,
    annotation_status integer DEFAULT 5 NOT NULL,
    only_iuphar boolean,
    grac_comments text,
    only_grac boolean,
    no_contributor_list boolean DEFAULT true NOT NULL,
    abbreviation character varying(100),
    systematic_name character varying(100),
    quaternary_structure_comments text,
    in_cgtp boolean DEFAULT false NOT NULL,
    in_gtip boolean DEFAULT false,
    gtip_comment text,
    in_gtmp boolean DEFAULT false,
    gtmp_comment text
);


ALTER TABLE public.object OWNER TO simon;

--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN object.in_gtip; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.object.in_gtip IS 'Flag to detect if object is in Guide to Immunpharmacology (gtip).';


--
-- TOC entry 4040 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN object.gtip_comment; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.object.gtip_comment IS 'Comments fields to capture early curator notes on GtoImmPdb targets';


--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN object.in_gtmp; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.object.in_gtmp IS 'Flag to detect if object is in Guide to Malaria Pharmacology (gtmp).';


--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN object.gtmp_comment; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.object.gtmp_comment IS 'Comments fields to capture curator notes on GtoMPdb targets';


--
-- TOC entry 332 (class 1259 OID 25388)
-- Name: object2celltype_object2celltype_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.object2celltype_object2celltype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.object2celltype_object2celltype_id_seq OWNER TO simon;

--
-- TOC entry 333 (class 1259 OID 25390)
-- Name: object2go_process; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.object2go_process (
    object_id integer NOT NULL,
    go_process_id integer NOT NULL,
    go_evidence character varying(5),
    comment character varying(500),
    comment_vector tsvector
);


ALTER TABLE public.object2go_process OWNER TO simon;

--
-- TOC entry 334 (class 1259 OID 25396)
-- Name: object2reaction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.object2reaction (
    object_id integer NOT NULL,
    reaction_id integer NOT NULL
);


ALTER TABLE public.object2reaction OWNER TO simon;

--
-- TOC entry 335 (class 1259 OID 25399)
-- Name: object_vectors; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.object_vectors (
    object_id integer NOT NULL,
    name tsvector,
    abbreviation tsvector,
    comments tsvector,
    grac_comments tsvector,
    gtip_comments tsvector,
    structural_info_comments tsvector,
    associated_proteins_comments tsvector,
    functional_assay_comments tsvector,
    tissue_distribution_comments tsvector,
    functions_comments tsvector,
    altered_expression_comments tsvector,
    expression_pathophysiology_comments tsvector,
    mutations_pathophysiology_comments tsvector,
    variants_comments tsvector,
    xenobiotic_expression_comments tsvector,
    antibody_comments tsvector,
    agonists_comments tsvector,
    antagonists_comments tsvector,
    allosteric_modulators_comments tsvector,
    activators_comments tsvector,
    inhibitors_comments tsvector,
    channel_blockers_comments tsvector,
    gating_inhibitors_comments tsvector,
    subunit_specific_agents_comments tsvector,
    selectivity_comments tsvector,
    voltage_dependence_comments tsvector,
    target_gene_comments tsvector,
    dna_binding_comments tsvector,
    coregulator_comments tsvector,
    binding_partner_comments tsvector
);


ALTER TABLE public.object_vectors OWNER TO simon;

--
-- TOC entry 336 (class 1259 OID 25405)
-- Name: ontology_ontology_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.ontology_ontology_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ontology_ontology_id_seq OWNER TO simon;

--
-- TOC entry 337 (class 1259 OID 25407)
-- Name: ontology; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ontology (
    ontology_id integer DEFAULT nextval('public.ontology_ontology_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    short_name character varying(100)
);


ALTER TABLE public.ontology OWNER TO simon;

--
-- TOC entry 338 (class 1259 OID 25411)
-- Name: ontology_term; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.ontology_term (
    ontology_id integer DEFAULT 1 NOT NULL,
    term_id character varying(100) NOT NULL,
    term character varying(1000),
    description character varying(3000)
);


ALTER TABLE public.ontology_term OWNER TO simon;

--
-- TOC entry 339 (class 1259 OID 25418)
-- Name: other_ic; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.other_ic (
    object_id integer NOT NULL,
    selectivity_comments text
);


ALTER TABLE public.other_ic OWNER TO simon;

--
-- TOC entry 340 (class 1259 OID 25424)
-- Name: other_protein; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.other_protein (
    object_id integer NOT NULL
);


ALTER TABLE public.other_protein OWNER TO simon;

--
-- TOC entry 341 (class 1259 OID 25427)
-- Name: pathophysiology_pathophysiology_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.pathophysiology_pathophysiology_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pathophysiology_pathophysiology_id_seq OWNER TO simon;

--
-- TOC entry 342 (class 1259 OID 25429)
-- Name: pathophysiology; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.pathophysiology (
    pathophysiology_id integer DEFAULT nextval('public.pathophysiology_pathophysiology_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    disease character varying(2000),
    role character varying(2000),
    drugs character varying(2000),
    side_effects character varying(2000),
    use character varying(2000),
    omim character varying(200),
    comments text,
    orphanet character varying(200),
    disease_id integer,
    role_vector tsvector,
    drugs_vector tsvector,
    side_effects_vector tsvector,
    use_vector tsvector,
    comments_vector tsvector
);


ALTER TABLE public.pathophysiology OWNER TO simon;

--
-- TOC entry 343 (class 1259 OID 25436)
-- Name: pathophysiology_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.pathophysiology_refs (
    pathophysiology_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.pathophysiology_refs OWNER TO simon;

--
-- TOC entry 344 (class 1259 OID 25439)
-- Name: pdb_structure_pdb_structure_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.pdb_structure_pdb_structure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pdb_structure_pdb_structure_id_seq OWNER TO simon;

--
-- TOC entry 345 (class 1259 OID 25441)
-- Name: pdb_structure; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.pdb_structure (
    pdb_structure_id integer DEFAULT nextval('public.pdb_structure_pdb_structure_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    ligand_id integer,
    endogenous boolean DEFAULT false NOT NULL,
    pdb_code character varying(4),
    description character varying(1000),
    resolution double precision,
    species_id integer NOT NULL,
    description_vector tsvector
);


ALTER TABLE public.pdb_structure OWNER TO simon;

--
-- TOC entry 346 (class 1259 OID 25449)
-- Name: pdb_structure_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.pdb_structure_refs (
    pdb_structure_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.pdb_structure_refs OWNER TO simon;

--
-- TOC entry 347 (class 1259 OID 25452)
-- Name: peptide; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.peptide (
    ligand_id integer NOT NULL,
    one_letter_seq text,
    three_letter_seq text,
    post_translational_modifications character varying(1000),
    chemical_modifications character varying(1000),
    medical_relevance character varying(2000)
);


ALTER TABLE public.peptide OWNER TO simon;

--
-- TOC entry 348 (class 1259 OID 25458)
-- Name: peptide_ligand_cluster; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.peptide_ligand_cluster (
    ligand_id integer NOT NULL,
    cluster character varying(10)
);


ALTER TABLE public.peptide_ligand_cluster OWNER TO simon;

--
-- TOC entry 349 (class 1259 OID 25461)
-- Name: peptide_ligand_sequence_cluster; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.peptide_ligand_sequence_cluster (
    ligand_id integer NOT NULL,
    cluster integer NOT NULL
);


ALTER TABLE public.peptide_ligand_sequence_cluster OWNER TO simon;

--
-- TOC entry 350 (class 1259 OID 25464)
-- Name: physiological_function_physiological_function_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.physiological_function_physiological_function_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.physiological_function_physiological_function_id_seq OWNER TO simon;

--
-- TOC entry 351 (class 1259 OID 25466)
-- Name: physiological_function; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.physiological_function (
    physiological_function_id integer DEFAULT nextval('public.physiological_function_physiological_function_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    description text NOT NULL,
    species_id integer NOT NULL,
    tissue text NOT NULL,
    description_vector tsvector,
    tissue_vector tsvector
);


ALTER TABLE public.physiological_function OWNER TO simon;

--
-- TOC entry 352 (class 1259 OID 25473)
-- Name: physiological_function_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.physiological_function_refs (
    physiological_function_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.physiological_function_refs OWNER TO simon;

--
-- TOC entry 353 (class 1259 OID 25476)
-- Name: precursor_precursor_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.precursor_precursor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.precursor_precursor_id_seq OWNER TO simon;

--
-- TOC entry 354 (class 1259 OID 25478)
-- Name: precursor; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.precursor (
    precursor_id integer DEFAULT nextval('public.precursor_precursor_id_seq'::regclass) NOT NULL,
    gene_name character varying(100),
    official_gene_id character varying(100),
    protein_name character varying(200),
    species_id integer NOT NULL,
    gene_long_name character varying(2000),
    protein_name_vector tsvector,
    gene_long_name_vector tsvector
);


ALTER TABLE public.precursor OWNER TO simon;

--
-- TOC entry 355 (class 1259 OID 25485)
-- Name: precursor2peptide; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.precursor2peptide (
    precursor_id integer NOT NULL,
    ligand_id integer NOT NULL
);


ALTER TABLE public.precursor2peptide OWNER TO simon;

--
-- TOC entry 356 (class 1259 OID 25488)
-- Name: precursor2synonym_precursor2synonym_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.precursor2synonym_precursor2synonym_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.precursor2synonym_precursor2synonym_id_seq OWNER TO simon;

--
-- TOC entry 357 (class 1259 OID 25490)
-- Name: precursor2synonym; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.precursor2synonym (
    precursor2synonym_id integer DEFAULT nextval('public.precursor2synonym_precursor2synonym_id_seq'::regclass) NOT NULL,
    precursor_id integer NOT NULL,
    synonym character varying(2000) NOT NULL,
    synonym_vector tsvector
);


ALTER TABLE public.precursor2synonym OWNER TO simon;

--
-- TOC entry 358 (class 1259 OID 25497)
-- Name: primary_regulator_primary_regulator_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.primary_regulator_primary_regulator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.primary_regulator_primary_regulator_id_seq OWNER TO simon;

--
-- TOC entry 359 (class 1259 OID 25499)
-- Name: primary_regulator; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.primary_regulator (
    primary_regulator_id integer DEFAULT nextval('public.primary_regulator_primary_regulator_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    name character varying(1000),
    regulatory_effect character varying(2000),
    regulator_object_id integer
);


ALTER TABLE public.primary_regulator OWNER TO simon;

--
-- TOC entry 360 (class 1259 OID 25506)
-- Name: primary_regulator_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.primary_regulator_refs (
    primary_regulator_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.primary_regulator_refs OWNER TO simon;

--
-- TOC entry 361 (class 1259 OID 25509)
-- Name: process_assoc_process_assoc_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.process_assoc_process_assoc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.process_assoc_process_assoc_id_seq OWNER TO simon;

--
-- TOC entry 362 (class 1259 OID 25511)
-- Name: process_assoc; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.process_assoc (
    object_id integer NOT NULL,
    gtip_process_id integer NOT NULL,
    comment character varying(500),
    direct_annotation boolean DEFAULT false NOT NULL,
    go_annotation integer DEFAULT 0 NOT NULL,
    process_assoc_id integer DEFAULT nextval('public.process_assoc_process_assoc_id_seq'::regclass) NOT NULL,
    comment_vector tsvector
);


ALTER TABLE public.process_assoc OWNER TO simon;

--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN process_assoc.go_annotation; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.process_assoc.go_annotation IS 'determines if annotation is from GO. 0 is no, 1 is yes, 2 is yes, but only with IEA evidence';


--
-- TOC entry 363 (class 1259 OID 25520)
-- Name: process_assoc_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.process_assoc_refs (
    process_assoc_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.process_assoc_refs OWNER TO simon;

--
-- TOC entry 364 (class 1259 OID 25523)
-- Name: prodrug; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.prodrug (
    prodrug_ligand_id integer NOT NULL,
    drug_ligand_id integer NOT NULL
);


ALTER TABLE public.prodrug OWNER TO simon;

--
-- TOC entry 365 (class 1259 OID 25526)
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_id_seq OWNER TO simon;

--
-- TOC entry 366 (class 1259 OID 25528)
-- Name: product; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.product (
    product_id integer DEFAULT nextval('public.product_product_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    ligand_id integer,
    name character varying(1000),
    endogenous boolean DEFAULT true NOT NULL,
    in_iuphar boolean DEFAULT true NOT NULL,
    in_grac boolean DEFAULT false NOT NULL,
    name_vector tsvector
);


ALTER TABLE public.product OWNER TO simon;

--
-- TOC entry 367 (class 1259 OID 25538)
-- Name: product_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.product_refs (
    product_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.product_refs OWNER TO simon;

--
-- TOC entry 368 (class 1259 OID 25541)
-- Name: reaction_reaction_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.reaction_reaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reaction_reaction_id_seq OWNER TO simon;

--
-- TOC entry 369 (class 1259 OID 25543)
-- Name: reaction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.reaction (
    reaction_id integer DEFAULT nextval('public.reaction_reaction_id_seq'::regclass) NOT NULL,
    ec_number character varying(50) NOT NULL,
    reaction character varying(3000)
);


ALTER TABLE public.reaction OWNER TO simon;

--
-- TOC entry 370 (class 1259 OID 25550)
-- Name: reaction_component_reaction_component_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.reaction_component_reaction_component_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reaction_component_reaction_component_id_seq OWNER TO simon;

--
-- TOC entry 371 (class 1259 OID 25552)
-- Name: reaction_mechanism_reaction_mechanism_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.reaction_mechanism_reaction_mechanism_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reaction_mechanism_reaction_mechanism_id_seq OWNER TO simon;

--
-- TOC entry 372 (class 1259 OID 25554)
-- Name: receptor2family; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.receptor2family (
    object_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer NOT NULL
);


ALTER TABLE public.receptor2family OWNER TO simon;

--
-- TOC entry 373 (class 1259 OID 25557)
-- Name: receptor2subunit; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.receptor2subunit (
    receptor_id integer NOT NULL,
    subunit_id integer NOT NULL,
    type character varying(200)
);


ALTER TABLE public.receptor2subunit OWNER TO simon;

--
-- TOC entry 374 (class 1259 OID 25560)
-- Name: receptor_basic; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.receptor_basic (
    object_id integer NOT NULL,
    list_comments character varying(1000),
    associated_proteins_comments text,
    functional_assay_comments text,
    tissue_distribution_comments text,
    functions_comments text,
    altered_expression_comments text,
    expression_pathophysiology_comments text,
    mutations_pathophysiology_comments text,
    variants_comments text,
    xenobiotic_expression_comments text,
    antibody_comments text,
    agonists_comments text,
    antagonists_comments text,
    allosteric_modulators_comments text,
    activators_comments text,
    inhibitors_comments text,
    channel_blockers_comments text,
    gating_inhibitors_comments text
);


ALTER TABLE public.receptor_basic OWNER TO simon;

--
-- TOC entry 375 (class 1259 OID 25566)
-- Name: reference_reference_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.reference_reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_reference_id_seq OWNER TO simon;

--
-- TOC entry 376 (class 1259 OID 25568)
-- Name: reference; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.reference (
    reference_id integer DEFAULT nextval('public.reference_reference_id_seq'::regclass) NOT NULL,
    type character varying(50) NOT NULL,
    title character varying(2000),
    article_title character varying(1000) NOT NULL,
    year smallint,
    issue character varying(50),
    volume character varying(50),
    pages character varying(50),
    publisher character varying(500),
    publisher_address character varying(2000),
    editors character varying(2000),
    pubmed_id bigint,
    isbn character varying(13),
    pub_status character varying(100),
    topics character varying(250),
    comments character varying(500),
    read boolean,
    useful boolean,
    website character varying(500),
    url character varying(2000),
    doi character varying(500),
    accessed date,
    modified date,
    patent_number character varying(250),
    priority date,
    publication date,
    authors text,
    assignee character varying(500),
    authors_vector tsvector,
    article_title_vector tsvector
);


ALTER TABLE public.reference OWNER TO simon;

--
-- TOC entry 377 (class 1259 OID 25575)
-- Name: reference2immuno; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.reference2immuno (
    reference_id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.reference2immuno OWNER TO simon;

--
-- TOC entry 4044 (class 0 OID 0)
-- Dependencies: 377
-- Name: COLUMN reference2immuno.reference_id; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.reference2immuno.reference_id IS 'ID of reference from reference table';


--
-- TOC entry 378 (class 1259 OID 25578)
-- Name: reference2ligand; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.reference2ligand (
    reference_id integer NOT NULL,
    ligand_id integer NOT NULL
);


ALTER TABLE public.reference2ligand OWNER TO simon;

--
-- TOC entry 379 (class 1259 OID 25581)
-- Name: screen_screen_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.screen_screen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.screen_screen_id_seq OWNER TO simon;

--
-- TOC entry 380 (class 1259 OID 25583)
-- Name: screen; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.screen (
    screen_id integer DEFAULT nextval('public.screen_screen_id_seq'::regclass) NOT NULL,
    name character varying(500) NOT NULL,
    description text,
    url character varying(1000),
    affinity_cut_off_nm integer,
    company_logo_filename character varying(250),
    technology_logo_filename character varying(250)
);


ALTER TABLE public.screen OWNER TO simon;

--
-- TOC entry 381 (class 1259 OID 25590)
-- Name: screen_interaction_screen_interaction_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.screen_interaction_screen_interaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.screen_interaction_screen_interaction_id_seq OWNER TO simon;

--
-- TOC entry 382 (class 1259 OID 25592)
-- Name: screen_interaction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.screen_interaction (
    screen_interaction_id integer DEFAULT nextval('public.screen_interaction_screen_interaction_id_seq'::regclass) NOT NULL,
    screen_id integer NOT NULL,
    ligand_id integer NOT NULL,
    object_id integer NOT NULL,
    type character varying(100) NOT NULL,
    action character varying(1000) NOT NULL,
    action_comment character varying(2000) NOT NULL,
    species_id integer NOT NULL,
    endogenous boolean DEFAULT false NOT NULL,
    affinity_units character varying(100) DEFAULT '-'::character varying NOT NULL,
    affinity_high double precision,
    affinity_median double precision,
    affinity_low double precision,
    concentration_range character varying(200),
    original_affinity_low_nm double precision,
    original_affinity_median_nm double precision,
    original_affinity_high_nm double precision,
    original_affinity_units character varying(20),
    original_affinity_relation character varying(10),
    assay_description character varying(1000),
    percent_activity double precision,
    assay_url character varying(500)
);


ALTER TABLE public.screen_interaction OWNER TO simon;

--
-- TOC entry 383 (class 1259 OID 25601)
-- Name: screen_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.screen_refs (
    screen_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.screen_refs OWNER TO simon;

--
-- TOC entry 384 (class 1259 OID 25604)
-- Name: selectivity_selectivity_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.selectivity_selectivity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.selectivity_selectivity_id_seq OWNER TO simon;

--
-- TOC entry 385 (class 1259 OID 25606)
-- Name: selectivity; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.selectivity (
    selectivity_id integer DEFAULT nextval('public.selectivity_selectivity_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    ion character varying(20) NOT NULL,
    conductance_high real,
    conductance_low real,
    conductance_median real,
    hide_conductance boolean,
    species_id integer NOT NULL
);


ALTER TABLE public.selectivity OWNER TO simon;

--
-- TOC entry 386 (class 1259 OID 25610)
-- Name: selectivity_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.selectivity_refs (
    selectivity_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.selectivity_refs OWNER TO simon;

--
-- TOC entry 387 (class 1259 OID 25613)
-- Name: species_species_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.species_species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.species_species_id_seq OWNER TO simon;

--
-- TOC entry 388 (class 1259 OID 25615)
-- Name: species; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.species (
    species_id integer DEFAULT nextval('public.species_species_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    short_name character varying(15) NOT NULL,
    scientific_name character varying(200),
    ncbi_taxonomy_id integer,
    comments text,
    description text
);


ALTER TABLE public.species OWNER TO simon;

--
-- TOC entry 4045 (class 0 OID 0)
-- Dependencies: 388
-- Name: COLUMN species.description; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON COLUMN public.species.description IS 'Detailed description of the species for display on species page - added for MMV';


--
-- TOC entry 389 (class 1259 OID 25622)
-- Name: specific_reaction_specific_reaction_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.specific_reaction_specific_reaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.specific_reaction_specific_reaction_id_seq OWNER TO simon;

--
-- TOC entry 390 (class 1259 OID 25624)
-- Name: specific_reaction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.specific_reaction (
    specific_reaction_id integer DEFAULT nextval('public.specific_reaction_specific_reaction_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    reaction_id integer NOT NULL,
    description character varying(1000),
    reaction character varying(3000) NOT NULL
);


ALTER TABLE public.specific_reaction OWNER TO simon;

--
-- TOC entry 4046 (class 0 OID 0)
-- Dependencies: 390
-- Name: TABLE specific_reaction; Type: COMMENT; Schema: public; Owner: simon
--

COMMENT ON TABLE public.specific_reaction IS 'provides a place to enter specific forms of reactions described by EC numbers, e.g. with different chemical substrates/products';


--
-- TOC entry 391 (class 1259 OID 25631)
-- Name: specific_reaction_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.specific_reaction_refs (
    specific_reaction_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.specific_reaction_refs OWNER TO simon;

--
-- TOC entry 392 (class 1259 OID 25634)
-- Name: structural_info_structural_info_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.structural_info_structural_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structural_info_structural_info_id_seq OWNER TO simon;

--
-- TOC entry 393 (class 1259 OID 25636)
-- Name: structural_info; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.structural_info (
    structural_info_id integer DEFAULT nextval('public.structural_info_structural_info_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    transmembrane_domains integer,
    amino_acids integer,
    pore_loops integer,
    genomic_location character varying(50),
    gene_name character varying(100),
    official_gene_id character varying(100),
    molecular_weight integer,
    gene_long_name character varying(2000),
    gene_long_name_vector tsvector
);


ALTER TABLE public.structural_info OWNER TO simon;

--
-- TOC entry 394 (class 1259 OID 25643)
-- Name: structural_info_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.structural_info_refs (
    structural_info_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.structural_info_refs OWNER TO simon;

--
-- TOC entry 395 (class 1259 OID 25646)
-- Name: subcommittee; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.subcommittee (
    contributor_id integer NOT NULL,
    family_id integer NOT NULL,
    role character varying(50),
    display_order integer NOT NULL
);


ALTER TABLE public.subcommittee OWNER TO simon;

--
-- TOC entry 396 (class 1259 OID 25649)
-- Name: substrate_substrate_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.substrate_substrate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.substrate_substrate_id_seq OWNER TO simon;

--
-- TOC entry 397 (class 1259 OID 25651)
-- Name: substrate; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.substrate (
    substrate_id integer DEFAULT nextval('public.substrate_substrate_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    ligand_id integer,
    property character varying(20) DEFAULT '-'::character varying NOT NULL,
    value double precision,
    units character varying(100),
    assay_description character varying(1000),
    assay_conditions character varying(1000),
    comments character varying(1000),
    name character varying(1000),
    endogenous boolean DEFAULT true NOT NULL,
    in_iuphar boolean DEFAULT true NOT NULL,
    in_grac boolean DEFAULT false NOT NULL,
    standard_property character varying(100) DEFAULT '-'::character varying,
    standard_value double precision,
    name_vector tsvector
);


ALTER TABLE public.substrate OWNER TO simon;

--
-- TOC entry 398 (class 1259 OID 25663)
-- Name: substrate_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.substrate_refs (
    substrate_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.substrate_refs OWNER TO simon;

--
-- TOC entry 399 (class 1259 OID 25666)
-- Name: synonym_synonym_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.synonym_synonym_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.synonym_synonym_id_seq OWNER TO simon;

--
-- TOC entry 400 (class 1259 OID 25668)
-- Name: synonym; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.synonym (
    synonym_id integer DEFAULT nextval('public.synonym_synonym_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    synonym character varying(2000) NOT NULL,
    display boolean DEFAULT true NOT NULL,
    from_grac boolean DEFAULT false NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    synonym_vector tsvector
);


ALTER TABLE public.synonym OWNER TO simon;

--
-- TOC entry 401 (class 1259 OID 25678)
-- Name: synonym_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.synonym_refs (
    synonym_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.synonym_refs OWNER TO simon;

--
-- TOC entry 402 (class 1259 OID 25681)
-- Name: target_gene_target_gene_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.target_gene_target_gene_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.target_gene_target_gene_id_seq OWNER TO simon;

--
-- TOC entry 403 (class 1259 OID 25683)
-- Name: target_gene; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.target_gene (
    target_gene_id integer DEFAULT nextval('public.target_gene_target_gene_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    description character varying(1000),
    official_gene_id character varying(100),
    effect character varying(300),
    technique character varying(500),
    comments character varying(2000),
    description_vector tsvector,
    effect_vector tsvector,
    technique_vector tsvector,
    comments_vector tsvector
);


ALTER TABLE public.target_gene OWNER TO simon;

--
-- TOC entry 404 (class 1259 OID 25690)
-- Name: target_gene_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.target_gene_refs (
    target_gene_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.target_gene_refs OWNER TO simon;

--
-- TOC entry 405 (class 1259 OID 25693)
-- Name: target_ligand_same_entity; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.target_ligand_same_entity (
    object_id integer NOT NULL,
    ligand_id integer NOT NULL
);


ALTER TABLE public.target_ligand_same_entity OWNER TO simon;

--
-- TOC entry 406 (class 1259 OID 25696)
-- Name: tissue_tissue_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.tissue_tissue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tissue_tissue_id_seq OWNER TO simon;

--
-- TOC entry 407 (class 1259 OID 25698)
-- Name: tissue; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.tissue (
    tissue_id integer DEFAULT nextval('public.tissue_tissue_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.tissue OWNER TO simon;

--
-- TOC entry 408 (class 1259 OID 25702)
-- Name: tissue_distribution_tissue_distribution_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.tissue_distribution_tissue_distribution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tissue_distribution_tissue_distribution_id_seq OWNER TO simon;

--
-- TOC entry 409 (class 1259 OID 25704)
-- Name: tissue_distribution; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.tissue_distribution (
    tissue_distribution_id integer DEFAULT nextval('public.tissue_distribution_tissue_distribution_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    tissues character varying(10000) NOT NULL,
    species_id integer NOT NULL,
    technique character varying(1000),
    expression_level integer,
    tissues_vector tsvector,
    technique_vector tsvector
);


ALTER TABLE public.tissue_distribution OWNER TO simon;

--
-- TOC entry 410 (class 1259 OID 25711)
-- Name: tissue_distribution_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.tissue_distribution_refs (
    tissue_distribution_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.tissue_distribution_refs OWNER TO simon;

--
-- TOC entry 411 (class 1259 OID 25714)
-- Name: tocris; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.tocris (
    cat_no character varying(100) NOT NULL,
    url character varying(500) NOT NULL,
    name character varying(1000),
    smiles character varying(2000),
    pubchem_cid character varying(100)
);


ALTER TABLE public.tocris OWNER TO simon;

--
-- TOC entry 412 (class 1259 OID 25720)
-- Name: transduction_transduction_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.transduction_transduction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transduction_transduction_id_seq OWNER TO simon;

--
-- TOC entry 413 (class 1259 OID 25722)
-- Name: transduction; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.transduction (
    transduction_id integer DEFAULT nextval('public.transduction_transduction_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    secondary boolean NOT NULL,
    t01 boolean DEFAULT false NOT NULL,
    t02 boolean DEFAULT false NOT NULL,
    t03 boolean DEFAULT false NOT NULL,
    t04 boolean DEFAULT false NOT NULL,
    t05 boolean DEFAULT false NOT NULL,
    t06 boolean DEFAULT false NOT NULL,
    e01 boolean DEFAULT false NOT NULL,
    e02 boolean DEFAULT false NOT NULL,
    e03 boolean DEFAULT false NOT NULL,
    e04 boolean DEFAULT false NOT NULL,
    e05 boolean DEFAULT false NOT NULL,
    e06 boolean DEFAULT false NOT NULL,
    e07 boolean DEFAULT false NOT NULL,
    e08 boolean DEFAULT false NOT NULL,
    e09 boolean DEFAULT false NOT NULL,
    comments character varying(10000),
    comments_vector tsvector
);


ALTER TABLE public.transduction OWNER TO simon;

--
-- TOC entry 414 (class 1259 OID 25744)
-- Name: transduction_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.transduction_refs (
    transduction_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.transduction_refs OWNER TO simon;

--
-- TOC entry 415 (class 1259 OID 25747)
-- Name: transporter; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.transporter (
    object_id integer NOT NULL,
    grac_stoichiometry character varying(1000),
    grac_stoichiometry_vector tsvector
);


ALTER TABLE public.transporter OWNER TO simon;

--
-- TOC entry 416 (class 1259 OID 25753)
-- Name: variant_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.variant_variant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variant_variant_id_seq OWNER TO simon;

--
-- TOC entry 417 (class 1259 OID 25755)
-- Name: variant; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.variant (
    variant_id integer DEFAULT nextval('public.variant_variant_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    description character varying(2000),
    type character varying(100),
    species_id integer NOT NULL,
    amino_acids integer,
    amino_acid_change character varying(500),
    validation character varying(1000),
    global_maf character varying(100),
    subpop_maf character varying(1000),
    minor_allele_count character varying(500),
    frequency_comment character varying(1000),
    nucleotide_change character varying(500),
    description_vector tsvector
);


ALTER TABLE public.variant OWNER TO simon;

--
-- TOC entry 418 (class 1259 OID 25762)
-- Name: variant2database_link; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.variant2database_link (
    variant_id integer NOT NULL,
    database_link_id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.variant2database_link OWNER TO simon;

--
-- TOC entry 419 (class 1259 OID 25765)
-- Name: variant_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.variant_refs (
    variant_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.variant_refs OWNER TO simon;

--
-- TOC entry 420 (class 1259 OID 25768)
-- Name: version; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.version (
    version_number character varying(100) NOT NULL,
    publish_date date
);


ALTER TABLE public.version OWNER TO simon;

--
-- TOC entry 421 (class 1259 OID 25771)
-- Name: vgic; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.vgic (
    object_id integer NOT NULL,
    physiological_ion character varying(100),
    selectivity_comments text,
    voltage_dependence_comments text
);


ALTER TABLE public.vgic OWNER TO simon;

--
-- TOC entry 422 (class 1259 OID 25777)
-- Name: voltage_dep_activation_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.voltage_dep_activation_refs (
    voltage_dependence_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.voltage_dep_activation_refs OWNER TO simon;

--
-- TOC entry 423 (class 1259 OID 25780)
-- Name: voltage_dep_deactivation_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.voltage_dep_deactivation_refs (
    voltage_dependence_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.voltage_dep_deactivation_refs OWNER TO simon;

--
-- TOC entry 424 (class 1259 OID 25783)
-- Name: voltage_dep_inactivation_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.voltage_dep_inactivation_refs (
    voltage_dependence_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.voltage_dep_inactivation_refs OWNER TO simon;

--
-- TOC entry 425 (class 1259 OID 25786)
-- Name: voltage_dependence_voltage_dependence_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.voltage_dependence_voltage_dependence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voltage_dependence_voltage_dependence_id_seq OWNER TO simon;

--
-- TOC entry 426 (class 1259 OID 25788)
-- Name: voltage_dependence; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.voltage_dependence (
    voltage_dependence_id integer DEFAULT nextval('public.voltage_dependence_voltage_dependence_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    cell_type character varying(500) NOT NULL,
    comments text,
    activation_v_high double precision,
    activation_v_median double precision,
    activation_v_low double precision,
    activation_t_high double precision,
    activation_t_low double precision,
    inactivation_v_high double precision,
    inactivation_v_median double precision,
    inactivation_v_low double precision,
    inactivation_t_high double precision,
    inactivation_t_low double precision,
    deactivation_v_high double precision,
    deactivation_v_median double precision,
    deactivation_v_low double precision,
    deactivation_t_high double precision,
    deactivation_t_low double precision,
    species_id integer NOT NULL,
    cell_type_vector tsvector,
    comments_vector tsvector
);


ALTER TABLE public.voltage_dependence OWNER TO simon;

--
-- TOC entry 427 (class 1259 OID 25795)
-- Name: vw_interaction_summary; Type: VIEW; Schema: public; Owner: simon
--

CREATE VIEW public.vw_interaction_summary AS
 SELECT interaction.ligand_id,
    interaction.object_id,
    interaction.target_ligand_id,
    interaction.primary_target,
    interaction.species_id,
    interaction.type,
    interaction.action,
    interaction.affinity_units,
    GREATEST(max(interaction.affinity_high), max(interaction.affinity_median), max(interaction.affinity_low)) AS affinity_high,
    LEAST(min(interaction.affinity_high), min(interaction.affinity_median), min(interaction.affinity_low)) AS affinity_low,
    NULLIF((interaction.ligand_context)::text, ''::text) AS ligand_context,
    array_agg(interaction.interaction_id) AS interaction_ids
   FROM public.interaction
  GROUP BY interaction.object_id, interaction.target_ligand_id, interaction.type, interaction.action, interaction.species_id, interaction.affinity_units, NULLIF((interaction.ligand_context)::text, ''::text), interaction.ligand_id, interaction.primary_target;


ALTER TABLE public.vw_interaction_summary OWNER TO simon;

--
-- TOC entry 428 (class 1259 OID 25800)
-- Name: vw_ligand_display_synonyms; Type: VIEW; Schema: public; Owner: simon
--

CREATE VIEW public.vw_ligand_display_synonyms AS
 SELECT ls.ligand_id,
    string_agg((ls.synonym)::text, '|'::text) AS synonyms
   FROM public.ligand2synonym ls,
    public.ligand l
  WHERE ((ls.display IS TRUE) AND ((ls.synonym)::text <> (l.name)::text) AND (ls.ligand_id = l.ligand_id))
  GROUP BY ls.ligand_id;


ALTER TABLE public.vw_ligand_display_synonyms OWNER TO simon;

--
-- TOC entry 429 (class 1259 OID 25804)
-- Name: vw_ligand_peptide_species_ids; Type: VIEW; Schema: public; Owner: simon
--

CREATE VIEW public.vw_ligand_peptide_species_ids AS
 SELECT DISTINCT p2p.ligand_id,
    p.species_id
   FROM public.precursor2peptide p2p,
    public.precursor p
  WHERE ((p2p.precursor_id = p.precursor_id) AND (p.species_id <> 9))
UNION
 SELECT DISTINCT ls.ligand_id,
    p.species_id
   FROM public.precursor2peptide p2p,
    public.precursor p,
    public.ligand2subunit ls
  WHERE ((p2p.precursor_id = p.precursor_id) AND (p2p.ligand_id = ls.subunit_id) AND (p.species_id <> 9))
  ORDER BY 1, 2;


ALTER TABLE public.vw_ligand_peptide_species_ids OWNER TO simon;

--
-- TOC entry 430 (class 1259 OID 25808)
-- Name: vw_ligand_peptide_species; Type: VIEW; Schema: public; Owner: simon
--

CREATE VIEW public.vw_ligand_peptide_species AS
 SELECT v.ligand_id,
    string_agg((( SELECT DISTINCT s.name
           FROM public.species s
          WHERE (s.species_id = v.species_id)))::text, ', '::text) AS species
   FROM public.vw_ligand_peptide_species_ids v
  GROUP BY v.ligand_id;


ALTER TABLE public.vw_ligand_peptide_species OWNER TO simon;

--
-- TOC entry 431 (class 1259 OID 25812)
-- Name: xenobiotic_expression_xenobiotic_expression_id_seq; Type: SEQUENCE; Schema: public; Owner: simon
--

CREATE SEQUENCE public.xenobiotic_expression_xenobiotic_expression_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xenobiotic_expression_xenobiotic_expression_id_seq OWNER TO simon;

--
-- TOC entry 432 (class 1259 OID 25814)
-- Name: xenobiotic_expression; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.xenobiotic_expression (
    xenobiotic_expression_id integer DEFAULT nextval('public.xenobiotic_expression_xenobiotic_expression_id_seq'::regclass) NOT NULL,
    object_id integer NOT NULL,
    change character varying(2000),
    technique character varying(500),
    tissue character varying(1000),
    species_id integer NOT NULL,
    change_vector tsvector,
    tissue_vector tsvector,
    technique_vector tsvector
);


ALTER TABLE public.xenobiotic_expression OWNER TO simon;

--
-- TOC entry 433 (class 1259 OID 25821)
-- Name: xenobiotic_expression_refs; Type: TABLE; Schema: public; Owner: simon
--

CREATE TABLE public.xenobiotic_expression_refs (
    xenobiotic_expression_id integer NOT NULL,
    reference_id integer NOT NULL
);


ALTER TABLE public.xenobiotic_expression_refs OWNER TO simon;

--
-- TOC entry 2989 (class 2604 OID 25824)
-- Name: committee committee_id; Type: DEFAULT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.committee ALTER COLUMN committee_id SET DEFAULT nextval('public.committee_committee_id_seq'::regclass);


--
-- TOC entry 3111 (class 2606 OID 30043)
-- Name: accessory_protein accessory_protein_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.accessory_protein
    ADD CONSTRAINT accessory_protein_pk PRIMARY KEY (object_id);


--
-- TOC entry 3113 (class 2606 OID 30045)
-- Name: allele allele_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.allele
    ADD CONSTRAINT allele_pk PRIMARY KEY (allele_id);


--
-- TOC entry 3118 (class 2606 OID 30047)
-- Name: altered_expression altered_expression_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.altered_expression
    ADD CONSTRAINT altered_expression_pkey PRIMARY KEY (altered_expression_id);


--
-- TOC entry 3120 (class 2606 OID 30049)
-- Name: altered_expression_refs altered_expression_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.altered_expression_refs
    ADD CONSTRAINT altered_expression_refs_pk PRIMARY KEY (altered_expression_id, reference_id);


--
-- TOC entry 3122 (class 2606 OID 30051)
-- Name: analogue_cluster analogue_cluster_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.analogue_cluster
    ADD CONSTRAINT analogue_cluster_pk PRIMARY KEY (ligand_id, cluster);


--
-- TOC entry 3125 (class 2606 OID 30053)
-- Name: associated_protein associated_protein_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.associated_protein
    ADD CONSTRAINT associated_protein_pk PRIMARY KEY (associated_protein_id);


--
-- TOC entry 3127 (class 2606 OID 30055)
-- Name: associated_protein_refs associated_protein_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.associated_protein_refs
    ADD CONSTRAINT associated_protein_refs_pk PRIMARY KEY (associated_protein_id, reference_id);


--
-- TOC entry 3132 (class 2606 OID 30057)
-- Name: binding_partner binding_partner_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.binding_partner
    ADD CONSTRAINT binding_partner_pk PRIMARY KEY (binding_partner_id);


--
-- TOC entry 3134 (class 2606 OID 30059)
-- Name: binding_partner_refs binding_partner_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.binding_partner_refs
    ADD CONSTRAINT binding_partner_refs_pk PRIMARY KEY (binding_partner_id, reference_id);


--
-- TOC entry 3136 (class 2606 OID 30061)
-- Name: catalytic_receptor catalytic_receptor_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.catalytic_receptor
    ADD CONSTRAINT catalytic_receptor_pk PRIMARY KEY (object_id);


--
-- TOC entry 3141 (class 2606 OID 30063)
-- Name: celltype_assoc_colist celltype_assoc_colist_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc_colist
    ADD CONSTRAINT celltype_assoc_colist_pk PRIMARY KEY (celltype_assoc_id, co_celltype_id);


--
-- TOC entry 3139 (class 2606 OID 30065)
-- Name: celltype_assoc celltype_assoc_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc
    ADD CONSTRAINT celltype_assoc_pk PRIMARY KEY (celltype_assoc_id);


--
-- TOC entry 3143 (class 2606 OID 30067)
-- Name: celltype_assoc_refs celltype_assoc_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc_refs
    ADD CONSTRAINT celltype_assoc_refs_pk PRIMARY KEY (celltype_assoc_id, reference_id);


--
-- TOC entry 3145 (class 2606 OID 30069)
-- Name: cellular_location cellular_location_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cellular_location
    ADD CONSTRAINT cellular_location_pk PRIMARY KEY (cellular_location_id);


--
-- TOC entry 3147 (class 2606 OID 30071)
-- Name: cellular_location_refs cellular_location_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cellular_location_refs
    ADD CONSTRAINT cellular_location_refs_pk PRIMARY KEY (cellular_location_id, reference_id);


--
-- TOC entry 3149 (class 2606 OID 30073)
-- Name: chembl_cluster chembl_cluster_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.chembl_cluster
    ADD CONSTRAINT chembl_cluster_pk PRIMARY KEY (object_id, chembl_id);


--
-- TOC entry 3157 (class 2606 OID 30075)
-- Name: co_celltype_isa co_celltype_isa_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.co_celltype_isa
    ADD CONSTRAINT co_celltype_isa_pk PRIMARY KEY (parent_id, child_id);


--
-- TOC entry 3152 (class 2606 OID 30077)
-- Name: co_celltype co_celltype_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.co_celltype
    ADD CONSTRAINT co_celltype_pk PRIMARY KEY (co_celltype_id);


--
-- TOC entry 3159 (class 2606 OID 30079)
-- Name: co_celltype_relationship co_celltype_relationship_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.co_celltype_relationship
    ADD CONSTRAINT co_celltype_relationship_pk PRIMARY KEY (co_celltype_rel_id);


--
-- TOC entry 3162 (class 2606 OID 30081)
-- Name: cofactor cofactor_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor
    ADD CONSTRAINT cofactor_pk PRIMARY KEY (cofactor_id);


--
-- TOC entry 3164 (class 2606 OID 30083)
-- Name: cofactor_refs cofactor_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor_refs
    ADD CONSTRAINT cofactor_refs_pk PRIMARY KEY (cofactor_id, reference_id);


--
-- TOC entry 3166 (class 2606 OID 30085)
-- Name: committee committee_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.committee
    ADD CONSTRAINT committee_pk PRIMARY KEY (committee_id);


--
-- TOC entry 3168 (class 2606 OID 30087)
-- Name: conductance conductance_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance
    ADD CONSTRAINT conductance_pk PRIMARY KEY (conductance_id);


--
-- TOC entry 3170 (class 2606 OID 30089)
-- Name: conductance_refs conductance_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_refs
    ADD CONSTRAINT conductance_refs_pk PRIMARY KEY (conductance_id, reference_id);


--
-- TOC entry 3172 (class 2606 OID 30091)
-- Name: conductance_states conductance_states_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_states
    ADD CONSTRAINT conductance_states_pk PRIMARY KEY (conductance_states_id);


--
-- TOC entry 3174 (class 2606 OID 30093)
-- Name: conductance_states_refs conductance_states_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_states_refs
    ADD CONSTRAINT conductance_states_refs_pk PRIMARY KEY (conductance_states_id, reference_id);


--
-- TOC entry 3180 (class 2606 OID 30095)
-- Name: contributor2committee contributor2committee_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2committee
    ADD CONSTRAINT contributor2committee_pk PRIMARY KEY (contributor_id, committee_id);


--
-- TOC entry 3182 (class 2606 OID 30097)
-- Name: contributor2family contributor2family_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2family
    ADD CONSTRAINT contributor2family_pk PRIMARY KEY (contributor_id, family_id);


--
-- TOC entry 3184 (class 2606 OID 30099)
-- Name: contributor2intro contributor2intro_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2intro
    ADD CONSTRAINT contributor2intro_pk PRIMARY KEY (contributor_id, family_id);


--
-- TOC entry 3186 (class 2606 OID 30101)
-- Name: contributor2object contributor2object_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2object
    ADD CONSTRAINT contributor2object_pk PRIMARY KEY (contributor_id, object_id);


--
-- TOC entry 3188 (class 2606 OID 30103)
-- Name: contributor_link contributor_link_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor_link
    ADD CONSTRAINT contributor_link_pk PRIMARY KEY (contributor_id, url);


--
-- TOC entry 3177 (class 2606 OID 30105)
-- Name: contributor contributor_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT contributor_pkey PRIMARY KEY (contributor_id);


--
-- TOC entry 3200 (class 2606 OID 30107)
-- Name: coregulator_gene coregulator_gene_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator_gene
    ADD CONSTRAINT coregulator_gene_pk PRIMARY KEY (coregulator_gene_id);


--
-- TOC entry 3192 (class 2606 OID 30109)
-- Name: coregulator coregulator_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator
    ADD CONSTRAINT coregulator_pk PRIMARY KEY (coregulator_id);


--
-- TOC entry 3202 (class 2606 OID 30111)
-- Name: coregulator_refs coregulator_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator_refs
    ADD CONSTRAINT coregulator_refs_pk PRIMARY KEY (coregulator_id, reference_id);


--
-- TOC entry 3206 (class 2606 OID 30113)
-- Name: database_link database_link_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.database_link
    ADD CONSTRAINT database_link_pkey PRIMARY KEY (database_link_id);


--
-- TOC entry 3204 (class 2606 OID 30115)
-- Name: database database_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.database
    ADD CONSTRAINT database_pkey PRIMARY KEY (database_id);


--
-- TOC entry 3209 (class 2606 OID 30117)
-- Name: deleted_family deleted_family_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.deleted_family
    ADD CONSTRAINT deleted_family_pk PRIMARY KEY (family_id);


--
-- TOC entry 3211 (class 2606 OID 30119)
-- Name: discoverx discoverx_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.discoverx
    ADD CONSTRAINT discoverx_pk PRIMARY KEY (cat_no);


--
-- TOC entry 3217 (class 2606 OID 30121)
-- Name: disease2category disease2category_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease2category
    ADD CONSTRAINT disease2category_pk PRIMARY KEY (disease_id, disease_category_id);


--
-- TOC entry 3219 (class 2606 OID 30123)
-- Name: disease2synonym disease2synonym_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease2synonym
    ADD CONSTRAINT disease2synonym_pk PRIMARY KEY (disease2synonym_id);


--
-- TOC entry 3222 (class 2606 OID 30125)
-- Name: disease_category disease_category_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_category
    ADD CONSTRAINT disease_category_pk PRIMARY KEY (disease_category_id);


--
-- TOC entry 3224 (class 2606 OID 30127)
-- Name: disease_database_link disease_database_link_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_database_link
    ADD CONSTRAINT disease_database_link_pk PRIMARY KEY (disease_database_link_id);


--
-- TOC entry 3215 (class 2606 OID 30129)
-- Name: disease disease_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pk PRIMARY KEY (disease_id);


--
-- TOC entry 3227 (class 2606 OID 30131)
-- Name: disease_synonym2database_link disease_synonym2database_link_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_synonym2database_link
    ADD CONSTRAINT disease_synonym2database_link_pk PRIMARY KEY (disease2synonym_id, disease_database_link_id);


--
-- TOC entry 3229 (class 2606 OID 30133)
-- Name: dna_binding dna_binding_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.dna_binding
    ADD CONSTRAINT dna_binding_pk PRIMARY KEY (dna_binding_id);


--
-- TOC entry 3234 (class 2606 OID 30135)
-- Name: dna_binding_refs dna_binding_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.dna_binding_refs
    ADD CONSTRAINT dna_binding_refs_pk PRIMARY KEY (dna_binding_id, reference_id);


--
-- TOC entry 3239 (class 2606 OID 30137)
-- Name: do_disease_isa do_disease_isa_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.do_disease_isa
    ADD CONSTRAINT do_disease_isa_pk PRIMARY KEY (parent_id, child_id);


--
-- TOC entry 3237 (class 2606 OID 30139)
-- Name: do_disease do_disease_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.do_disease
    ADD CONSTRAINT do_disease_pk PRIMARY KEY (do_disease_id);


--
-- TOC entry 3241 (class 2606 OID 30141)
-- Name: drug2disease drug2disease_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.drug2disease
    ADD CONSTRAINT drug2disease_pk PRIMARY KEY (ligand_id, disease_id);


--
-- TOC entry 3243 (class 2606 OID 30143)
-- Name: enzyme enzyme_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.enzyme
    ADD CONSTRAINT enzyme_pk PRIMARY KEY (object_id);


--
-- TOC entry 3245 (class 2606 OID 30145)
-- Name: expression_experiment expression_experiment_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_experiment
    ADD CONSTRAINT expression_experiment_pk PRIMARY KEY (expression_experiment_id);


--
-- TOC entry 3247 (class 2606 OID 30147)
-- Name: expression_level expression_level_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_level
    ADD CONSTRAINT expression_level_pk PRIMARY KEY (structural_info_id, tissue_id, expression_experiment_id);


--
-- TOC entry 3253 (class 2606 OID 30149)
-- Name: expression_pathophysiology expression_pathophys_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_pathophysiology
    ADD CONSTRAINT expression_pathophys_pk PRIMARY KEY (expression_pathophysiology_id);


--
-- TOC entry 3255 (class 2606 OID 30151)
-- Name: expression_pathophysiology_refs expression_pathophysiology_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_pathophysiology_refs
    ADD CONSTRAINT expression_pathophysiology_refs_pk PRIMARY KEY (expression_pathophysiology_id, reference_id);


--
-- TOC entry 3259 (class 2606 OID 30153)
-- Name: family family_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pk PRIMARY KEY (family_id);


--
-- TOC entry 3266 (class 2606 OID 30155)
-- Name: functional_assay functional_assay_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.functional_assay
    ADD CONSTRAINT functional_assay_pkey PRIMARY KEY (functional_assay_id);


--
-- TOC entry 3268 (class 2606 OID 30157)
-- Name: functional_assay_refs functional_assay_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.functional_assay_refs
    ADD CONSTRAINT functional_assay_refs_pk PRIMARY KEY (functional_assay_id, reference_id);


--
-- TOC entry 3270 (class 2606 OID 30159)
-- Name: further_reading further_reading_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.further_reading
    ADD CONSTRAINT further_reading_pk PRIMARY KEY (object_id, reference_id);


--
-- TOC entry 3272 (class 2606 OID 30161)
-- Name: go_process go_process_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.go_process
    ADD CONSTRAINT go_process_pk PRIMARY KEY (go_process_id);


--
-- TOC entry 3277 (class 2606 OID 30163)
-- Name: go_process_rel go_process_rel_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.go_process_rel
    ADD CONSTRAINT go_process_rel_pk PRIMARY KEY (parent_id, child_id);


--
-- TOC entry 3279 (class 2606 OID 30165)
-- Name: gpcr gpcr_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.gpcr
    ADD CONSTRAINT gpcr_pk PRIMARY KEY (object_id);


--
-- TOC entry 3283 (class 2606 OID 30167)
-- Name: grac_family_text grac_family_text_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_family_text
    ADD CONSTRAINT grac_family_text_pk PRIMARY KEY (family_id);


--
-- TOC entry 3286 (class 2606 OID 30169)
-- Name: grac_functional_characteristics grac_functional_characteristics_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_functional_characteristics
    ADD CONSTRAINT grac_functional_characteristics_pk PRIMARY KEY (object_id);


--
-- TOC entry 3288 (class 2606 OID 30171)
-- Name: grac_further_reading grac_further_reading_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_further_reading
    ADD CONSTRAINT grac_further_reading_pk PRIMARY KEY (family_id, reference_id);


--
-- TOC entry 3291 (class 2606 OID 30173)
-- Name: grac_ligand_rank_potency grac_ligand_rank_potency_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_ligand_rank_potency
    ADD CONSTRAINT grac_ligand_rank_potency_pk PRIMARY KEY (grac_ligand_rank_potency_id);


--
-- TOC entry 3293 (class 2606 OID 30175)
-- Name: grac_ligand_rank_potency_refs grac_ligand_rank_potency_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_ligand_rank_potency_refs
    ADD CONSTRAINT grac_ligand_rank_potency_refs_pk PRIMARY KEY (grac_ligand_rank_potency_id, reference_id);


--
-- TOC entry 3295 (class 2606 OID 30177)
-- Name: grac_transduction grac_transduction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_transduction
    ADD CONSTRAINT grac_transduction_pk PRIMARY KEY (object_id);


--
-- TOC entry 3297 (class 2606 OID 30179)
-- Name: grouping grouping_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public."grouping"
    ADD CONSTRAINT grouping_pk PRIMARY KEY (group_id, family_id);


--
-- TOC entry 3299 (class 2606 OID 30181)
-- Name: gtip2go_process gtip2go_process_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.gtip2go_process
    ADD CONSTRAINT gtip2go_process_pk PRIMARY KEY (gtip_process_id, go_process_id);


--
-- TOC entry 3301 (class 2606 OID 30183)
-- Name: gtip_process gtip_process_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.gtip_process
    ADD CONSTRAINT gtip_process_pk PRIMARY KEY (gtip_process_id);


--
-- TOC entry 3305 (class 2606 OID 30185)
-- Name: hottopic_refs hottopic_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.hottopic_refs
    ADD CONSTRAINT hottopic_refs_pk PRIMARY KEY (reference_id, type);


--
-- TOC entry 3307 (class 2606 OID 30187)
-- Name: immuno2co_celltype immuno2co_celltype_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno2co_celltype
    ADD CONSTRAINT immuno2co_celltype_pk PRIMARY KEY (immuno_celltype_id, cellonto_id);


--
-- TOC entry 3311 (class 2606 OID 30189)
-- Name: immuno_celltype immuno_celltype_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_celltype
    ADD CONSTRAINT immuno_celltype_pk PRIMARY KEY (immuno_celltype_id);


--
-- TOC entry 3314 (class 2606 OID 30191)
-- Name: immuno_disease2ligand immuno_disease2ligand_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2ligand
    ADD CONSTRAINT immuno_disease2ligand_pk PRIMARY KEY (immuno_disease2ligand_id);


--
-- TOC entry 3316 (class 2606 OID 30193)
-- Name: immuno_disease2ligand_refs immuno_disease2ligand_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2ligand_refs
    ADD CONSTRAINT immuno_disease2ligand_refs_pk PRIMARY KEY (immuno_disease2ligand_id, reference_id);


--
-- TOC entry 3319 (class 2606 OID 30195)
-- Name: immuno_disease2object immuno_disease2object_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2object
    ADD CONSTRAINT immuno_disease2object_pk PRIMARY KEY (immuno_disease2object_id);


--
-- TOC entry 3321 (class 2606 OID 30197)
-- Name: immuno_disease2object_refs immuno_disease2object_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2object_refs
    ADD CONSTRAINT immuno_disease2object_refs_pk PRIMARY KEY (immuno_disease2object_id, reference_id);


--
-- TOC entry 3323 (class 2606 OID 30199)
-- Name: immunopaedia2family immunopaedia2family_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2family
    ADD CONSTRAINT immunopaedia2family_pk PRIMARY KEY (immunopaedia_case_id, family_id);


--
-- TOC entry 3325 (class 2606 OID 30201)
-- Name: immunopaedia2ligand immunopaedia2ligand_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2ligand
    ADD CONSTRAINT immunopaedia2ligand_pk PRIMARY KEY (immunopaedia_case_id, ligand_id);


--
-- TOC entry 3327 (class 2606 OID 30203)
-- Name: immunopaedia2object immunopaedia2object_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2object
    ADD CONSTRAINT immunopaedia2object_pk PRIMARY KEY (immunopaedia_case_id, object_id);


--
-- TOC entry 3329 (class 2606 OID 30205)
-- Name: immunopaedia_cases immunopaedia_cases_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia_cases
    ADD CONSTRAINT immunopaedia_cases_pk PRIMARY KEY (immunopaedia_case_id);


--
-- TOC entry 3333 (class 2606 OID 30207)
-- Name: inn inn_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.inn
    ADD CONSTRAINT inn_pk PRIMARY KEY (inn_number);


--
-- TOC entry 3341 (class 2606 OID 30209)
-- Name: interaction_affinity_refs interaction_affinity_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction_affinity_refs
    ADD CONSTRAINT interaction_affinity_refs_pk PRIMARY KEY (interaction_id, reference_id);


--
-- TOC entry 3338 (class 2606 OID 30211)
-- Name: interaction interaction_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction
    ADD CONSTRAINT interaction_pkey PRIMARY KEY (interaction_id);


--
-- TOC entry 3344 (class 2606 OID 30213)
-- Name: introduction introduction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.introduction
    ADD CONSTRAINT introduction_pk PRIMARY KEY (family_id);


--
-- TOC entry 3346 (class 2606 OID 30215)
-- Name: iuphar2discoverx iuphar2discoverx_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.iuphar2discoverx
    ADD CONSTRAINT iuphar2discoverx_pk PRIMARY KEY (object_id, cat_no);


--
-- TOC entry 3348 (class 2606 OID 30217)
-- Name: iuphar2tocris iuphar2tocris_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.iuphar2tocris
    ADD CONSTRAINT iuphar2tocris_pk PRIMARY KEY (ligand_id, cat_no);


--
-- TOC entry 3350 (class 2606 OID 30219)
-- Name: lgic lgic_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.lgic
    ADD CONSTRAINT lgic_pk PRIMARY KEY (object_id);


--
-- TOC entry 3370 (class 2606 OID 30221)
-- Name: ligand2family ligand2family_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2family
    ADD CONSTRAINT ligand2family_pk PRIMARY KEY (ligand_id, family_id);


--
-- TOC entry 3372 (class 2606 OID 30223)
-- Name: ligand2inn ligand2inn_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2inn
    ADD CONSTRAINT ligand2inn_pk PRIMARY KEY (ligand_id, inn_number);


--
-- TOC entry 3374 (class 2606 OID 30225)
-- Name: ligand2meshpharmacology ligand2meshpharmacology_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2meshpharmacology
    ADD CONSTRAINT ligand2meshpharmacology_pk PRIMARY KEY (ligand_id, mesh_term);


--
-- TOC entry 3376 (class 2606 OID 30227)
-- Name: ligand2subunit ligand2subunit_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2subunit
    ADD CONSTRAINT ligand2subunit_pk PRIMARY KEY (ligand_id, subunit_id);


--
-- TOC entry 3379 (class 2606 OID 30229)
-- Name: ligand2synonym ligand2synonym_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2synonym
    ADD CONSTRAINT ligand2synonym_pk PRIMARY KEY (ligand2synonym_id);


--
-- TOC entry 3382 (class 2606 OID 30231)
-- Name: ligand2synonym_refs ligand2synonym_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2synonym_refs
    ADD CONSTRAINT ligand2synonym_refs_pk PRIMARY KEY (ligand2synonym_id, reference_id);


--
-- TOC entry 3384 (class 2606 OID 30233)
-- Name: ligand_cluster ligand_cluster_pkey1; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_cluster
    ADD CONSTRAINT ligand_cluster_pkey1 PRIMARY KEY (ligand_id);


--
-- TOC entry 3386 (class 2606 OID 30235)
-- Name: ligand_database_link ligand_database_link_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_database_link
    ADD CONSTRAINT ligand_database_link_pk PRIMARY KEY (ligand_database_link_id);


--
-- TOC entry 3389 (class 2606 OID 30237)
-- Name: ligand_physchem ligand_physchem_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_physchem
    ADD CONSTRAINT ligand_physchem_pk PRIMARY KEY (ligand_id);


--
-- TOC entry 3391 (class 2606 OID 30239)
-- Name: ligand_physchem_public ligand_physchem_public_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_physchem_public
    ADD CONSTRAINT ligand_physchem_public_pk PRIMARY KEY (ligand_id);


--
-- TOC entry 3365 (class 2606 OID 30241)
-- Name: ligand ligand_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand
    ADD CONSTRAINT ligand_pk PRIMARY KEY (ligand_id);


--
-- TOC entry 3393 (class 2606 OID 30243)
-- Name: ligand_structure ligand_structure_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_structure
    ADD CONSTRAINT ligand_structure_pk PRIMARY KEY (ligand_id);


--
-- TOC entry 3395 (class 2606 OID 30245)
-- Name: list_ligand list_ligand_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.list_ligand
    ADD CONSTRAINT list_ligand_pk PRIMARY KEY (object_id, ligand_id);


--
-- TOC entry 3399 (class 2606 OID 30247)
-- Name: malaria_stage2interaction malaria_stage2interaction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.malaria_stage2interaction
    ADD CONSTRAINT malaria_stage2interaction_pk PRIMARY KEY (interaction_id, malaria_stage_id);


--
-- TOC entry 3397 (class 2606 OID 30249)
-- Name: malaria_stage malaria_stage_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.malaria_stage
    ADD CONSTRAINT malaria_stage_pk PRIMARY KEY (malaria_stage_id);


--
-- TOC entry 3401 (class 2606 OID 30251)
-- Name: multimer multimer_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.multimer
    ADD CONSTRAINT multimer_pk PRIMARY KEY (object_id);


--
-- TOC entry 3403 (class 2606 OID 30253)
-- Name: mutation mutation_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation
    ADD CONSTRAINT mutation_pkey PRIMARY KEY (mutation_id);


--
-- TOC entry 3405 (class 2606 OID 30255)
-- Name: mutation_refs mutation_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation_refs
    ADD CONSTRAINT mutation_refs_pk PRIMARY KEY (mutation_id, reference_id);


--
-- TOC entry 3407 (class 2606 OID 30257)
-- Name: nhr nhr_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.nhr
    ADD CONSTRAINT nhr_pk PRIMARY KEY (object_id);


--
-- TOC entry 3415 (class 2606 OID 30259)
-- Name: object2go_process object2go_process_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object2go_process
    ADD CONSTRAINT object2go_process_pk PRIMARY KEY (object_id, go_process_id);


--
-- TOC entry 3417 (class 2606 OID 30261)
-- Name: object2reaction object2reaction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object2reaction
    ADD CONSTRAINT object2reaction_pk PRIMARY KEY (object_id, reaction_id);


--
-- TOC entry 3410 (class 2606 OID 30263)
-- Name: object object_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object
    ADD CONSTRAINT object_pk PRIMARY KEY (object_id);


--
-- TOC entry 3441 (class 2606 OID 30265)
-- Name: object_vectors object_vectors_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object_vectors
    ADD CONSTRAINT object_vectors_pkey PRIMARY KEY (object_id);


--
-- TOC entry 3451 (class 2606 OID 30267)
-- Name: ontology ontology_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ontology
    ADD CONSTRAINT ontology_pk PRIMARY KEY (ontology_id);


--
-- TOC entry 3453 (class 2606 OID 30269)
-- Name: ontology_term ontology_term_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ontology_term
    ADD CONSTRAINT ontology_term_pk PRIMARY KEY (ontology_id, term_id);


--
-- TOC entry 3455 (class 2606 OID 30271)
-- Name: other_ic other_ic_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.other_ic
    ADD CONSTRAINT other_ic_pk PRIMARY KEY (object_id);


--
-- TOC entry 3457 (class 2606 OID 30273)
-- Name: other_protein other_protein_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.other_protein
    ADD CONSTRAINT other_protein_pk PRIMARY KEY (object_id);


--
-- TOC entry 3465 (class 2606 OID 30275)
-- Name: pathophysiology pathophysiology_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pathophysiology
    ADD CONSTRAINT pathophysiology_pkey PRIMARY KEY (pathophysiology_id);


--
-- TOC entry 3467 (class 2606 OID 30277)
-- Name: pathophysiology_refs pathophysiology_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pathophysiology_refs
    ADD CONSTRAINT pathophysiology_refs_pk PRIMARY KEY (pathophysiology_id, reference_id);


--
-- TOC entry 3471 (class 2606 OID 30279)
-- Name: pdb_structure pdb_structure_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure
    ADD CONSTRAINT pdb_structure_pk PRIMARY KEY (pdb_structure_id);


--
-- TOC entry 3473 (class 2606 OID 30281)
-- Name: pdb_structure_refs pdb_structure_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure_refs
    ADD CONSTRAINT pdb_structure_refs_pk PRIMARY KEY (pdb_structure_id, reference_id);


--
-- TOC entry 3477 (class 2606 OID 30283)
-- Name: peptide_ligand_cluster peptide_ligand_cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.peptide_ligand_cluster
    ADD CONSTRAINT peptide_ligand_cluster_pkey PRIMARY KEY (ligand_id);


--
-- TOC entry 3479 (class 2606 OID 30285)
-- Name: peptide_ligand_sequence_cluster peptide_ligand_sequence_cluster_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.peptide_ligand_sequence_cluster
    ADD CONSTRAINT peptide_ligand_sequence_cluster_pk PRIMARY KEY (ligand_id);


--
-- TOC entry 3475 (class 2606 OID 30287)
-- Name: peptide peptide_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.peptide
    ADD CONSTRAINT peptide_pk PRIMARY KEY (ligand_id);


--
-- TOC entry 3483 (class 2606 OID 30289)
-- Name: physiological_function physiological_function_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.physiological_function
    ADD CONSTRAINT physiological_function_pkey PRIMARY KEY (physiological_function_id);


--
-- TOC entry 3485 (class 2606 OID 30291)
-- Name: physiological_function_refs physiological_function_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.physiological_function_refs
    ADD CONSTRAINT physiological_function_refs_pk PRIMARY KEY (physiological_function_id, reference_id);


--
-- TOC entry 3493 (class 2606 OID 30293)
-- Name: precursor2peptide precursor2peptide_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor2peptide
    ADD CONSTRAINT precursor2peptide_pk PRIMARY KEY (precursor_id, ligand_id);


--
-- TOC entry 3495 (class 2606 OID 30295)
-- Name: precursor2synonym precursor2synonym_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor2synonym
    ADD CONSTRAINT precursor2synonym_pk PRIMARY KEY (precursor2synonym_id);


--
-- TOC entry 3490 (class 2606 OID 30297)
-- Name: precursor precursor_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor
    ADD CONSTRAINT precursor_pk PRIMARY KEY (precursor_id);


--
-- TOC entry 3598 (class 2606 OID 30299)
-- Name: transduction primary_1; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transduction
    ADD CONSTRAINT primary_1 PRIMARY KEY (transduction_id);


--
-- TOC entry 3498 (class 2606 OID 30301)
-- Name: primary_regulator primary_regulator_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.primary_regulator
    ADD CONSTRAINT primary_regulator_pk PRIMARY KEY (primary_regulator_id);


--
-- TOC entry 3500 (class 2606 OID 30303)
-- Name: primary_regulator_refs primary_regulator_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.primary_regulator_refs
    ADD CONSTRAINT primary_regulator_refs_pk PRIMARY KEY (primary_regulator_id, reference_id);


--
-- TOC entry 3503 (class 2606 OID 30305)
-- Name: process_assoc process_assoc_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.process_assoc
    ADD CONSTRAINT process_assoc_pk PRIMARY KEY (process_assoc_id);


--
-- TOC entry 3505 (class 2606 OID 30307)
-- Name: process_assoc_refs process_assoc_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.process_assoc_refs
    ADD CONSTRAINT process_assoc_refs_pk PRIMARY KEY (process_assoc_id, reference_id);


--
-- TOC entry 3507 (class 2606 OID 30309)
-- Name: prodrug prodrug_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.prodrug
    ADD CONSTRAINT prodrug_pk PRIMARY KEY (prodrug_ligand_id, drug_ligand_id);


--
-- TOC entry 3510 (class 2606 OID 30311)
-- Name: product product_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pk PRIMARY KEY (product_id);


--
-- TOC entry 3512 (class 2606 OID 30313)
-- Name: product_refs product_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product_refs
    ADD CONSTRAINT product_refs_pk PRIMARY KEY (product_id, reference_id);


--
-- TOC entry 3515 (class 2606 OID 30315)
-- Name: reaction reaction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reaction
    ADD CONSTRAINT reaction_pk PRIMARY KEY (reaction_id);


--
-- TOC entry 3518 (class 2606 OID 30317)
-- Name: receptor2family receptor2family_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor2family
    ADD CONSTRAINT receptor2family_pk PRIMARY KEY (object_id, family_id);


--
-- TOC entry 3520 (class 2606 OID 30319)
-- Name: receptor2subunit receptor2subunit_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor2subunit
    ADD CONSTRAINT receptor2subunit_pk PRIMARY KEY (receptor_id, subunit_id);


--
-- TOC entry 3522 (class 2606 OID 30321)
-- Name: receptor_basic receptor_basic_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor_basic
    ADD CONSTRAINT receptor_basic_pk PRIMARY KEY (object_id);


--
-- TOC entry 3529 (class 2606 OID 30323)
-- Name: reference2immuno reference2immuno_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reference2immuno
    ADD CONSTRAINT reference2immuno_pk PRIMARY KEY (reference_id, type);


--
-- TOC entry 3531 (class 2606 OID 30325)
-- Name: reference2ligand reference2ligand_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reference2ligand
    ADD CONSTRAINT reference2ligand_pk PRIMARY KEY (reference_id, ligand_id);


--
-- TOC entry 3526 (class 2606 OID 30327)
-- Name: reference reference_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (reference_id);


--
-- TOC entry 3538 (class 2606 OID 30329)
-- Name: screen_interaction screen_interaction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_interaction
    ADD CONSTRAINT screen_interaction_pk PRIMARY KEY (screen_interaction_id);


--
-- TOC entry 3533 (class 2606 OID 30331)
-- Name: screen screen_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen
    ADD CONSTRAINT screen_pk PRIMARY KEY (screen_id);


--
-- TOC entry 3540 (class 2606 OID 30333)
-- Name: screen_refs screen_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_refs
    ADD CONSTRAINT screen_refs_pk PRIMARY KEY (screen_id, reference_id);


--
-- TOC entry 3542 (class 2606 OID 30335)
-- Name: selectivity selectivity_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.selectivity
    ADD CONSTRAINT selectivity_pkey PRIMARY KEY (selectivity_id);


--
-- TOC entry 3544 (class 2606 OID 30337)
-- Name: selectivity_refs selectivity_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.selectivity_refs
    ADD CONSTRAINT selectivity_refs_pk PRIMARY KEY (selectivity_id, reference_id);


--
-- TOC entry 3546 (class 2606 OID 30339)
-- Name: species species_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pk PRIMARY KEY (species_id);


--
-- TOC entry 3552 (class 2606 OID 30341)
-- Name: specific_reaction specific_reaction_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.specific_reaction
    ADD CONSTRAINT specific_reaction_pk PRIMARY KEY (specific_reaction_id);


--
-- TOC entry 3554 (class 2606 OID 30343)
-- Name: specific_reaction_refs specific_reaction_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.specific_reaction_refs
    ADD CONSTRAINT specific_reaction_refs_pk PRIMARY KEY (specific_reaction_id, reference_id);


--
-- TOC entry 3560 (class 2606 OID 30345)
-- Name: structural_info structural_info_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.structural_info
    ADD CONSTRAINT structural_info_pk PRIMARY KEY (structural_info_id);


--
-- TOC entry 3562 (class 2606 OID 30347)
-- Name: structural_info_refs structural_info_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.structural_info_refs
    ADD CONSTRAINT structural_info_refs_pk PRIMARY KEY (structural_info_id, reference_id);


--
-- TOC entry 3564 (class 2606 OID 30349)
-- Name: subcommittee subcommittee_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.subcommittee
    ADD CONSTRAINT subcommittee_pk PRIMARY KEY (contributor_id, family_id);


--
-- TOC entry 3567 (class 2606 OID 30351)
-- Name: substrate substrate_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate
    ADD CONSTRAINT substrate_pk PRIMARY KEY (substrate_id);


--
-- TOC entry 3569 (class 2606 OID 30353)
-- Name: substrate_refs substrate_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate_refs
    ADD CONSTRAINT substrate_refs_pk PRIMARY KEY (substrate_id, reference_id);


--
-- TOC entry 3573 (class 2606 OID 30355)
-- Name: synonym synonym_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.synonym
    ADD CONSTRAINT synonym_pk PRIMARY KEY (synonym_id);


--
-- TOC entry 3575 (class 2606 OID 30357)
-- Name: synonym_refs synonym_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.synonym_refs
    ADD CONSTRAINT synonym_refs_pk PRIMARY KEY (synonym_id, reference_id);


--
-- TOC entry 3581 (class 2606 OID 30359)
-- Name: target_gene target_gene_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_gene
    ADD CONSTRAINT target_gene_pk PRIMARY KEY (target_gene_id);


--
-- TOC entry 3584 (class 2606 OID 30361)
-- Name: target_gene_refs target_gene_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_gene_refs
    ADD CONSTRAINT target_gene_refs_pk PRIMARY KEY (target_gene_id, reference_id);


--
-- TOC entry 3586 (class 2606 OID 30363)
-- Name: target_ligand_same_entity target_ligand_same_entity_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_ligand_same_entity
    ADD CONSTRAINT target_ligand_same_entity_pk PRIMARY KEY (object_id, ligand_id);


--
-- TOC entry 3590 (class 2606 OID 30365)
-- Name: tissue_distribution tissue_distribution_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue_distribution
    ADD CONSTRAINT tissue_distribution_pkey PRIMARY KEY (tissue_distribution_id);


--
-- TOC entry 3594 (class 2606 OID 30367)
-- Name: tissue_distribution_refs tissue_distribution_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue_distribution_refs
    ADD CONSTRAINT tissue_distribution_refs_pk PRIMARY KEY (tissue_distribution_id, reference_id);


--
-- TOC entry 3588 (class 2606 OID 30369)
-- Name: tissue tissue_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue
    ADD CONSTRAINT tissue_pk PRIMARY KEY (tissue_id);


--
-- TOC entry 3596 (class 2606 OID 30371)
-- Name: tocris tocris_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tocris
    ADD CONSTRAINT tocris_pk PRIMARY KEY (cat_no);


--
-- TOC entry 3601 (class 2606 OID 30373)
-- Name: transduction_refs transduction_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transduction_refs
    ADD CONSTRAINT transduction_refs_pk PRIMARY KEY (transduction_id, reference_id);


--
-- TOC entry 3604 (class 2606 OID 30375)
-- Name: transporter transporter_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transporter
    ADD CONSTRAINT transporter_pk PRIMARY KEY (object_id);


--
-- TOC entry 3548 (class 2606 OID 30377)
-- Name: species unique_name; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- TOC entry 3550 (class 2606 OID 30379)
-- Name: species unique_sname; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT unique_sname UNIQUE (short_name);


--
-- TOC entry 3609 (class 2606 OID 30381)
-- Name: variant2database_link variant2database_link_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant2database_link
    ADD CONSTRAINT variant2database_link_pk PRIMARY KEY (variant_id, database_link_id);


--
-- TOC entry 3607 (class 2606 OID 30383)
-- Name: variant variant_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant
    ADD CONSTRAINT variant_pkey PRIMARY KEY (variant_id);


--
-- TOC entry 3611 (class 2606 OID 30385)
-- Name: variant_refs variant_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant_refs
    ADD CONSTRAINT variant_refs_pk PRIMARY KEY (variant_id, reference_id);


--
-- TOC entry 3613 (class 2606 OID 30387)
-- Name: version version_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_pk PRIMARY KEY (version_number);


--
-- TOC entry 3615 (class 2606 OID 30389)
-- Name: vgic vgic_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.vgic
    ADD CONSTRAINT vgic_pk PRIMARY KEY (object_id);


--
-- TOC entry 3617 (class 2606 OID 30391)
-- Name: voltage_dep_activation_refs voltage_dep_activation_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_activation_refs
    ADD CONSTRAINT voltage_dep_activation_refs_pk PRIMARY KEY (voltage_dependence_id, reference_id);


--
-- TOC entry 3619 (class 2606 OID 30393)
-- Name: voltage_dep_deactivation_refs voltage_dep_deactivation_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_deactivation_refs
    ADD CONSTRAINT voltage_dep_deactivation_refs_pk PRIMARY KEY (voltage_dependence_id, reference_id);


--
-- TOC entry 3621 (class 2606 OID 30395)
-- Name: voltage_dep_inactivation_refs voltage_dep_inactivation_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_inactivation_refs
    ADD CONSTRAINT voltage_dep_inactivation_refs_pk PRIMARY KEY (voltage_dependence_id, reference_id);


--
-- TOC entry 3623 (class 2606 OID 30397)
-- Name: voltage_dependence voltage_dependence_pkey; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dependence
    ADD CONSTRAINT voltage_dependence_pkey PRIMARY KEY (voltage_dependence_id);


--
-- TOC entry 3630 (class 2606 OID 30399)
-- Name: xenobiotic_expression xenobiotic_expression_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.xenobiotic_expression
    ADD CONSTRAINT xenobiotic_expression_pk PRIMARY KEY (xenobiotic_expression_id);


--
-- TOC entry 3632 (class 2606 OID 30401)
-- Name: xenobiotic_expression_refs xenobiotic_expression_refs_pk; Type: CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.xenobiotic_expression_refs
    ADD CONSTRAINT xenobiotic_expression_refs_pk PRIMARY KEY (xenobiotic_expression_id, reference_id);


--
-- TOC entry 3418 (class 1259 OID 30402)
-- Name: abbreviation_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX abbreviation_index ON public.object_vectors USING gist (abbreviation);


--
-- TOC entry 3419 (class 1259 OID 30403)
-- Name: activators_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX activators_com_index ON public.object_vectors USING gist (activators_comments);


--
-- TOC entry 3420 (class 1259 OID 30404)
-- Name: agonists_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX agonists_com_index ON public.object_vectors USING gist (agonists_comments);


--
-- TOC entry 3421 (class 1259 OID 30405)
-- Name: allosteric_modulators_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX allosteric_modulators_com_index ON public.object_vectors USING gist (allosteric_modulators_comments);


--
-- TOC entry 3114 (class 1259 OID 30406)
-- Name: alt_exp_desc_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX alt_exp_desc_index ON public.altered_expression USING gist (description_vector);


--
-- TOC entry 3115 (class 1259 OID 30407)
-- Name: alt_exp_technique_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX alt_exp_technique_index ON public.altered_expression USING gist (technique_vector);


--
-- TOC entry 3116 (class 1259 OID 30408)
-- Name: alt_exp_tissue_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX alt_exp_tissue_index ON public.altered_expression USING gist (tissue_vector);


--
-- TOC entry 3422 (class 1259 OID 30409)
-- Name: altered_expression_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX altered_expression_com_index ON public.object_vectors USING gist (altered_expression_comments);


--
-- TOC entry 3423 (class 1259 OID 30410)
-- Name: antagonists_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX antagonists_com_index ON public.object_vectors USING gist (antagonists_comments);


--
-- TOC entry 3424 (class 1259 OID 30411)
-- Name: antibody_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX antibody_com_index ON public.object_vectors USING gist (antibody_comments);


--
-- TOC entry 3123 (class 1259 OID 30412)
-- Name: ap_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ap_name_index ON public.associated_protein USING gist (name_vector);


--
-- TOC entry 3425 (class 1259 OID 30413)
-- Name: associated_proteins_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX associated_proteins_com_index ON public.object_vectors USING gist (associated_proteins_comments);


--
-- TOC entry 3426 (class 1259 OID 30414)
-- Name: binding_partner_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX binding_partner_com_index ON public.object_vectors USING gist (binding_partner_comments);


--
-- TOC entry 3128 (class 1259 OID 30415)
-- Name: binding_partner_effect_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX binding_partner_effect_index ON public.binding_partner USING gist (effect_vector);


--
-- TOC entry 3129 (class 1259 OID 30416)
-- Name: binding_partner_interaction_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX binding_partner_interaction_index ON public.binding_partner USING gist (interaction_vector);


--
-- TOC entry 3130 (class 1259 OID 30417)
-- Name: binding_partner_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX binding_partner_name_index ON public.binding_partner USING gist (name_vector);


--
-- TOC entry 3351 (class 1259 OID 30418)
-- Name: bioactivity_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX bioactivity_comments_index ON public.ligand USING gist (bioactivity_comments_vector);


--
-- TOC entry 3137 (class 1259 OID 30419)
-- Name: cellassoc_comment_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX cellassoc_comment_index ON public.celltype_assoc USING gist (comment_vector);


--
-- TOC entry 3427 (class 1259 OID 30420)
-- Name: channel_blockers_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX channel_blockers_com_index ON public.object_vectors USING gist (channel_blockers_comments);


--
-- TOC entry 3150 (class 1259 OID 30421)
-- Name: co_celltype_cellonto_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE UNIQUE INDEX co_celltype_cellonto_id_index ON public.co_celltype USING btree (cellonto_id);


--
-- TOC entry 3153 (class 1259 OID 30422)
-- Name: cocell_cellonto_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX cocell_cellonto_id_index ON public.co_celltype USING gist (cellonto_id_vector);


--
-- TOC entry 3154 (class 1259 OID 30423)
-- Name: cocell_definition_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX cocell_definition_index ON public.co_celltype USING gist (definition_vector);


--
-- TOC entry 3155 (class 1259 OID 30424)
-- Name: cocell_term_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX cocell_term_index ON public.co_celltype USING gist (name_vector);


--
-- TOC entry 3160 (class 1259 OID 30425)
-- Name: cofactor_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX cofactor_name_index ON public.cofactor USING gist (name_vector);


--
-- TOC entry 3175 (class 1259 OID 30426)
-- Name: contributor_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX contributor_name_index ON public.contributor USING gist (name_vector);


--
-- TOC entry 3189 (class 1259 OID 30427)
-- Name: coregulator_activity_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_activity_index ON public.coregulator USING gist (activity_vector);


--
-- TOC entry 3428 (class 1259 OID 30428)
-- Name: coregulator_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_com_index ON public.object_vectors USING gist (coregulator_comments);


--
-- TOC entry 3190 (class 1259 OID 30429)
-- Name: coregulator_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_comments_index ON public.coregulator USING gist (comments_vector);


--
-- TOC entry 3193 (class 1259 OID 30430)
-- Name: coregulator_gene_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_gene_comments_index ON public.coregulator_gene USING gist (comments_vector);


--
-- TOC entry 3194 (class 1259 OID 30431)
-- Name: coregulator_gene_gene_long_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_gene_gene_long_name_index ON public.coregulator_gene USING gist (gene_long_name_vector);


--
-- TOC entry 3195 (class 1259 OID 30432)
-- Name: coregulator_gene_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_gene_name_index ON public.coregulator_gene USING gist (primary_name_vector);


--
-- TOC entry 3196 (class 1259 OID 30433)
-- Name: coregulator_gene_nursa_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_gene_nursa_index ON public.coregulator_gene USING btree (nursa_id);


--
-- TOC entry 3197 (class 1259 OID 30434)
-- Name: coregulator_gene_official_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_gene_official_id_index ON public.coregulator_gene USING btree (official_gene_id);


--
-- TOC entry 3198 (class 1259 OID 30435)
-- Name: coregulator_gene_other_names_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX coregulator_gene_other_names_index ON public.coregulator_gene USING gist (other_names_vector);


--
-- TOC entry 3220 (class 1259 OID 30436)
-- Name: disease2synonym_synonym_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX disease2synonym_synonym_index ON public.disease2synonym USING gist (synonym_vector);


--
-- TOC entry 3212 (class 1259 OID 30437)
-- Name: disease_description_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX disease_description_index ON public.disease USING gist (description_vector);


--
-- TOC entry 3213 (class 1259 OID 30438)
-- Name: disease_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX disease_name_index ON public.disease USING gist (name_vector);


--
-- TOC entry 3225 (class 1259 OID 30439)
-- Name: disease_placeholder_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX disease_placeholder_index ON public.disease_database_link USING btree (placeholder);


--
-- TOC entry 3429 (class 1259 OID 30440)
-- Name: dna_binding_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX dna_binding_com_index ON public.object_vectors USING gist (dna_binding_comments);


--
-- TOC entry 3230 (class 1259 OID 30441)
-- Name: dna_binding_response_element_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX dna_binding_response_element_index ON public.dna_binding USING gist (response_element_vector);


--
-- TOC entry 3231 (class 1259 OID 30442)
-- Name: dna_binding_sequence_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX dna_binding_sequence_index ON public.dna_binding USING gist (sequence_vector);


--
-- TOC entry 3232 (class 1259 OID 30443)
-- Name: dna_binding_structure_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX dna_binding_structure_index ON public.dna_binding USING gist (structure_vector);


--
-- TOC entry 3235 (class 1259 OID 30444)
-- Name: do_disease_do_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE UNIQUE INDEX do_disease_do_id_index ON public.do_disease USING btree (do_id);


--
-- TOC entry 3513 (class 1259 OID 30445)
-- Name: ec_num_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ec_num_index ON public.reaction USING btree (ec_number);


--
-- TOC entry 3248 (class 1259 OID 30446)
-- Name: exp_change_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX exp_change_index ON public.expression_pathophysiology USING gist (change_vector);


--
-- TOC entry 3249 (class 1259 OID 30447)
-- Name: exp_pathophysiology_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX exp_pathophysiology_index ON public.expression_pathophysiology USING gist (pathophysiology_vector);


--
-- TOC entry 3250 (class 1259 OID 30448)
-- Name: exp_technique_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX exp_technique_index ON public.expression_pathophysiology USING gist (technique_vector);


--
-- TOC entry 3251 (class 1259 OID 30449)
-- Name: exp_tissue_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX exp_tissue_index ON public.expression_pathophysiology USING gist (tissue_vector);


--
-- TOC entry 3430 (class 1259 OID 30450)
-- Name: expression_pathophysiology_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX expression_pathophysiology_com_index ON public.object_vectors USING gist (expression_pathophysiology_comments);


--
-- TOC entry 3256 (class 1259 OID 30451)
-- Name: fam_display_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX fam_display_index ON public.family USING btree (display_order);


--
-- TOC entry 3257 (class 1259 OID 30452)
-- Name: family_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX family_name_index ON public.family USING gist (name_vector);


--
-- TOC entry 3260 (class 1259 OID 30453)
-- Name: family_previous_names_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX family_previous_names_index ON public.family USING gist (previous_names_vector);


--
-- TOC entry 3262 (class 1259 OID 30454)
-- Name: fassay_desc_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX fassay_desc_index ON public.functional_assay USING gist (description_vector);


--
-- TOC entry 3263 (class 1259 OID 30455)
-- Name: fassay_response_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX fassay_response_index ON public.functional_assay USING gist (response_vector);


--
-- TOC entry 3264 (class 1259 OID 30456)
-- Name: fassay_tissue_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX fassay_tissue_index ON public.functional_assay USING gist (tissue_vector);


--
-- TOC entry 3431 (class 1259 OID 30457)
-- Name: functional_assay_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX functional_assay_com_index ON public.object_vectors USING gist (functional_assay_comments);


--
-- TOC entry 3432 (class 1259 OID 30458)
-- Name: functions_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX functions_com_index ON public.object_vectors USING gist (functions_comments);


--
-- TOC entry 3433 (class 1259 OID 30459)
-- Name: gating_inhibitors_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gating_inhibitors_com_index ON public.object_vectors USING gist (gating_inhibitors_comments);


--
-- TOC entry 3273 (class 1259 OID 30460)
-- Name: gop_definition_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gop_definition_index ON public.go_process USING gist (definition_vector);


--
-- TOC entry 3274 (class 1259 OID 30461)
-- Name: gop_go_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gop_go_id_index ON public.go_process USING gist (go_id_vector);


--
-- TOC entry 3275 (class 1259 OID 30462)
-- Name: gop_term_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gop_term_index ON public.go_process USING gist (term_vector);


--
-- TOC entry 3280 (class 1259 OID 30463)
-- Name: grac_family_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX grac_family_comments_index ON public.grac_family_text USING gist (comments_vector);


--
-- TOC entry 3281 (class 1259 OID 30464)
-- Name: grac_family_overview_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX grac_family_overview_index ON public.grac_family_text USING gist (overview_vector);


--
-- TOC entry 3284 (class 1259 OID 30465)
-- Name: grac_functional_characteristics_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX grac_functional_characteristics_index ON public.grac_functional_characteristics USING gist (functional_characteristics_vector);


--
-- TOC entry 3289 (class 1259 OID 30466)
-- Name: grac_ligand_rank_potency_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX grac_ligand_rank_potency_index ON public.grac_ligand_rank_potency USING gist (rank_potency_vector);


--
-- TOC entry 3434 (class 1259 OID 30467)
-- Name: grac_obj_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX grac_obj_com_index ON public.object_vectors USING gist (grac_comments);


--
-- TOC entry 3435 (class 1259 OID 30468)
-- Name: gtip_obj_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gtip_obj_com_index ON public.object_vectors USING gist (gtip_comments);


--
-- TOC entry 3302 (class 1259 OID 30469)
-- Name: gtippro_definition_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gtippro_definition_index ON public.gtip_process USING gist (definition_vector);


--
-- TOC entry 3303 (class 1259 OID 30470)
-- Name: gtippro_term_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX gtippro_term_index ON public.gtip_process USING gist (term_vector);


--
-- TOC entry 3312 (class 1259 OID 30471)
-- Name: idl_comment_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX idl_comment_index ON public.immuno_disease2ligand USING gist (comment_vector);


--
-- TOC entry 3317 (class 1259 OID 30472)
-- Name: ido_comment_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ido_comment_index ON public.immuno_disease2object USING gist (comment_vector);


--
-- TOC entry 3308 (class 1259 OID 30473)
-- Name: immcell_definition_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX immcell_definition_index ON public.immuno_celltype USING gist (definition_vector);


--
-- TOC entry 3309 (class 1259 OID 30474)
-- Name: immcell_term_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX immcell_term_index ON public.immuno_celltype USING gist (term_vector);


--
-- TOC entry 3352 (class 1259 OID 30475)
-- Name: immuno_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX immuno_comments_index ON public.ligand USING gist (immuno_comments_vector);


--
-- TOC entry 3436 (class 1259 OID 30476)
-- Name: inhibitors_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX inhibitors_com_index ON public.object_vectors USING gist (inhibitors_comments);


--
-- TOC entry 3330 (class 1259 OID 30477)
-- Name: inn_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX inn_btree_index ON public.inn USING btree (inn);


--
-- TOC entry 3331 (class 1259 OID 30478)
-- Name: inn_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX inn_index ON public.inn USING gist (inn_vector);


--
-- TOC entry 3334 (class 1259 OID 30479)
-- Name: int_type_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX int_type_index ON public.interaction USING gist (type_vector);


--
-- TOC entry 3335 (class 1259 OID 30480)
-- Name: interaction_ligand_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX interaction_ligand_index ON public.interaction USING btree (ligand_id);


--
-- TOC entry 3336 (class 1259 OID 30481)
-- Name: interaction_object_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX interaction_object_index ON public.interaction USING btree (object_id);


--
-- TOC entry 3342 (class 1259 OID 30482)
-- Name: intro_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX intro_index ON public.introduction USING gist (intro_vector);


--
-- TOC entry 3353 (class 1259 OID 30483)
-- Name: lig_abbname_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX lig_abbname_btree_index ON public.ligand USING btree (abbreviation);


--
-- TOC entry 3354 (class 1259 OID 30484)
-- Name: lig_name_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX lig_name_btree_index ON public.ligand USING btree (name);


--
-- TOC entry 3377 (class 1259 OID 30485)
-- Name: lig_synonym_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX lig_synonym_btree_index ON public.ligand2synonym USING btree (synonym);


--
-- TOC entry 3355 (class 1259 OID 30486)
-- Name: ligand_abbreviation_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_abbreviation_index ON public.ligand USING gist (abbreviation_vector);


--
-- TOC entry 3356 (class 1259 OID 30487)
-- Name: ligand_absorption_distribution_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_absorption_distribution_index ON public.ligand USING gist (absorption_distribution_vector);


--
-- TOC entry 3357 (class 1259 OID 30488)
-- Name: ligand_clinical_use_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_clinical_use_index ON public.ligand USING gist (clinical_use_vector);


--
-- TOC entry 3358 (class 1259 OID 30489)
-- Name: ligand_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_com_index ON public.ligand USING gist (comments_vector);


--
-- TOC entry 3359 (class 1259 OID 30490)
-- Name: ligand_elimination_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_elimination_index ON public.ligand USING gist (elimination_vector);


--
-- TOC entry 3360 (class 1259 OID 30491)
-- Name: ligand_mechanism_of_action_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_mechanism_of_action_index ON public.ligand USING gist (mechanism_of_action_vector);


--
-- TOC entry 3361 (class 1259 OID 30492)
-- Name: ligand_metabolism_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_metabolism_index ON public.ligand USING gist (metabolism_vector);


--
-- TOC entry 3362 (class 1259 OID 30493)
-- Name: ligand_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_name_index ON public.ligand USING gist (name_vector);


--
-- TOC entry 3363 (class 1259 OID 30494)
-- Name: ligand_organ_function_impairment_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_organ_function_impairment_index ON public.ligand USING gist (organ_function_impairment_vector);


--
-- TOC entry 3387 (class 1259 OID 30495)
-- Name: ligand_placeholder_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_placeholder_index ON public.ligand_database_link USING btree (placeholder);


--
-- TOC entry 3366 (class 1259 OID 30496)
-- Name: ligand_popn_pharmacokinetics_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_popn_pharmacokinetics_index ON public.ligand USING gist (popn_pharmacokinetics_vector);


--
-- TOC entry 3339 (class 1259 OID 30497)
-- Name: ligand_species_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_species_index ON public.interaction USING btree (ligand_id, species_id);


--
-- TOC entry 3380 (class 1259 OID 30498)
-- Name: ligand_synonym_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_synonym_index ON public.ligand2synonym USING gist (synonym_vector);


--
-- TOC entry 3367 (class 1259 OID 30499)
-- Name: ligand_type_idx; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ligand_type_idx ON public.ligand USING btree (type);


--
-- TOC entry 3437 (class 1259 OID 30500)
-- Name: mutations_pathophysiology_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX mutations_pathophysiology_com_index ON public.object_vectors USING gist (mutations_pathophysiology_comments);


--
-- TOC entry 3408 (class 1259 OID 30501)
-- Name: name_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX name_btree_index ON public.object USING btree (name);


--
-- TOC entry 3438 (class 1259 OID 30502)
-- Name: name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX name_index ON public.object_vectors USING gist (name);


--
-- TOC entry 3413 (class 1259 OID 30503)
-- Name: obj2go_comment_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX obj2go_comment_index ON public.object2go_process USING gist (comment_vector);


--
-- TOC entry 3516 (class 1259 OID 30504)
-- Name: obj_display_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX obj_display_index ON public.receptor2family USING btree (display_order);


--
-- TOC entry 3439 (class 1259 OID 30505)
-- Name: object_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX object_com_index ON public.object_vectors USING gist (comments);


--
-- TOC entry 3261 (class 1259 OID 30506)
-- Name: old_fam_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX old_fam_id_index ON public.family USING btree (old_family_id);


--
-- TOC entry 3368 (class 1259 OID 30507)
-- Name: old_ligand_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX old_ligand_index ON public.ligand USING btree (old_ligand_id);


--
-- TOC entry 3411 (class 1259 OID 30508)
-- Name: old_obj_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX old_obj_id_index ON public.object USING btree (old_object_id);


--
-- TOC entry 3178 (class 1259 OID 30509)
-- Name: orcid_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX orcid_index ON public.contributor USING btree (orcid);


--
-- TOC entry 3458 (class 1259 OID 30510)
-- Name: pathophys_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pathophys_comments_index ON public.pathophysiology USING gist (comments_vector);


--
-- TOC entry 3459 (class 1259 OID 30511)
-- Name: pathophys_drugs_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pathophys_drugs_index ON public.pathophysiology USING gist (drugs_vector);


--
-- TOC entry 3460 (class 1259 OID 30512)
-- Name: pathophys_role_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pathophys_role_index ON public.pathophysiology USING gist (role_vector);


--
-- TOC entry 3461 (class 1259 OID 30513)
-- Name: pathophys_side_effects_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pathophys_side_effects_index ON public.pathophysiology USING gist (side_effects_vector);


--
-- TOC entry 3462 (class 1259 OID 30514)
-- Name: pathophys_use_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pathophys_use_index ON public.pathophysiology USING gist (use_vector);


--
-- TOC entry 3463 (class 1259 OID 30515)
-- Name: pathophysiology_disease_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pathophysiology_disease_id_index ON public.pathophysiology USING btree (disease_id);


--
-- TOC entry 3468 (class 1259 OID 30516)
-- Name: pdb_structure_desc_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pdb_structure_desc_index ON public.pdb_structure USING gist (description_vector);


--
-- TOC entry 3469 (class 1259 OID 30517)
-- Name: pdb_structure_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX pdb_structure_id_index ON public.pdb_structure USING btree (pdb_code);


--
-- TOC entry 3480 (class 1259 OID 30518)
-- Name: physfun_desc_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX physfun_desc_index ON public.physiological_function USING gist (description_vector);


--
-- TOC entry 3481 (class 1259 OID 30519)
-- Name: physfun_tissue_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX physfun_tissue_index ON public.physiological_function USING gist (tissue_vector);


--
-- TOC entry 3207 (class 1259 OID 30520)
-- Name: placeholder_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX placeholder_index ON public.database_link USING btree (placeholder);


--
-- TOC entry 3486 (class 1259 OID 30521)
-- Name: precursor_gene_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX precursor_gene_id_index ON public.precursor USING btree (official_gene_id);


--
-- TOC entry 3487 (class 1259 OID 30522)
-- Name: precursor_gene_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX precursor_gene_index ON public.precursor USING btree (gene_name);


--
-- TOC entry 3488 (class 1259 OID 30523)
-- Name: precursor_gene_long_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX precursor_gene_long_name_index ON public.precursor USING gist (gene_long_name_vector);


--
-- TOC entry 3491 (class 1259 OID 30524)
-- Name: precursor_protein_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX precursor_protein_name_index ON public.precursor USING gist (protein_name_vector);


--
-- TOC entry 3496 (class 1259 OID 30525)
-- Name: precursor_synonym_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX precursor_synonym_index ON public.precursor2synonym USING gist (synonym_vector);


--
-- TOC entry 3501 (class 1259 OID 30526)
-- Name: proassoc_comment_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX proassoc_comment_index ON public.process_assoc USING gist (comment_vector);


--
-- TOC entry 3508 (class 1259 OID 30527)
-- Name: product_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX product_name_index ON public.product USING gist (name_vector);


--
-- TOC entry 3523 (class 1259 OID 30528)
-- Name: ref_article_title_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ref_article_title_index ON public.reference USING gist (article_title_vector);


--
-- TOC entry 3524 (class 1259 OID 30529)
-- Name: ref_authors_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX ref_authors_index ON public.reference USING gist (authors_vector);


--
-- TOC entry 3527 (class 1259 OID 30602)
-- Name: reference_pmid_idx; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX reference_pmid_idx ON public.reference USING btree (pubmed_id);


--
-- TOC entry 3534 (class 1259 OID 30611)
-- Name: screen_interaction_idx; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX screen_interaction_idx ON public.screen_interaction USING btree (object_id, screen_id, action_comment, ligand_id);


--
-- TOC entry 3535 (class 1259 OID 30647)
-- Name: screen_interaction_idx_2; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX screen_interaction_idx_2 ON public.screen_interaction USING btree (object_id, screen_id, action_comment, concentration_range);


--
-- TOC entry 3536 (class 1259 OID 30648)
-- Name: screen_interaction_idx_3; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX screen_interaction_idx_3 ON public.screen_interaction USING btree (object_id, screen_id, action_comment, ligand_id, concentration_range);


--
-- TOC entry 3442 (class 1259 OID 30649)
-- Name: selectivity_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX selectivity_com_index ON public.object_vectors USING gist (selectivity_comments);


--
-- TOC entry 3555 (class 1259 OID 30650)
-- Name: si_gene_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX si_gene_id_index ON public.structural_info USING btree (official_gene_id);


--
-- TOC entry 3556 (class 1259 OID 30661)
-- Name: si_gene_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX si_gene_index ON public.structural_info USING btree (gene_name);


--
-- TOC entry 3557 (class 1259 OID 30662)
-- Name: si_gene_long_name_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX si_gene_long_name_btree_index ON public.structural_info USING btree (gene_long_name);


--
-- TOC entry 3558 (class 1259 OID 30663)
-- Name: si_gene_long_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX si_gene_long_name_index ON public.structural_info USING gist (gene_long_name_vector);


--
-- TOC entry 3443 (class 1259 OID 30664)
-- Name: structural_info_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX structural_info_com_index ON public.object_vectors USING gist (structural_info_comments);


--
-- TOC entry 3565 (class 1259 OID 30665)
-- Name: substrate_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX substrate_name_index ON public.substrate USING gist (name_vector);


--
-- TOC entry 3444 (class 1259 OID 30666)
-- Name: subunit_specific_agents_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX subunit_specific_agents_com_index ON public.object_vectors USING gist (subunit_specific_agents_comments);


--
-- TOC entry 3570 (class 1259 OID 30667)
-- Name: synonym_btree_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX synonym_btree_index ON public.synonym USING btree (synonym);


--
-- TOC entry 3571 (class 1259 OID 30671)
-- Name: synonym_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX synonym_index ON public.synonym USING gist (synonym_vector);


--
-- TOC entry 3412 (class 1259 OID 30690)
-- Name: sys_name_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX sys_name_index ON public.object USING btree (systematic_name);


--
-- TOC entry 3445 (class 1259 OID 30691)
-- Name: target_gene_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX target_gene_com_index ON public.object_vectors USING gist (target_gene_comments);


--
-- TOC entry 3576 (class 1259 OID 30692)
-- Name: target_gene_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX target_gene_comments_index ON public.target_gene USING gist (comments_vector);


--
-- TOC entry 3577 (class 1259 OID 30693)
-- Name: target_gene_desc_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX target_gene_desc_index ON public.target_gene USING gist (description_vector);


--
-- TOC entry 3578 (class 1259 OID 30694)
-- Name: target_gene_effect_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX target_gene_effect_index ON public.target_gene USING gist (effect_vector);


--
-- TOC entry 3579 (class 1259 OID 30695)
-- Name: target_gene_official_id_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX target_gene_official_id_index ON public.target_gene USING btree (official_gene_id);


--
-- TOC entry 3582 (class 1259 OID 30696)
-- Name: target_gene_technique_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX target_gene_technique_index ON public.target_gene USING gist (technique_vector);


--
-- TOC entry 3446 (class 1259 OID 30697)
-- Name: tissue_distribution_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX tissue_distribution_com_index ON public.object_vectors USING gist (tissue_distribution_comments);


--
-- TOC entry 3591 (class 1259 OID 30698)
-- Name: tissue_technique_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX tissue_technique_index ON public.tissue_distribution USING gist (technique_vector);


--
-- TOC entry 3592 (class 1259 OID 30699)
-- Name: tissues_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX tissues_index ON public.tissue_distribution USING gist (tissues_vector);


--
-- TOC entry 3602 (class 1259 OID 30700)
-- Name: trans_grac_stoichiometry_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX trans_grac_stoichiometry_index ON public.transporter USING gist (grac_stoichiometry_vector);


--
-- TOC entry 3599 (class 1259 OID 30701)
-- Name: transduction_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX transduction_comments_index ON public.transduction USING gist (comments_vector);


--
-- TOC entry 3605 (class 1259 OID 30702)
-- Name: var_description_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX var_description_index ON public.variant USING gist (description_vector);


--
-- TOC entry 3447 (class 1259 OID 30703)
-- Name: variants_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX variants_com_index ON public.object_vectors USING gist (variants_comments);


--
-- TOC entry 3448 (class 1259 OID 30704)
-- Name: voltage_dependence_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX voltage_dependence_com_index ON public.object_vectors USING gist (voltage_dependence_comments);


--
-- TOC entry 3624 (class 1259 OID 30705)
-- Name: voltdep_cell_type_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX voltdep_cell_type_index ON public.voltage_dependence USING gist (cell_type_vector);


--
-- TOC entry 3625 (class 1259 OID 30706)
-- Name: voltdep_comments_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX voltdep_comments_index ON public.voltage_dependence USING gist (comments_vector);


--
-- TOC entry 3626 (class 1259 OID 30707)
-- Name: xeno_exp_change_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX xeno_exp_change_index ON public.xenobiotic_expression USING gist (change_vector);


--
-- TOC entry 3627 (class 1259 OID 30708)
-- Name: xeno_exp_technique_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX xeno_exp_technique_index ON public.xenobiotic_expression USING gist (technique_vector);


--
-- TOC entry 3628 (class 1259 OID 30709)
-- Name: xeno_exp_tissue_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX xeno_exp_tissue_index ON public.xenobiotic_expression USING gist (tissue_vector);


--
-- TOC entry 3449 (class 1259 OID 30710)
-- Name: xenobiotic_expression_com_index; Type: INDEX; Schema: public; Owner: simon
--

CREATE INDEX xenobiotic_expression_com_index ON public.object_vectors USING gist (xenobiotic_expression_comments);


--
-- TOC entry 3638 (class 2606 OID 30711)
-- Name: altered_expression_refs altered_expression_altered_expression_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.altered_expression_refs
    ADD CONSTRAINT altered_expression_altered_expression_refs_fk FOREIGN KEY (altered_expression_id) REFERENCES public.altered_expression(altered_expression_id);


--
-- TOC entry 3636 (class 2606 OID 30716)
-- Name: altered_expression alterered_expression_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.altered_expression
    ADD CONSTRAINT alterered_expression_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3643 (class 2606 OID 30721)
-- Name: associated_protein_refs associated_protein_associated_protein_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.associated_protein_refs
    ADD CONSTRAINT associated_protein_associated_protein_refs_fk FOREIGN KEY (associated_protein_id) REFERENCES public.associated_protein(associated_protein_id);


--
-- TOC entry 3647 (class 2606 OID 30726)
-- Name: binding_partner_refs binding_partner_binding_partner_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.binding_partner_refs
    ADD CONSTRAINT binding_partner_binding_partner_refs_fk FOREIGN KEY (binding_partner_id) REFERENCES public.binding_partner(binding_partner_id);


--
-- TOC entry 3738 (class 2606 OID 30731)
-- Name: immuno2co_celltype cellonto_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno2co_celltype
    ADD CONSTRAINT cellonto_id_fk FOREIGN KEY (cellonto_id) REFERENCES public.co_celltype(cellonto_id);


--
-- TOC entry 3653 (class 2606 OID 30736)
-- Name: celltype_assoc_refs celltype_assoc_celltype_assoc_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc_refs
    ADD CONSTRAINT celltype_assoc_celltype_assoc_refs_fk FOREIGN KEY (celltype_assoc_id) REFERENCES public.celltype_assoc(celltype_assoc_id);


--
-- TOC entry 3652 (class 2606 OID 30741)
-- Name: celltype_assoc_colist celltype_assoc_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc_colist
    ADD CONSTRAINT celltype_assoc_id_fk FOREIGN KEY (celltype_assoc_id) REFERENCES public.celltype_assoc(celltype_assoc_id);


--
-- TOC entry 3656 (class 2606 OID 30746)
-- Name: cellular_location_refs cellular_location_cellular_location_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cellular_location_refs
    ADD CONSTRAINT cellular_location_cellular_location_refs_fk FOREIGN KEY (cellular_location_id) REFERENCES public.cellular_location(cellular_location_id);


--
-- TOC entry 3659 (class 2606 OID 30751)
-- Name: co_celltype_isa child_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.co_celltype_isa
    ADD CONSTRAINT child_id_fk FOREIGN KEY (child_id) REFERENCES public.co_celltype(co_celltype_id);


--
-- TOC entry 3722 (class 2606 OID 30756)
-- Name: go_process_rel child_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.go_process_rel
    ADD CONSTRAINT child_id_fk FOREIGN KEY (child_id) REFERENCES public.go_process(go_process_id) ON DELETE CASCADE;


--
-- TOC entry 3703 (class 2606 OID 30761)
-- Name: do_disease_isa child_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.do_disease_isa
    ADD CONSTRAINT child_id_fk FOREIGN KEY (child_id) REFERENCES public.do_disease(do_disease_id);


--
-- TOC entry 3664 (class 2606 OID 30766)
-- Name: cofactor_refs cofactor_cofactor_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor_refs
    ADD CONSTRAINT cofactor_cofactor_refs_fk FOREIGN KEY (cofactor_id) REFERENCES public.cofactor(cofactor_id);


--
-- TOC entry 3674 (class 2606 OID 30771)
-- Name: contributor2committee committee_contributor2committee_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2committee
    ADD CONSTRAINT committee_contributor2committee_fk FOREIGN KEY (committee_id) REFERENCES public.committee(committee_id);


--
-- TOC entry 3669 (class 2606 OID 30776)
-- Name: conductance_refs conductance_conductance_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_refs
    ADD CONSTRAINT conductance_conductance_refs_fk FOREIGN KEY (conductance_id) REFERENCES public.conductance(conductance_id);


--
-- TOC entry 3672 (class 2606 OID 30781)
-- Name: conductance_states_refs conductance_states_conductance_states_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_states_refs
    ADD CONSTRAINT conductance_states_conductance_states_refs_fk FOREIGN KEY (conductance_states_id) REFERENCES public.conductance_states(conductance_states_id);


--
-- TOC entry 3675 (class 2606 OID 30786)
-- Name: contributor2committee contributor_contributor2committee_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2committee
    ADD CONSTRAINT contributor_contributor2committee_fk FOREIGN KEY (contributor_id) REFERENCES public.contributor(contributor_id);


--
-- TOC entry 3676 (class 2606 OID 30791)
-- Name: contributor2family contributor_contributor2family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2family
    ADD CONSTRAINT contributor_contributor2family_fk FOREIGN KEY (contributor_id) REFERENCES public.contributor(contributor_id);


--
-- TOC entry 3678 (class 2606 OID 30796)
-- Name: contributor2intro contributor_contributor2intro_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2intro
    ADD CONSTRAINT contributor_contributor2intro_fk FOREIGN KEY (contributor_id) REFERENCES public.contributor(contributor_id);


--
-- TOC entry 3680 (class 2606 OID 30801)
-- Name: contributor2object contributor_contributor2object_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2object
    ADD CONSTRAINT contributor_contributor2object_fk FOREIGN KEY (contributor_id) REFERENCES public.contributor(contributor_id);


--
-- TOC entry 3682 (class 2606 OID 30806)
-- Name: contributor_link contributor_contributor_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor_link
    ADD CONSTRAINT contributor_contributor_link_fk FOREIGN KEY (contributor_id) REFERENCES public.contributor(contributor_id);


--
-- TOC entry 3859 (class 2606 OID 30811)
-- Name: subcommittee contributor_subcommittee_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.subcommittee
    ADD CONSTRAINT contributor_subcommittee_fk FOREIGN KEY (contributor_id) REFERENCES public.contributor(contributor_id);


--
-- TOC entry 3686 (class 2606 OID 30816)
-- Name: coregulator_refs coregulator_coregulator_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator_refs
    ADD CONSTRAINT coregulator_coregulator_refs_fk FOREIGN KEY (coregulator_id) REFERENCES public.coregulator(coregulator_id);


--
-- TOC entry 3683 (class 2606 OID 30821)
-- Name: coregulator coregulator_gene_coregulator_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator
    ADD CONSTRAINT coregulator_gene_coregulator_fk FOREIGN KEY (coregulator_gene_id) REFERENCES public.coregulator_gene(coregulator_gene_id);


--
-- TOC entry 3688 (class 2606 OID 30826)
-- Name: database_link database_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.database_link
    ADD CONSTRAINT database_database_link_fk FOREIGN KEY (database_id) REFERENCES public.database(database_id);


--
-- TOC entry 3696 (class 2606 OID 30831)
-- Name: disease_database_link database_disease_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_database_link
    ADD CONSTRAINT database_disease_database_link_fk FOREIGN KEY (database_id) REFERENCES public.database(database_id);


--
-- TOC entry 3777 (class 2606 OID 30836)
-- Name: ligand_database_link database_ligand_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_database_link
    ADD CONSTRAINT database_ligand_database_link_fk FOREIGN KEY (database_id) REFERENCES public.database(database_id);


--
-- TOC entry 3885 (class 2606 OID 30841)
-- Name: variant2database_link database_link_variant2database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant2database_link
    ADD CONSTRAINT database_link_variant2database_link_fk FOREIGN KEY (database_link_id) REFERENCES public.database_link(database_link_id);


--
-- TOC entry 3761 (class 2606 OID 30846)
-- Name: iuphar2discoverx discoverx_iuphar2discoverx_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.iuphar2discoverx
    ADD CONSTRAINT discoverx_iuphar2discoverx_fk FOREIGN KEY (cat_no) REFERENCES public.discoverx(cat_no);


--
-- TOC entry 3698 (class 2606 OID 30851)
-- Name: disease_synonym2database_link disease2synonym_disease_synonym2database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_synonym2database_link
    ADD CONSTRAINT disease2synonym_disease_synonym2database_link_fk FOREIGN KEY (disease2synonym_id) REFERENCES public.disease2synonym(disease2synonym_id);


--
-- TOC entry 3693 (class 2606 OID 30856)
-- Name: disease2category disease_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease2category
    ADD CONSTRAINT disease_category_id_fk FOREIGN KEY (disease_category_id) REFERENCES public.disease_category(disease_category_id);


--
-- TOC entry 3699 (class 2606 OID 30861)
-- Name: disease_synonym2database_link disease_database_link_disease_synonym2database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_synonym2database_link
    ADD CONSTRAINT disease_database_link_disease_synonym2database_link_fk FOREIGN KEY (disease_database_link_id) REFERENCES public.disease_database_link(disease_database_link_id);


--
-- TOC entry 3695 (class 2606 OID 30866)
-- Name: disease2synonym disease_disease2synonym_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease2synonym
    ADD CONSTRAINT disease_disease2synonym_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3697 (class 2606 OID 30871)
-- Name: disease_database_link disease_disease_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease_database_link
    ADD CONSTRAINT disease_disease_database_link_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3705 (class 2606 OID 30876)
-- Name: drug2disease disease_drug2disease_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.drug2disease
    ADD CONSTRAINT disease_drug2disease_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3694 (class 2606 OID 30881)
-- Name: disease2category disease_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.disease2category
    ADD CONSTRAINT disease_id_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3740 (class 2606 OID 30886)
-- Name: immuno_disease2ligand disease_immuno_disease2ligand_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2ligand
    ADD CONSTRAINT disease_immuno_disease2ligand_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3744 (class 2606 OID 30891)
-- Name: immuno_disease2object disease_immuno_disease2object_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2object
    ADD CONSTRAINT disease_immuno_disease2object_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3798 (class 2606 OID 30896)
-- Name: pathophysiology disease_pathophysiology_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pathophysiology
    ADD CONSTRAINT disease_pathophysiology_fk FOREIGN KEY (disease_id) REFERENCES public.disease(disease_id);


--
-- TOC entry 3701 (class 2606 OID 30901)
-- Name: dna_binding_refs dna_binding_dna_binding_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.dna_binding_refs
    ADD CONSTRAINT dna_binding_dna_binding_refs_fk FOREIGN KEY (dna_binding_id) REFERENCES public.dna_binding(dna_binding_id);


--
-- TOC entry 3661 (class 2606 OID 30906)
-- Name: cofactor enzyme_cofactor_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor
    ADD CONSTRAINT enzyme_cofactor_fk FOREIGN KEY (object_id) REFERENCES public.enzyme(object_id);


--
-- TOC entry 3709 (class 2606 OID 30911)
-- Name: expression_level expression_experiment_expression_level_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_level
    ADD CONSTRAINT expression_experiment_expression_level_fk FOREIGN KEY (expression_experiment_id) REFERENCES public.expression_experiment(expression_experiment_id);


--
-- TOC entry 3714 (class 2606 OID 30916)
-- Name: expression_pathophysiology_refs expression_pathophysiology_expression_pathophysiology_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_pathophysiology_refs
    ADD CONSTRAINT expression_pathophysiology_expression_pathophysiology_refs_fk FOREIGN KEY (expression_pathophysiology_id) REFERENCES public.expression_pathophysiology(expression_pathophysiology_id);


--
-- TOC entry 3666 (class 2606 OID 30921)
-- Name: committee family_committee_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.committee
    ADD CONSTRAINT family_committee_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3677 (class 2606 OID 30926)
-- Name: contributor2family family_contributor2family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2family
    ADD CONSTRAINT family_contributor2family_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3691 (class 2606 OID 30931)
-- Name: deleted_family family_deleted_family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.deleted_family
    ADD CONSTRAINT family_deleted_family_fk FOREIGN KEY (new_family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3725 (class 2606 OID 30936)
-- Name: grac_family_text family_grac_family_text_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_family_text
    ADD CONSTRAINT family_grac_family_text_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3727 (class 2606 OID 30941)
-- Name: grac_further_reading family_grac_further_reading_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_further_reading
    ADD CONSTRAINT family_grac_further_reading_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3734 (class 2606 OID 30946)
-- Name: grouping family_grouping_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public."grouping"
    ADD CONSTRAINT family_grouping_fk FOREIGN KEY (group_id) REFERENCES public.family(family_id);


--
-- TOC entry 3735 (class 2606 OID 30951)
-- Name: grouping family_grouping_fk1; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public."grouping"
    ADD CONSTRAINT family_grouping_fk1 FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3748 (class 2606 OID 30956)
-- Name: immunopaedia2family family_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2family
    ADD CONSTRAINT family_id_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3760 (class 2606 OID 30961)
-- Name: introduction family_introduction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.introduction
    ADD CONSTRAINT family_introduction_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3766 (class 2606 OID 30966)
-- Name: ligand2family family_ligand2family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2family
    ADD CONSTRAINT family_ligand2family_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3833 (class 2606 OID 30971)
-- Name: receptor2family family_receptor2family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor2family
    ADD CONSTRAINT family_receptor2family_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3860 (class 2606 OID 30976)
-- Name: subcommittee family_subcommittee_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.subcommittee
    ADD CONSTRAINT family_subcommittee_fk FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 3718 (class 2606 OID 30981)
-- Name: functional_assay_refs functional_assay_functional_assay_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.functional_assay_refs
    ADD CONSTRAINT functional_assay_functional_assay_refs_fk FOREIGN KEY (functional_assay_id) REFERENCES public.functional_assay(functional_assay_id);


--
-- TOC entry 3791 (class 2606 OID 30986)
-- Name: object2go_process go_process_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object2go_process
    ADD CONSTRAINT go_process_id_fk FOREIGN KEY (go_process_id) REFERENCES public.go_process(go_process_id) ON DELETE CASCADE;


--
-- TOC entry 3731 (class 2606 OID 30991)
-- Name: grac_ligand_rank_potency_refs grac_ligand_rank_potency_grac_ligand_rank_potency_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_ligand_rank_potency_refs
    ADD CONSTRAINT grac_ligand_rank_potency_grac_ligand_rank_potency_refs_fk FOREIGN KEY (grac_ligand_rank_potency_id) REFERENCES public.grac_ligand_rank_potency(grac_ligand_rank_potency_id);


--
-- TOC entry 3736 (class 2606 OID 30996)
-- Name: gtip2go_process gtip_process_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.gtip2go_process
    ADD CONSTRAINT gtip_process_id_fk FOREIGN KEY (gtip_process_id) REFERENCES public.gtip_process(gtip_process_id);


--
-- TOC entry 3822 (class 2606 OID 31001)
-- Name: process_assoc gtip_process_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.process_assoc
    ADD CONSTRAINT gtip_process_id_fk FOREIGN KEY (gtip_process_id) REFERENCES public.gtip_process(gtip_process_id);


--
-- TOC entry 3650 (class 2606 OID 31006)
-- Name: celltype_assoc immuno_celltype_celltype_assoc_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc
    ADD CONSTRAINT immuno_celltype_celltype_assoc_fk FOREIGN KEY (immuno_celltype_id) REFERENCES public.immuno_celltype(immuno_celltype_id);


--
-- TOC entry 3739 (class 2606 OID 31011)
-- Name: immuno2co_celltype immuno_celltype_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno2co_celltype
    ADD CONSTRAINT immuno_celltype_id_fk FOREIGN KEY (immuno_celltype_id) REFERENCES public.immuno_celltype(immuno_celltype_id);


--
-- TOC entry 3742 (class 2606 OID 31016)
-- Name: immuno_disease2ligand_refs immuno_disease2ligand_immuno_disease2ligand_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2ligand_refs
    ADD CONSTRAINT immuno_disease2ligand_immuno_disease2ligand_refs_fk FOREIGN KEY (immuno_disease2ligand_id) REFERENCES public.immuno_disease2ligand(immuno_disease2ligand_id);


--
-- TOC entry 3746 (class 2606 OID 31021)
-- Name: immuno_disease2object_refs immuno_disease2object_immuno_disease2object_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2object_refs
    ADD CONSTRAINT immuno_disease2object_immuno_disease2object_refs_fk FOREIGN KEY (immuno_disease2object_id) REFERENCES public.immuno_disease2object(immuno_disease2object_id);


--
-- TOC entry 3749 (class 2606 OID 31026)
-- Name: immunopaedia2family immunopaedia2family_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2family
    ADD CONSTRAINT immunopaedia2family_id_fk FOREIGN KEY (immunopaedia_case_id) REFERENCES public.immunopaedia_cases(immunopaedia_case_id);


--
-- TOC entry 3750 (class 2606 OID 31031)
-- Name: immunopaedia2ligand immunopaedia2ligand_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2ligand
    ADD CONSTRAINT immunopaedia2ligand_id_fk FOREIGN KEY (immunopaedia_case_id) REFERENCES public.immunopaedia_cases(immunopaedia_case_id);


--
-- TOC entry 3752 (class 2606 OID 31036)
-- Name: immunopaedia2object immunopaedia2object_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2object
    ADD CONSTRAINT immunopaedia2object_id_fk FOREIGN KEY (immunopaedia_case_id) REFERENCES public.immunopaedia_cases(immunopaedia_case_id);


--
-- TOC entry 3768 (class 2606 OID 31041)
-- Name: ligand2inn inn_ligand2inn_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2inn
    ADD CONSTRAINT inn_ligand2inn_fk FOREIGN KEY (inn_number) REFERENCES public.inn(inn_number);


--
-- TOC entry 3758 (class 2606 OID 31046)
-- Name: interaction_affinity_refs interaction_interaction_affinity_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction_affinity_refs
    ADD CONSTRAINT interaction_interaction_affinity_refs_fk FOREIGN KEY (interaction_id) REFERENCES public.interaction(interaction_id);


--
-- TOC entry 3782 (class 2606 OID 31051)
-- Name: malaria_stage2interaction interaction_malaria_stage2interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.malaria_stage2interaction
    ADD CONSTRAINT interaction_malaria_stage2interaction_fk FOREIGN KEY (interaction_id) REFERENCES public.interaction(interaction_id);


--
-- TOC entry 3679 (class 2606 OID 31056)
-- Name: contributor2intro introduction_contributor2intro_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2intro
    ADD CONSTRAINT introduction_contributor2intro_fk FOREIGN KEY (family_id) REFERENCES public.introduction(family_id);


--
-- TOC entry 3774 (class 2606 OID 31061)
-- Name: ligand2synonym_refs ligand2synonym_ligand2synonym_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2synonym_refs
    ADD CONSTRAINT ligand2synonym_ligand2synonym_refs_fk FOREIGN KEY (ligand2synonym_id) REFERENCES public.ligand2synonym(ligand2synonym_id);


--
-- TOC entry 3640 (class 2606 OID 31066)
-- Name: analogue_cluster ligand_analogue_cluster_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.analogue_cluster
    ADD CONSTRAINT ligand_analogue_cluster_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3662 (class 2606 OID 31071)
-- Name: cofactor ligand_cofactor_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor
    ADD CONSTRAINT ligand_cofactor_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3706 (class 2606 OID 31076)
-- Name: drug2disease ligand_drug2disease_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.drug2disease
    ADD CONSTRAINT ligand_drug2disease_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3751 (class 2606 OID 31081)
-- Name: immunopaedia2ligand ligand_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2ligand
    ADD CONSTRAINT ligand_id_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3754 (class 2606 OID 31086)
-- Name: interaction ligand_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction
    ADD CONSTRAINT ligand_interaction_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3755 (class 2606 OID 31091)
-- Name: interaction ligand_interaction_fk1; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction
    ADD CONSTRAINT ligand_interaction_fk1 FOREIGN KEY (target_ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3763 (class 2606 OID 31096)
-- Name: iuphar2tocris ligand_iuphar2tocris_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.iuphar2tocris
    ADD CONSTRAINT ligand_iuphar2tocris_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3767 (class 2606 OID 31101)
-- Name: ligand2family ligand_ligand2family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2family
    ADD CONSTRAINT ligand_ligand2family_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3769 (class 2606 OID 31106)
-- Name: ligand2inn ligand_ligand2inn_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2inn
    ADD CONSTRAINT ligand_ligand2inn_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3770 (class 2606 OID 31111)
-- Name: ligand2meshpharmacology ligand_ligand2meshpharmacology_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2meshpharmacology
    ADD CONSTRAINT ligand_ligand2meshpharmacology_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3771 (class 2606 OID 31116)
-- Name: ligand2subunit ligand_ligand2subunit_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2subunit
    ADD CONSTRAINT ligand_ligand2subunit_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3772 (class 2606 OID 31121)
-- Name: ligand2subunit ligand_ligand2subunit_fk1; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2subunit
    ADD CONSTRAINT ligand_ligand2subunit_fk1 FOREIGN KEY (subunit_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3773 (class 2606 OID 31126)
-- Name: ligand2synonym ligand_ligand2synonym_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2synonym
    ADD CONSTRAINT ligand_ligand2synonym_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3776 (class 2606 OID 31131)
-- Name: ligand_cluster ligand_ligand_cluster_fk2; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_cluster
    ADD CONSTRAINT ligand_ligand_cluster_fk2 FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3778 (class 2606 OID 31136)
-- Name: ligand_database_link ligand_ligand_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_database_link
    ADD CONSTRAINT ligand_ligand_database_link_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3780 (class 2606 OID 31141)
-- Name: list_ligand ligand_ligand_list_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.list_ligand
    ADD CONSTRAINT ligand_ligand_list_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3802 (class 2606 OID 31146)
-- Name: pdb_structure ligand_pdb_structure_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure
    ADD CONSTRAINT ligand_pdb_structure_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3807 (class 2606 OID 31151)
-- Name: peptide ligand_peptide_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.peptide
    ADD CONSTRAINT ligand_peptide_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3809 (class 2606 OID 31156)
-- Name: peptide_ligand_sequence_cluster ligand_peptide_ligand_cluster_1_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.peptide_ligand_sequence_cluster
    ADD CONSTRAINT ligand_peptide_ligand_cluster_1_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3808 (class 2606 OID 31161)
-- Name: peptide_ligand_cluster ligand_peptide_ligand_cluster_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.peptide_ligand_cluster
    ADD CONSTRAINT ligand_peptide_ligand_cluster_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3826 (class 2606 OID 31166)
-- Name: prodrug ligand_prodrug_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.prodrug
    ADD CONSTRAINT ligand_prodrug_fk FOREIGN KEY (prodrug_ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3827 (class 2606 OID 31171)
-- Name: prodrug ligand_prodrug_fk1; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.prodrug
    ADD CONSTRAINT ligand_prodrug_fk1 FOREIGN KEY (drug_ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3828 (class 2606 OID 31176)
-- Name: product ligand_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT ligand_product_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3839 (class 2606 OID 31181)
-- Name: reference2ligand ligand_reference2ligand_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reference2ligand
    ADD CONSTRAINT ligand_reference2ligand_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3841 (class 2606 OID 31186)
-- Name: screen_interaction ligand_screen_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_interaction
    ADD CONSTRAINT ligand_screen_interaction_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3861 (class 2606 OID 31191)
-- Name: substrate ligand_substrate_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate
    ADD CONSTRAINT ligand_substrate_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3873 (class 2606 OID 31196)
-- Name: target_ligand_same_entity ligand_target_ligand_same_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_ligand_same_entity
    ADD CONSTRAINT ligand_target_ligand_same_entity_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3783 (class 2606 OID 31201)
-- Name: malaria_stage2interaction malaria_stage_malaria_stage2interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.malaria_stage2interaction
    ADD CONSTRAINT malaria_stage_malaria_stage2interaction_fk FOREIGN KEY (malaria_stage_id) REFERENCES public.malaria_stage(malaria_stage_id);


--
-- TOC entry 3788 (class 2606 OID 31206)
-- Name: mutation_refs mutation_mutation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation_refs
    ADD CONSTRAINT mutation_mutation_refs_fk FOREIGN KEY (mutation_id) REFERENCES public.mutation(mutation_id);


--
-- TOC entry 3633 (class 2606 OID 31211)
-- Name: accessory_protein object_accessory_protein_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.accessory_protein
    ADD CONSTRAINT object_accessory_protein_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3641 (class 2606 OID 31216)
-- Name: associated_protein object_associated_protein_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.associated_protein
    ADD CONSTRAINT object_associated_protein_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3642 (class 2606 OID 31221)
-- Name: associated_protein object_associated_protein_fk1; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.associated_protein
    ADD CONSTRAINT object_associated_protein_fk1 FOREIGN KEY (associated_object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3645 (class 2606 OID 31226)
-- Name: binding_partner object_binding_partner_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.binding_partner
    ADD CONSTRAINT object_binding_partner_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3646 (class 2606 OID 31231)
-- Name: binding_partner object_binding_partner_partner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.binding_partner
    ADD CONSTRAINT object_binding_partner_partner_id_fk FOREIGN KEY (partner_object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3649 (class 2606 OID 31236)
-- Name: catalytic_receptor object_catalytic_receptor_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.catalytic_receptor
    ADD CONSTRAINT object_catalytic_receptor_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3651 (class 2606 OID 31241)
-- Name: celltype_assoc object_celltype_assoc_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc
    ADD CONSTRAINT object_celltype_assoc_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3655 (class 2606 OID 31246)
-- Name: cellular_location object_cellular_location_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cellular_location
    ADD CONSTRAINT object_cellular_location_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3658 (class 2606 OID 31251)
-- Name: chembl_cluster object_chembl_cluster_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.chembl_cluster
    ADD CONSTRAINT object_chembl_cluster_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3667 (class 2606 OID 31256)
-- Name: conductance object_conductance_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance
    ADD CONSTRAINT object_conductance_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3671 (class 2606 OID 31261)
-- Name: conductance_states object_conductance_states_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_states
    ADD CONSTRAINT object_conductance_states_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3681 (class 2606 OID 31266)
-- Name: contributor2object object_contributor2object_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.contributor2object
    ADD CONSTRAINT object_contributor2object_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3684 (class 2606 OID 31271)
-- Name: coregulator object_coregulator_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator
    ADD CONSTRAINT object_coregulator_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3689 (class 2606 OID 31276)
-- Name: database_link object_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.database_link
    ADD CONSTRAINT object_database_link_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3700 (class 2606 OID 31281)
-- Name: dna_binding object_dna_binding_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.dna_binding
    ADD CONSTRAINT object_dna_binding_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3707 (class 2606 OID 31286)
-- Name: enzyme object_enzyme_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.enzyme
    ADD CONSTRAINT object_enzyme_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3712 (class 2606 OID 31291)
-- Name: expression_pathophysiology object_expression_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_pathophysiology
    ADD CONSTRAINT object_expression_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3716 (class 2606 OID 31296)
-- Name: functional_assay object_functional_assay_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.functional_assay
    ADD CONSTRAINT object_functional_assay_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3720 (class 2606 OID 31301)
-- Name: further_reading object_further_reading_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.further_reading
    ADD CONSTRAINT object_further_reading_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3724 (class 2606 OID 31306)
-- Name: gpcr object_gpcr_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.gpcr
    ADD CONSTRAINT object_gpcr_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3726 (class 2606 OID 31311)
-- Name: grac_functional_characteristics object_grac_functional_characteristics_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_functional_characteristics
    ADD CONSTRAINT object_grac_functional_characteristics_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3729 (class 2606 OID 31316)
-- Name: grac_ligand_rank_potency object_grac_ligand_rank_potency_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_ligand_rank_potency
    ADD CONSTRAINT object_grac_ligand_rank_potency_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3733 (class 2606 OID 31321)
-- Name: grac_transduction object_grac_transduction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_transduction
    ADD CONSTRAINT object_grac_transduction_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3792 (class 2606 OID 31326)
-- Name: object2go_process object_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object2go_process
    ADD CONSTRAINT object_id_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3823 (class 2606 OID 31331)
-- Name: process_assoc object_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.process_assoc
    ADD CONSTRAINT object_id_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3753 (class 2606 OID 31336)
-- Name: immunopaedia2object object_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immunopaedia2object
    ADD CONSTRAINT object_id_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3741 (class 2606 OID 31341)
-- Name: immuno_disease2ligand object_immuno_disease2ligand_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2ligand
    ADD CONSTRAINT object_immuno_disease2ligand_fk FOREIGN KEY (ligand_id) REFERENCES public.ligand(ligand_id);


--
-- TOC entry 3745 (class 2606 OID 31346)
-- Name: immuno_disease2object object_immuno_disease2object_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2object
    ADD CONSTRAINT object_immuno_disease2object_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3756 (class 2606 OID 31351)
-- Name: interaction object_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction
    ADD CONSTRAINT object_interaction_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3762 (class 2606 OID 31356)
-- Name: iuphar2discoverx object_iuphar2discoverx_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.iuphar2discoverx
    ADD CONSTRAINT object_iuphar2discoverx_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3765 (class 2606 OID 31361)
-- Name: lgic object_lgic_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.lgic
    ADD CONSTRAINT object_lgic_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3781 (class 2606 OID 31366)
-- Name: list_ligand object_ligand_list_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.list_ligand
    ADD CONSTRAINT object_ligand_list_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3784 (class 2606 OID 31371)
-- Name: multimer object_multimer_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.multimer
    ADD CONSTRAINT object_multimer_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3785 (class 2606 OID 31376)
-- Name: mutation object_mutation_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation
    ADD CONSTRAINT object_mutation_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3790 (class 2606 OID 31381)
-- Name: nhr object_nhr_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.nhr
    ADD CONSTRAINT object_nhr_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3793 (class 2606 OID 31386)
-- Name: object2reaction object_object2reaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object2reaction
    ADD CONSTRAINT object_object2reaction_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3796 (class 2606 OID 31391)
-- Name: other_ic object_other_ic_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.other_ic
    ADD CONSTRAINT object_other_ic_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3797 (class 2606 OID 31396)
-- Name: other_protein object_other_protein_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.other_protein
    ADD CONSTRAINT object_other_protein_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3799 (class 2606 OID 31401)
-- Name: pathophysiology object_pathophysiology_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pathophysiology
    ADD CONSTRAINT object_pathophysiology_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3803 (class 2606 OID 31406)
-- Name: pdb_structure object_pdb_structure_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure
    ADD CONSTRAINT object_pdb_structure_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3810 (class 2606 OID 31411)
-- Name: physiological_function object_physiological_function_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.physiological_function
    ADD CONSTRAINT object_physiological_function_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3818 (class 2606 OID 31416)
-- Name: primary_regulator object_primary_regulator_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.primary_regulator
    ADD CONSTRAINT object_primary_regulator_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3819 (class 2606 OID 31421)
-- Name: primary_regulator object_primary_regulator_regulator_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.primary_regulator
    ADD CONSTRAINT object_primary_regulator_regulator_fk FOREIGN KEY (regulator_object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3829 (class 2606 OID 31426)
-- Name: product object_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT object_product_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3837 (class 2606 OID 31431)
-- Name: receptor_basic object_receptor_basic_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor_basic
    ADD CONSTRAINT object_receptor_basic_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3842 (class 2606 OID 31436)
-- Name: screen_interaction object_screen_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_interaction
    ADD CONSTRAINT object_screen_interaction_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3847 (class 2606 OID 31441)
-- Name: selectivity object_selectivity_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.selectivity
    ADD CONSTRAINT object_selectivity_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3851 (class 2606 OID 31446)
-- Name: specific_reaction object_specific_reaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.specific_reaction
    ADD CONSTRAINT object_specific_reaction_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3855 (class 2606 OID 31451)
-- Name: structural_info object_structural_info_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.structural_info
    ADD CONSTRAINT object_structural_info_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3862 (class 2606 OID 31456)
-- Name: substrate object_substrate_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate
    ADD CONSTRAINT object_substrate_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3835 (class 2606 OID 31461)
-- Name: receptor2subunit object_subunits_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor2subunit
    ADD CONSTRAINT object_subunits_fk FOREIGN KEY (receptor_id) REFERENCES public.object(object_id);


--
-- TOC entry 3836 (class 2606 OID 31466)
-- Name: receptor2subunit object_subunits_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor2subunit
    ADD CONSTRAINT object_subunits_fk_1 FOREIGN KEY (subunit_id) REFERENCES public.object(object_id);


--
-- TOC entry 3866 (class 2606 OID 31471)
-- Name: synonym object_synonym_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.synonym
    ADD CONSTRAINT object_synonym_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3869 (class 2606 OID 31476)
-- Name: target_gene object_target_gene_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_gene
    ADD CONSTRAINT object_target_gene_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3874 (class 2606 OID 31481)
-- Name: target_ligand_same_entity object_target_ligand_same_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_ligand_same_entity
    ADD CONSTRAINT object_target_ligand_same_entity_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3875 (class 2606 OID 31486)
-- Name: tissue_distribution object_tissue_distribution_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue_distribution
    ADD CONSTRAINT object_tissue_distribution_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3879 (class 2606 OID 31491)
-- Name: transduction object_transduction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transduction
    ADD CONSTRAINT object_transduction_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3882 (class 2606 OID 31496)
-- Name: transporter object_transporter_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transporter
    ADD CONSTRAINT object_transporter_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3883 (class 2606 OID 31501)
-- Name: variant object_variant_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant
    ADD CONSTRAINT object_variant_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3889 (class 2606 OID 31506)
-- Name: vgic object_vgic_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.vgic
    ADD CONSTRAINT object_vgic_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3896 (class 2606 OID 31511)
-- Name: voltage_dependence object_voltage_dependence_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dependence
    ADD CONSTRAINT object_voltage_dependence_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3898 (class 2606 OID 31516)
-- Name: xenobiotic_expression object_xenobiotic_expression_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.xenobiotic_expression
    ADD CONSTRAINT object_xenobiotic_expression_fk FOREIGN KEY (object_id) REFERENCES public.object(object_id);


--
-- TOC entry 3795 (class 2606 OID 31521)
-- Name: ontology_term ontology_ontology_term_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ontology_term
    ADD CONSTRAINT ontology_ontology_term_fk FOREIGN KEY (ontology_id) REFERENCES public.ontology(ontology_id);


--
-- TOC entry 3634 (class 2606 OID 31526)
-- Name: allele ontology_term_allele_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.allele
    ADD CONSTRAINT ontology_term_allele_fk FOREIGN KEY (ontology_id, term_id) REFERENCES public.ontology_term(ontology_id, term_id);


--
-- TOC entry 3660 (class 2606 OID 31531)
-- Name: co_celltype_isa parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.co_celltype_isa
    ADD CONSTRAINT parent_id_fk FOREIGN KEY (parent_id) REFERENCES public.co_celltype(co_celltype_id);


--
-- TOC entry 3723 (class 2606 OID 31536)
-- Name: go_process_rel parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.go_process_rel
    ADD CONSTRAINT parent_id_fk FOREIGN KEY (parent_id) REFERENCES public.go_process(go_process_id) ON DELETE CASCADE;


--
-- TOC entry 3704 (class 2606 OID 31541)
-- Name: do_disease_isa parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.do_disease_isa
    ADD CONSTRAINT parent_id_fk FOREIGN KEY (parent_id) REFERENCES public.do_disease(do_disease_id);


--
-- TOC entry 3786 (class 2606 OID 31546)
-- Name: mutation pathophysiology_mutation_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation
    ADD CONSTRAINT pathophysiology_mutation_fk FOREIGN KEY (pathophysiology_id) REFERENCES public.pathophysiology(pathophysiology_id);


--
-- TOC entry 3800 (class 2606 OID 31551)
-- Name: pathophysiology_refs pathophysiology_pathophysiology_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pathophysiology_refs
    ADD CONSTRAINT pathophysiology_pathophysiology_refs_fk FOREIGN KEY (pathophysiology_id) REFERENCES public.pathophysiology(pathophysiology_id);


--
-- TOC entry 3805 (class 2606 OID 31556)
-- Name: pdb_structure_refs pdb_structure_pdb_structure_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure_refs
    ADD CONSTRAINT pdb_structure_pdb_structure_refs_fk FOREIGN KEY (pdb_structure_id) REFERENCES public.pdb_structure(pdb_structure_id);


--
-- TOC entry 3815 (class 2606 OID 31561)
-- Name: precursor2peptide peptide_precursor2peptide_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor2peptide
    ADD CONSTRAINT peptide_precursor2peptide_fk FOREIGN KEY (ligand_id) REFERENCES public.peptide(ligand_id);


--
-- TOC entry 3812 (class 2606 OID 31566)
-- Name: physiological_function_refs physiological_function_physiological_function_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.physiological_function_refs
    ADD CONSTRAINT physiological_function_physiological_function_refs_fk FOREIGN KEY (physiological_function_id) REFERENCES public.physiological_function(physiological_function_id);


--
-- TOC entry 3816 (class 2606 OID 31571)
-- Name: precursor2peptide precursor_precursor2peptide_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor2peptide
    ADD CONSTRAINT precursor_precursor2peptide_fk FOREIGN KEY (precursor_id) REFERENCES public.precursor(precursor_id);


--
-- TOC entry 3817 (class 2606 OID 31576)
-- Name: precursor2synonym precursor_precursor2synonym_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor2synonym
    ADD CONSTRAINT precursor_precursor2synonym_fk FOREIGN KEY (precursor_id) REFERENCES public.precursor(precursor_id);


--
-- TOC entry 3820 (class 2606 OID 31581)
-- Name: primary_regulator_refs primary_regulator_primary_regulator_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.primary_regulator_refs
    ADD CONSTRAINT primary_regulator_primary_regulator_refs_fk FOREIGN KEY (primary_regulator_id) REFERENCES public.primary_regulator(primary_regulator_id);


--
-- TOC entry 3824 (class 2606 OID 31586)
-- Name: process_assoc_refs process_assoc_process_assoc_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.process_assoc_refs
    ADD CONSTRAINT process_assoc_process_assoc_refs_fk FOREIGN KEY (process_assoc_id) REFERENCES public.process_assoc(process_assoc_id);


--
-- TOC entry 3831 (class 2606 OID 31591)
-- Name: product_refs product_product_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product_refs
    ADD CONSTRAINT product_product_refs_fk FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3794 (class 2606 OID 31596)
-- Name: object2reaction reaction_object2reaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.object2reaction
    ADD CONSTRAINT reaction_object2reaction_fk FOREIGN KEY (reaction_id) REFERENCES public.reaction(reaction_id);


--
-- TOC entry 3852 (class 2606 OID 31601)
-- Name: specific_reaction reaction_specific_reaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.specific_reaction
    ADD CONSTRAINT reaction_specific_reaction_fk FOREIGN KEY (reaction_id) REFERENCES public.reaction(reaction_id);


--
-- TOC entry 3834 (class 2606 OID 31606)
-- Name: receptor2family receptor_basic_receptor2family_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.receptor2family
    ADD CONSTRAINT receptor_basic_receptor2family_fk FOREIGN KEY (object_id) REFERENCES public.receptor_basic(object_id);


--
-- TOC entry 3639 (class 2606 OID 31611)
-- Name: altered_expression_refs reference_altered_expression_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.altered_expression_refs
    ADD CONSTRAINT reference_altered_expression_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3644 (class 2606 OID 31616)
-- Name: associated_protein_refs reference_associated_protein_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.associated_protein_refs
    ADD CONSTRAINT reference_associated_protein_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3648 (class 2606 OID 31621)
-- Name: binding_partner_refs reference_binding_partner_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.binding_partner_refs
    ADD CONSTRAINT reference_binding_partner_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3654 (class 2606 OID 31626)
-- Name: celltype_assoc_refs reference_celltype_assoc_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.celltype_assoc_refs
    ADD CONSTRAINT reference_celltype_assoc_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3657 (class 2606 OID 31631)
-- Name: cellular_location_refs reference_cellular_location_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cellular_location_refs
    ADD CONSTRAINT reference_cellular_location_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3665 (class 2606 OID 31636)
-- Name: cofactor_refs reference_cofactor_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor_refs
    ADD CONSTRAINT reference_cofactor_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3670 (class 2606 OID 31641)
-- Name: conductance_refs reference_conductance_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_refs
    ADD CONSTRAINT reference_conductance_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3673 (class 2606 OID 31646)
-- Name: conductance_states_refs reference_conductance_states_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance_states_refs
    ADD CONSTRAINT reference_conductance_states_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3687 (class 2606 OID 31651)
-- Name: coregulator_refs reference_coregulator_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator_refs
    ADD CONSTRAINT reference_coregulator_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3702 (class 2606 OID 31656)
-- Name: dna_binding_refs reference_dna_binding_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.dna_binding_refs
    ADD CONSTRAINT reference_dna_binding_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3715 (class 2606 OID 31661)
-- Name: expression_pathophysiology_refs reference_expression_pathophysiology_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_pathophysiology_refs
    ADD CONSTRAINT reference_expression_pathophysiology_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3719 (class 2606 OID 31666)
-- Name: functional_assay_refs reference_functional_assay_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.functional_assay_refs
    ADD CONSTRAINT reference_functional_assay_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3721 (class 2606 OID 31671)
-- Name: further_reading reference_further_reading_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.further_reading
    ADD CONSTRAINT reference_further_reading_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3728 (class 2606 OID 31676)
-- Name: grac_further_reading reference_grac_further_reading_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_further_reading
    ADD CONSTRAINT reference_grac_further_reading_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3732 (class 2606 OID 31681)
-- Name: grac_ligand_rank_potency_refs reference_grac_ligand_rank_potency_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_ligand_rank_potency_refs
    ADD CONSTRAINT reference_grac_ligand_rank_potency_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3737 (class 2606 OID 31686)
-- Name: hottopic_refs reference_hottopic_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.hottopic_refs
    ADD CONSTRAINT reference_hottopic_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3743 (class 2606 OID 31691)
-- Name: immuno_disease2ligand_refs reference_immuno_disease2ligand_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2ligand_refs
    ADD CONSTRAINT reference_immuno_disease2ligand_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3747 (class 2606 OID 31696)
-- Name: immuno_disease2object_refs reference_immuno_disease2object_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.immuno_disease2object_refs
    ADD CONSTRAINT reference_immuno_disease2object_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3759 (class 2606 OID 31701)
-- Name: interaction_affinity_refs reference_interaction_affinity_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction_affinity_refs
    ADD CONSTRAINT reference_interaction_affinity_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3775 (class 2606 OID 31706)
-- Name: ligand2synonym_refs reference_ligand2synonym_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand2synonym_refs
    ADD CONSTRAINT reference_ligand2synonym_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3789 (class 2606 OID 31711)
-- Name: mutation_refs reference_mutation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation_refs
    ADD CONSTRAINT reference_mutation_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3801 (class 2606 OID 31716)
-- Name: pathophysiology_refs reference_pathophysiology_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pathophysiology_refs
    ADD CONSTRAINT reference_pathophysiology_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3806 (class 2606 OID 31721)
-- Name: pdb_structure_refs reference_pdb_structure_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure_refs
    ADD CONSTRAINT reference_pdb_structure_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3813 (class 2606 OID 31726)
-- Name: physiological_function_refs reference_physiological_function_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.physiological_function_refs
    ADD CONSTRAINT reference_physiological_function_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3821 (class 2606 OID 31731)
-- Name: primary_regulator_refs reference_primary_regulator_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.primary_regulator_refs
    ADD CONSTRAINT reference_primary_regulator_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3825 (class 2606 OID 31736)
-- Name: process_assoc_refs reference_process_assoc_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.process_assoc_refs
    ADD CONSTRAINT reference_process_assoc_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3832 (class 2606 OID 31741)
-- Name: product_refs reference_product_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product_refs
    ADD CONSTRAINT reference_product_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3838 (class 2606 OID 31746)
-- Name: reference2immuno reference_reference2immuno_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reference2immuno
    ADD CONSTRAINT reference_reference2immuno_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3840 (class 2606 OID 31751)
-- Name: reference2ligand reference_reference2ligand_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.reference2ligand
    ADD CONSTRAINT reference_reference2ligand_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3845 (class 2606 OID 31756)
-- Name: screen_refs reference_screen_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_refs
    ADD CONSTRAINT reference_screen_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3849 (class 2606 OID 31761)
-- Name: selectivity_refs reference_selectivity_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.selectivity_refs
    ADD CONSTRAINT reference_selectivity_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3853 (class 2606 OID 31766)
-- Name: specific_reaction_refs reference_specific_reaction_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.specific_reaction_refs
    ADD CONSTRAINT reference_specific_reaction_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3857 (class 2606 OID 31771)
-- Name: structural_info_refs reference_structural_info_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.structural_info_refs
    ADD CONSTRAINT reference_structural_info_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3864 (class 2606 OID 31776)
-- Name: substrate_refs reference_substrate_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate_refs
    ADD CONSTRAINT reference_substrate_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3867 (class 2606 OID 31781)
-- Name: synonym_refs reference_synonym_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.synonym_refs
    ADD CONSTRAINT reference_synonym_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3871 (class 2606 OID 31786)
-- Name: target_gene_refs reference_target_gene_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_gene_refs
    ADD CONSTRAINT reference_target_gene_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3877 (class 2606 OID 31791)
-- Name: tissue_distribution_refs reference_tissue_distribution_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue_distribution_refs
    ADD CONSTRAINT reference_tissue_distribution_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3880 (class 2606 OID 31796)
-- Name: transduction_refs reference_transduction_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transduction_refs
    ADD CONSTRAINT reference_transduction_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3887 (class 2606 OID 31801)
-- Name: variant_refs reference_variant_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant_refs
    ADD CONSTRAINT reference_variant_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3890 (class 2606 OID 31806)
-- Name: voltage_dep_activation_refs reference_voltage_dep_activation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_activation_refs
    ADD CONSTRAINT reference_voltage_dep_activation_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3892 (class 2606 OID 31811)
-- Name: voltage_dep_deactivation_refs reference_voltage_dep_deactivation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_deactivation_refs
    ADD CONSTRAINT reference_voltage_dep_deactivation_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3894 (class 2606 OID 31816)
-- Name: voltage_dep_inactivation_refs reference_voltage_dep_inactivation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_inactivation_refs
    ADD CONSTRAINT reference_voltage_dep_inactivation_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3900 (class 2606 OID 31821)
-- Name: xenobiotic_expression_refs reference_xenobiotic_expression_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.xenobiotic_expression_refs
    ADD CONSTRAINT reference_xenobiotic_expression_refs_fk FOREIGN KEY (reference_id) REFERENCES public.reference(reference_id);


--
-- TOC entry 3843 (class 2606 OID 31826)
-- Name: screen_interaction screen_screen_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_interaction
    ADD CONSTRAINT screen_screen_interaction_fk FOREIGN KEY (screen_id) REFERENCES public.screen(screen_id);


--
-- TOC entry 3846 (class 2606 OID 31831)
-- Name: screen_refs screen_screen_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_refs
    ADD CONSTRAINT screen_screen_refs_fk FOREIGN KEY (screen_id) REFERENCES public.screen(screen_id);


--
-- TOC entry 3850 (class 2606 OID 31836)
-- Name: selectivity_refs selectivity_selectivity_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.selectivity_refs
    ADD CONSTRAINT selectivity_selectivity_refs_fk FOREIGN KEY (selectivity_id) REFERENCES public.selectivity(selectivity_id);


--
-- TOC entry 3635 (class 2606 OID 31841)
-- Name: allele species_allele_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.allele
    ADD CONSTRAINT species_allele_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3637 (class 2606 OID 31846)
-- Name: altered_expression species_altered_expression_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.altered_expression
    ADD CONSTRAINT species_altered_expression_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3663 (class 2606 OID 31851)
-- Name: cofactor species_cofactor_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.cofactor
    ADD CONSTRAINT species_cofactor_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3668 (class 2606 OID 31856)
-- Name: conductance species_conductance_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.conductance
    ADD CONSTRAINT species_conductance_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3685 (class 2606 OID 31861)
-- Name: coregulator_gene species_coregulator_gene_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.coregulator_gene
    ADD CONSTRAINT species_coregulator_gene_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3690 (class 2606 OID 31866)
-- Name: database_link species_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.database_link
    ADD CONSTRAINT species_database_link_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3692 (class 2606 OID 31871)
-- Name: discoverx species_discoverx_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.discoverx
    ADD CONSTRAINT species_discoverx_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3708 (class 2606 OID 31876)
-- Name: expression_experiment species_expression_experiment_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_experiment
    ADD CONSTRAINT species_expression_experiment_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3713 (class 2606 OID 31881)
-- Name: expression_pathophysiology species_expression_pathophysiology_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_pathophysiology
    ADD CONSTRAINT species_expression_pathophysiology_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3717 (class 2606 OID 31886)
-- Name: functional_assay species_functional_assay_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.functional_assay
    ADD CONSTRAINT species_functional_assay_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3730 (class 2606 OID 31891)
-- Name: grac_ligand_rank_potency species_grac_ligand_rank_potency_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.grac_ligand_rank_potency
    ADD CONSTRAINT species_grac_ligand_rank_potency_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3757 (class 2606 OID 31896)
-- Name: interaction species_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.interaction
    ADD CONSTRAINT species_interaction_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3779 (class 2606 OID 31901)
-- Name: ligand_database_link species_ligand_database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.ligand_database_link
    ADD CONSTRAINT species_ligand_database_link_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3787 (class 2606 OID 31906)
-- Name: mutation species_mutation_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.mutation
    ADD CONSTRAINT species_mutation_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3804 (class 2606 OID 31911)
-- Name: pdb_structure species_pdb_structure_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.pdb_structure
    ADD CONSTRAINT species_pdb_structure_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3811 (class 2606 OID 31916)
-- Name: physiological_function species_physiological_function_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.physiological_function
    ADD CONSTRAINT species_physiological_function_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3814 (class 2606 OID 31921)
-- Name: precursor species_precursor_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.precursor
    ADD CONSTRAINT species_precursor_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3830 (class 2606 OID 31926)
-- Name: product species_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT species_product_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3844 (class 2606 OID 31931)
-- Name: screen_interaction species_screen_interaction_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.screen_interaction
    ADD CONSTRAINT species_screen_interaction_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3848 (class 2606 OID 31936)
-- Name: selectivity species_selectivity_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.selectivity
    ADD CONSTRAINT species_selectivity_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3856 (class 2606 OID 31941)
-- Name: structural_info species_structural_info_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.structural_info
    ADD CONSTRAINT species_structural_info_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3863 (class 2606 OID 31946)
-- Name: substrate species_substrate_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate
    ADD CONSTRAINT species_substrate_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3870 (class 2606 OID 31951)
-- Name: target_gene species_target_gene_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_gene
    ADD CONSTRAINT species_target_gene_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3876 (class 2606 OID 31956)
-- Name: tissue_distribution species_tissue_distribution_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue_distribution
    ADD CONSTRAINT species_tissue_distribution_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3884 (class 2606 OID 31961)
-- Name: variant species_variant_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant
    ADD CONSTRAINT species_variant_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3897 (class 2606 OID 31966)
-- Name: voltage_dependence species_voltage_dependence_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dependence
    ADD CONSTRAINT species_voltage_dependence_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3899 (class 2606 OID 31971)
-- Name: xenobiotic_expression species_xenobiotic_expression_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.xenobiotic_expression
    ADD CONSTRAINT species_xenobiotic_expression_fk FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- TOC entry 3854 (class 2606 OID 31976)
-- Name: specific_reaction_refs specific_reaction_specific_reaction_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.specific_reaction_refs
    ADD CONSTRAINT specific_reaction_specific_reaction_refs_fk FOREIGN KEY (specific_reaction_id) REFERENCES public.specific_reaction(specific_reaction_id);


--
-- TOC entry 3710 (class 2606 OID 31981)
-- Name: expression_level structural_info_expression_level_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_level
    ADD CONSTRAINT structural_info_expression_level_fk FOREIGN KEY (structural_info_id) REFERENCES public.structural_info(structural_info_id);


--
-- TOC entry 3858 (class 2606 OID 31986)
-- Name: structural_info_refs structural_info_structural_info_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.structural_info_refs
    ADD CONSTRAINT structural_info_structural_info_refs_fk FOREIGN KEY (structural_info_id) REFERENCES public.structural_info(structural_info_id);


--
-- TOC entry 3865 (class 2606 OID 31991)
-- Name: substrate_refs substrate_substrate_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.substrate_refs
    ADD CONSTRAINT substrate_substrate_refs_fk FOREIGN KEY (substrate_id) REFERENCES public.substrate(substrate_id);


--
-- TOC entry 3868 (class 2606 OID 31996)
-- Name: synonym_refs synonym_synonym_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.synonym_refs
    ADD CONSTRAINT synonym_synonym_refs_fk FOREIGN KEY (synonym_id) REFERENCES public.synonym(synonym_id);


--
-- TOC entry 3872 (class 2606 OID 32001)
-- Name: target_gene_refs target_gene_target_gene_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.target_gene_refs
    ADD CONSTRAINT target_gene_target_gene_refs_fk FOREIGN KEY (target_gene_id) REFERENCES public.target_gene(target_gene_id);


--
-- TOC entry 3878 (class 2606 OID 32006)
-- Name: tissue_distribution_refs tissue_distribution_tissue_distribution_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.tissue_distribution_refs
    ADD CONSTRAINT tissue_distribution_tissue_distribution_refs_fk FOREIGN KEY (tissue_distribution_id) REFERENCES public.tissue_distribution(tissue_distribution_id);


--
-- TOC entry 3711 (class 2606 OID 32011)
-- Name: expression_level tissue_expression_level_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.expression_level
    ADD CONSTRAINT tissue_expression_level_fk FOREIGN KEY (tissue_id) REFERENCES public.tissue(tissue_id);


--
-- TOC entry 3764 (class 2606 OID 32016)
-- Name: iuphar2tocris tocris_iuphar2tocris_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.iuphar2tocris
    ADD CONSTRAINT tocris_iuphar2tocris_fk FOREIGN KEY (cat_no) REFERENCES public.tocris(cat_no);


--
-- TOC entry 3881 (class 2606 OID 32021)
-- Name: transduction_refs transduction_transduction_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.transduction_refs
    ADD CONSTRAINT transduction_transduction_refs_fk FOREIGN KEY (transduction_id) REFERENCES public.transduction(transduction_id);


--
-- TOC entry 3886 (class 2606 OID 32026)
-- Name: variant2database_link variant_variant2database_link_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant2database_link
    ADD CONSTRAINT variant_variant2database_link_fk FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id);


--
-- TOC entry 3888 (class 2606 OID 32031)
-- Name: variant_refs variant_variant_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.variant_refs
    ADD CONSTRAINT variant_variant_refs_fk FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id);


--
-- TOC entry 3891 (class 2606 OID 32036)
-- Name: voltage_dep_activation_refs voltage_dependence_voltage_dep_activation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_activation_refs
    ADD CONSTRAINT voltage_dependence_voltage_dep_activation_refs_fk FOREIGN KEY (voltage_dependence_id) REFERENCES public.voltage_dependence(voltage_dependence_id);


--
-- TOC entry 3893 (class 2606 OID 32041)
-- Name: voltage_dep_deactivation_refs voltage_dependence_voltage_dep_deactivation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_deactivation_refs
    ADD CONSTRAINT voltage_dependence_voltage_dep_deactivation_refs_fk FOREIGN KEY (voltage_dependence_id) REFERENCES public.voltage_dependence(voltage_dependence_id);


--
-- TOC entry 3895 (class 2606 OID 32046)
-- Name: voltage_dep_inactivation_refs voltage_dependence_voltage_dep_inactivation_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.voltage_dep_inactivation_refs
    ADD CONSTRAINT voltage_dependence_voltage_dep_inactivation_refs_fk FOREIGN KEY (voltage_dependence_id) REFERENCES public.voltage_dependence(voltage_dependence_id);


--
-- TOC entry 3901 (class 2606 OID 32051)
-- Name: xenobiotic_expression_refs xenobiotic_expression_xenobiotic_expression_refs_fk; Type: FK CONSTRAINT; Schema: public; Owner: simon
--

ALTER TABLE ONLY public.xenobiotic_expression_refs
    ADD CONSTRAINT xenobiotic_expression_xenobiotic_expression_refs_fk FOREIGN KEY (xenobiotic_expression_id) REFERENCES public.xenobiotic_expression(xenobiotic_expression_id);


--
-- TOC entry 4025 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2019-02-06 13:25:26 GMT

--
-- PostgreSQL database dump complete
--

