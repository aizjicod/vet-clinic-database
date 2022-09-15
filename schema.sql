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
