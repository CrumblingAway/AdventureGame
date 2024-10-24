shader_type canvas_item;

uniform float enabled = 0.0;
const vec4 white = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	float time_coeff = sin(TIME * 2.5) * 0.5 + 0.5;
	vec4 target_color = time_coeff * white + (1.0 - time_coeff) * texture(TEXTURE, UV);
	
	COLOR = enabled * target_color + (1.0 - enabled) * texture(TEXTURE, UV);
}
