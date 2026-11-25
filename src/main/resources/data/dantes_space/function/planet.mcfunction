summon block_display ~ ~ ~ {Tags:["ds.new","ds.body"],view_range:5f,block_state:{Name:"minecraft:blue_ice"},transformation:{scale:[14f,14f,14f],translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}
execute as @e[tag=ds.new,distance=..1] store result score @s ds.route run random value 0..3
execute as @e[tag=ds.new,distance=..1,scores={ds.route=0}] run data modify entity @s block_state.Name set value "minecraft:packed_ice"
execute as @e[tag=ds.new,distance=..1,scores={ds.route=1}] run data modify entity @s block_state.Name set value "minecraft:orange_terracotta"
execute as @e[tag=ds.new,distance=..1,scores={ds.route=2}] run data modify entity @s block_state.Name set value "minecraft:calcite"
execute as @e[tag=ds.new,distance=..1,scores={ds.route=3}] run data modify entity @s block_state.Name set value "minecraft:ochre_froglight"
execute as @e[tag=ds.new,distance=..1] store result entity @s Rotation[0] float 1 run random value -180..180
execute as @e[tag=ds.new,distance=..1] at @s run tp @s ^ ^ ^28
tag @e[tag=ds.new,distance=..35] remove ds.new
