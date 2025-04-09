-- FIRST exercise find the 10 city the populated most in 2012
SELECT ville_nom, ville_population_2012 FROM villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 

-- exercise 2 50 city the smallest surface area

SELECT ville_nom, ville_surface FROM villes_france_free
ORDER BY ville_surface ASC
LIMIT 50;

-- exercise 3 find DOM departement begin by 97

SELECT departement_nom, departement_code FROM departement
WHERE departement_code LIKE "97%";

-- exercise 4 find the 10 city the most populated in 2012 + their departyment

SELECT ville_nom_reel, departement_code FROM villes_france_free
INNER JOIN departement
	ON villes_france_free.ville_departement = departement.departement_code
ORDER BY ville_population_2012 DESC
LIMIT 10;

-- exercise 5 get all the departement sorted by number of municipalities inside it

SELECT departement_nom,  departement_code, SUM(ville_arrondissement) AS number_city FROM departement
INNER JOIN villes_france_free
	ON departement.departement_code = villes_france_free.ville_departement
GROUP BY departement_nom
ORDER BY number_city DESC;

--exercise 6 get 10 bigest department in surface area

SELECT departement_nom, SUM(ville_surface) AS departement_surface FROM departement
INNER JOIN villes_france_free
	ON villes_france_free.ville_departement = departement.departement_code
GROUP BY departement_nom
ORDER BY departement_surface DESC
LIMIT 10;

-- exercise 7 count the number of city which begin by "SAINT"

SELECT count(*) AS number_saint_city FROM villes_france_free
WHERE ville_nom LIKE "saint%";

-- exercise 8 get the names of cities that are repeated sorted by the names that occur most often

SELECT ville_nom, COUNT(*) AS frequence FROM villes_france_free
GROUP BY ville_nom
HAVING COUNT(*)
ORDER BY frequence DESC;

-- exercise 9 get in one SQL query the list of the city greater than the average 

SELECT ville_nom, ville_surface FROM villes_france_free
WHERE ville_surface > (SELECT AVG(ville_surface) FROM villes_france_free)
ORDER BY ville_surface DESC;

-- exercise 10 get the department which has more than 2.000.000 residents

SELECT departement_nom, SUM(ville_population_2012) AS departement_population FROM departement
INNER JOIN villes_france_free
	ON departement.departement_code = villes_france_free.ville_departement
GROUP BY departement_nom
HAVING departement_population > 2000000;

-- exercise 11 remplace "-" by " " in each city with "SAINT-"

UPDATE villes_france_free
SET ville_nom = REPLACE(ville_nom, "-", " ")
WHERE ville_nom LIKE "SAINT-%";