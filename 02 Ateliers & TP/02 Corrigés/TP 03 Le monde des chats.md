# TP 3 - Le monde des les chats
## :warning: La correction
<img src="../../img/c.webp" width="100"> <img src="../../img/three.webp" width="100">  

| id | nom | yeux | age |
|---|---|---|---|
| 1 | Maine coon | marron | 20 |
| 2 | Siamois | bleu | 15 |
| 3 | Bengal | marron | 18 |
| 4 | Scottish Fold | marron | 10 |
  
![maincoon](/img/09/maincoon.webp)
![siamois](/img/09/siamois.webp)
![bengal](/img/09/bengal.webp)
![scottish](/img/09/scottish.webp)

:one: - Ajouter les données  
:two: - Afficher le chat avec l'id :2  
:three: - Trier les chats par nom et par age  
:four: - Afficher les chats qui vive entre 11 et 19 ans  
:five: - Afficher le ou les chats dont le nom contient 'sia'  
:six: - Afficher le ou les chats dont le nom contient 'a'  
:seven: - Afficher la moyenne d'age des chats  
:eight: - Afficher le nombre de chats dans la table   
:nine: - Afficher le nombre de chat avec couleur d'yeux marron  
10 - Afficher le nombre de chat par couleur d'yeux    
[BONUS] - Ajouter les données à partir d'un fichier excel  

# La correction :
:one: - Ajouter les données  
```sql
USE zoo;
-- vider la table
TRUNCATE chat;
-- INSERTION DES DONNES
INSERT INTO chat (nom,yeux,age)
VALUES
('maine coon','marron',20),
('siamois','bleu',15),
('bengal','marron',18),
('scottish Fold','marron',10);
```

:two: - Afficher le chat avec l'id :2 
| id | nom | yeux | age |
|---|---|---|---|
| 2 | Siamois | bleu | 15 |
```sql
USE zoo;
SELECT 
    id, nom, yeux, age 
FROM chat 
WHERE id=2;
```  
:three: - Trier les chats par nom et par age  

| id | nom | yeux | age |
|---|---|---|---|
| 3 | Bengal | marron | 18 |
| 1 | Maine coon | marron | 20 |
| 4 | Scottish Fold | marron | 10 |
| 2 | Siamois | bleu | 15 |
```sql
USE zoo;
SELECT
    id,nom,yeux,age
FROM chat
ORDER BY nom,age;
``` 
:four: - Afficher les chats qui vive entre 11 et 19 ans  
| id | nom | yeux | age |
|---|---|---|---|
| 3 | Bengal | marron | 18 |
| 2 | Siamois | bleu | 15 |
```sql
USE zoo;
SELECT 
    nom, age 
FROM chat 
WHERE age >=11
AND age <=19;
``` 
:five: - Afficher le ou les chats dont le nom contient 'sia'
| id | nom | yeux | age |
|---|---|---|---|
| 2 | Siamois | bleu | 15 |
```sql
USE zoo; 
SELECT 
    nom, age 
FROM chat  
WHERE nom LIKE 'sia%';
``` 
:six: - Afficher le ou les chats dont le nom contient 'a'
| id | nom | yeux | age |
|---|---|---|---|
| 1 | Maine coon | marron | 20 |
| 2 | Siamois | bleu | 15 |
| 3 | Bengal | marron | 18 |
```sql
USE zoo; 
SELECT 
    nom, age 
FROM chat  
WHERE nom LIKE '%a%';
```
:seven: - Afficher la moyenne d'age des chats 
| age_moyen |
|---|
| 15.7500 |
```sql
USE zoo;
SELECT 
    AVG(age) AS age_moyen
FROM chat; 
```
:eight: - Afficher le nombre de chats dans la table
| nb_chat |
|---|
| 4 |   
```sql
USE zoo;
SELECT 
    COUNT(id) AS nb_chat
FROM chat; 
```

:nine: - Afficher le nombre de chat avec couleur d'yeux marron
| couleur | nb_chat |
|---|---|
| marron | 3 |
```sql
USE zoo;
SELECT
    yeux AS couleur,
    COUNT(id) AS nb_chat
FROM chat
WHERE yeux ='marron'
GROUP BY (yeux);
```
10 - Afficher le nombre de chat par couleur d'yeux
| couleur | nb_chat |
|---|---|
| marron | 3 |
| bleu | 1 |
```sql
USE zoo;
SELECT
    yeux AS couleur,
    COUNT(id) AS nb_chat
FROM chat
GROUP BY (yeux);
```

