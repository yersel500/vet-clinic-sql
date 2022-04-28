/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '2022-05-14', 4, TRUE, 22);

BEGIN;
INSERT INTO owners (full_name,age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name,age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name,age) VALUES ('Bob', 45);
INSERT INTO owners (full_name,age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name,age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name,age) VALUES ('Jodie Whittaker', 38);
COMMIT;

BEGIN;
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');
COMMIT;

BEGIN;
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;
COMMIT;

BEGIN;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
COMMIT;

INSERT INTO vets (name,age,date_of_graduation) VALUES 
('William Tatcher',45,'2000-04-23'),
('Maisy Smith',26,'2019-01-17'),
('Stephanie Mendez',64,'1981-05-04'),
('Jack Harkness',38,'2008-06-08');

INSERT INTO specializations (vet_id, spec_id) VALUES 
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO visits (vet_id, anim_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animaltests WHERE name = 'Agumon'), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animaltests WHERE name = 'Agumon'), '2020-07-22'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animaltests WHERE name = 'Gabumon'), '2021-02-02'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Pikachu'), '2020-01-05'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Pikachu'), '2020-03-08'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Pikachu'), '2020-05-14'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animaltests WHERE name = 'Devimon'), '2021-05-04'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animaltests WHERE name = 'Charmander'), '2021-02-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Plantmon'), '2019-12-21'),
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animaltests WHERE name = 'Plantmon'), '2020-08-10'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Plantmon'), '2021-04-07'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animaltests WHERE name = 'Squirtle'), '2019-09-29'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animaltests WHERE name = 'Angemon'), '2020-10-03'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animaltests WHERE name = 'Angemon'), '2020-11-04'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Boarmon'), '2019-01-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Boarmon'), '2019-05-15'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Boarmon'), '2020-02-27'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animaltests WHERE name = 'Boarmon'), '2020-08-03'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animaltests WHERE name = 'Blossom'), '2020-05-24'),
((SELECT id FROM vets WHERE name = ' William Tatcher'), (SELECT id FROM animaltests WHERE name = 'Blossom'), '2021-01-11');




