-- Splitting apart the abilities column and storing those values into a new table
CREATE or ALTER TABLE split_abilities AS
SELECT abilities, 
       trim(value) AS split_value
FROM imported_pokemon_data, 
     json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE split_value <> '';

-- Join split_abilities table back together with imported_pokemon_data table so easier for 2nd/3rd NF
SELECT split_abilities.split_value, imported_pokemon_data.name, imported_pokemon_data.pokedex_number
FROM imported_pokemon_data
left JOIN split_abilities on  imported_pokemon_data.abilities = split_abilities.split_value;