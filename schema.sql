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
