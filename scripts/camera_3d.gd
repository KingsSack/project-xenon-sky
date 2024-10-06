extends Camera3D

func _ready():
	get_node("/root/Node3D/CanvasLayer/Control/VSlider").slider_changed.connect(_on_slider_changed)

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			rotate_object_local(Vector3.UP, event.relative.x*0.002)
			rotate_object_local(Vector3.RIGHT, event.relative.y*0.002)

func _on_slider_changed(new_value):
	set_fov(new_value+1)
