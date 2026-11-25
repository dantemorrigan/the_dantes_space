package com.dantemorrigan.space.mixin;

import com.dantemorrigan.space.FlightView;
import com.dantemorrigan.space.OrbitSky;
import net.minecraft.client.Minecraft;
import net.minecraft.client.renderer.SkyRenderer;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

@Mixin(SkyRenderer.class)
public abstract class OrbitSkyMixin {
    @Inject(method="renderEndSky",at=@At("HEAD"),cancellable=true)
    private void space$sky(CallbackInfo ci) {
        var level=Minecraft.getInstance().level;
        if(level!=null && level.dimension().equals(FlightView.COSMOS)) {
            OrbitSky.render();
            ci.cancel();
        }
    }
}
