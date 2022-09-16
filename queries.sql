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
GROUP BY O.full_name ORDER BY owned DESC
LiMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT A."name", MAX(VI.date) AS date FROM visits VI
JOIN vets VE
ON VE.id = VI.vets_id
JOIN animals A
ON VI.animals_id = A.id
WHERE VE."name" = 'William Tatcher'
GROUP BY A."name" ORDER BY date DESC
LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) AS count FROM visits VI
JOIN vets VE
ON VE.id = VI.vets_id
WHERE VE."name" = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets."name" as vets_name, S."name" as vet_specialization
FROM vets
FULL JOIN specializations SP
ON vets.id = SP.vets_id
FULL JOIN species S 
ON SP.species_id = S.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A."name", visits.date FROM visits
JOIN animals A
ON visits.animals_id = A.id
WHERE visits.date >= '2020-04-01' AND visits.date <= '2020-08-30'
ORDER BY visits.date DESC;
-- What animal has the most visits to vets?
SELECT A."name", COUNT(visits.date) as number_visits FROM visits
JOIN animals A
ON visits.animals_id = A.id
GROUP BY A."name" ORDER BY number_visits DESC
LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT A."name", visits.date as date FROM visits
JOIN animals A
ON visits.animals_id = A.id
JOIN vets VE
ON visits.vets_id = VE.id
WHERE VE."name" = 'Maisy Smith'
ORDER BY date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals."name" AS animal, date_of_birth AS animal_DOB, escape_attempts AS escape_att, neutered AS neut, weight_kg AS animal_kg,
vets."name" AS vet_name, vets.age AS vet_age, date_of_graduation AS grad_date,
date AS recent_visit
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id 
ORDER BY date DESC
LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT VE."name", COUNT(*) as not_specialities FROM visits
JOIN animals A
ON visits.animals_id = A.id
JOIN species
ON A.species_id = species.id
JOIN vets VE
ON visits.vets_id = VE.id
JOIN specializations as S
ON S.vets_id = visits.vets_id
WHERE species.id != S.species_id
GROUP BY VE."name" ORDER BY not_specialities DESC;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT species."name", COUNT(species."name") as count_species FROM visits
JOIN animals A
ON visits.animals_id = A.id
JOIN species
ON A.species_id = species.id
JOIN vets VE
ON visits.vets_id = VE.id
WHERE VE."name" = 'Maisy Smith'
GROUP BY species.id ORDER BY count_species DESC
LIMIT 1;
