execute in minecraft:overworld as @e[type=marker,tag=ds.pad] at @s run function dantes_space:pad
execute in minecraft:overworld as @e[type=marker,tag=ds.ship] at @s run function dantes_space:launch
execute in dantes_space:cosmos as @e[type=marker,tag=ds.bridge] at @s if entity @a[distance=..112] run function dantes_space:flight
