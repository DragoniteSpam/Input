attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;

varying vec4 v_vColour;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1);
    
    vec3 LIGHT_DIR1 = -normalize(vec3(1, 1, -1));
    vec3 LIGHT_DIR2 = -normalize(vec3(1, -1, -1)) * 0.5;
    vec3 LIGHT_DIR3 = -normalize(vec3(-1, -1, 1)) * 0.25;
    vec3 LIGHT_AMBIENT = vec3(0.25);
    
    v_vColour = in_Colour;
    
    vec3 world_normal = (gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0)).xyz;
    float NdotL = dot(world_normal, LIGHT_DIR1) + dot(world_normal, LIGHT_DIR2) + dot(world_normal, LIGHT_DIR3);
    
    v_vColour.rgb *= clamp(vec3(NdotL), LIGHT_AMBIENT, vec3(1));
}