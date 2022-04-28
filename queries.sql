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
UPDATE animals SET species = 'digimon' WHERE name LIKE '%m
on';
UPDATE animals SET species = 'pokemon' WHERE species <> 'digimon';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

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


SELECT full_name,owners.id,name,owner_id FROM owners INNER JOIN animals ON owners.id = owner_id WHERE full_name = 'Melody Pond';
SELECT animals.name,species_id,species.name,species.id FROM animals INNER JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT full_name,owners.id,name,owner_id FROM owners LEFT JOIN animals ON owners.id = owner_id;
SELECT COUNT(species.name) FROM species INNER JOIN animals ON species.id = species_id WHERE species.name = 'Pokemon';
SELECT COUNT(species.name) FROM species INNER JOIN animals ON species.id = species_id WHERE species.name = 'Digimon';
SELECT full_name, species_id, animals.name FROM owners INNER JOIN animals ON owners.id = owner_id WHERE species_id = (SELECT id FROM species WHERE name = 'Digimon') AND full_name = 'Jennifer Orwell';
SELECT full_name, species_id, animals.name FROM owners INNER JOIN animals ON owners.id = owner_id WHERE escape_attempts = 0 AND full_name = 'Dean Winchester';
SELECT full_name, COUNT(name) FROM (SELECT full_name, species_id, animals.name FROM owners INNER JOIN animals ON owners.id = owner_id) AS derivedTable GROUP BY full_name;

-- Who was the last animal seen by William Tatcher?
SELECT name FROM animals WHERE id = (SELECT anim_id FROM visits WHERE date_of_visit = (SELECT MAX(date_of_visit) FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')));
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT anim_id) FROM (SELECT * FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')) AS dsm;
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.id, vets.name, specializations.vet_id, specializations.spec_id FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, animals.id, anim_id FROM animals INNER JOIN (SELECT * FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez') AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30')  AS rdsm ON animals.id = anim_id;
-- What animal has the most visits to vets?
SELECT name FROM animals WHERE id = (SELECT anim_id FROM (SELECT anim_id, COUNT(anim_id) FROM visits GROUP BY anim_id) AS mva WHERE count = (SELECT MAX(count) FROM (SELECT anim_id, COUNT(anim_id) FROM visits GROUP BY anim_id) AS mva2));
-- Who was Maisy Smith's first visit?
SELECT date_of_visit FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY date_of_visit ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, visits.anim_id,visits.vet_id, vets.name,date_of_visit FROM visits INNER JOIN animals ON visits.anim_id = animals.id INNER JOIN vets ON visits.vet_id = vets.id ORDER BY date_of_visit DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT count(*) FROM (SELECT visits.vet_id, specializations.spec_id FROM visits LEFT JOIN specializations ON visits.vet_id = specializations.vet_id) AS nsas WHERE spec_id is NULL;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species_id, COUNT(species_id) FROM (SELECT visits.vet_id, visits.anim_id, animals.species_id FROM visits INNER JOIN animals ON visits.anim_id = animals.id WHERE vet_id = 2) AS bste GROUP BY species_id;
