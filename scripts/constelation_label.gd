extends MeshInstance3D

var pos : Vector3

func _process(_delta):
	look_at(get_viewport().get_camera().global_transform.origin)
	$Label.global_position = pos
