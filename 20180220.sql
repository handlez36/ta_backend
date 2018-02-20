--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categories (id, name, created_at, updated_at) FROM stdin;
17	Health	2017-12-12 18:18:58.693996	2017-12-12 18:18:58.693996
11	Category 1!!!	2017-11-25 18:42:07.252915	2017-12-12 18:45:15.288678
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categories_id_seq', 17, true);


--
-- Data for Name: journeys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY journeys (id, title, description, category_id, created_at, updated_at, user_id) FROM stdin;
24	Changing title	fourth	11	2017-12-11 21:56:15.15209	2017-12-12 13:06:18.96573	google-oauth2|115686955194036496492
29	B Mac Journey	B mac journey	17	2017-12-12 18:09:52.492306	2017-12-12 18:19:12.364395	google-oauth2|115686955194036496492
30	New Journey	New journey	17	2017-12-14 00:12:21.415363	2017-12-14 00:12:21.415363	facebook|10103823206031627
31	Another Journey	another journey	11	2017-12-14 00:17:23.054832	2017-12-14 00:17:23.054832	facebook|10103823206031627
32	Newest journey	newest journey	17	2017-12-14 00:17:55.970724	2017-12-14 00:17:55.970724	facebook|10103823206031627
\.


--
-- Name: journeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('journeys_id_seq', 32, true);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY posts (id, title, content, video_url, image_urls, journy_id, created_at, updated_at) FROM stdin;
1	Test	Test post	\N	{}	24	2017-12-14 00:28:44.041616	2017-12-14 00:28:44.041616
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 1, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20171124202743
20171124203319
20171208002401
20171208003108
20171210160953
20171214001938
20171214003001
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, name, nickname, picture, email, user_id, created_at, updated_at) FROM stdin;
2	Brandon McLean	handlez36	https://scontent.xx.fbcdn.net/v/t1.0-1/c8.0.50.50/p50x50/1743563_10101216079484127_438555586_n.jpg?oh=bcee8cecc792e99092f48bd33c1e553f&oe=5A8AE7D3	handlez36@hotmail.com	facebook|10103823206031627	2017-12-10 16:19:31.287197	2017-12-10 16:19:31.287197
1	Brandon McLean	handlez36	https://lh5.googleusercontent.com/-ACM19C-PmuQ/AAAAAAAAAAI/AAAAAAAAAIo/QvWGj7kva4U/photo.jpg	handlez36@gmail.com	google-oauth2|115686955194036496492	2017-12-10 16:18:38.33216	2017-12-10 18:50:30.732364
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

