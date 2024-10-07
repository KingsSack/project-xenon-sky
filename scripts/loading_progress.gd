extends Label

@onready var node := get_node("/root/Node3D")

func _process(_delta):
	text = str(node.exoplanet_data_recieved + node.star_data_recieved) + "/" + str(node.max_exoplanet_data + node.max_star_data)
