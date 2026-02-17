--Filtrer les meurtres à SQL City
SELECT *
FROM crime_scene_report
WHERE type = 'murder' AND city = 'SQL City';

--Trouver le premier témoin (dernier numéro sur Northwestern Dr)
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

--Trouver le deuxième témoin (Annabel sur Franklin Ave)
SELECT *
FROM person
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave';

--Lire les interviews des témoins
SELECT person_id, transcript
FROM interview
WHERE person_id IN (14887, 16371);

--Identifier le meurtrier dans la table person
SELECT *
FROM person
WHERE id = 10007;





