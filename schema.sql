/* Database schema to keep the structure of entire database. */

-- Create a table

CREATE TABLE animals(
 id INT GENERATED ALWAYS AS IDENTITY, 
 name CHAR(50),
 date_of_birth DATE,
 escape_attempts INT,
 neutered BOOLEAN,
 weight_kg INT,
 PRIMARY KEY(id)
);

-- Add a column in an existing table

ALTER TABLE animals
ADD species VARCHAR;

-- create 2 tables 

CREATE TABLE owners(
	id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	full_name "varchar",
	age INT NOT NULL,
	PRIMARY KEY (id)
); 

CREATE TABLE species(
	id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	name "varchar",
	PRIMARY KEY (id)
); 


ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals 
ADD species_id INT,
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals 
ADD owners_id INT,
ADD FOREIGN KEY (owners_id) REFERENCES owners(id);

UPDATE animals 
SET owners_id = 1 
WHERE name = 'Agumon';

UPDATE animals 
SET owners_id = 2 
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals 
SET owners_id = 3 
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals 
SET owners_id = 4 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals 
SET owners_id = 5 
WHERE name IN ('Angemon', 'Boarmon');

CREATE TABLE vets(
id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	name VARCHAR,
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
);

-- creating many to many links
CREATE TABLE visits (
  vets_id INT,
  animals_id INT,
	date DATE,
	PRIMARY KEY(animals_id, vets_id,date)
);

CREATE TABLE specializations(
  species_id INT,
  vets_id INT,
	PRIMARY KEY(species_id, vets_id)
);
