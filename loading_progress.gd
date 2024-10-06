extends Label

func _process(_delta):
	if get_node("/root/Node3D").exoplanet_data_recieved or get_node("/root/Node3D").star_data_recieved:
		if get_node("/root/Node3D").exoplanet_data_recieved and get_node("/root/Node3D").star_data_recieved:
			text = "2/2"
		else:
			text = "1/2"
