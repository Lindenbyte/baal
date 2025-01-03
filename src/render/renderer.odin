package render

import sg "../../lib/sokol/gfx"
import sglue "../../lib/sokol/glue"
import slog "../../lib/sokol/log"

import "./shader"

@(private="file")
gfx_state: struct {
	pass_action: sg.Pass_Action,
	bindings: sg.Bindings,
	pipeline: sg.Pipeline,
}

@(private)
renderer: struct {
	vertecies: []f32,
	indecies: []u16,
}

initialize_renderer :: proc() {
	sg.setup({
		environment = sglue.environment(),
		logger = { func = slog.func },
	})

	renderer.vertecies = []f32 {
		-0.5, -0.5, 0,
		 0.5, -0.5, 0,
		 0.5,  0.5, 0,
		-0.5,  0.5, 0,
	}
	gfx_state.bindings.vertex_buffers[0] = sg.make_buffer({
		usage = .DYNAMIC,
		size = len(renderer.vertecies) * size_of(f32),
	})

	renderer.indecies = []u16 {
		0, 1, 2,
		0, 2, 3,
	}
	gfx_state.bindings.index_buffer = sg.make_buffer({
		type = .INDEXBUFFER,
		data = { ptr = &renderer.indecies[0], size = len(renderer.indecies) * size_of(u16) },
	})

	gfx_state.pipeline = sg.make_pipeline({
		shader = sg.make_shader(shader.quad_shader_desc(sg.query_backend())),
		index_type = .UINT16,
		layout = {
			attrs = {
				shader.ATTR_quad_position = { format = .FLOAT3 },
			},
		},
	})
	
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
	// sg.update_buffer(
	// 	gfx_state.bindings.vertex_buffers[0],
	// 	{ ptr = &renderer.vertecies[0], size = len(renderer.vertecies) * size_of(f32) },
	// )
	
	sg.begin_pass({ action = gfx_state.pass_action, swapchain = sglue.swapchain() })
		sg.apply_pipeline(gfx_state.pipeline)
		sg.apply_bindings(gfx_state.bindings)
		sg.draw(0, 6, 1)
	sg.end_pass()
	sg.commit()
}