USE location_ski;

# 1
SELECT  nocli,
        nom,
        prenom,
        adresse,
        cpo,
        ville
FROM clients
WHERE nom LIKE "d%";

# 2
SELECT nom, prenom FROM clients;

# 3
SELECT  fiches.noFic AS noFIc,
        fiches.etat AS etat,
        clients.nom AS nom,
        clients.prenom AS prenom
FROM fiches
INNER JOIN clients ON fiches.noCli=clients.noCli
WHERE cpo LIKE "44%";

-- version réduite
SELECT noFic, etat, nom, prenom
FROM fiches 
JOIN clients USING (noCli)
WHERE cpo LIKE '44%';

# 4
SELECT  fiches.noFic AS noFic,
        clients.nom AS nom,
        clients.prenom AS prenom,
        articles.refart AS refart,
        articles.designation AS designation,
        lignesFic.depart AS depart,
        lignesFic.retour AS retour,
        tarifs.prixJour AS prixJour,
        -- affiche la valeur en premier argument si non null, sinon affiche la valeur en second argument
        COALESCE(
            -- DATDIFF => valeur le plus recente puis valeur la plus ancienne, sinon résultat négatif
            (DATEDIFF(lignesfic.retour, lignesfic.depart) + 1) * tarifs.prixJour,
            (DATEDIFF(NOW(), lignesfic.depart) + 1) * tarifs.prixJour
        ) AS montant
FROM fiches
INNER JOIN clients ON fiches.noCli=clients.noCli
INNER JOIN lignesfic ON fiches.noFic=lignesfic.noFic
INNER JOIN articles ON lignesfic.refart=articles.refart
INNER JOIN grilleTarifs ON (articles.codeGam=grilleTarifs.codeGam AND articles.codeCate=grilleTarifs.codeCate)
INNER JOIN tarifs ON grilleTarifs.codeTarif=tarifs.codeTarif
WHERE lignesFic.noFic=1002;

-- version réduite
SELECT  f.noFic AS noFic,
        nom,
        prenom,
        a.refart AS refart,
        designation,
        depart,
        retour,
        prixJour,
        COALESCE(
            (DATEDIFF(retour, depart) + 1) * prixJour,
            (DATEDIFF(NOW(), depart) + 1) * prixJour
        ) AS montant
FROM fiches f
JOIN clients USING (noCli)
JOIN lignesfic l USING (noFic)
JOIN articles a USING (refart)
JOIN grilleTarifs g ON (a.codeGam=g.codeGam AND a.codeCate=g.codeCate)
JOIN tarifs USING (codeTarif)
WHERE l.noFic=1002;

# 5
SELECT  gammes.libelle AS Gamme,
        AVG(tarifs.prixJour) as TarifMoyen
FROM grilletarifs 
INNER JOIN gammes USING (codeGam)
INNER JOIN tarifs USING (codeTarif)
GROUP BY Gamme;

# 6
SELECT  fiches.noFic AS noFic,
        clients.nom AS nom,
        clients.prenom AS prenom,
        articles.refart AS refart,
        articles.designation AS designation,
        lignesFic.depart AS depart,
        lignesFic.retour AS retour,
        tarifs.prixJour AS prixJour,
        COALESCE(
            (DATEDIFF(lignesfic.retour, lignesfic.depart) + 1) * tarifs.prixJour,
            (DATEDIFF(NOW(), lignesfic.depart) + 1) * tarifs.prixJour
        ) AS montant,
        total
FROM fiches
INNER JOIN clients ON fiches.noCli=clients.noCli
INNER JOIN lignesfic ON fiches.noFic=lignesfic.noFic
INNER JOIN articles ON lignesfic.refart=articles.refart
INNER JOIN grilleTarifs ON (articles.codeGam=grilleTarifs.codeGam AND articles.codeCate=grilleTarifs.codeCate)
INNER JOIN tarifs ON grilleTarifs.codeTarif=tarifs.codeTarif
INNER JOIN (
    SELECT  lignesFic.noFic,
            SUM(
                COALESCE(
                    (DATEDIFF(lignesfic.retour, lignesfic.depart) + 1) * tarifs.prixJour,
                    (DATEDIFF(NOW(), lignesfic.depart) + 1) * tarifs.prixJour
                )
            ) AS total
        FROM lignesFic
        INNER JOIN articles ON lignesFic.refart=articles.refart
        INNER JOIN grilleTarifs ON (articles.codeGam=grilleTarifs.codeGam AND articles.codeCate=grilleTarifs.codeCate)
        INNER JOIN tarifs ON grilleTarifs.codeTarif=tarifs.codeTarif
        WHERE lignesFic.noFic=1002
        GROUP BY lignesFic.noFic
) AS table_intermediaire ON table_intermediaire.noFic=fiches.noFIc
WHERE lignesFic.noFic=1002;

-- version réduite
SELECT  f.noFic AS noFic,
        nom, prenom, 
	    a.refart AS refart, 
        designation, depart, retour, prixJour,
        COALESCE(
            (DATEDIFF(retour, depart) + 1) * prixJour,
            (DATEDIFF(NOW(), depart) + 1) * prixJour
        ) AS montant, 
        total
FROM fiches f
JOIN clients c USING (noCli)
JOIN lignesfic l USING (noFic)
JOIN articles a USING (refart)
JOIN grilletarifs g ON (a.codeGam=g.codeGam AND a.codeCate=g.codeCate)
JOIN tarifs t USING (codeTarif)
JOIN (
    SELECT  l.noFic,
    SUM( 
        COALESCE(
            (DATEDIFF(retour, depart) + 1) * prixJour,
            (DATEDIFF(NOW(), depart) + 1) * prixJour
        )
    ) as total
    FROM 
        lignesfic l
        JOIN articles a USING (refart)
        JOIN grilletarifs g ON (a.codeGam=g.codeGam AND a.codeCate=g.codeCate)
        JOIN tarifs t USING (codeTarif)
        WHERE l.noFic=1002
        GROUP BY l.noFic 
) _ USING (noFic);

# 7
SELECT c.libelle, g.libelle, t.libelle, prixJour
FROM grilleTarifs gt
	JOIN gammes g USING (codeGam)
	JOIN categories c USING (codeCate)
	JOIN tarifs t USING (codeTarif);

# 8
SELECT a.refart, designation, count(a.refart) nbLocation
FROM lignesfic l 
JOIN articles a USING (refart)
WHERE a.codeCate='SURF'
GROUP by a.refart;

# 9
SELECT  AVG(table_intermediaire.nb_lignes_par_fiche) AS nb_lignes_moyen_par_fiche
FROM (
    SELECT COUNT(noLig) AS nb_lignes_par_fiche
    FROM lignesFic
    GROUP BY noFic
) table_intermediaire;

-- version réduite
SELECT AVG(nb_lignes_par_fiche) as nb_lignes_moyen_par_fiche
FROM (
		SELECT COUNT(noLig) AS nb_lignes_par_fiche
		FROM lignesfic l 
		GROUP BY noFic) info;

# 10
SELECT c.libelle, count(noFic)
FROM lignesfic l 
JOIN articles a USING (refart)
JOIN categories c USING(codeCate)
WHERE c.libelle IN ('Ski Alpin','Surf','Patinette')
GROUP BY c.libelle;

# 11
SELECT AVG(MontantParFiche)
FROM (
	SELECT  noFic, 
            SUM(
                (DATEDIFF(
                    IFNULL(retour, NOW() + 1), depart) + 1
                ) * prixJour
            ) AS MontantParfiche
	FROM lignesfic l 
	JOIN articles a USING (refart)
	JOIN grilletarifs g ON (a.codeGam=g.codeGam AND a.codeCate=g.codeCate)
	JOIN tarifs t USING (codeTarif)
	GROUP BY noFic) AS info;