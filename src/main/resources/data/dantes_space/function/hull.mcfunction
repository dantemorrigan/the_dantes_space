summon marker ~ ~ ~ {Tags:["ds.bridge"]}
function dantes_space:skat
fill ~-1 ~1 ~10 ~1 ~3 ~10 iron_block
setblock ~2 ~1 ~8 glass
summon armor_stand ~2 ~1 ~9 {Tags:["ds.suit"],ShowArms:1b,Invulnerable:1b}
item replace entity @e[tag=ds.suit,sort=nearest,limit=1] armor.head with iron_helmet
item replace entity @e[tag=ds.suit,sort=nearest,limit=1] armor.chest with chainmail_chestplate
$data modify entity @e[tag=ds.bridge,sort=nearest,limit=1] data.home set value {x:$(hx),y:$(hy),z:$(hz)}
function dantes_space:system
