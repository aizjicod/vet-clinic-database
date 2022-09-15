/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE "name" LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Pikachu','Agumon');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE "name" NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.3 AND 17.4;


-- transactions 
-- TRANSACTOIN N1
BEGIN;
UPDATE animals
SET species  = 'unspecified';
ROLLBACK;
-- TRANSACTOIN N2
BEGIN; 

UPDATE animals
SET species  = 'digimon'
WHERE name LIKE ('%mon%');
SELECT name, species FROM animals

UPDATE animals
SET species  = 'pokemon'
WHERE name NOT LIKE ('%mon%');

COMMIT;

-- TRANSACTOIN N3

BEGIN;
 DELETE FROM animals;
 SELECT * FROM animals;
 ROLLBACK;

-- TRANSACTOIN N4

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-1-1';
SELECT * FROM animals;

SAVEPOINT delete_animals;

UPDATE animals
SET weight_kg = weight_kg * -1;

SELECT * FROM animals;

ROLLBACK TO delete_animals;
SELECT * FROM animals;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT;

-- more queries

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts > 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts), neutered FROM animals
GROUP BY neutered;
SELECT MAX(weight_kg),MIN(weight_kg), species FROM animals
GROUP BY species;
SELECT AVG(escape_attempts), species FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-01-01'
GROUP BY species;

-- using join to query 

SELECT "name", O.full_name FROM animals A
JOIN owners O 
ON a.owners_id = o.id
WHERE O.full_name = 'Melody Pond';

SELECT A."name", S."name" FROM animals A
JOIN species S 
ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT O.full_name, A."name" FROM owners O
FULL JOIN animals A 
ON A.owners_id = O.id;

SELECT COUNT(A."name"), S."name" FROM animals A
JOIN species S
ON A.species_id = S.id
GROUP BY S."name";

SELECT O.full_name, A."name", S."name" FROM animals A
JOIN owners O 
ON a.owners_id = O.id
JOIN species S
ON A.species_id = S.id
WHERE O.full_name = 'Jennifer Orwell' AND S."name" = 'Digimon' ;

SELECT O.full_name, COUNT(A."name") as owned
FROM owners O
INNER JOIN animals A
ON A.owners_id = O.id
GROUP BY O.full_name ORDER BY owned DESC;

