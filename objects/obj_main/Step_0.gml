if live_call() return live_result

if keyboard_check_pressed(ord("R")) {
	uibase.clear()
	event_user(0)
}

uibase.step()