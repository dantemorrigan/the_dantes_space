execute unless block ~ ~-1 ~ lodestone run return run function dantes_space:invalid_dock
execute if entity @e[tag=ds.docked,distance=..2] run return run function dantes_space:invalid_dock
function dantes_space:skat
setblock ~ ~-1 ~ lodestone
tag @s add ds.docked
tag @s remove ds.ship
scoreboard players set @s ds.phase 0
tellraw @a[distance=..32] {"text":"Скат готов. Вход с кормы между двигателями. Присядь у штурвала для старта.","color":"aqua"}
