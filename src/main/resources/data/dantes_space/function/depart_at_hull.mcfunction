execute unless data entity @s data.berth run function dantes_space:allocate_berth
data modify storage dantes_space:launch x set from entity @s data.berth
execute store result storage dantes_space:launch hx int 1 run data get entity @s Pos[0]
execute store result storage dantes_space:launch hy int 1 run data get entity @s Pos[1]
execute store result score @s ds.z run data get entity @s Pos[2]
scoreboard players add @s ds.z 13
execute store result storage dantes_space:launch hz int 1 run scoreboard players get @s ds.z
execute positioned ~ ~ ~ as @a[dx=4,dy=2,dz=15] run function dantes_space:board with storage dantes_space:launch
