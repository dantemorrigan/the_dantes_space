execute unless dimension dantes_space:cosmos run return run tellraw @s {"text":"Ты уже вне космоса."}
execute unless entity @e[tag=ds.bridge,distance=..128] run return run tellraw @s {"text":"Корабль слишком далеко."}
function dantes_space:return with entity @e[tag=ds.bridge,sort=nearest,limit=1,distance=..128] data.home
