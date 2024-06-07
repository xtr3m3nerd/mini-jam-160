shader_type spatial;
render_mode unshaded;

uniform float k = 1.0;
uniform float kcube = 0.5;
uniform float offset = 0.1;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void vertex(){
	VERTEX *= 2.0;
	POSITION = vec4(VERTEX, 1.0);
}

vec2 computeUV(vec2 uv, float kp, float kcubep) {
    vec2 t = uv - 0.5;
    float r2 = t.x * t.x + t.y * t.y;
    float f = 0.0;
    
    if (kcubep == 0.0) {
        f = 1.0 + r2 * kp;
    } else {
        f = 1.0 + r2 * (kp + kcubep * sqrt(r2));
    }
    
    vec2 nUv = f * t + 0.5;
    //nUv.y = 1.0 - nUv.y;
 
    return nUv;
}

void fragment() {
    vec2 uv = SCREEN_UV;
    
    float red = texture(SCREEN_TEXTURE, computeUV(uv, k + offset, kcube)).r;
    float green = texture(SCREEN_TEXTURE, computeUV(uv, k, kcube)).g;
    float blue = texture(SCREEN_TEXTURE, computeUV(uv, k - offset, kcube)).b;
    
    ALBEDO = vec3(red, green, blue);
}