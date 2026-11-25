$execute in dantes_space:cosmos positioned $(x) 128 0 unless entity @e[tag=ds.bridge,distance=..2] run function dantes_space:hull with storage dantes_space:launch
$execute in dantes_space:cosmos run tp @s $(x) 129 0
playsound minecraft:block.beacon.activate ambient @s ~ ~ ~
