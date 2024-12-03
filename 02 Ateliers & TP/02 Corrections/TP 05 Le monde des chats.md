# TP 5 - Le mondes des chats avec une table de jointure
## :warning: La correction

<img src="../../img/c.webp" width="100"> <img src="../../img/five.webp" width="100">  

<img src="../../img/05/chat-couleur.svg" width="600">

<img src="../../img/06/tp-chat.png" width="800">

![maincoon](/img/09/maincoon.webp)
![siamois](/img/09/siamois.webp)
![bengal](/img/09/bengal.webp)
![scottish](/img/09/scottish.webp)



# Objectifs :
:one: Création de la base de données **spa**  
:two: Création de la table **chat**  
:three: Creation de la table **couleur**  
```sql
# 1 Création de la base de données spa
DROP DATABASE IF EXISTS spa;
-- CREATION DE LA DATA BASE
CREATE DATABASE spa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE spa;

# 2 Création de la table chat  
CREATE TABLE chat (
 id int NOT NULL AUTO_INCREMENT,
 nom VARCHAR(50) NOT NULL,
 couleur_id int NULL, # le champ peut etre null
 CONSTRAINT pk_chat PRIMARY KEY (id)
)ENGINE=INNODB;

# 3 Creation de la table couleur 
CREATE TABLE couleur (
 id int NOT NULL AUTO_INCREMENT,
 nom VARCHAR(50) NOT NULL,
 CONSTRAINT pk_couleur PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE chat ADD CONSTRAINT fk_couleur FOREIGN KEY (couleur_id) REFERENCES couleur(id);
```

:four: Insérer  les données  
```sql
USE spa;

# 1 on commence par la table couleur
INSERT INTO couleur (nom) VALUES
('marron'),
('bleu'),
('vert');

# 1 ensuite la table chat
INSERT INTO chat (nom,couleur_id) VALUES
('maine coon',1),
('siamois',2),
('bengal',1),
('scottish fold',1),
('domestique',null);
```
#  - Je teste et j'affiche
```sql
USE spa;

SELECT  nom FROM chat; 
```

| nom | 
|---|
| maine coon |
| siamois |
| bengal | 
| scottish fold |
| domestique |

-----------------------------------------------

```sql
USE spa;

SELECT  nom FROM couleur; 
```
| nom | 
|---|
| marron |
| bleu |
| vert | 

# Bonus : pseudo code pour db diagram

<img src="../../img/dbdiagram.svg" width="200">  

[db Diagram](https://dbdiagram.io/home) 
**prompt db diagram :**
```
Table couleur{
  id int [pk,not null, increment]
  nom varchar(30) [not null]
}
Table chat{
  id int [pk,not null, increment]
  nom varchar(30) [not null]
  couleur_id int [null]
}
Ref: "couleur"."id" < "chat"."couleur_id"
```