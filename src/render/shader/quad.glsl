@header package shader
@header import sg "../../../lib/sokol/gfx"

@vs vs
in vec3 position;

void main() {
	gl_Position = vec4(position, 0.0f);
}
@end

@fs fs
out vec4 FragColor;

void main() {
	FragColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
}
@end

@program quad vs fs