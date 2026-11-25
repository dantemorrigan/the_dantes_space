package com.dantemorrigan.space;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.fabricmc.fabric.api.creativetab.v1.FabricCreativeModeTab;
import net.minecraft.commands.Commands;
import net.minecraft.core.Direction;
import net.minecraft.core.BlockPos;
import net.minecraft.core.Registry;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.core.registries.Registries;
import net.minecraft.network.chat.Component;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.context.UseOnContext;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.block.Blocks;

public final class SpaceMod implements ModInitializer {
    private static Identifier id(String path) {
        return Identifier.fromNamespaceAndPath("dantes_space", path);
    }

    private static Item register(String name, boolean ship) {
        var key = ResourceKey.create(Registries.ITEM, id(name));
        return Registry.register(BuiltInRegistries.ITEM, key, new Item(new Item.Properties().setId(key)) {
            @Override public InteractionResult useOn(UseOnContext ctx) {
                var level = ctx.getLevel();
                var clicked = ctx.getClickedPos();
                var pos = !ship && level.getBlockState(clicked).canBeReplaced() ? clicked : clicked.above();
                if (!level.dimension().equals(Level.OVERWORLD)
                        || (ship && (ctx.getClickedFace() != Direction.UP || !level.getBlockState(clicked).is(Blocks.LODESTONE)))) {
                    if (ctx.getPlayer() != null && !level.isClientSide())
                        ctx.getPlayer().sendSystemMessage(Component.translatable(ship ? "space.place_ship" : "space.place_pad"));
                    return InteractionResult.FAIL;
                }
                if (level instanceof ServerLevel world) {
                    if (world.isOutsideBuildHeight(pos) || world.isOutsideBuildHeight(pos.above(ship ? 4 : 5))) {
                        return InteractionResult.FAIL;
                    }
                    for (int z = -14; z <= 14; z++) {
                        int deckWidth = 13 - Math.max(0, Math.abs(z) - 10);
                        int width = ship ? Math.min(12, deckWidth) : deckWidth;
                        var first = pos.offset(-width, 0, z);
                        var last = pos.offset(width, ship ? 4 : 5, z);
                        for (var cell : BlockPos.betweenClosed(first, last)) {
                            var state = world.getBlockState(cell);
                            if (state.hasBlockEntity() || state.getDestroySpeed(world, cell) < 0
                                    || state.is(Blocks.LODESTONE) || (ship && !state.canBeReplaced())) {
                                if (ctx.getPlayer() != null) ctx.getPlayer().sendSystemMessage(Component.literal(
                                        ship ? "Над магнитом есть препятствие." : "В контуре есть защищённый блок. Смести центр площадки."));
                                return InteractionResult.FAIL;
                            }
                        }
                    }
                    var server = world.getServer();
                    var source = server.createCommandSourceStack().withLevel(world)
                            .withPosition(new net.minecraft.world.phys.Vec3(pos.getX() + 0.5, pos.getY(), pos.getZ() + 0.5)).withSuppressedOutput();
                    server.getCommands().performPrefixedCommand(source,
                            "summon minecraft:marker ~ ~ ~ {Tags:[\"ds." + (ship ? "ship" : "pad") + "\"]}");
                    ctx.getItemInHand().consume(1, ctx.getPlayer());
                }
                return InteractionResult.SUCCESS;
            }
        });
    }

    @Override public void onInitialize() {
        Item pad = register("landing_pad", false);
        Item ship = register("starship", true);
        Registry.register(BuiltInRegistries.CREATIVE_MODE_TAB, id("main"), FabricCreativeModeTab.builder()
                .title(Component.literal("The Dante’s Space")).icon(() -> new ItemStack(ship))
                .displayItems((params, out) -> { out.accept(pad); out.accept(ship); }).build());
        CommandRegistrationCallback.EVENT.register((dispatcher, access, env) -> {
            var root = Commands.literal("space").requires(Commands.hasPermission(Commands.LEVEL_GAMEMASTERS))
                    .executes(c -> {
                        c.getSource().sendSystemMessage(Component.literal("/space kit | pad | ship | launch | home"));
                        return 1;
                    });
            for (String name : new String[]{"kit","pad","ship","launch","home"}) {
                root.then(Commands.literal(name).executes(c -> {
                    var source = c.getSource();
                    var player = source.getPlayerOrException();
                    source.getServer().getCommands().performPrefixedCommand(source.withPosition(player.position()),
                            "function dantes_space:cmd/" + name);
                    return 1;
                }));
            }
            root.then(Commands.literal("prepare_orbit").executes(c -> {
                var source = c.getSource();
                var level = source.getLevel();
                if (!level.dimension().equals(ResourceKey.create(Registries.DIMENSION, id("cosmos")))) return 0;
                var center = BlockPos.containing(source.getPosition());
                for (int x = -16; x <= 16; x += 16) {
                    for (int z = -16; z <= 16; z += 16) level.getChunkAt(center.offset(x, 0, z));
                }
                level.getChunkAt(center.offset(-26, 11, -59));
                level.getChunkAt(center.offset(19, 15, -70));
                level.getChunkAt(center.offset(12, 7, -53));
                return 1;
            }));
            dispatcher.register(root);
        });
    }
}
