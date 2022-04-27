/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name = 'Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg >= 10.5;
 SELECT name, neutered FROM animals WHERE neute
red = TRUE;
SELECT name FROM animals WHERE name <> 'Gabumon';
SELECT name, weight_kg FROM animals WHERE weig
ht_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animaltests SET species = 'digimon' WHERE name LIKE '%m
on';
UPDATE animaltests SET species = 'pokemon' WHERE species <> 'digimon';
SELECT * FROM animaltests;
COMMIT;
SELECT * FROM animaltests;

BEGIN;
DELETE FROM animaltests;
SELECT * FROM animaltests;
ROLLBACK;
SELECT * FROM animaltests;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered,AVG(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


SELECT full_name,owners.id,name,owner_id FROM owners INNER JOIN animaltests ON owners.id = owner_id WHERE full_name = 'Melody Pond';
SELECT animaltests.name,species_id,species.name,species.id FROM animaltests INNER JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT full_name,owners.id,name,owner_id FROM owners LEFT JOIN animaltests ON owners.id = owner_id;
SELECT COUNT(species.name) FROM species INNER JOIN animaltests ON species.id = species_id WHERE species.name = 'Pokemon';
SELECT COUNT(species.name) FROM species INNER JOIN animaltests ON species.id = species_id WHERE species.name = 'Digimon';
SELECT full_name, species_id, animaltests.name FROM owners INNER JOIN animaltests ON owners.id = owner_id WHERE species_id = (SELECT id FROM species WHERE name = 'Digimon') AND full_name = 'Jennifer Orwell';
SELECT full_name, species_id, animaltests.name FROM owners INNER JOIN animaltests ON owners.id = owner_id WHERE escape_attempts = 0 AND full_name = 'Dean Winchester';
SELECT full_name, COUNT(name) FROM (SELECT full_name, species_id, animaltests.name FROM owners INNER JOIN animaltests ON owners.id = owner_id) AS derivedTable GROUP BY full_name;