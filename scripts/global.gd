extends Node

signal exoplanet_changed(planet_name)

var current_exoplanet = ""

func set_exoplanet(planet_name):
	current_exoplanet = planet_name
	exoplanet_changed.emit(planet_name)
	print("Exoplanet set to: ", current_exoplanet)

signal constelation_create(pos1 : Vector2, pos2 : Vector2)

var selected_stars = []

func add_star(star : Node3D):
	selected_stars.append(star)
	if len(selected_stars) == 2:
		constelation_create.emit(Vector2(selected_stars[0].global_transform.origin.x, selected_stars[0].global_transform.origin.y), Vector2(selected_stars[1].global_transform.origin.x, selected_stars[1].global_transform.origin.y))
