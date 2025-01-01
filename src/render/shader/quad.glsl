@header package shader
@header import sg "../../../lib/sokol/gfx"

@vs vert
in vec4 position;

void main() {
	gl_Position = vec4(position.x, position.y, position.y, 1.0f);
}
@end

@fs frag
out vec4 FragColor;

void main() {
	FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);
}
@end

@program quad vert frag