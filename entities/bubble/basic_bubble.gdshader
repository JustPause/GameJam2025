shader_type canvas_item;
uniform vec4 flash_color : source_color;
uniform float flash_value : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 texturecolor = texture(TEXTURE, UV);
	COLOR = mix(texturecolor, flash_color, flash_value);
	COLOR.a = texturecolor.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
