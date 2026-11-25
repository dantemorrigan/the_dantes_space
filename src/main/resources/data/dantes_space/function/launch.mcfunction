execute unless block ~ ~-1 ~ lodestone run tellraw @p {"text":"Установи звездолёт на центральный магнит площадки."}
execute unless block ~ ~-1 ~ lodestone run give @p minecraft:bat_spawn_egg[minecraft:entity_data={id:"minecraft:marker",Tags:["ds.ship"]},minecraft:custom_name={text:"Скат"}]
execute if block ~ ~-1 ~ lodestone run function dantes_space:depart
kill @s
