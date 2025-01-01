package event

import sapp "../../lib/sokol/app"

ListenerCallback :: #type proc(user_ptr: rawptr)

EventListener :: struct {
	user_ptr: rawptr,
	callback: ListenerCallback,
}

ListenerBuffer :: #type [dynamic]EventListener
EventHandler :: struct($E: typeid) {
	listeners: map[E]ListenerBuffer
}

initialize_register :: proc($E: typeid) -> (register: EventHandler(E), ok: bool) {
	register = EventHandler(E){}
	register.listeners = make(map[E]ListenerBuffer) or_return

	return register, true
}

terminate_register :: proc(register: ^$E) {
	for key, buffer in register.listeners {
		delete(buffer)
	}
	delete(register.listeners)
}