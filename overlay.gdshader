shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D paper : repeat_enable;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV) * clamp(texture(paper, UV * vec2(16.0f / 9.0, 1.0f)*0.75).x, 0.0f, 1.0);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
