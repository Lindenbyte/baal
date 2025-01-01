package main

import "base:runtime"

import sapp "../lib/sokol/app"
// import sg "../lib/sokol/gfx"
// import sglue "../lib/sokol/glue"
// import slog "../lib/sokol/log"

import "./render"

WINDOW_TITLE	:: "Baal"
WINDOW_WIDTH	:: 1280
WINDOW_HEIGHT	:: 720

initialize :: proc "c" () {
	context = runtime.default_context()
	render.initialize_renderer()
}

terminate :: proc "c" () {
	context = runtime.default_context()
	render.terminate_renderer()
}

frame :: proc "c" () {
	context = runtime.default_context()

	// TODO Update stuff here
	render.flush_renderer()
}

event :: proc "c" (event: ^sapp.Event) {
	context = runtime.default_context()

	if event.type == .KEY_DOWN && event.key_code == .ESCAPE {
		sapp.request_quit()
	}
}

main :: proc() {
	description := sapp.Desc {
		init_cb = initialize,
		cleanup_cb = terminate,
		frame_cb = frame,
		event_cb = event,

		window_title = WINDOW_TITLE,
		width = WINDOW_WIDTH,
		height = WINDOW_HEIGHT,
	}
	
	sapp.run(description)
}