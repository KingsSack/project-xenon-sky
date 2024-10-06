extends Camera3D

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			rotate_object_local(Vector3.UP, event.relative.x*0.002)
			rotate_object_local(Vector3.RIGHT, event.relative.y*0.002)
