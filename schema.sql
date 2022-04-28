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
CREATE SEQUENCE my_serial AS INTEGER START 12 OWNED BY animals.id;
ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('my_serial');
COMMIT;

BEGIN;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners (id);
COMMIT;

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    spec_id INT,
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species FOREIGN KEY(spec_id) REFERENCES species(id)
);

CREATE TABLE visits (
    vet_id INT,
    anim_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animaltests FOREIGN KEY(anim_id) REFERENCES animaltests(id)
);