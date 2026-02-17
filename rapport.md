# Sans titre

```markdown
# Enquête SQL Murder Mystery

## Objectif
Trouver qui a commis le meurtre à SQL City 
## Outil utilisé :
VS Code avec l’extension 'SQLite' pour exécuter toutes les requêtes et voir les résultats.

**1. Chercher les meurtres à SQL City**
SELECT *
FROM crime_scene_report
WHERE type = 'murder' AND city = 'SQL City';

Résultat :
| date     | type   | description                                                                                                                                                                               | city     |
| -------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| 20180115 | murder | Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave". | SQL City |
| 20180215 | murder | REDACTED                                                                                                                                                                                  | SQL City |
| 20180215 | murder | Someone killed the guard! He took an arrow to the knee!                                                                                                                                   | SQL City |

**Explication* : on filtre tous les meurtres qui ont eu lieu à SQL City pour identifier ceux qui ont des témoins et les analyser.

**2. Identifier les témoins**
*2a. Premier témoin – Morty Schapiro*
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

Résultat :
| id    | name           | license_id | address_number | address_street_name | ssn       |
| ----- | -------------- | ---------- | -------------- | ------------------- | --------- |
| 14887 | Morty Schapiro | 118009     | 4919           | Northwestern Dr     | 111564949 |

**Explication :* on cherche le dernier numéro de la rue Northwestern Dr pour trouver Morty, le premier témoin mentionné dans le rapport de crime.

*2b. Deuxième témoin – Annabel Miller*
SELECT *
FROM person
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave';

Résultat :
| id    | name           | license_id | address_number | address_street_name | ssn       |
| ----- | -------------- | ---------- | -------------- | ------------------- | --------- |
| 16371 | Annabel Miller | 490173     | 103            | Franklin Ave        | 318771143 |

**Explication :* on cherche Annabel, le deuxième témoin, qui habite sur Franklin Ave.

**3. Lire les déclarations des témoins**
SELECT person_id, transcript
FROM interview
WHERE person_id IN (14887, 16371);

Résultat :
| person_id | transcript                                                                                                                                                                                                                      |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 14887     | I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W". |
| 16371     | I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.                                                                                                           |

**Explication :* on récupère les déclarations des deux témoins pour obtenir des indices précis sur le meurtrier.

a. Morty a vu un sac de gym “Get Fit Now Gym” avec le numéro 48Z et une voiture H42W.
b. Annabel a reconnu le meurtrier dans son gym.*

4. Identifier le meurtrier
SELECT *
FROM person
WHERE id = 10007;

Résultat :
| id    | name                | license_id | address_number | address_street_name | ssn       |
| ----- | ------------------- | ---------- | -------------- | ------------------- | --------- |
| 10007 | Kourtney Calderwood | 861794     | 2791           | Gustavus Blvd       | 477972044 |

**Explication :* en croisant les indices des témoins avec la table person, on trouve le coupable correspondant aux indices : Kourtney Calderwood.
```