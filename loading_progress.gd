extends Label

@onready var node := get_node("/root/Node3D")

func _process(_delta):
	if node.exoplanet_data_recieved or node.star_data_recieved:
		if node.exoplanet_data_recieved and node.star_data_recieved:
			text = "2/2"
		else:
			text = "1/2"
