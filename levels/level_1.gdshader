shader_type canvas_item;
uniform float scroll_speed;

void vertex() {
	UV.y += TIME * .1;
}

void fragment() {
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
