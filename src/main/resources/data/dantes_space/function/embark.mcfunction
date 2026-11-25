scoreboard players set @s ds.phase 0
execute positioned ~-2 ~1 ~-7 if entity @a[dx=4,dy=2,dz=15] run function dantes_space:depart_at_hull
