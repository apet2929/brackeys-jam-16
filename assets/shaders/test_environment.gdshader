shader_type spatial;

uniform float square_size = 1.0;
uniform vec4 color_a : source_color = vec4(1.0);
uniform vec4 color_b : source_color = vec4(0.0);

varying vec3 world_position;
varying vec3 world_normal;

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    world_normal = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}

vec3 checker(vec2 p) {
    vec2 grid = floor(p / square_size);
    float c = mod(grid.x + grid.y, 2.0);
    return mix(color_a.rgb, color_b.rgb, c);
}

void fragment() {
    vec3 n = abs(normalize(world_normal));

    vec3 color;

    if (n.x > n.y && n.x > n.z) {
        color = checker(world_position.yz);
    }
    else if (n.y > n.z) {
        color = checker(world_position.xz);
    }
    else {
        color = checker(world_position.xy);
    }

    ALBEDO = color;
}