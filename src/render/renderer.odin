package render

import sg "../../lib/sokol/gfx"
import sglue "../../lib/sokol/glue"
import slog "../../lib/sokol/log"

@(private="file")
gfx_state: struct {
	pass_action: sg.Pass_Action,
}

initialize_renderer :: proc() {
	sg_desc := sg.Desc {
		environment = sglue.environment(),
		logger = { func = slog.func },
	}
	sg.setup(sg_desc)

	gfx_state.pass_action = sg.Pass_Action {
		colors = {
			0 = { load_action = .CLEAR, clear_value = { 0, 0, 0, 1 } },
		},
	}
}

terminate_renderer :: proc() {
	sg.shutdown()
}

flush_renderer :: proc() {
	sg.begin_pass({ action = gfx_state.pass_action, swapchain = sglue.swapchain() })
		// TODO Render stuff here
	sg.end_pass()
	sg.commit()
}