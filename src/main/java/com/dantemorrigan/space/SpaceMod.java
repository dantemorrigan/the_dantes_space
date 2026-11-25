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
                var pos = ctx.getClickedPos().above();
                if (ctx.getClickedFace() != Direction.UP || !level.dimension().equals(Level.OVERWORLD)
                        || !level.isEmptyBlock(pos) || (ship && !level.getBlockState(ctx.getClickedPos()).is(Blocks.LODESTONE))) {
                    if (ctx.getPlayer() != null && !level.isClientSide())
                        ctx.getPlayer().sendSystemMessage(Component.translatable(ship ? "space.place_ship" : "space.place_pad"));
                    return InteractionResult.FAIL;
                }
                if (level instanceof ServerLevel world) {
                    int width = ship ? 12 : 13;
                    int height = ship ? 4 : 0;
                    var corner = pos.offset(-width, 0, -14);
                    var opposite = pos.offset(width, height, 14);
                    for (var cell : BlockPos.betweenClosed(corner, opposite)) {
                        if (!world.getBlockState(cell).canBeReplaced()) {
                            if (ctx.getPlayer() != null) ctx.getPlayer().sendSystemMessage(Component.literal(
                                    ship ? "Для корпуса нужно свободное место над площадкой." :
                                    "Для площадки нужна свободная площадка 27 × 29."));
                            return InteractionResult.FAIL;
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
                return 1;
            }));
            dispatcher.register(root);
        });
    }
}
