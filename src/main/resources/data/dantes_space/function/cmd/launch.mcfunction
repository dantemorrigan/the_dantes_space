execute unless dimension minecraft:overworld run return run tellraw @s {"text":"Запуск доступен в обычном мире."}
scoreboard players add #berth ds.x 512
execute store result storage dantes_space:launch x int 1 run scoreboard players get #berth ds.x
execute store result storage dantes_space:launch hx int 1 run data get entity @s Pos[0]
execute store result storage dantes_space:launch hy int 1 run data get entity @s Pos[1]
execute store result storage dantes_space:launch hz int 1 run data get entity @s Pos[2]
function dantes_space:board with storage dantes_space:launch
