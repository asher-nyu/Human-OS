shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 10.0;

void fragment() {
	vec2 tex_size = 1.0 / TEXTURE_PIXEL_SIZE;
	vec4 color = texture(TEXTURE, UV);
	
	// Simple box blur
	for(float x = -blur_amount; x <= blur_amount; x += 1.0) {
		for(float y = -blur_amount; y <= blur_amount; y += 1.0) {
			vec2 offset = vec2(x, y) / tex_size;
			color += texture(TEXTURE, UV + offset);
		}
	}
	
	color /= (2.0 * blur_amount + 1.0) * (2.0 * blur_amount + 1.0);
	COLOR = color;
}