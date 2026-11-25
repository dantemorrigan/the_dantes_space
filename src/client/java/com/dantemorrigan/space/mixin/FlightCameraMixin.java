package com.dantemorrigan.space.mixin;
import com.dantemorrigan.space.FlightView;

import net.minecraft.client.Camera;
import net.minecraft.client.Minecraft;
import net.minecraft.util.Mth;
import net.minecraft.world.phys.Vec3;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.Unique;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

@Mixin(Camera.class)
public abstract class FlightCameraMixin {
    @Shadow private boolean detached;
    @Shadow protected abstract void setRotation(float yaw, float pitch);
    @Shadow protected abstract void setPosition(Vec3 position);
    @Unique private long space$last;
    @Unique private float space$yaw;
    @Unique private double space$distance;
    @Unique private double space$elevation;

    @Inject(method="alignWithEntity", at=@At("TAIL"))
    private void space$chase(float partialTick, CallbackInfo ci) {
        var mc = Minecraft.getInstance();
        var pivot = FlightView.pivot;
        if (pivot == null || mc.player == null || mc.getCameraEntity() != mc.player) {
            space$last = 0;
            return;
        }
        long now = System.nanoTime();
        float targetYaw = mc.player.getViewYRot(partialTick);
        double elevation = Mth.clamp(18 + mc.player.getViewXRot(partialTick)*0.25, 10, 34);
        if (space$last == 0) {
            space$yaw = targetYaw;
            space$distance = FlightView.distance();
            space$elevation = elevation;
        } else {
            double dt = Math.min(0.1, (now-space$last)*1e-9);
            double blend = -Math.expm1(-6*dt);
            space$yaw += Mth.wrapDegrees(targetYaw-space$yaw)*blend;
            space$distance += (FlightView.distance()-space$distance)*blend;
            space$elevation += (elevation-space$elevation)*blend;
        }
        space$last = now;
        var forward = Vec3.directionFromRotation((float)space$elevation, space$yaw);
        setPosition(pivot.subtract(forward.scale(space$distance)));
        setRotation(space$yaw,(float)space$elevation);
        detached = true;
    }
}
