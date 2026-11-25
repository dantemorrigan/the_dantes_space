execute if score @s ds.phase matches 0 positioned ~ ~1 ~-7 if entity @a[distance=..2,predicate=dantes_space:crouching] run scoreboard players set @s ds.phase 1
execute if score @s ds.phase matches 1 run playsound minecraft:block.beacon.power_select block @a[distance=..24] ~ ~ ~
execute if score @s ds.phase matches 1..60 run title @a[distance=..12] actionbar {"text":"Зажигание  •  Выход на орбиту","color":"gold"}
execute if score @s ds.phase matches 1..60 run particle minecraft:soul_fire_flame ~-6 ~1 ~11 0.25 0.25 0.7 0.03 6
execute if score @s ds.phase matches 1..60 run particle minecraft:soul_fire_flame ~6 ~1 ~11 0.25 0.25 0.7 0.03 6
execute if score @s ds.phase matches 1.. run scoreboard players add @s ds.phase 1
execute if score @s ds.phase matches 61.. run function dantes_space:embark
