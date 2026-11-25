execute if entity @a[distance=..12] positioned ~ ~1 ~-7 if entity @a[distance=..2,nbt={Pose:"CROUCHING"}] run scoreboard players set @s ds.speed 1
execute positioned ~ ~1 ~-5 if entity @a[distance=..1.5,nbt={Pose:"CROUCHING"}] run scoreboard players set @s ds.speed 0
execute if score @s ds.speed matches 1 run scoreboard players add @s ds.phase 1
execute if score @s ds.speed matches 1 as @e[tag=ds.body,distance=..210] at @s run tp @s ~ ~ ~0.08
execute if score @s ds.phase matches 650.. run function dantes_space:system
execute positioned ~ ~1 ~8 if entity @a[distance=..2,nbt={Pose:"CROUCHING"}] unless score @s ds.speed matches 1 run function dantes_space:open
execute unless entity @a[distance=9..96] run fill ~-1 ~1 ~10 ~1 ~3 ~10 iron_block replace air
execute positioned ~ ~1 ~11 as @a[distance=..3] run effect give @s slow_falling 8 0 true
execute as @a[distance=36..96] run tp @s ~ ~2 ~13
execute as @a[distance=12..36] at @s run particle minecraft:end_rod ~ ~-0.4 ~ 0 0 0 0 1
execute positioned ~ ~1 ~6 if entity @a[distance=..1,nbt={Pose:"CROUCHING"}] as @a[distance=..1,nbt={Pose:"CROUCHING"}] run function dantes_space:return with entity @e[tag=ds.bridge,sort=nearest,limit=1] data.home
