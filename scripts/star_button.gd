extends Button

@export var star : Node3D

func _process(_delta):
	position = get_viewport().get_camera_3d().unproject_position(star.global_transform.origin)

func _on_pressed():
	get_node("/root/Node3D/CanvasLayer/Control/Label2").text = "Selected star: " + star.star_name
	
	if get_node("/root/Node3D/CanvasLayer/Control/Control2/CheckButton").editor_enabled:
		Global.add_star_to_constelation(star)
