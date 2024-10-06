extends Button

@export var star : Node3D

func _process(_delta):
	position = get_viewport().get_camera_3d().unproject_position(star.global_transform.origin)

func _on_pressed():
	print("Star button pressed")
	Global.add_star(star)
