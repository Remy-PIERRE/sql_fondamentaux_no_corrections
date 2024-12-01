# Module 03 - Insertion des données :outbox_tray:
<a href="../00 Les fichiers PDF - Supports de cours/03 Insertion des données.pdf">
  <img src="../img/03/m3.png" width="300">
</a>  
<br>
<a href="../00 Les fichiers PDF - Supports de cours/03 Insertion des données.pdf">
03 Insertion des données
</a> 

<br><br>  

![star](../img/04/star.webp)
![matrix](../img/04/matrix.webp)
![pulp](../img/04/pulp.webp)
  
| id | titre | sortie |
|---|---|---|
| 1 | STAR WARS | 1977/05/25 |
| 2 | THE MATRIX | 1999/06/23 |
| 3 | PULP FICTION | 1994/10/26 |
  
Pour insérer les données dans une table :
```sql
INSERT INTO film (...) VALUES (...);
```

Je précise les champs :
```sql
INSERT INTO film (id,titre,sortie) VALUES (...);
```
Et puis je rentre les valeurs :
```sql
INSERT INTO film (id,titre,sortie) VALUES (1,'STAR WARS','1977/05/25');
```

Je ne suis pas obligé de mettre l'ID
```sql
INSERT INTO film (titre,sortie) VALUES ('STAR WARS','1977/05/25');
```

Il est possible d'enchaîner les commandes comme celà :

```sql
INSERT INTO film (...) VALUES
(...),
(...),
(...);
```

```sql
INSERT INTO film (id,titre,sortie) VALUES
(1,'STAR WARS','1977/05/25'),
(2,'THE MATRIX','1999/06/23'),
(3,'PULP FICTION','1994/10/26');
```
**ou bien sans les ID** :
```sql
INSERT INTO film (titre,sortie) VALUES
('STAR WARS','1977/05/25'),
('THE MATRIX','1999/06/23'),
('PULP FICTION','1994/10/26');
```
## Effacer un ou des enregistrements

:warning: **Penser à vider la table** :scream:  
  

Pour vider la table :  
:warning: l'ID n'est pas remis à 1
```sql
DELETE FROM film;
```
Utiliser <code>DELETE</code> pour effacer un film  
Effacer un film  
Effacer un enregistrement
```sql
DELETE FROM film where id=1;
```

**Bonne pratique**   :heart_eyes: :   
Pour vider la table et repartir à l'ID=1:
```sql
TRUNCATE film;
```

