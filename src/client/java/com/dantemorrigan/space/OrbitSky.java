package com.dantemorrigan.space;

import com.mojang.blaze3d.vertex.*;
import net.minecraft.client.renderer.RenderPipelines;
import net.minecraft.client.renderer.rendertype.RenderSetup;
import net.minecraft.client.renderer.rendertype.RenderType;
import net.minecraft.resources.Identifier;
import org.joml.Vector3f;

public final class OrbitSky {
    private static final String[] FACES = {"positive_x","negative_x","positive_y","negative_y","positive_z","negative_z"};
    private static final RenderType[] MATERIALS = new RenderType[6];

    private static Vector3f vertex(int face,float u,float v) {
        return switch(face) {
            case 0 -> new Vector3f(1,-v,-u);
            case 1 -> new Vector3f(-1,-v,u);
            case 2 -> new Vector3f(u,1,v);
            case 3 -> new Vector3f(u,-1,-v);
            case 4 -> new Vector3f(u,-v,1);
            default -> new Vector3f(-u,-v,-1);
        };
    }

    public static void render() {
        for (int face=0; face<FACES.length; face++) {
            if (MATERIALS[face]==null) {
                var texture=Identifier.fromNamespaceAndPath("dantes_space","textures/sky/"+FACES[face]+".png");
                MATERIALS[face]=RenderType.create("dantes_space_sky",RenderSetup.builder(RenderPipelines.END_SKY)
                        .withTexture("Sampler0",texture).createRenderSetup());
            }
            var out=Tesselator.getInstance().begin(VertexFormat.Mode.QUADS,DefaultVertexFormat.POSITION_TEX_COLOR);
            for(int i=0;i<8;i++) {
                int k=i<4?i:7-i;
                float u=k==1||k==2?1:0, v=k>=2?1:0;
                var point=vertex(face,2*u-1,2*v-1).mul(100);
                out.addVertex(point.x,point.y,point.z).setUv((0.5f+127*u)/128,(0.5f+127*v)/128).setColor(-1);
            }
            var mesh = out.build();
            if (mesh != null) MATERIALS[face].draw(mesh);
        }
    }
}
