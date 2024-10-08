shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(0.06, 0.22, 0.06, 1.0); // #0f380f
uniform vec4 color2 : source_color = vec4(0.19, 0.38, 0.19, 1.0); // #306230
uniform vec4 color3 : source_color = vec4(0.54, 0.67, 0.06, 1.0); // #8bac0f
uniform vec4 color4 : source_color = vec4(0.61, 0.74, 0.06, 1.0); // #9bbc0f

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114)); // Convert to grayscale

    if (gray < 0.33) {
        COLOR = color1;
    } else if (gray < 0.66) {
        COLOR = color2;
    } else if (gray < 0.99) {
        COLOR = color3;
    } else {
        COLOR = color4;
    }
}
