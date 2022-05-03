//// -- LEVEL 1
//// -- Tables and References

// Creating tables


Table owners {
  id int [pk]
  full_name varchar(20)
  age int
 }
 
Table species {
  id int [pk]
  name varchar(20)
 }

Table animals {
  id int [pk, increment] // auto-increment
  name varchar
  date_of_birth date
  neutered boolean
  weight_kg decimal
  species_id int
  owner_id int
}

// Creating references
// You can also define relaionship separately
// > many-to-one; < one-to-many; - one-to-one
Ref: animals.species_id > species.id 
Ref: animals.owner_id > owners.id


//----------------------------------------------//

//// -- LEVEL 2
//// -- Adding column settings

Table vets {
  id serial [pk]
  name varchar(20)
  age int
  date_of_graduation date
}

Table specializations {
  vet_id int
  spec_id int
}

Ref: specializations.vet_id - vets.id
Ref: specializations.spec_id - species.id


Table visits {
  vet_id int
  anim_id int
  date_of_visit date_of_visit
}

Ref: visits.vet_id - vets.id
Ref: visits.anim_id - animals.id

//----------------------------------------------//