/* Populate database with sample data. */

-- first insert --
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Agumon','2020-2-3',0,true,10.23);
-- second insert --
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Gabumon','2018-11-15',2,true,8);
-- third insert --
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Pikachu','2021-1-7',1,false,15.04);
-- forth insert --
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Devimon','2017-5-12',5,true,11);

-- insert more that one value inside a table
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Charmander','2020-2-8',0,FALSE,-11.23),
('Plantmon','2021-11-15',2,TRUE,-5.7) ,
('Squirtle','1992-4-2',3,FALSE,-12.13), 
('Angemon','2005-6-12',1,TRUE,-45),
('Boarmon','2005-6-7',7,TRUE,20.4),
('Blossom','1998-10-13',3,TRUE,17),
('Ditto','2022-5-14',4,TRUE,22);

-- insert values into owners table
INSERT INTO owners(full_name, age)
VALUES('Sam Smith',34),
('Jennifer Orwell',19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 17),
('Jodie Whittaker', 38);

-- insert values into species table

INSERT INTO species("name")
VALUES('Digimon'),
('Pokemon');

UPDATE animals
SET species_id = 1
WHERE "name" LIKE ('%mon%');

UPDATE animals
SET species_id = 2
WHERE "name" NOT LIKE ('%mon%');
SELECT * FROM animals;

INSERT INTO vets("name",age,date_of_graduation)
VALUES('William Tatcher',45 ,'2020-4-23'),
('Maisy Smith',26 ,'2019-1-17'),
('Stephanie Mendez',64 ,'1981-5-4'),
('Jack Harkness',38  ,'2008-6-8');

INSERT INTO specializations(species_id,vets_id)
VALUES(1,2),(3,2),(3,1),(4,1);

INSERT INTO visits (animals_id, vets_id, date) 
VALUES (1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-07-10'),
(6, 2, '2021-04-07'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'),
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-07-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');