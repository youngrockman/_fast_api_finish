--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

--CREATE ROLE postgres;
--ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:latvp/UmiEjXEC6pXDB88A==$e0hl4G+rfg/akt/V/lEpySqvnW3TsHgbaDrmKJ6Eu6k=:VAuCA/65Hkxy35Yvm1e+jXqYAF0FUV8sm8m07kjIfOk=';
--CREATE ROLE psql_sys;
--ALTER ROLE psql_sys WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:hL3N4wtzEDgDAAUM5N55ww==$NHcP6W4cAa6dI/D2mW/V0dRyK8D0ZtIMo9zXlfR9238=:dqRF8MrG2SpWpowAPNV2H9ZCSmXcLb+dpQRCOM+edMs=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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
-- PostgreSQL database dump complete
--

--
-- Database "test_apiv2" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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
-- Name: test_apiv2; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE test_apiv2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE test_apiv2 OWNER TO postgres;

\connect test_apiv2

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
-- Name: measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurements (
    sensor_inventory_number character(15),
    measurement_value numeric(17,2),
    measurement_ts timestamp without time zone,
    measurement_type integer
);


ALTER TABLE public.measurements OWNER TO postgres;

--
-- Name: measurements_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurements_type (
    type_id integer NOT NULL,
    type_name character varying(31),
    type_units character(4)
);


ALTER TABLE public.measurements_type OWNER TO postgres;

--
-- Name: measurements_type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measurements_type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurements_type_type_id_seq OWNER TO postgres;

--
-- Name: measurements_type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measurements_type_type_id_seq OWNED BY public.measurements_type.type_id;


--
-- Name: meteostatins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meteostatins (
    station_id integer NOT NULL,
    station_name character varying(127),
    station_longitude numeric(5,2),
    station_latitude numeric(5,2),
    CONSTRAINT meteostatins_station_latitude_check CHECK (((station_latitude >= ('-180'::integer)::numeric) AND (station_latitude <= (180)::numeric))),
    CONSTRAINT meteostatins_station_longitude_check CHECK (((station_longitude >= ('-180'::integer)::numeric) AND (station_longitude <= (180)::numeric)))
);


ALTER TABLE public.meteostatins OWNER TO postgres;

--
-- Name: meteostatins_station_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meteostatins_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.meteostatins_station_id_seq OWNER TO postgres;

--
-- Name: meteostatins_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meteostatins_station_id_seq OWNED BY public.meteostatins.station_id;


--
-- Name: meteostation_sensor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meteostation_sensor (
    sensor_inventory_number character(15) NOT NULL,
    station_id integer,
    sensor_id integer,
    added_ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    removed_ts timestamp without time zone DEFAULT '9999-01-01 00:00:00'::timestamp without time zone
);


ALTER TABLE public.meteostation_sensor OWNER TO postgres;

--
-- Name: sensors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sensors (
    sensor_id integer NOT NULL,
    sensor_name character varying(31)
);


ALTER TABLE public.sensors OWNER TO postgres;

--
-- Name: sensors_measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sensors_measurements (
    sensor_id integer,
    type_id integer,
    measurement_formula character varying(255)
);


ALTER TABLE public.sensors_measurements OWNER TO postgres;

--
-- Name: sensors_sensor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sensors_sensor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensors_sensor_id_seq OWNER TO postgres;

--
-- Name: sensors_sensor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sensors_sensor_id_seq OWNED BY public.sensors.sensor_id;


--
-- Name: measurements_type type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurements_type ALTER COLUMN type_id SET DEFAULT nextval('public.measurements_type_type_id_seq'::regclass);


--
-- Name: meteostatins station_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meteostatins ALTER COLUMN station_id SET DEFAULT nextval('public.meteostatins_station_id_seq'::regclass);


--
-- Name: sensors sensor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensors ALTER COLUMN sensor_id SET DEFAULT nextval('public.sensors_sensor_id_seq'::regclass);


--
-- Data for Name: measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measurements (sensor_inventory_number, measurement_value, measurement_ts, measurement_type) FROM stdin;
502-1          	251.66	2023-12-18 20:34:00	1
502-2          	65.00	2023-12-19 18:45:00	1
502-3          	13.00	2023-12-19 18:55:00	1
502-2          	1078.00	2023-12-19 16:43:00	2
502-2          	450.00	2023-12-19 16:41:00	2
502-1          	288.49	2023-12-19 16:40:00	1
502-1          	151.40	2023-12-18 20:32:00	1
502-1          	128.90	2023-12-19 19:00:00	1
502-1          	137.08	2023-12-18 20:33:00	1
502-2          	68.00	2023-12-19 16:40:00	1
502-3          	43.00	2023-12-18 20:30:00	1
502-3          	70.00	2023-12-19 16:43:00	3
502-1          	130.94	2023-12-19 16:42:00	1
502-1          	30.69	2023-12-18 20:31:00	1
502-1          	175.96	2023-12-19 16:44:00	1
502-1          	278.26	2023-12-18 10:33:00	1
502-2          	35.00	2023-12-18 20:32:00	3
502-3          	21.00	2023-12-19 19:10:00	3
502-1          	147.31	2023-12-18 20:30:00	1
502-3          	33.00	2023-12-18 20:30:00	1
502-3          	5.00	2023-12-18 20:31:00	1
502-3          	74.00	2023-12-18 10:25:00	3
502-1          	251.66	2023-12-19 16:44:00	1
502-3          	47.00	2023-12-18 20:33:00	1
502-1          	-51.15	2023-12-18 20:32:00	1
502-1          	261.89	2023-12-18 20:31:00	1
502-2          	509.00	2023-12-18 20:29:00	2
502-2          	36.00	2023-12-18 20:29:00	3
502-2          	-1.00	2023-12-18 20:33:00	1
502-3          	21.00	2023-12-19 18:50:00	3
502-1          	-85.93	2023-12-18 10:23:00	1
502-2          	883.00	2023-12-19 16:40:00	2
502-1          	-100.25	2023-12-19 16:41:00	1
502-3          	56.00	2023-12-18 20:30:00	3
502-2          	37.00	2023-12-19 18:40:00	3
502-3          	0.00	2023-12-18 20:31:00	1
502-2          	-7.00	2023-12-18 10:37:00	1
502-1          	237.34	2023-12-19 16:42:00	1
502-2          	21.00	2023-12-18 20:33:00	3
502-1          	120.71	2023-12-18 20:31:00	1
502-2          	62.00	2023-12-18 20:30:00	1
502-3          	30.00	2023-12-18 10:21:00	1
502-1          	192.32	2023-12-18 20:31:00	1
\.


--
-- Data for Name: measurements_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measurements_type (type_id, type_name, type_units) FROM stdin;
1	Temperature	°C  
2	Pressure	hPa 
3	Humidity	%   
\.


--
-- Data for Name: meteostatins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meteostatins (station_id, station_name, station_longitude, station_latitude) FROM stdin;
160	Jan Mayen	-8.70	70.90
161	Grahuken	14.50	79.80
162	Hornsund	15.50	77.00
163	Ny-Alesund Ii	11.90	78.90
164	Edgeoya	22.80	78.20
165	Ny Alesund	11.90	78.90
166	Svalbard Lufthavn	15.50	78.20
167	Phippsoya	20.90	80.70
168	Andoya	16.20	69.30
169	Kvitoya	31.40	80.10
170	Hekkingen Fyr	17.80	69.60
171	Senja-Grasmyrskogen	17.80	69.30
172	Bardufoss	18.50	69.10
173	Tromso Langnes	18.90	69.70
174	Tromso	18.90	69.60
175	Bjornoya	19.00	74.50
176	Torsvag Fyr	19.50	70.20
177	Fugloykalven Fyr	20.20	70.30
178	Oteren	19.90	69.20
179	Nodreisa-Oyeng	21.00	69.70
180	Loppa	21.50	70.30
181	Nordstraum I Kvaenangen	21.90	69.80
182	Sorkjosen	24.00	69.80
183	Kautokeino	23.00	69.00
184	Alta Lufthavn	23.40	25.00
185	Suolovuopmi	23.50	69.60
186	Hammerfest	23.70	70.70
187	Fruholmen Fyr	24.00	71.10
188	Cuovddatmohkki	24.40	69.40
189	Banak	26.00	70.10
190	Hopen	25.10	76.50
191	Karasjok	25.50	69.50
192	Helnes Fyr	26.20	71.10
193	Honningsvag Valan	67.00	71.00
194	Mehamn	27.80	71.00
195	Rustefjelbma	28.20	70.40
196	Sletnes Fyr	28.20	71.10
197	Berlevag	29.00	70.90
198	Vadso	29.90	70.10
199	Kirkenes Lufthavn	29.90	69.70
200	Makkaur Fyr	30.10	70.70
201	Svartnes	31.10	70.30
202	Vardo	31.10	70.40
203	Sklinna Fyr	11.00	65.20
204	Leka	11.70	65.10
205	Rost Ii	12.10	67.50
206	Rost Flyplass	12.10	67.50
207	Vega-Vallsjo	11.90	65.70
208	Ytterholmen Fyr	11.70	66.00
209	Bronnoysund Bronnoy	12.20	65.50
210	Myken	12.50	66.80
211	Sandnessjoen Stokka	12.50	12.60
212	Nord-Solvaer	12.60	66.40
213	Mosjoen Kjaerstad	13.10	65.80
214	Majavatn Iii	13.40	65.20
215	Stott	13.40	66.90
216	Tennholmen Fyr	13.50	67.30
217	Leknes	13.60	68.20
218	Susendal-Bjormo	14.00	65.50
219	Rana-Basmoen	14.10	66.30
220	Mo I rana Rossvoll	14.30	66.40
221	Bodo Vi	14.40	67.30
222	Litloy Fyr	14.30	68.60
223	Bo I Vesteralen Ii	14.50	68.60
224	Skrova Fyr	14.60	68.20
225	Svolvaer Helle	14.70	68.20
226	Storkmarknes Skagen	15.00	68.60
227	Sortland	15.40	68.70
228	Saltdal	15.30	66.90
229	Finnoy I Hamaroy	15.60	68.00
230	Evenes	16.70	68.50
231	Narvik Framnes	17.40	68.40
232	Narvik Iii	17.50	68.50
233	Tennevoll	17.80	68.80
234	Sihcajavri	23.50	68.80
235	Krakenes	41.00	62.00
236	Svinoy Fyr	5.30	62.30
237	Orsta-Volda Hovden	6.10	62.20
238	Alesund Vigra	6.10	62.60
239	Ona Ii	6.50	62.90
240	Molde Aro	7.30	62.80
241	Tafjord	7.40	62.20
242	Kristiansund Kvernberget	7.80	63.10
243	Skalmen Fyr	7.80	63.50
244	Tingvoll-Hanem	8.30	62.80
245	Sula	8.50	63.90
246	Lesjaskog	8.40	62.20
247	Vinjeora Ii	9.00	63.20
248	Fokstua Ii	9.30	62.20
249	Fokstua Ii	9.30	62.10
250	Halten Fyr	9.40	64.20
251	Orland Iii	9.60	63.70
252	Oppdal-Bjorke	9.70	62.60
253	Berkak-Lyngholt	10.00	62.80
254	Buholmrasa Fyr	10.40	64.40
255	Nordoyan Fyr	10.60	64.80
256	Tynset Ii	10.80	62.30
257	Trondheim Vaernes	10.90	63.50
258	Selbu-Stubbe	11.10	63.20
259	Steinkjer	11.40	64.00
260	Verdal-Reppe	11.70	63.80
261	Namdalseid	11.20	64.20
262	Rorvik Ryum	11.20	64.80
263	Roros	11.40	62.60
264	Roros Lufthavn	11.30	62.60
265	Namsos Lufthavn	11.60	64.50
266	Maraker-Utsyn	11.80	63.40
267	Nordli-Holand	13.70	64.40
268	Ytteroyane Fyr	4.70	61.60
269	Hellisoy Fyr	4.70	60.80
270	Floro	5.00	61.60
271	Bergen Flesland	5.20	60.30
272	Bergen Florida	5.30	60.40
273	Takle	5.40	61.00
274	Sandane Anda	6.10	61.80
275	Stryn	6.60	61.90
276	Forde-Tefre	5.90	61.50
277	Forde Bringelandsasen	5.80	61.40
278	Modalen Ii	5.90	60.80
279	Kvamskogen	5.90	60.40
280	Omastrand	51.00	60.20
281	Voss-Bo	6.50	60.60
282	Vangsnes	6.60	61.20
283	Eidfjord-Bu	6.90	60.50
284	Reimegrend	6.80	60.70
285	Sogndal Haukasen	7.10	61.20
286	Finsevatn	7.50	60.60
287	Laerdal-Tonjum	7.50	61.10
288	Fortun	7.70	61.50
289	Brata	7.90	61.90
290	Geilo-Geilostolen	8.20	60.50
291	Sognefjell	8.00	61.60
292	Fagernes	9.20	70.00
293	Fagernes Leirin	9.30	61.00
294	Skabu-Storslaen	9.40	61.50
295	Nesbyen-Skoglund	9.10	60.60
296	Vest-Torpa Ii	10.00	60.90
297	Kvitfjell	91.00	61.50
298	Lillehammer-Saetherengen	10.50	61.10
299	Sor-Nesset	10.20	61.90
300	Venabu	10.10	61.60
301	Evenstad-Overenget	11.20	61.40
302	Oslo Gardermoen	11.10	60.20
303	Haugedalshogda	11.40	61.20
304	Flisa	12.00	60.60
305	Drevsjo	12.10	61.90
306	Trysil Vegstasjon	12.30	61.30
307	Ekofisk	3.20	56.50
308	Utsira Fyr	4.90	59.30
309	Slatteroy Fyr	5.10	59.90
310	Haugesund Karmoy	5.20	59.30
311	Obrestad	5.60	58.60
312	Stavanger Sola	5.60	58.90
313	Nedre Vats	5.80	59.50
314	Fister-Tonnevik	6.10	59.20
315	Sauda	6.40	59.60
316	Ualand-Bjuland	6.30	58.60
317	Lista Fyr	6.60	58.10
318	Lista Fyr	6.60	58.10
319	Lista Flyplass	6.60	58.10
320	Sirdal-Tjorhom	6.90	58.90
321	Midtlaeger	61.00	59.80
322	Vaagsli	7.40	59.80
323	Lindesnes Fyr	7.10	8.00
324	Konsmo-Hoyland	7.30	58.20
325	Hovden-Lundane	7.40	59.60
326	Byglandsfjord-Solbakken	7.80	58.70
327	Oyfjell-Trovatn	8.20	59.60
328	Oksoy Fyr	8.10	58.10
329	Mosstrand Ii	8.20	59.80
330	Kristiansand Kjevik	8.10	58.20
331	Kristiansand Kjevik	8.10	58.20
332	Tveitsund	8.50	59.00
333	Nelaug	8.60	58.60
334	Torungen Fyr	8.80	58.40
335	Lyngor Fyr	9.20	58.60
336	Lyngdal I Numedal	9.50	59.90
337	Skien-Geiteryggen	9.60	59.20
338	Jomfruland Fyr	9.60	58.90
339	Kongsberg Iv	9.60	59.70
340	Ferder Fyr	10.50	59.00
341	Torp	10.30	59.20
342	Oslo Fornebu	10.60	59.90
343	Tryvasshogda Ii	10.70	9.00
344	Oslo-Blindern	10.70	59.90
345	Rygge	10.80	59.40
346	Stromtangen Fyr	10.80	59.20
347	Holand-Loken	11.50	59.80
348	Prestebakke	11.50	59.00
349	Magnor	12.20	9.00
350	Ritsem	17.50	67.70
351	Katterjakk	18.20	68.40
352	Abisko	18.80	68.30
353	Tornetrask Lake	19.70	68.20
354	Nikkaluokta	19.00	67.90
355	Esrange	21.10	67.90
356	Kiruna Airport	20.30	67.80
357	Kiruna Geofysiska	20.40	67.80
358	Gallivare	20.60	67.20
359	Karesuando	22.50	68.40
360	Pajala	23.40	67.20
361	Hemavan-Skorvfjallet	15.10	65.80
362	Hemavan	15.10	65.80
363	Abelvattnet	141.00	65.50
364	Dikanas-Skansnas	16.00	65.30
365	Kvikkjokk	17.80	66.90
366	Arjeplog	17.90	66.00
367	Gunnarn	17.70	65.00
368	Tjakaape	19.20	66.30
369	Jokkmokk	19.60	66.60
370	Paljamyren	19.10	66.20
371	Tellejaur	19.60	66.20
372	Vidsel	20.10	65.90
373	Fallfors	20.80	65.10
374	Nattavaara	21.10	66.80
375	Heden	21.40	65.90
376	Boden	21.70	65.80
377	Ronnskar	21.60	65.00
378	Svartbyn	22.90	66.30
379	Lulea Sol	22.10	65.60
380	Lulea Kallax	22.10	65.60
381	Lulea Kallax	22.10	65.60
382	Rodkallen	22.40	65.30
383	Haparanda	24.20	65.80
384	Storlien-Visjovalen	12.10	63.30
385	Sylarna	12.30	63.10
386	Areskutan	13.10	63.40
387	Korsvattnet	13.50	63.80
388	Gaddede	14.10	64.50
389	Ostersund Froson	14.50	63.20
390	Ostersund Sol	14.50	63.20
391	Junsele	16.90	63.70
392	Vilhelmina	16.90	64.60
393	Krangede	16.20	63.20
394	Krangede	16.20	63.20
395	Kramfors Flygplats	17.80	63.10
396	Ornskoldsvik Airport	7.00	63.40
397	Skagsudde	19.00	63.20
398	Vindeln	19.70	64.20
399	Umea Robacksdalen	20.20	63.80
400	Jarnasklubb	19.70	63.40
401	Umea Flygplats	20.30	63.80
402	Holmogadd	20.80	63.60
403	Skelleftea Airport	21.10	64.60
404	Bjuroklubb	21.60	64.50
405	Idre	12.90	61.90
406	Tannas	12.70	62.40
407	Sarna	13.20	61.70
408	Tandadalen	13.00	61.20
409	Klovsjo	14.20	62.50
410	Sveg	14.40	62.00
411	Edsbyn	15.70	61.40
412	Kuggoren	17.50	61.70
413	Sundvall-Harnlsand Flygplats	17.40	62.50
414	Sundsvall-Harnosand Flygplats	17.40	62.50
415	Bramon	17.80	62.20
416	Soderhamn	17.10	61.30
417	Lungo	18.10	62.60
418	Ostmark	12.60	60.30
419	Blomskog	12.10	59.20
420	Malung	13.70	60.70
421	Karlstad Sol	13.50	59.40
422	Naven	13.10	58.70
423	Karlstad Flygplats	13.50	59.40
424	Stalldalen	14.90	59.90
425	Orebro	15.10	59.20
426	Falun	15.70	60.60
427	Borlange	15.50	60.40
428	Gavle Sandviken Air force base	16.90	60.60
429	Vasteras Hasslo	16.60	59.60
430	Eggegrund	17.60	60.70
431	Gavle	17.20	60.70
432	Films Kyrkby	17.90	60.20
433	Uppsala	17.60	59.90
434	Stockholm Arlanda	17.90	59.60
435	Stockholm Bromma	17.90	59.30
436	Floda	16.40	59.10
437	Stockholm Kth	18.10	59.30
438	Stockholm Observatoriet	18.10	59.60
439	Stavsnas	18.70	59.30
440	Orskar	18.40	60.50
441	Harsfjarden	18.10	59.10
442	Svenska Hogarna	19.50	59.40
443	Almagrundet	19.10	59.20
444	Nordkoster	11.00	58.90
445	Vaderoarna	11.10	58.60
446	Maseskar	11.30	58.10
447	Maseskar Light House	11.30	58.10
448	Goteborg Save	11.90	57.80
449	Goteborg	12.00	57.70
450	Vinga	11.60	57.60
451	Trubaduren	11.60	57.60
452	Nidingen	11.90	57.30
453	Ringhals	12.10	57.30
454	Satenas	12.70	58.40
455	Goteborg Landvetter	12.30	57.70
456	Goteborg Landvetter	12.30	57.70
457	Skovde Flygplats	131.00	58.40
458	Rangedala	13.20	57.80
459	Axstal	14.60	58.60
460	Jonkoping Flygplats	14.10	57.80
461	Hagshult	14.10	57.30
462	Linkoping Malmen	15.50	58.40
463	Malexander	15.20	58.10
464	Hultsfred Swedish Air Force Base	15.80	57.50
465	Malilla	15.80	57.40
466	Landsort	17.90	58.80
467	Stavsjo	16.40	58.70
468	Norrkoping	16.20	58.60
469	Smhi	16.20	58.60
470	Olands Norra Udde	17.10	57.40
471	Gustaf Dalen	17.50	58.60
472	Gotska Sandon	19.20	58.40
473	Harstena	17.00	58.20
474	Visby Flygplats	18.30	57.70
475	Visby Aerologiska Station	18.30	57.60
476	Nasudden	18.20	57.10
477	Halmstad Swedish Air Force Base	12.80	56.70
478	Hallands Vadero	12.60	56.40
479	Kullen	12.40	56.30
480	Angelholm	12.90	56.30
481	Helsingborg	12.80	56.00
482	Oskarsgrundet	12.90	55.60
483	Falsterbo	12.80	55.40
484	Torup	13.10	57.00
485	Skillinge	14.30	55.50
486	Osby	13.90	56.40
487	Lund Lth	13.20	55.70
488	Hano	14.90	56.00
489	Ljungbyhed Ljungbyhed (swe-Afb)	13.20	56.10
490	Malmo	13.00	55.60
491	Malmo Sturup	13.40	55.60
492	Vaxjo	14.80	56.90
493	Olands Sodra Udde	16.40	56.20
494	Kristianstad Everod	14.10	55.90
495	Ronneby	15.30	56.30
496	Ungskar	15.80	56.00
497	Kungsholms Fort	15.60	56.10
498	Kalmar Flygplats	16.30	56.70
499	Kalmar	16.30	56.70
500	Hoburg	18.20	56.90
501	Vreta Kloster	15.50	58.50
502	Olands Sodra Grund	16.70	56.10
\.


--
-- Data for Name: meteostation_sensor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meteostation_sensor (sensor_inventory_number, station_id, sensor_id, added_ts, removed_ts) FROM stdin;
160-1          	160	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
160-2          	160	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
160-3          	160	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
160-4          	160	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
161-1          	161	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
161-2          	161	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
161-3          	161	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
161-4          	161	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
162-1          	162	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
162-2          	162	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
162-3          	162	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
162-4          	162	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
163-1          	163	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
163-2          	163	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
163-3          	163	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
163-4          	163	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
164-1          	164	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
164-2          	164	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
164-3          	164	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
164-4          	164	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
165-1          	165	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
165-2          	165	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
165-3          	165	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
165-4          	165	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
166-1          	166	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
166-2          	166	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
166-3          	166	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
166-4          	166	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
167-1          	167	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
167-2          	167	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
167-3          	167	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
167-4          	167	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
168-1          	168	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
168-2          	168	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
168-3          	168	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
168-4          	168	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
169-1          	169	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
169-2          	169	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
169-3          	169	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
169-4          	169	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
170-1          	170	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
170-2          	170	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
170-3          	170	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
170-4          	170	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
171-1          	171	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
171-2          	171	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
171-3          	171	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
171-4          	171	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
172-1          	172	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
172-2          	172	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
172-3          	172	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
172-4          	172	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
173-1          	173	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
173-2          	173	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
173-3          	173	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
173-4          	173	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
174-1          	174	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
174-2          	174	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
174-3          	174	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
174-4          	174	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
175-1          	175	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
175-2          	175	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
175-3          	175	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
175-4          	175	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
176-1          	176	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
176-2          	176	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
176-3          	176	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
176-4          	176	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
177-1          	177	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
177-2          	177	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
177-3          	177	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
177-4          	177	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
178-1          	178	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
178-2          	178	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
178-3          	178	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
178-4          	178	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
179-1          	179	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
179-2          	179	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
179-3          	179	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
179-4          	179	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
180-1          	180	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
180-2          	180	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
180-3          	180	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
180-4          	180	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
181-1          	181	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
181-2          	181	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
181-3          	181	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
181-4          	181	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
182-1          	182	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
182-2          	182	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
182-3          	182	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
182-4          	182	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
183-1          	183	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
183-2          	183	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
183-3          	183	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
183-4          	183	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
184-1          	184	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
184-2          	184	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
184-3          	184	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
184-4          	184	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
185-1          	185	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
185-2          	185	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
185-3          	185	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
185-4          	185	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
186-1          	186	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
186-2          	186	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
186-3          	186	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
186-4          	186	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
187-1          	187	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
187-2          	187	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
187-3          	187	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
187-4          	187	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
188-1          	188	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
188-2          	188	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
188-3          	188	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
188-4          	188	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
189-1          	189	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
189-2          	189	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
189-3          	189	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
189-4          	189	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
190-1          	190	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
190-2          	190	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
190-3          	190	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
190-4          	190	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
191-1          	191	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
191-2          	191	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
191-3          	191	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
191-4          	191	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
192-1          	192	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
192-2          	192	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
192-3          	192	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
192-4          	192	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
193-1          	193	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
193-2          	193	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
193-3          	193	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
193-4          	193	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
194-1          	194	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
194-2          	194	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
194-3          	194	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
194-4          	194	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
195-1          	195	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
195-2          	195	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
195-3          	195	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
195-4          	195	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
196-1          	196	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
196-2          	196	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
196-3          	196	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
196-4          	196	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
197-1          	197	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
197-2          	197	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
197-3          	197	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
197-4          	197	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
198-1          	198	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
198-2          	198	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
198-3          	198	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
198-4          	198	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
199-1          	199	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
199-2          	199	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
199-3          	199	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
199-4          	199	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
200-1          	200	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
200-2          	200	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
200-3          	200	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
200-4          	200	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
201-1          	201	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
201-2          	201	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
201-3          	201	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
201-4          	201	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
202-1          	202	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
202-2          	202	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
202-3          	202	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
202-4          	202	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
203-1          	203	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
203-2          	203	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
203-3          	203	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
203-4          	203	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
204-1          	204	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
204-2          	204	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
204-3          	204	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
204-4          	204	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
205-1          	205	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
205-2          	205	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
205-3          	205	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
205-4          	205	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
206-1          	206	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
206-2          	206	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
206-3          	206	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
206-4          	206	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
207-1          	207	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
207-2          	207	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
207-3          	207	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
207-4          	207	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
208-1          	208	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
208-2          	208	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
208-3          	208	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
208-4          	208	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
209-1          	209	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
209-2          	209	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
209-3          	209	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
209-4          	209	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
210-1          	210	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
210-2          	210	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
210-3          	210	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
210-4          	210	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
211-1          	211	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
211-2          	211	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
211-3          	211	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
211-4          	211	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
212-1          	212	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
212-2          	212	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
212-3          	212	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
212-4          	212	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
213-1          	213	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
213-2          	213	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
213-3          	213	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
213-4          	213	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
214-1          	214	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
214-2          	214	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
214-3          	214	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
214-4          	214	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
215-1          	215	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
215-2          	215	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
215-3          	215	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
215-4          	215	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
216-1          	216	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
216-2          	216	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
216-3          	216	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
216-4          	216	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
217-1          	217	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
217-2          	217	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
217-3          	217	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
217-4          	217	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
218-1          	218	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
218-2          	218	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
218-3          	218	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
218-4          	218	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
219-1          	219	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
219-2          	219	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
219-3          	219	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
219-4          	219	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
220-1          	220	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
220-2          	220	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
220-3          	220	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
220-4          	220	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
221-1          	221	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
221-2          	221	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
221-3          	221	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
221-4          	221	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
222-1          	222	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
222-2          	222	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
222-3          	222	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
222-4          	222	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
223-1          	223	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
223-2          	223	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
223-3          	223	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
223-4          	223	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
224-1          	224	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
224-2          	224	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
224-3          	224	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
224-4          	224	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
225-1          	225	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
225-2          	225	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
225-3          	225	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
225-4          	225	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
226-1          	226	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
226-2          	226	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
226-3          	226	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
226-4          	226	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
227-1          	227	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
227-2          	227	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
227-3          	227	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
227-4          	227	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
228-1          	228	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
228-2          	228	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
228-3          	228	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
228-4          	228	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
229-1          	229	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
229-2          	229	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
229-3          	229	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
229-4          	229	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
230-1          	230	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
230-2          	230	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
230-3          	230	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
230-4          	230	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
231-1          	231	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
231-2          	231	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
231-3          	231	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
231-4          	231	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
232-1          	232	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
232-2          	232	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
232-3          	232	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
232-4          	232	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
233-1          	233	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
233-2          	233	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
233-3          	233	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
233-4          	233	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
234-1          	234	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
234-2          	234	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
234-3          	234	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
234-4          	234	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
235-1          	235	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
235-2          	235	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
235-3          	235	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
235-4          	235	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
236-1          	236	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
236-2          	236	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
236-3          	236	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
236-4          	236	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
237-1          	237	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
237-2          	237	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
237-3          	237	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
237-4          	237	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
238-1          	238	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
238-2          	238	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
238-3          	238	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
238-4          	238	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
239-1          	239	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
239-2          	239	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
239-3          	239	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
239-4          	239	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
240-1          	240	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
240-2          	240	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
240-3          	240	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
240-4          	240	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
241-1          	241	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
241-2          	241	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
241-3          	241	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
241-4          	241	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
242-1          	242	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
242-2          	242	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
242-3          	242	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
242-4          	242	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
243-1          	243	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
243-2          	243	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
243-3          	243	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
243-4          	243	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
244-1          	244	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
244-2          	244	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
244-3          	244	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
244-4          	244	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
245-1          	245	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
245-2          	245	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
245-3          	245	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
245-4          	245	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
246-1          	246	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
246-2          	246	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
246-3          	246	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
246-4          	246	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
247-1          	247	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
247-2          	247	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
247-3          	247	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
247-4          	247	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
248-1          	248	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
248-2          	248	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
248-3          	248	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
248-4          	248	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
249-1          	249	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
249-2          	249	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
249-3          	249	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
249-4          	249	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
250-1          	250	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
250-2          	250	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
250-3          	250	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
250-4          	250	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
251-1          	251	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
251-2          	251	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
251-3          	251	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
251-4          	251	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
252-1          	252	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
252-2          	252	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
252-3          	252	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
252-4          	252	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
253-1          	253	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
253-2          	253	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
253-3          	253	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
253-4          	253	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
254-1          	254	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
254-2          	254	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
254-3          	254	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
254-4          	254	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
255-1          	255	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
255-2          	255	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
255-3          	255	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
255-4          	255	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
256-1          	256	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
256-2          	256	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
256-3          	256	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
256-4          	256	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
257-1          	257	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
257-2          	257	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
257-3          	257	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
257-4          	257	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
258-1          	258	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
258-2          	258	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
258-3          	258	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
258-4          	258	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
259-1          	259	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
259-2          	259	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
259-3          	259	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
259-4          	259	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
260-1          	260	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
260-2          	260	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
260-3          	260	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
260-4          	260	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
261-1          	261	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
261-2          	261	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
261-3          	261	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
261-4          	261	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
262-1          	262	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
262-2          	262	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
262-3          	262	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
262-4          	262	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
263-1          	263	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
263-2          	263	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
263-3          	263	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
263-4          	263	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
264-1          	264	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
264-2          	264	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
264-3          	264	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
264-4          	264	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
265-1          	265	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
265-2          	265	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
265-3          	265	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
265-4          	265	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
266-1          	266	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
266-2          	266	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
266-3          	266	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
266-4          	266	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
267-1          	267	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
267-2          	267	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
267-3          	267	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
267-4          	267	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
268-1          	268	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
268-2          	268	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
268-3          	268	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
268-4          	268	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
269-1          	269	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
269-2          	269	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
269-3          	269	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
269-4          	269	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
270-1          	270	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
270-2          	270	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
270-3          	270	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
270-4          	270	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
271-1          	271	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
271-2          	271	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
271-3          	271	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
271-4          	271	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
272-1          	272	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
272-2          	272	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
272-3          	272	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
272-4          	272	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
273-1          	273	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
273-2          	273	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
273-3          	273	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
273-4          	273	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
274-1          	274	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
274-2          	274	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
274-3          	274	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
274-4          	274	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
275-1          	275	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
275-2          	275	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
275-3          	275	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
275-4          	275	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
276-1          	276	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
276-2          	276	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
276-3          	276	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
276-4          	276	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
277-1          	277	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
277-2          	277	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
277-3          	277	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
277-4          	277	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
278-1          	278	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
278-2          	278	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
278-3          	278	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
278-4          	278	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
279-1          	279	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
279-2          	279	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
279-3          	279	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
279-4          	279	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
280-1          	280	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
280-2          	280	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
280-3          	280	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
280-4          	280	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
281-1          	281	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
281-2          	281	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
281-3          	281	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
281-4          	281	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
282-1          	282	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
282-2          	282	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
282-3          	282	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
282-4          	282	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
283-1          	283	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
283-2          	283	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
283-3          	283	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
283-4          	283	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
284-1          	284	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
284-2          	284	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
284-3          	284	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
284-4          	284	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
285-1          	285	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
285-2          	285	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
285-3          	285	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
285-4          	285	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
286-1          	286	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
286-2          	286	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
286-3          	286	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
286-4          	286	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
287-1          	287	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
287-2          	287	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
287-3          	287	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
287-4          	287	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
288-1          	288	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
288-2          	288	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
288-3          	288	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
288-4          	288	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
289-1          	289	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
289-2          	289	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
289-3          	289	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
289-4          	289	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
290-1          	290	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
290-2          	290	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
290-3          	290	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
290-4          	290	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
291-1          	291	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
291-2          	291	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
291-3          	291	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
291-4          	291	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
292-1          	292	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
292-2          	292	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
292-3          	292	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
292-4          	292	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
293-1          	293	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
293-2          	293	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
293-3          	293	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
293-4          	293	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
294-1          	294	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
294-2          	294	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
294-3          	294	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
294-4          	294	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
295-1          	295	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
295-2          	295	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
295-3          	295	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
295-4          	295	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
296-1          	296	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
296-2          	296	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
296-3          	296	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
296-4          	296	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
297-1          	297	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
297-2          	297	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
297-3          	297	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
297-4          	297	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
298-1          	298	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
298-2          	298	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
298-3          	298	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
298-4          	298	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
299-1          	299	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
299-2          	299	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
299-3          	299	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
299-4          	299	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
300-1          	300	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
300-2          	300	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
300-3          	300	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
300-4          	300	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
301-1          	301	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
301-2          	301	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
301-3          	301	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
301-4          	301	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
302-1          	302	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
302-2          	302	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
302-3          	302	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
302-4          	302	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
303-1          	303	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
303-2          	303	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
303-3          	303	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
303-4          	303	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
304-1          	304	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
304-2          	304	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
304-3          	304	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
304-4          	304	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
305-1          	305	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
305-2          	305	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
305-3          	305	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
305-4          	305	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
306-1          	306	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
306-2          	306	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
306-3          	306	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
306-4          	306	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
307-1          	307	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
307-2          	307	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
307-3          	307	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
307-4          	307	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
308-1          	308	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
308-2          	308	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
308-3          	308	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
308-4          	308	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
309-1          	309	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
309-2          	309	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
309-3          	309	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
309-4          	309	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
310-1          	310	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
310-2          	310	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
310-3          	310	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
310-4          	310	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
311-1          	311	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
311-2          	311	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
311-3          	311	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
311-4          	311	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
312-1          	312	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
312-2          	312	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
312-3          	312	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
312-4          	312	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
313-1          	313	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
313-2          	313	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
313-3          	313	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
313-4          	313	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
314-1          	314	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
314-2          	314	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
314-3          	314	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
314-4          	314	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
315-1          	315	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
315-2          	315	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
315-3          	315	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
315-4          	315	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
316-1          	316	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
316-2          	316	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
316-3          	316	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
316-4          	316	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
317-1          	317	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
317-2          	317	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
317-3          	317	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
317-4          	317	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
318-1          	318	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
318-2          	318	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
318-3          	318	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
318-4          	318	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
319-1          	319	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
319-2          	319	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
319-3          	319	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
319-4          	319	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
320-1          	320	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
320-2          	320	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
320-3          	320	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
320-4          	320	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
321-1          	321	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
321-2          	321	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
321-3          	321	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
321-4          	321	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
322-1          	322	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
322-2          	322	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
322-3          	322	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
322-4          	322	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
323-1          	323	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
323-2          	323	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
323-3          	323	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
323-4          	323	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
324-1          	324	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
324-2          	324	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
324-3          	324	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
324-4          	324	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
325-1          	325	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
325-2          	325	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
325-3          	325	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
325-4          	325	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
326-1          	326	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
326-2          	326	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
326-3          	326	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
326-4          	326	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
327-1          	327	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
327-2          	327	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
327-3          	327	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
327-4          	327	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
328-1          	328	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
328-2          	328	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
328-3          	328	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
328-4          	328	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
329-1          	329	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
329-2          	329	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
329-3          	329	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
329-4          	329	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
330-1          	330	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
330-2          	330	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
330-3          	330	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
330-4          	330	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
331-1          	331	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
331-2          	331	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
331-3          	331	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
331-4          	331	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
332-1          	332	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
332-2          	332	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
332-3          	332	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
332-4          	332	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
333-1          	333	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
333-2          	333	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
333-3          	333	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
333-4          	333	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
334-1          	334	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
334-2          	334	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
334-3          	334	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
334-4          	334	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
335-1          	335	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
335-2          	335	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
335-3          	335	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
335-4          	335	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
336-1          	336	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
336-2          	336	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
336-3          	336	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
336-4          	336	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
337-1          	337	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
337-2          	337	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
337-3          	337	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
337-4          	337	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
338-1          	338	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
338-2          	338	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
338-3          	338	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
338-4          	338	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
339-1          	339	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
339-2          	339	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
339-3          	339	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
339-4          	339	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
340-1          	340	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
340-2          	340	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
340-3          	340	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
340-4          	340	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
341-1          	341	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
341-2          	341	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
341-3          	341	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
341-4          	341	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
342-1          	342	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
342-2          	342	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
342-3          	342	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
342-4          	342	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
343-1          	343	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
343-2          	343	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
343-3          	343	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
343-4          	343	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
344-1          	344	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
344-2          	344	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
344-3          	344	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
344-4          	344	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
345-1          	345	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
345-2          	345	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
345-3          	345	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
345-4          	345	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
346-1          	346	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
346-2          	346	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
346-3          	346	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
346-4          	346	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
347-1          	347	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
347-2          	347	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
347-3          	347	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
347-4          	347	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
348-1          	348	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
348-2          	348	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
348-3          	348	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
348-4          	348	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
349-1          	349	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
349-2          	349	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
349-3          	349	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
349-4          	349	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
350-1          	350	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
350-2          	350	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
350-3          	350	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
350-4          	350	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
351-1          	351	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
351-2          	351	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
351-3          	351	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
351-4          	351	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
352-1          	352	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
352-2          	352	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
352-3          	352	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
352-4          	352	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
353-1          	353	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
353-2          	353	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
353-3          	353	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
353-4          	353	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
354-1          	354	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
354-2          	354	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
354-3          	354	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
354-4          	354	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
355-1          	355	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
355-2          	355	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
355-3          	355	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
355-4          	355	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
356-1          	356	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
356-2          	356	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
356-3          	356	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
356-4          	356	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
357-1          	357	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
357-2          	357	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
357-3          	357	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
357-4          	357	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
358-1          	358	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
358-2          	358	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
358-3          	358	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
358-4          	358	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
359-1          	359	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
359-2          	359	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
359-3          	359	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
359-4          	359	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
360-1          	360	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
360-2          	360	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
360-3          	360	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
360-4          	360	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
361-1          	361	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
361-2          	361	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
361-3          	361	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
361-4          	361	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
362-1          	362	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
362-2          	362	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
362-3          	362	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
362-4          	362	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
363-1          	363	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
363-2          	363	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
363-3          	363	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
363-4          	363	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
364-1          	364	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
364-2          	364	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
364-3          	364	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
364-4          	364	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
365-1          	365	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
365-2          	365	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
365-3          	365	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
365-4          	365	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
366-1          	366	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
366-2          	366	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
366-3          	366	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
366-4          	366	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
367-1          	367	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
367-2          	367	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
367-3          	367	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
367-4          	367	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
368-1          	368	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
368-2          	368	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
368-3          	368	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
368-4          	368	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
369-1          	369	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
369-2          	369	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
369-3          	369	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
369-4          	369	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
370-1          	370	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
370-2          	370	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
370-3          	370	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
370-4          	370	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
371-1          	371	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
371-2          	371	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
371-3          	371	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
371-4          	371	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
372-1          	372	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
372-2          	372	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
372-3          	372	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
372-4          	372	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
373-1          	373	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
373-2          	373	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
373-3          	373	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
373-4          	373	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
374-1          	374	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
374-2          	374	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
374-3          	374	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
374-4          	374	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
375-1          	375	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
375-2          	375	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
375-3          	375	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
375-4          	375	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
376-1          	376	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
376-2          	376	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
376-3          	376	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
376-4          	376	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
377-1          	377	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
377-2          	377	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
377-3          	377	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
377-4          	377	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
378-1          	378	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
378-2          	378	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
378-3          	378	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
378-4          	378	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
379-1          	379	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
379-2          	379	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
379-3          	379	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
379-4          	379	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
380-1          	380	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
380-2          	380	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
380-3          	380	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
380-4          	380	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
381-1          	381	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
381-2          	381	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
381-3          	381	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
381-4          	381	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
382-1          	382	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
382-2          	382	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
382-3          	382	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
382-4          	382	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
383-1          	383	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
383-2          	383	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
383-3          	383	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
383-4          	383	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
384-1          	384	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
384-2          	384	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
384-3          	384	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
384-4          	384	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
385-1          	385	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
385-2          	385	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
385-3          	385	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
385-4          	385	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
386-1          	386	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
386-2          	386	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
386-3          	386	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
386-4          	386	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
387-1          	387	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
387-2          	387	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
387-3          	387	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
387-4          	387	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
388-1          	388	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
388-2          	388	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
388-3          	388	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
388-4          	388	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
389-1          	389	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
389-2          	389	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
389-3          	389	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
389-4          	389	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
390-1          	390	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
390-2          	390	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
390-3          	390	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
390-4          	390	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
391-1          	391	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
391-2          	391	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
391-3          	391	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
391-4          	391	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
392-1          	392	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
392-2          	392	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
392-3          	392	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
392-4          	392	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
393-1          	393	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
393-2          	393	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
393-3          	393	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
393-4          	393	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
394-1          	394	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
394-2          	394	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
394-3          	394	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
394-4          	394	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
395-1          	395	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
395-2          	395	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
395-3          	395	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
395-4          	395	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
396-1          	396	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
396-2          	396	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
396-3          	396	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
396-4          	396	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
397-1          	397	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
397-2          	397	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
397-3          	397	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
397-4          	397	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
398-1          	398	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
398-2          	398	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
398-3          	398	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
398-4          	398	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
399-1          	399	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
399-2          	399	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
399-3          	399	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
399-4          	399	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
400-1          	400	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
400-2          	400	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
400-3          	400	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
400-4          	400	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
401-1          	401	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
401-2          	401	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
401-3          	401	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
401-4          	401	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
402-1          	402	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
402-2          	402	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
402-3          	402	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
402-4          	402	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
403-1          	403	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
403-2          	403	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
403-3          	403	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
403-4          	403	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
404-1          	404	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
404-2          	404	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
404-3          	404	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
404-4          	404	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
405-1          	405	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
405-2          	405	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
405-3          	405	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
405-4          	405	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
406-1          	406	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
406-2          	406	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
406-3          	406	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
406-4          	406	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
407-1          	407	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
407-2          	407	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
407-3          	407	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
407-4          	407	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
408-1          	408	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
408-2          	408	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
408-3          	408	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
408-4          	408	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
409-1          	409	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
409-2          	409	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
409-3          	409	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
409-4          	409	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
410-1          	410	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
410-2          	410	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
410-3          	410	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
410-4          	410	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
411-1          	411	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
411-2          	411	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
411-3          	411	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
411-4          	411	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
412-1          	412	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
412-2          	412	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
412-3          	412	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
412-4          	412	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
413-1          	413	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
413-2          	413	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
413-3          	413	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
413-4          	413	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
414-1          	414	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
414-2          	414	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
414-3          	414	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
414-4          	414	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
415-1          	415	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
415-2          	415	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
415-3          	415	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
415-4          	415	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
416-1          	416	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
416-2          	416	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
416-3          	416	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
416-4          	416	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
417-1          	417	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
417-2          	417	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
417-3          	417	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
417-4          	417	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
418-1          	418	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
418-2          	418	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
418-3          	418	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
418-4          	418	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
419-1          	419	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
419-2          	419	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
419-3          	419	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
419-4          	419	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
420-1          	420	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
420-2          	420	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
420-3          	420	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
420-4          	420	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
421-1          	421	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
421-2          	421	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
421-3          	421	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
421-4          	421	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
422-1          	422	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
422-2          	422	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
422-3          	422	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
422-4          	422	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
423-1          	423	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
423-2          	423	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
423-3          	423	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
423-4          	423	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
424-1          	424	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
424-2          	424	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
424-3          	424	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
424-4          	424	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
425-1          	425	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
425-2          	425	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
425-3          	425	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
425-4          	425	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
426-1          	426	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
426-2          	426	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
426-3          	426	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
426-4          	426	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
427-1          	427	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
427-2          	427	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
427-3          	427	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
427-4          	427	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
428-1          	428	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
428-2          	428	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
428-3          	428	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
428-4          	428	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
429-1          	429	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
429-2          	429	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
429-3          	429	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
429-4          	429	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
430-1          	430	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
430-2          	430	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
430-3          	430	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
430-4          	430	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
431-1          	431	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
431-2          	431	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
431-3          	431	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
431-4          	431	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
432-1          	432	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
432-2          	432	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
432-3          	432	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
432-4          	432	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
433-1          	433	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
433-2          	433	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
433-3          	433	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
433-4          	433	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
434-1          	434	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
434-2          	434	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
434-3          	434	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
434-4          	434	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
435-1          	435	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
435-2          	435	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
435-3          	435	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
435-4          	435	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
436-1          	436	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
436-2          	436	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
436-3          	436	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
436-4          	436	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
437-1          	437	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
437-2          	437	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
437-3          	437	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
437-4          	437	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
438-1          	438	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
438-2          	438	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
438-3          	438	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
438-4          	438	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
439-1          	439	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
439-2          	439	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
439-3          	439	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
439-4          	439	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
440-1          	440	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
440-2          	440	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
440-3          	440	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
440-4          	440	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
441-1          	441	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
441-2          	441	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
441-3          	441	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
441-4          	441	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
442-1          	442	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
442-2          	442	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
442-3          	442	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
442-4          	442	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
443-1          	443	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
443-2          	443	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
443-3          	443	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
443-4          	443	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
444-1          	444	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
444-2          	444	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
444-3          	444	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
444-4          	444	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
445-1          	445	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
445-2          	445	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
445-3          	445	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
445-4          	445	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
446-1          	446	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
446-2          	446	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
446-3          	446	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
446-4          	446	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
447-1          	447	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
447-2          	447	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
447-3          	447	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
447-4          	447	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
448-1          	448	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
448-2          	448	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
448-3          	448	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
448-4          	448	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
449-1          	449	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
449-2          	449	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
449-3          	449	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
449-4          	449	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
450-1          	450	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
450-2          	450	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
450-3          	450	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
450-4          	450	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
451-1          	451	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
451-2          	451	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
451-3          	451	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
451-4          	451	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
452-1          	452	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
452-2          	452	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
452-3          	452	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
452-4          	452	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
453-1          	453	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
453-2          	453	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
453-3          	453	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
453-4          	453	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
454-1          	454	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
454-2          	454	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
454-3          	454	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
454-4          	454	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
455-1          	455	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
455-2          	455	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
455-3          	455	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
455-4          	455	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
456-1          	456	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
456-2          	456	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
456-3          	456	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
456-4          	456	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
457-1          	457	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
457-2          	457	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
457-3          	457	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
457-4          	457	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
458-1          	458	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
458-2          	458	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
458-3          	458	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
458-4          	458	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
459-1          	459	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
459-2          	459	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
459-3          	459	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
459-4          	459	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
460-1          	460	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
460-2          	460	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
460-3          	460	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
460-4          	460	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
461-1          	461	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
461-2          	461	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
461-3          	461	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
461-4          	461	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
462-1          	462	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
462-2          	462	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
462-3          	462	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
462-4          	462	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
463-1          	463	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
463-2          	463	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
463-3          	463	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
463-4          	463	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
464-1          	464	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
464-2          	464	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
464-3          	464	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
464-4          	464	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
465-1          	465	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
465-2          	465	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
465-3          	465	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
465-4          	465	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
466-1          	466	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
466-2          	466	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
466-3          	466	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
466-4          	466	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
467-1          	467	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
467-2          	467	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
467-3          	467	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
467-4          	467	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
468-1          	468	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
468-2          	468	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
468-3          	468	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
468-4          	468	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
469-1          	469	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
469-2          	469	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
469-3          	469	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
469-4          	469	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
470-1          	470	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
470-2          	470	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
470-3          	470	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
470-4          	470	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
471-1          	471	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
471-2          	471	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
471-3          	471	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
471-4          	471	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
472-1          	472	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
472-2          	472	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
472-3          	472	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
472-4          	472	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
473-1          	473	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
473-2          	473	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
473-3          	473	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
473-4          	473	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
474-1          	474	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
474-2          	474	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
474-3          	474	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
474-4          	474	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
475-1          	475	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
475-2          	475	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
475-3          	475	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
475-4          	475	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
476-1          	476	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
476-2          	476	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
476-3          	476	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
476-4          	476	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
477-1          	477	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
477-2          	477	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
477-3          	477	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
477-4          	477	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
478-1          	478	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
478-2          	478	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
478-3          	478	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
478-4          	478	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
479-1          	479	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
479-2          	479	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
479-3          	479	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
479-4          	479	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
480-1          	480	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
480-2          	480	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
480-3          	480	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
480-4          	480	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
481-1          	481	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
481-2          	481	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
481-3          	481	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
481-4          	481	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
482-1          	482	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
482-2          	482	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
482-3          	482	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
482-4          	482	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
483-1          	483	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
483-2          	483	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
483-3          	483	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
483-4          	483	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
484-1          	484	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
484-2          	484	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
484-3          	484	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
484-4          	484	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
485-1          	485	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
485-2          	485	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
485-3          	485	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
485-4          	485	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
486-1          	486	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
486-2          	486	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
486-3          	486	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
486-4          	486	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
487-1          	487	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
487-2          	487	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
487-3          	487	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
487-4          	487	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
488-1          	488	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
488-2          	488	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
488-3          	488	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
488-4          	488	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
489-1          	489	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
489-2          	489	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
489-3          	489	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
489-4          	489	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
490-1          	490	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
490-2          	490	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
490-3          	490	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
490-4          	490	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
491-1          	491	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
491-2          	491	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
491-3          	491	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
491-4          	491	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
492-1          	492	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
492-2          	492	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
492-3          	492	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
492-4          	492	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
493-1          	493	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
493-2          	493	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
493-3          	493	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
493-4          	493	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
494-1          	494	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
494-2          	494	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
494-3          	494	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
494-4          	494	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
495-1          	495	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
495-2          	495	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
495-3          	495	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
495-4          	495	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
496-1          	496	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
496-2          	496	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
496-3          	496	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
496-4          	496	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
497-1          	497	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
497-2          	497	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
497-3          	497	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
497-4          	497	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
498-1          	498	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
498-2          	498	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
498-3          	498	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
498-4          	498	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
499-1          	499	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
499-2          	499	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
499-3          	499	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
499-4          	499	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
500-1          	500	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
500-2          	500	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
500-3          	500	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
500-4          	500	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
501-1          	501	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
501-2          	501	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
501-3          	501	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
501-4          	501	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
502-1          	502	1	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
502-2          	502	2	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
502-3          	502	3	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
502-4          	502	4	2024-02-26 12:08:13.114252	9999-01-01 00:00:00
\.


--
-- Data for Name: sensors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sensors (sensor_id, sensor_name) FROM stdin;
1	LM35
2	BME280
3	DHT11
4	GY-213V-HTU21D
\.


--
-- Data for Name: sensors_measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sensors_measurements (sensor_id, type_id, measurement_formula) FROM stdin;
1	1	251,66
1	2	288.49
1	3	151.40
2	1	65,00
2	2	1078.00
2	3	35.00
3	1	13.00
3	2	43.00
3	3	70.00
\.


--
-- Name: measurements_type_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measurements_type_type_id_seq', 3, true);


--
-- Name: meteostatins_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meteostatins_station_id_seq', 502, true);


--
-- Name: sensors_sensor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sensors_sensor_id_seq', 4, true);


--
-- Name: measurements_type measurements_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurements_type
    ADD CONSTRAINT measurements_type_pkey PRIMARY KEY (type_id);


--
-- Name: meteostatins meteostatins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meteostatins
    ADD CONSTRAINT meteostatins_pkey PRIMARY KEY (station_id);


--
-- Name: meteostation_sensor meteostation_sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meteostation_sensor
    ADD CONSTRAINT meteostation_sensor_pkey PRIMARY KEY (sensor_inventory_number);


--
-- Name: sensors sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensors
    ADD CONSTRAINT sensors_pkey PRIMARY KEY (sensor_id);


--
-- Name: measurements measurements_measurement_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_measurement_type_fkey FOREIGN KEY (measurement_type) REFERENCES public.measurements_type(type_id);


--
-- Name: measurements measurements_sensor_inventory_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_sensor_inventory_number_fkey FOREIGN KEY (sensor_inventory_number) REFERENCES public.meteostation_sensor(sensor_inventory_number);


--
-- Name: meteostation_sensor meteostation_sensor_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meteostation_sensor
    ADD CONSTRAINT meteostation_sensor_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES public.sensors(sensor_id);


--
-- Name: meteostation_sensor meteostation_sensor_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meteostation_sensor
    ADD CONSTRAINT meteostation_sensor_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.meteostatins(station_id);


--
-- Name: sensors_measurements sensors_measurements_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensors_measurements
    ADD CONSTRAINT sensors_measurements_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES public.sensors(sensor_id);


--
-- Name: sensors_measurements sensors_measurements_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sensors_measurements
    ADD CONSTRAINT sensors_measurements_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.measurements_type(type_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

