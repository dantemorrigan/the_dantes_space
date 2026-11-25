$execute in dantes_space:cosmos run tp @s $(x) 129 -3 180 0
$execute in dantes_space:cosmos positioned $(x) 128 0 unless entity @e[tag=ds.bridge,distance=..2] run function dantes_space:hull with storage dantes_space:launch
playsound minecraft:block.beacon.activate ambient @s ~ ~ ~
tellraw @s {"text":"Система Веспер. У штурвала — внешний обзор. Shift запускает двигатели. Для торможения присядь в двух блоках позади пульта.","color":"aqua"}
