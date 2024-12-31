package main

import sapp "../lib/sokol/app"
import sg "../lib/sokol/gfx"
import sglue "../lib/sokol/glue"
import slog "../lib/sokol/log"

WINDOW_TITLE	:: "Baal"
WINDOW_WIDTH	:: 1280
WINDOW_HEIGHT	:: 720

sokol_state: struct {
	pass_action: sg.Pass_Action,
}

initialize :: proc "c" () {
	sg_desc := sg.Desc {
		environment = sglue.environment(),
		logger = { func = slog.func },
	}
	sg.setup(sg_desc)

	sokol_state.pass_action = sg.Pass_Action {
		colors = {
			0 = { load_action = .CLEAR, clear_value = { 0, 0, 0, 1 } },
		},
	}
}

terminate :: proc "c" () {
	sg.shutdown()
}

frame :: proc "c" () {
	// TODO Update stuff here
	
	sg.begin_pass({ action = sokol_state.pass_action, swapchain = sglue.swapchain() })
		// TODO Render stuff here
	sg.end_pass()
	sg.commit()
}

event :: proc "c" (event: ^sapp.Event) {
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