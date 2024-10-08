extends Node

var max_stars : int

signal exoplanet_changed(planet_name)

var current_exoplanet = ""

func set_exoplanet(planet_name):
	current_exoplanet = planet_name
	exoplanet_changed.emit(planet_name)

signal create_constelation(pos1 : Vector3, pos2 : Vector3)

var selected_stars = []

func add_star_to_constelation(star : Node3D):
	selected_stars.append(star)
	if len(selected_stars) == 2:
		# constelation_create.emit(get_viewport().get_camera_3d().unproject_position(selected_stars[0].global_transform.origin), get_viewport().get_camera_3d().unproject_position(selected_stars[1].global_transform.origin))
		create_constelation.emit(selected_stars[0].global_transform.origin, selected_stars[1].global_transform.origin)
		selected_stars = []

signal start_constelation()

var last_constelation_pos : Vector3

signal complete_constelation()
