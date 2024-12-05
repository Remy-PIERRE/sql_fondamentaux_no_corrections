DROP DATABASE IF EXISTS my_crm;

CREATE DATABASE my_crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE my_crm;

CREATE TABLE clients (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE projects (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    client_id INT UNSIGNED NOT NULL,
    CONSTRAINT pk_projects PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE quotes (
    id VARCHAR(8) NOT NULL,
    version INT UNSIGNED NOT NULL,
    price INT UNSIGNED NOT NULL,
    project_id INT UNSIGNED NOT NULL,
    CONSTRAINT pk_quotes PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE invoices (
    id VARCHAR(5) NOT NULL,
    info VARCHAR(100) NOT NULL,
    total INT UNSIGNED NOT NULL,
    date_crea DATE NOT NULL,
    date_payment DATE,
    quote_id VARCHAR(8) NOT NULL,
    CONSTRAINT pk_invoices PRIMARY KEY (id)
) ENGINE=InnoDB;

ALTER TABLE projects ADD
CONSTRAINT fk_projects_clients FOREIGN KEY (client_id) REFERENCES clients(id);

ALTER TABLE quotes ADD
CONSTRAINT fk_quotes_projects FOREIGN KEY (project_id) REFERENCES projects(id);

ALTER TABLE invoices ADD
CONSTRAINT fk_invoices_quotes FOREIGN KEY (quote_id) REFERENCES quotes(id);

INSERT INTO clients (name) VALUES 
	('Mairie de Rennes'),
	('Neo Soft'),
	('Sopra'),
	('Accenture'),
	('Amazon');

INSERT INTO projects (name, client_id) VALUES
	('Création de site internet', 1),
	('Logiciel CRM', 2),
	('Logiciel de devis', 3),
	('Site internet e-commerce', 4),
	('Logiciel ERP', 2),
	('Logiciel gestion de stock',5);

INSERT INTO quotes (id, version, price, project_id) VALUES
	('DEV2100A', '1', 3000, 1),
	('DEV2100B', '2', 5000, 1),
	('DEV2100C', '1', 5000, 2),
	('DEV2100D', '1', 3000, 3),
	('DEV2100E', '1', 5000, 4),
	('DEV2100F', '1', 2000, 5),
	('DEV2100G', '1', 1000, 6);

INSERT INTO invoices (id, info, total, quote_id, date_crea, date_payment)	
    VALUES
	('FA001', 'site internet partie 1', 1500, 'DEV2100A', '2023-09-01','2023-10-01'),
	('FA002', 'site internet partie 2', 1500, 'DEV2100A', '2023-09-20',null),
	('FA003', 'logiciel CRM', 5000, 'DEV2100C', '2024-02-01',null),
	('FA004', 'logiciel devis', 3000, 'DEV2100D', '2024-03-03','2024-04-03'),
	('FA005', 'site ecommerce', 5000, 'DEV2100E', '2023-03-01',null),
	('FA006', 'logiciel ERP', 2000, 'DEV2100F', '2023-03-01',null);

-- 1
SELECT  i.id AS ref,
        c.name AS client,
        info,
        total,
        date_crea AS date,
        date_payment AS paiement
FROM invoices i
INNER JOIN quotes q ON i.quote_id = q.id
INNER JOIN projects p ON q.project_id = p.id
INNER JOIN clients c ON p.client_id = c.id;

-- 2
SELECT  c.name AS client,
        COUNT(i.id) AS nb_factures
FROM invoices i
RIGHT JOIN quotes q ON i.quote_id = q.id
RIGHT JOIN projects p ON q.project_id = p.id
RIGHT JOIN clients c ON p.client_id = c.id
GROUP BY c.id;

-- 3
SELECT  c.name AS client,
        COALESCE(SUM(i.total), 0) AS total_factures
FROM invoices i
RIGHT JOIN quotes q ON i.quote_id = q.id
RIGHT JOIN projects p ON q.project_id = p.id
RIGHT JOIN clients c ON p.client_id = c.id
GROUP BY c.id;

-- 4
SELECT SUM(total) AS ca_total
FROM invoices;

-- 5
SELECT SUM(total) AS total_facture
FROM invoices
WHERE date_payment IS NULL;

-- 6
SELECT  id AS facture,
        DATEDIFF(NOW(), date_crea) - 30
        AS nb_jour
FROM invoices
WHERE date_payment IS NULL
AND DATEDIFF(NOW(), date_crea) > 30;

-- 7
SELECT  id AS facture,
        DATEDIFF(NOW(), date_crea) - 30 AS nb_jour_de_retard,
        (DATEDIFF(NOW(), date_crea) - 30) * 2 AS penalite,
        total,
        (DATEDIFF(NOW(), date_crea) - 30) * 2 + total AS facture_finale
FROM invoices
WHERE date_payment IS NULL
AND DATEDIFF(NOW(), date_crea) > 30;