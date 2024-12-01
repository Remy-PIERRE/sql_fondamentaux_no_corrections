# TP 09 - Film avec acteurs - table de jointure
## :warning: La correction

<img src="../../img/c.webp" width="100">  <img src="../../img/nine.webp" width="100">

![db](../../img/13/titanic.webp)
## Le modèle relationnel
<img src="../../img/05/film_has_acteur.svg" width="800">

## Les données
![db2](../../img/13/data.png)




# Afficher tous les films et leur acteurs
```mysql
SELECT 
film.nom AS film,
acteur.prenom,
acteur.nom
FROM film
INNER JOIN film_has_acteur  ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
```

:one: - Afficher tous les films Léonardo
| film | acteur_prenom | acteur_nom |
|--- |--- |--- |
|Once Upon the time |  Leonardo | DICAPRIO |
|Fight Club |  Leonardo | DICAPRIO |

```sql
SELECT 
film.nom AS film,
acteur.prenom,
acteur.nom
FROM film
INNER JOIN film_has_acteur  ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
WHERE acteur_id=2
```
:two: Afficher le nombre de films par acteur
| acteur_prenom | acteur_nom |  nb_films | 
|--- |--- |--- |
|  Leonardo | DICAPRIO | 1|
| Brad | PITT | 2 |

```sql
SELECT 
COUNT(film.id) AS nb_films,
acteur.prenom,
acteur.nom
FROM film
INNER JOIN film_has_acteur  ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
GROUP BY (acteur.id);
```

:three: Ajouter un film TITANIC
```sql
INSERT INTO film (nom) VALUES ('TITANIC');
```
:four: - Trouver le film qui n'a pas d'acteur
| film | 
|--- |
|  TITANIC |


```sql
SELECT 
film.nom, 
acteur_id
FROM film
LEFT JOIN film_has_acteur on film.id=film_has_acteur.film_id
WHERE acteur_id IS NULL
```