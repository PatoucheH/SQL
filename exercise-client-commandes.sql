-- exercise 1 get the user with first_name "Muriel" and password "test11"

SELECT * FROM client
WHERE prenom = "Muriel" && PASSWORD = SHA1('test11');

-- exercise 2 get all the product in several orders

SELECT nom, COUNT(*) AS number_command 
FROM commande_ligne
GROUP BY nom
HAVING number_command > 1
ORDER BY number_command DESC;


-- exercise 3 get all the product in several orders and add a colomn with all the ID

SELECT nom, COUNT(*) AS number_command, GROUP_CONCAT(commande_id) AS commands
FROM commande_ligne
GROUP BY nom
HAVING number_command > 1
ORDER BY number_command DESC;

-- exercise 4 get the final price of each command

UPDATE commande_ligne
SET prix_total = quantite * prix_unitaire
WHERE prix_total = 0;

-- exercise 5 get the total price with and the date,first name and client's name 

SELECT client.prenom, client.nom, commande.date_achat, commande_id, SUM(prix_total) AS prix_commande
FROM commande_ligne
LEFT JOIN commande
	ON commande.id = commande_ligne.commande_id
LEFT JOIN client
	ON client.id = commande.client_id
GROUP BY commande_id;

-- exercise 6 Save the global price of each coman in cache_prix_total

UPDATE commande AS table_1
INNER JOIN ( SELECT commande_id, SUM(commande_ligne.prix_total) AS prix_totaux
				FROM commande_ligne
				GROUP BY commande_id) table_2
					ON table_1.id = table_2.commande_id

SET table_1.cache_prix_total = table_2.prix_totaux
WHERE table_2.prix_totaux;


-- exercise 7 get global price for each month 

SELECT MONTH(date_achat), SUM(cache_prix_total)
FROM commande
GROUP BY MONTH(date_achat)
ORDER BY MONTH(date_achat);

-- exercise 8 get the list of the ten clients who made the more commands and the total price

SELECT client.nom, client.prenom, SUM(cache_prix_total) AS client_prix_total
FROM commande
LEFT JOIN client ON client.id = commande.client_id
GROUP BY commande.client_id
ORDER BY client_prix_total DESC
LIMIT 10;

--exercise 9 get the total price for each date

SELECT date_achat, SUM(cache_prix_total)
FROM commande
GROUP BY date_achat;

--exercise 10 ADD column category

ALTER TABLE commande
ADD COLUMN category INT NOT NULL;

-- exercise 11 Save the value category "1" < 200, 200 < "2" < 500; 500 < "3" < 1000;  4> 1000

UPDATE commande
SET category = CASE 
		WHEN cache_prix_total < 200 THEN 1
		WHEN cache_prix_total >= 200 && cache_prix_total < 500 THEN 2
		WHEN cache_prix_total >= 500 && cache_prix_total < 1000 THEN 3
		WHEN cache_prix_total > 1000 THEN 4
	END;


-- exercise 12 create a  table "commande_category" 

CREATE TABLE commande_category (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nom VARCHAR(100) NOT NULL);


-- exercise 13 insert category inside the new table

INSERT INTO commande_category (id, nom)
VALUES (1, "commandes en dessous de 200");
INSERT INTO commande_category (id, nom)
VALUES (2, "commandes entre 200 et 500")
INSERT INTO commande_category (id, nom)
VALUES (3, "commandes entre 500 et 1000");
INSERT INTO commande_category (id, nom)
VALUES (4, "commandes au dessus de 1000");

-- exercise 14 delete all the commands before first february 2019
DELETE FROM commande_ligne
WHERE commande_id IN (SELECT id FROM commande WHERE date_achat < '2019-02-01');

DELETE FROM commande
WHERE date_achat < '2019-02-01';
