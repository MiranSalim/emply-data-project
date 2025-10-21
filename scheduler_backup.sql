--
-- PostgreSQL database dump
--

\restrict vwP68XZszc3iMNbLWeFI2bUm8iygY3OUueLaxQf4XuKZwff2JmMDmMKgQr9Qd8R

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Debian 16.10-1.pgdg13+1)

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
-- Name: applications_raw; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications_raw (
    id integer NOT NULL,
    application_id uuid,
    job_id integer,
    customer character varying,
    created_at timestamp without time zone,
    raw_data json
);


ALTER TABLE public.applications_raw OWNER TO postgres;

--
-- Name: applications_raw_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.applications_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.applications_raw_id_seq OWNER TO postgres;

--
-- Name: applications_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_raw_id_seq OWNED BY public.applications_raw.id;


--
-- Name: postings_raw; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postings_raw (
    id integer NOT NULL,
    job_id integer,
    vacancy_id uuid,
    customer character varying,
    media_id uuid,
    created_at timestamp without time zone,
    raw_data json
);


ALTER TABLE public.postings_raw OWNER TO postgres;

--
-- Name: postings_raw_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.postings_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.postings_raw_id_seq OWNER TO postgres;

--
-- Name: postings_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.postings_raw_id_seq OWNED BY public.postings_raw.id;


--
-- Name: applications_raw id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications_raw ALTER COLUMN id SET DEFAULT nextval('public.applications_raw_id_seq'::regclass);


--
-- Name: postings_raw id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postings_raw ALTER COLUMN id SET DEFAULT nextval('public.postings_raw_id_seq'::regclass);


--
-- Data for Name: applications_raw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications_raw (id, application_id, job_id, customer, created_at, raw_data) FROM stdin;
1	fad5e468-5e3c-4099-8856-64e64386effd	4365	acme	2025-10-11 06:15:59.07358	{"id": "fad5e468-5e3c-4099-8856-64e64386effd", "number": 55073, "vacancy_id": "902f6004-a106-49f6-b83c-e625deaeac31", "email": "hernandezjoanna@example.org", "first_name": "Catherine", "last_name": "Russell", "middle_name": null, "created": "2025-10-11T06:15:59.073580", "updated": "2025-10-15T06:15:59.073580", "status": 1, "job_id": 4365, "candidate_id": "b3aee11e-7f5c-4a8e-b5b6-54f490eec420", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": {"localization": [{"value": "Not a fit", "locale": "en"}]}, "source": {"type": "Referral"}}
2	60ee1dd5-4f60-4a95-b15d-33becbe29db0	3219	acme	2025-08-09 08:22:29.494929	{"id": "60ee1dd5-4f60-4a95-b15d-33becbe29db0", "number": 45324, "vacancy_id": "88f051d3-aaf9-48fb-9666-e053601815cd", "email": "melindahaas@example.com", "first_name": "Albert", "last_name": "Wilson", "middle_name": null, "created": "2025-08-09T08:22:29.494929", "updated": "2025-08-14T08:22:29.494929", "status": 1, "job_id": 3219, "candidate_id": "0468a11d-d22a-4eb0-bb5b-929684bafc7e", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
3	5acf9462-e297-4df0-abac-e62113daf415	3219	acme	2025-08-15 08:22:29.494929	{"id": "5acf9462-e297-4df0-abac-e62113daf415", "number": 41255, "vacancy_id": "88f051d3-aaf9-48fb-9666-e053601815cd", "email": null, "first_name": "Donna", "last_name": "Hunt", "middle_name": null, "created": "2025-08-15T08:22:29.494929", "updated": "2025-08-17T08:22:29.494929", "status": 1, "job_id": 3219, "candidate_id": "81096a99-4988-40fa-9617-513946102cc8", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Agency"}}
4	e4f6bc57-6798-47b5-83d6-b4ee93dec358	3219	acme	2025-08-17 08:22:29.494929	{"id": "e4f6bc57-6798-47b5-83d6-b4ee93dec358", "number": 38273, "vacancy_id": "88f051d3-aaf9-48fb-9666-e053601815cd", "email": "eboyle@example.net", "first_name": "Lauren", "last_name": "Fox", "middle_name": null, "created": "2025-08-17T08:22:29.494929", "updated": "2025-08-27T08:22:29.494929", "status": 1, "job_id": 3219, "candidate_id": "1e0e5915-e64d-47f5-9881-d0b4b1132ec4", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
5	0ccdb0e3-c082-440d-a4eb-fcbf23e2346b	6551	acme	2025-09-13 01:12:02.081409	{"id": "0ccdb0e3-c082-440d-a4eb-fcbf23e2346b", "number": 72227, "vacancy_id": "70c2edb2-231a-4d1d-9483-898e5cec41ed", "email": null, "first_name": "Karen", "last_name": "James", "middle_name": null, "created": "2025-09-13T01:12:02.081409", "updated": "2025-09-15T01:12:02.081409", "status": 0, "job_id": 6551, "candidate_id": "fe9d761b-bf98-4675-aa1f-986fd873a458", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
6	b116e0c9-9257-4ed6-8aa0-dc5b93d0d5ce	6551	acme	2025-10-05 01:12:02.081409	{"id": "b116e0c9-9257-4ed6-8aa0-dc5b93d0d5ce", "number": 47515, "vacancy_id": "70c2edb2-231a-4d1d-9483-898e5cec41ed", "email": null, "first_name": "Amber", "last_name": "Hill", "middle_name": null, "created": "2025-10-05T01:12:02.081409", "updated": "2025-10-13T01:12:02.081409", "status": 1, "job_id": 6551, "candidate_id": "a08b05ef-efb3-4c77-b3c6-b831ac77ad9c", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
7	155a1545-cd9b-4dcc-a8b2-1ecfc0b1ad28	6551	acme	2025-10-20 01:12:02.081409	{"id": "155a1545-cd9b-4dcc-a8b2-1ecfc0b1ad28", "number": 62078, "vacancy_id": "70c2edb2-231a-4d1d-9483-898e5cec41ed", "email": "khanwilliam@example.org", "first_name": "Robert", "last_name": "Fernandez", "middle_name": null, "created": "2025-10-20T01:12:02.081409", "updated": "2025-10-22T01:12:02.081409", "status": 1, "job_id": 6551, "candidate_id": "92988be5-5623-49dd-a0d6-d1c552485a99", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": {"localization": [{"value": "Not a fit", "locale": "en"}]}, "source": {"type": "Website"}}
8	331423b8-0a4b-49a1-89f2-d8f613782d95	6551	acme	2025-09-27 01:12:02.081409	{"id": "331423b8-0a4b-49a1-89f2-d8f613782d95", "number": 51862, "vacancy_id": "70c2edb2-231a-4d1d-9483-898e5cec41ed", "email": null, "first_name": "Justin", "last_name": "Henderson", "middle_name": null, "created": "2025-09-27T01:12:02.081409", "updated": "2025-10-01T01:12:02.081409", "status": 1, "job_id": 6551, "candidate_id": "d51ad199-c7e3-42a6-9c59-f307bb046b93", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": {"localization": [{"value": "Not a fit", "locale": "en"}]}, "source": {"type": "Website"}}
9	ef2aa679-7974-417e-b380-000c56c60f28	6551	acme	2025-09-18 01:12:02.081409	{"id": "ef2aa679-7974-417e-b380-000c56c60f28", "number": 29432, "vacancy_id": "70c2edb2-231a-4d1d-9483-898e5cec41ed", "email": null, "first_name": "Crystal", "last_name": "Johnson", "middle_name": null, "created": "2025-09-18T01:12:02.081409", "updated": "2025-09-23T01:12:02.081409", "status": 1, "job_id": 6551, "candidate_id": "40e594be-0b0b-4390-84a0-8fad8b849714", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
10	9762fb50-d48d-4347-9dfd-623af86119da	6551	acme	2025-10-02 01:12:02.081409	{"id": "9762fb50-d48d-4347-9dfd-623af86119da", "number": 24173, "vacancy_id": "70c2edb2-231a-4d1d-9483-898e5cec41ed", "email": "msolis@example.org", "first_name": "Jillian", "last_name": "Mitchell", "middle_name": null, "created": "2025-10-02T01:12:02.081409", "updated": "2025-10-09T01:12:02.081409", "status": 1, "job_id": 6551, "candidate_id": "78ce9481-8735-4d25-b133-789968d4921c", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
11	2435ff68-55db-4756-8a28-ccb78ae7feb7	9951	acme	2025-08-18 05:29:01.43076	{"id": "2435ff68-55db-4756-8a28-ccb78ae7feb7", "number": 74962, "vacancy_id": "900afb73-93de-4db9-803a-46b69c446d0c", "email": null, "first_name": "Christina", "last_name": "Taylor", "middle_name": null, "created": "2025-08-18T05:29:01.430760", "updated": "2025-08-26T05:29:01.430760", "status": 0, "job_id": 9951, "candidate_id": "9f5ebf27-5b4f-4b8f-8dae-7a73b717db33", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
12	e3e88e41-d083-4565-9282-7c6760642a9d	9951	acme	2025-08-19 05:29:01.43076	{"id": "e3e88e41-d083-4565-9282-7c6760642a9d", "number": 30519, "vacancy_id": "900afb73-93de-4db9-803a-46b69c446d0c", "email": null, "first_name": "Debbie", "last_name": "Trevino", "middle_name": "Shane", "created": "2025-08-19T05:29:01.430760", "updated": "2025-08-26T05:29:01.430760", "status": 1, "job_id": 9951, "candidate_id": "eaad439b-345e-4192-9a7c-899138ed07ea", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
13	a0163d38-8c73-42a8-9e6c-a5b6cf22e476	9951	acme	2025-07-25 05:29:01.43076	{"id": "a0163d38-8c73-42a8-9e6c-a5b6cf22e476", "number": 31924, "vacancy_id": "900afb73-93de-4db9-803a-46b69c446d0c", "email": null, "first_name": "Kara", "last_name": "Price", "middle_name": "Thomas", "created": "2025-07-25T05:29:01.430760", "updated": "2025-07-26T05:29:01.430760", "status": 0, "job_id": 9951, "candidate_id": "9802ec82-70ff-425b-9f32-1d112a838d78", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
14	88856fac-7791-4d8f-92bf-7edf1528dfe7	9951	acme	2025-08-02 05:29:01.43076	{"id": "88856fac-7791-4d8f-92bf-7edf1528dfe7", "number": 39542, "vacancy_id": "900afb73-93de-4db9-803a-46b69c446d0c", "email": "bcruz@example.com", "first_name": "Charles", "last_name": "Valdez", "middle_name": null, "created": "2025-08-02T05:29:01.430760", "updated": "2025-08-11T05:29:01.430760", "status": 1, "job_id": 9951, "candidate_id": "e5b43501-d51b-4fb1-a794-332fa824e411", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": {"localization": [{"value": "Not a fit", "locale": "en"}]}, "source": {"type": "Website"}}
15	de5f85de-b8fb-4451-aa9d-c08784685a97	9951	acme	2025-08-15 05:29:01.43076	{"id": "de5f85de-b8fb-4451-aa9d-c08784685a97", "number": 71108, "vacancy_id": "900afb73-93de-4db9-803a-46b69c446d0c", "email": null, "first_name": "Zachary", "last_name": "Leonard", "middle_name": null, "created": "2025-08-15T05:29:01.430760", "updated": "2025-08-22T05:29:01.430760", "status": 1, "job_id": 9951, "candidate_id": "6a0eab55-2a8c-4c0a-97f7-a7b4a41d8e31", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Agency"}}
16	77fa3e21-fd9b-4a95-a7b5-b03081bf0f57	8222	acme	2025-07-24 17:33:23.208253	{"id": "77fa3e21-fd9b-4a95-a7b5-b03081bf0f57", "number": 14954, "vacancy_id": "7932261a-57ff-4405-a302-166cc704d5c3", "email": "georgewilliams@example.org", "first_name": "Kathryn", "last_name": "Martin", "middle_name": null, "created": "2025-07-24T17:33:23.208253", "updated": "2025-07-31T17:33:23.208253", "status": 1, "job_id": 8222, "candidate_id": "61835f6a-ce76-492f-bb48-c5d2d912cded", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
17	1f282c6b-0360-4ee2-a550-d2cf794b4c0a	8222	acme	2025-08-04 17:33:23.208253	{"id": "1f282c6b-0360-4ee2-a550-d2cf794b4c0a", "number": 12959, "vacancy_id": "7932261a-57ff-4405-a302-166cc704d5c3", "email": "nraymond@example.com", "first_name": "Karen", "last_name": "Sherman", "middle_name": "Crystal", "created": "2025-08-04T17:33:23.208253", "updated": "2025-08-06T17:33:23.208253", "status": 1, "job_id": 8222, "candidate_id": "ac1c1a10-467a-4b4f-8d01-b90330c8ef65", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Website"}}
18	032d9e35-ea7a-4380-b40d-60b4cc3ec9e1	1801	acme	2025-09-22 17:43:08.032758	{"id": "032d9e35-ea7a-4380-b40d-60b4cc3ec9e1", "number": 94667, "vacancy_id": "34491e5a-8a1e-4c4f-915f-1162e220b608", "email": null, "first_name": "Jacqueline", "last_name": "Cortez", "middle_name": null, "created": "2025-09-22T17:43:08.032758", "updated": "2025-09-24T17:43:08.032758", "status": 0, "job_id": 1801, "candidate_id": "b7052a7c-7fa6-4472-85e7-6b64ef5ed05c", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
19	72a663ea-2581-41d4-8ce2-87ef0aba7313	1801	acme	2025-09-30 17:43:08.032758	{"id": "72a663ea-2581-41d4-8ce2-87ef0aba7313", "number": 68087, "vacancy_id": "34491e5a-8a1e-4c4f-915f-1162e220b608", "email": null, "first_name": "Adam", "last_name": "Quinn", "middle_name": "Kathryn", "created": "2025-09-30T17:43:08.032758", "updated": "2025-10-02T17:43:08.032758", "status": 0, "job_id": 1801, "candidate_id": "f0c40cdf-fe26-411a-86be-dd636835f252", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
20	e1ed9a8e-65f3-4ff8-8ac9-a18676bce769	6659	acme	2025-09-24 09:02:13.030694	{"id": "e1ed9a8e-65f3-4ff8-8ac9-a18676bce769", "number": 58554, "vacancy_id": "3850bded-5037-407b-bacb-94aa483bfb7f", "email": null, "first_name": "Kimberly", "last_name": "Baker", "middle_name": null, "created": "2025-09-24T09:02:13.030694", "updated": "2025-09-26T09:02:13.030694", "status": 0, "job_id": 6659, "candidate_id": "bb8505fc-0a03-427a-a381-c62838176f6e", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
21	0593144e-dfcb-4f9e-bb1a-422cd7c4e051	6659	acme	2025-09-10 09:02:13.030694	{"id": "0593144e-dfcb-4f9e-bb1a-422cd7c4e051", "number": 76019, "vacancy_id": "3850bded-5037-407b-bacb-94aa483bfb7f", "email": "mjohns@example.org", "first_name": "Laura", "last_name": "Logan", "middle_name": "Jeremy", "created": "2025-09-10T09:02:13.030694", "updated": "2025-09-19T09:02:13.030694", "status": 1, "job_id": 6659, "candidate_id": "c29cb382-104a-4c29-a459-6bbfecb0192a", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
22	1345316d-ad02-4481-b960-f42964c4e1ae	6659	acme	2025-09-03 09:02:13.030694	{"id": "1345316d-ad02-4481-b960-f42964c4e1ae", "number": 79792, "vacancy_id": "3850bded-5037-407b-bacb-94aa483bfb7f", "email": null, "first_name": "Patricia", "last_name": "Williams", "middle_name": null, "created": "2025-09-03T09:02:13.030694", "updated": "2025-09-08T09:02:13.030694", "status": 1, "job_id": 6659, "candidate_id": "4aae15a4-0c72-43f3-b020-14be9df68172", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": {"localization": [{"value": "Not a fit", "locale": "en"}]}, "source": {"type": "Agency"}}
23	c4e69917-bb25-41b0-a08a-37c08aa525a1	7044	acme	2025-08-04 06:26:05.155774	{"id": "c4e69917-bb25-41b0-a08a-37c08aa525a1", "number": 20902, "vacancy_id": "843a8fec-d014-4854-9b00-a4a10631d25a", "email": "vcochran@example.net", "first_name": "Allison", "last_name": "Sanchez", "middle_name": null, "created": "2025-08-04T06:26:05.155774", "updated": "2025-08-08T06:26:05.155774", "status": 1, "job_id": 7044, "candidate_id": "ba25dadf-369e-4890-a505-16050efdc98d", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Referral"}}
24	1c02b9bb-c25d-41dc-bee7-c751703ed1e7	7044	acme	2025-07-31 06:26:05.155774	{"id": "1c02b9bb-c25d-41dc-bee7-c751703ed1e7", "number": 29160, "vacancy_id": "843a8fec-d014-4854-9b00-a4a10631d25a", "email": null, "first_name": "Timothy", "last_name": "Stanton", "middle_name": null, "created": "2025-07-31T06:26:05.155774", "updated": "2025-08-02T06:26:05.155774", "status": 1, "job_id": 7044, "candidate_id": "233704e3-315b-4483-8768-a35a7238e82e", "stage": {"localization": [{"value": "Interview", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Agency"}}
25	bc9c15ed-e72b-42a6-be2d-bac973568326	7044	acme	2025-08-14 06:26:05.155774	{"id": "bc9c15ed-e72b-42a6-be2d-bac973568326", "number": 19740, "vacancy_id": "843a8fec-d014-4854-9b00-a4a10631d25a", "email": "monica58@example.com", "first_name": "Brian", "last_name": "Hunt", "middle_name": null, "created": "2025-08-14T06:26:05.155774", "updated": "2025-08-19T06:26:05.155774", "status": 1, "job_id": 7044, "candidate_id": "87db478e-6866-4084-a9bf-4197bca92f77", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": {"localization": [{"value": "Not a fit", "locale": "en"}]}, "source": {"type": "Agency"}}
26	018c85bf-1c5a-4709-8127-9ed362e80835	6231	acme	2025-10-09 05:03:23.383707	{"id": "018c85bf-1c5a-4709-8127-9ed362e80835", "number": 20232, "vacancy_id": "a5d946b6-dc99-4b0f-a7aa-7a38e051e2bb", "email": null, "first_name": "Guy", "last_name": "Davis", "middle_name": null, "created": "2025-10-09T05:03:23.383707", "updated": "2025-10-09T05:03:23.383707", "status": 1, "job_id": 6231, "candidate_id": "8d8a8e59-be83-47bc-9757-dae83dbea3e1", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
27	2e36cefd-157d-409d-8da8-79550a4e5890	6231	acme	2025-10-20 05:03:23.383707	{"id": "2e36cefd-157d-409d-8da8-79550a4e5890", "number": 87354, "vacancy_id": "a5d946b6-dc99-4b0f-a7aa-7a38e051e2bb", "email": null, "first_name": "William", "last_name": "Frazier", "middle_name": null, "created": "2025-10-20T05:03:23.383707", "updated": "2025-10-30T05:03:23.383707", "status": 0, "job_id": 6231, "candidate_id": "2a27dca8-02b7-45c6-9d0d-ce7fd43c5bfd", "stage": {"localization": [{"value": "Offer", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "Agency"}}
28	442eec55-2fef-47bd-a8ae-50e0c35336bc	6231	acme	2025-10-07 05:03:23.383707	{"id": "442eec55-2fef-47bd-a8ae-50e0c35336bc", "number": 76206, "vacancy_id": "a5d946b6-dc99-4b0f-a7aa-7a38e051e2bb", "email": "andersondevon@example.org", "first_name": "John", "last_name": "Casey", "middle_name": null, "created": "2025-10-07T05:03:23.383707", "updated": "2025-10-16T05:03:23.383707", "status": 1, "job_id": 6231, "candidate_id": "b383f232-26ae-42ce-8516-2cd57610e734", "stage": {"localization": [{"value": "Screening", "locale": "en"}]}, "disqualify_reason": null, "source": {"type": "LinkedIn"}}
\.


--
-- Data for Name: postings_raw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.postings_raw (id, job_id, vacancy_id, customer, media_id, created_at, raw_data) FROM stdin;
1	6900	0851bb5f-2a84-404f-ac6c-54555a554909	acme	60463526-3ba3-4587-9584-e25a96796119	2025-10-03 20:40:36.757174	{"job_id": 6900, "vacancy_id": "0851bb5f-2a84-404f-ac6c-54555a554909", "application_form_id": null, "advertisements": {"localization": [{"value": "Standard Ad", "locale": "en"}]}, "title": {"localization": [{"value": "Tourism officer", "locale": "en"}]}, "content": {"localization": [{"value": "Network case game message remain decade training relate. Policy quite condition those left. Suffer summer young education who four.", "locale": "en"}]}, "type": 0, "created": "2025-10-03T20:40:36.757174", "edited": "2025-10-13T20:40:36.757174", "deadline_utc": "2025-10-21T20:40:36.757174", "deadline": "2025-10-21T20:40:36.757174", "deadline_text": {"localization": [{"value": "2025-10-21T20:40:36.757174", "locale": "en"}]}, "location": {"address": "97480 Franco Ports Apt. 094\\nSheilafurt, FL 43213", "latitude": -82.3542795, "longitude": -107.271115}, "department": {"id": "3437aaa5-2c64-4c9f-a666-b320f165e5f5", "title": {"localization": [{"value": "Newspaper journalist", "locale": "en"}]}}, "tags": null, "data": [{"key": "employment", "value": "PT"}], "project_manager_user_id": null, "project_manager_full_name": "Jeffrey Leach", "template_id": "3965bb29-bf82-4c95-a0e4-1503f3819a9c", "template_title": {"localization": [{"value": "Standard Template", "locale": "en"}]}, "apply_url": {"localization": [{"value": "https://example.com/apply", "locale": "en"}]}, "ad_url": {"localization": [{"value": "https://example.com/ad", "locale": "en"}]}, "external_application_url": "https://example.com/apply", "time_zone": "Europe/Amsterdam", "media_id": "60463526-3ba3-4587-9584-e25a96796119", "stage": 1}
\.


--
-- Name: applications_raw_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_raw_id_seq', 28, true);


--
-- Name: postings_raw_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.postings_raw_id_seq', 1, true);


--
-- Name: applications_raw applications_raw_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications_raw
    ADD CONSTRAINT applications_raw_pkey PRIMARY KEY (id);


--
-- Name: postings_raw postings_raw_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postings_raw
    ADD CONSTRAINT postings_raw_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict vwP68XZszc3iMNbLWeFI2bUm8iygY3OUueLaxQf4XuKZwff2JmMDmMKgQr9Qd8R

