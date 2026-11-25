particle minecraft:dust{color:[0.65,0.67,0.72],scale:0.35} ^ ^0.5 ^1 0 0 0 0 1
execute positioned ^ ^ ^1 unless entity @e[tag=ds.bridge,distance=..2] if entity @e[tag=ds.bridge,distance=..38] run function dantes_space:tether
