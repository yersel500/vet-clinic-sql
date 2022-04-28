/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER NOT NULL PRIMARY KEY,
    name varchar(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attemps INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT 
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

BEGIN;
CREATE SEQUENCE my_serial AS INTEGER START 12 OWNED BY animaltests.id;
ALTER TABLE animaltests ALTER COLUMN id SET DEFAULT nextval('my_serial');
COMMIT;

BEGIN;
ALTER TABLE animaltests DROP COLUMN species;
ALTER TABLE animaltests ADD COLUMN species_id INT;
ALTER TABLE animaltests ADD FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animaltests ADD COLUMN owner_id INT;
ALTER TABLE animaltests ADD FOREIGN KEY (owner_id) REFERENCES owners (id);
COMMIT;

