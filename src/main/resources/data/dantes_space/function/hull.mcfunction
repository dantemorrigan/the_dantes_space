summon marker ~ ~ ~ {Tags:["ds.bridge"]}
fill ~-3 ~-1 ~-10 ~3 ~4 ~10 blue_concrete hollow
fill ~-3 ~1 ~-8 ~-3 ~2 ~7 glass
fill ~3 ~1 ~-8 ~3 ~2 ~7 glass
fill ~-2 ~1 ~-10 ~2 ~3 ~-10 glass
fill ~-2 ~0 ~-9 ~2 ~0 ~8 smooth_quartz
setblock ~ ~1 ~-8 lectern
setblock ~-2 ~1 ~5 barrel
setblock ~2 ~1 ~5 crafting_table
setblock ~2 ~1 ~7 furnace
setblock ~-2 ~1 ~7 white_bed[facing=north,part=foot]
setblock ~-2 ~1 ~6 white_bed[facing=north,part=head]
fill ~-1 ~-1 ~-14 ~1 ~-1 ~-14 blue_concrete
setblock ~1 ~-1 ~-14 yellow_concrete
setblock ~-1 ~-1 ~-14 yellow_concrete
fill ~-2 ~-1 ~-13 ~2 ~-1 ~-13 blue_concrete
setblock ~2 ~-1 ~-13 yellow_concrete
setblock ~-2 ~-1 ~-13 yellow_concrete
fill ~-2 ~-1 ~-12 ~2 ~-1 ~-12 blue_concrete
setblock ~2 ~-1 ~-12 yellow_concrete
setblock ~-2 ~-1 ~-12 yellow_concrete
fill ~-3 ~-1 ~-11 ~3 ~-1 ~-11 blue_concrete
setblock ~3 ~-1 ~-11 yellow_concrete
setblock ~-3 ~-1 ~-11 yellow_concrete
fill ~-3 ~-1 ~-10 ~3 ~-1 ~-10 blue_concrete
setblock ~3 ~-1 ~-10 yellow_concrete
setblock ~-3 ~-1 ~-10 yellow_concrete
fill ~-4 ~-1 ~-9 ~4 ~-1 ~-9 blue_concrete
setblock ~4 ~-1 ~-9 yellow_concrete
setblock ~-4 ~-1 ~-9 yellow_concrete
fill ~-4 ~-1 ~-8 ~4 ~-1 ~-8 blue_concrete
setblock ~4 ~-1 ~-8 yellow_concrete
setblock ~-4 ~-1 ~-8 yellow_concrete
fill ~-5 ~-1 ~-7 ~5 ~-1 ~-7 blue_concrete
setblock ~5 ~-1 ~-7 yellow_concrete
setblock ~-5 ~-1 ~-7 yellow_concrete
fill ~-5 ~-1 ~-6 ~5 ~-1 ~-6 blue_concrete
setblock ~5 ~-1 ~-6 yellow_concrete
setblock ~-5 ~-1 ~-6 yellow_concrete
fill ~-6 ~-1 ~-5 ~6 ~-1 ~-5 blue_concrete
setblock ~6 ~-1 ~-5 yellow_concrete
setblock ~-6 ~-1 ~-5 yellow_concrete
fill ~-6 ~-1 ~-4 ~6 ~-1 ~-4 blue_concrete
setblock ~6 ~-1 ~-4 yellow_concrete
setblock ~-6 ~-1 ~-4 yellow_concrete
fill ~-7 ~-1 ~-3 ~7 ~-1 ~-3 blue_concrete
setblock ~7 ~-1 ~-3 yellow_concrete
setblock ~-7 ~-1 ~-3 yellow_concrete
fill ~-7 ~-1 ~-2 ~7 ~-1 ~-2 blue_concrete
setblock ~7 ~-1 ~-2 yellow_concrete
setblock ~-7 ~-1 ~-2 yellow_concrete
fill ~-8 ~-1 ~-1 ~8 ~-1 ~-1 blue_concrete
setblock ~8 ~-1 ~-1 yellow_concrete
setblock ~-8 ~-1 ~-1 yellow_concrete
fill ~-8 ~-1 ~0 ~8 ~-1 ~0 blue_concrete
setblock ~8 ~-1 ~0 yellow_concrete
setblock ~-8 ~-1 ~0 yellow_concrete
fill ~-9 ~-1 ~1 ~9 ~-1 ~1 blue_concrete
setblock ~9 ~-1 ~1 yellow_concrete
setblock ~-9 ~-1 ~1 yellow_concrete
fill ~-9 ~-1 ~2 ~9 ~-1 ~2 blue_concrete
setblock ~9 ~-1 ~2 yellow_concrete
setblock ~-9 ~-1 ~2 yellow_concrete
fill ~-10 ~-1 ~3 ~10 ~-1 ~3 blue_concrete
setblock ~10 ~-1 ~3 yellow_concrete
setblock ~-10 ~-1 ~3 yellow_concrete
fill ~-10 ~-1 ~4 ~10 ~-1 ~4 blue_concrete
setblock ~10 ~-1 ~4 yellow_concrete
setblock ~-10 ~-1 ~4 yellow_concrete
fill ~-11 ~-1 ~5 ~11 ~-1 ~5 blue_concrete
setblock ~11 ~-1 ~5 yellow_concrete
setblock ~-11 ~-1 ~5 yellow_concrete
fill ~-11 ~-1 ~6 ~11 ~-1 ~6 blue_concrete
setblock ~11 ~-1 ~6 yellow_concrete
setblock ~-11 ~-1 ~6 yellow_concrete
fill ~-11 ~-1 ~7 ~11 ~-1 ~7 blue_concrete
setblock ~11 ~-1 ~7 yellow_concrete
setblock ~-11 ~-1 ~7 yellow_concrete
fill ~-11 ~-1 ~8 ~11 ~-1 ~8 blue_concrete
setblock ~11 ~-1 ~8 yellow_concrete
setblock ~-11 ~-1 ~8 yellow_concrete
fill ~-11 ~-1 ~9 ~11 ~-1 ~9 blue_concrete
setblock ~11 ~-1 ~9 yellow_concrete
setblock ~-11 ~-1 ~9 yellow_concrete
fill ~-11 ~-1 ~10 ~11 ~-1 ~10 blue_concrete
setblock ~11 ~-1 ~10 yellow_concrete
setblock ~-11 ~-1 ~10 yellow_concrete
fill ~-1 ~1 ~10 ~1 ~3 ~10 iron_block
setblock ~2 ~1 ~8 glass
summon armor_stand ~2 ~1 ~9 {Tags:["ds.suit"],ShowArms:1b,Invulnerable:1b}
item replace entity @e[tag=ds.suit,sort=nearest,limit=1] armor.head with iron_helmet
item replace entity @e[tag=ds.suit,sort=nearest,limit=1] armor.chest with chainmail_chestplate
$data modify entity @e[tag=ds.bridge,sort=nearest,limit=1] data.home set value {x:$(hx),y:$(hy),z:$(hz)}
function dantes_space:system
