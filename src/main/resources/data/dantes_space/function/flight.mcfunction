execute if entity @a[distance=..12] positioned ~ ~1 ~-7 if entity @a[distance=..2,predicate=dantes_space:crouching] run scoreboard players set @s ds.speed 1
execute positioned ~ ~1 ~-5 if entity @a[distance=..1.5,predicate=dantes_space:crouching] run scoreboard players set @s ds.speed 0
execute if score @s ds.speed matches 1 unless score @s ds.z matches 16.. run scoreboard players add @s ds.z 1
execute unless score @s ds.speed matches 1 if score @s ds.z matches 1.. run scoreboard players remove @s ds.z 1
execute if score @s ds.z matches 12..16 as @e[tag=ds.body,distance=..210] at @s rotated as @e[tag=ds.bridge,sort=nearest,limit=1] run tp @s ^ ^ ^-0.16
execute if score @s ds.z matches 8..11 as @e[tag=ds.body,distance=..210] at @s rotated as @e[tag=ds.bridge,sort=nearest,limit=1] run tp @s ^ ^ ^-0.10
execute if score @s ds.z matches 4..7 as @e[tag=ds.body,distance=..210] at @s rotated as @e[tag=ds.bridge,sort=nearest,limit=1] run tp @s ^ ^ ^-0.06
execute if score @s ds.z matches 1..3 as @e[tag=ds.body,distance=..210] at @s rotated as @e[tag=ds.bridge,sort=nearest,limit=1] run tp @s ^ ^ ^-0.025
execute positioned ~ ~1 ~8 if entity @a[distance=..2,predicate=dantes_space:crouching] unless score @s ds.speed matches 1 run function dantes_space:open
execute unless entity @a[distance=9..96] run fill ~-1 ~1 ~10 ~1 ~3 ~10 iron_block replace air
execute positioned ~ ~1 ~11 as @a[distance=..3] run effect give @s slow_falling 8 0 true
execute as @a[distance=36..96] run tp @s ~ ~2 ~13
execute as @a[distance=12..36] at @s run particle minecraft:end_rod ~ ~-0.4 ~ 0 0 0 0 1
execute positioned ~ ~1 ~6 if entity @a[distance=..1,predicate=dantes_space:crouching] as @a[distance=..1,predicate=dantes_space:crouching] run function dantes_space:return with entity @e[tag=ds.bridge,sort=nearest,limit=1] data.home
execute positioned ~ ~1 ~-7 as @a[distance=..2,sort=nearest,limit=1] rotated as @s run data modify entity @e[tag=ds.bridge,distance=..14,limit=1] Rotation set from entity @s Rotation
execute as @a[distance=13..36] at @s facing entity @e[tag=ds.bridge,sort=nearest,limit=1] feet run function dantes_space:tether
execute store result score @s ds.route run data get entity @s Rotation[0]
scoreboard players add @s ds.route 180
execute if score @s ds.route matches 360.. run scoreboard players remove @s ds.route 360
execute positioned ~ ~1 ~-7 run title @a[distance=..2] actionbar [{"text":"СКАТ   ◈   Курс ","color":"aqua"},{"score":{"name":"@s","objective":"ds.route"}},{"text":"°   •   Тяга "},{"score":{"name":"@s","objective":"ds.z"}},{"text":"/16   •   V  обзор","color":"gray"}]
execute if score @s ds.speed matches 1 positioned ^ ^ ^16 if entity @e[tag=ds.body,distance=..18] at @s run function dantes_space:proximity
