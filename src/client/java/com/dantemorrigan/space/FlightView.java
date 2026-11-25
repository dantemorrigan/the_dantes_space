package com.dantemorrigan.space;

import com.mojang.blaze3d.platform.InputConstants;
import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;
import net.fabricmc.fabric.api.client.keymapping.v1.KeyMappingHelper;
import net.minecraft.client.KeyMapping;
import net.minecraft.client.Minecraft;
import net.minecraft.core.BlockPos;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;
import org.lwjgl.glfw.GLFW;

public final class FlightView implements ClientModInitializer {
    private static final ResourceKey<Level> COSMOS = ResourceKey.create(Registries.DIMENSION,
            Identifier.fromNamespaceAndPath("dantes_space", "cosmos"));
    private static final int[] DISTANCES = {32, 44, 60};
    private static int zoom = 1;
    public static Vec3 pivot;

    @Override public void onInitializeClient() {
        var category = KeyMapping.Category.register(Identifier.fromNamespaceAndPath("dantes_space","flight"));
        var key = KeyMappingHelper.registerKeyMapping(new KeyMapping("key.dantes_space.zoom",
                InputConstants.Type.KEYSYM, GLFW.GLFW_KEY_V, category));
        ClientTickEvents.END_CLIENT_TICK.register(mc -> {
            pivot = helm(mc);
            while (key.consumeClick()) {
                if (pivot != null && mc.screen == null) zoom = (zoom + 1) % DISTANCES.length;
            }
        });
    }

    public static double distance() { return DISTANCES[zoom]; }

    private static Vec3 helm(Minecraft mc) {
        var p = mc.player;
        if (p == null || mc.level == null || mc.getCameraEntity() != p || !p.isAlive()
                || !mc.level.dimension().equals(COSMOS)) return null;
        // The berth allocator spaces hull origins 512 blocks apart at Y=128, Z=0.
        int x = (int)Math.round(p.getX() / 512.0) * 512;
        if (p.position().distanceToSqr(new Vec3(x,129,-7)) > 4 ||
                !mc.level.getBlockState(new BlockPos(x,129,-8)).is(Blocks.LECTERN)) return null;
        if (mc.level.getNearestPlayer(x,129,-7,2,false) != p) return null;
        return new Vec3(x + 0.5,130,-1.5);
    }
}
