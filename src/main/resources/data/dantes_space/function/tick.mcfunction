execute in minecraft:overworld as @e[type=marker,tag=ds.pad] at @s run function dantes_space:pad
execute in minecraft:overworld as @e[type=marker,tag=ds.ship] at @s run function dantes_space:launch
execute in dantes_space:cosmos as @e[type=marker,tag=ds.bridge] at @s if entity @a[distance=..112] run function dantes_space:flight
recipe give @a dantes_space:starship
recipe give @a dantes_space:landing_pad
execute in minecraft:overworld as @e[tag=ds.docked] at @s run function dantes_space:preflight
