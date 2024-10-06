extends Node

signal exoplanet_changed(planet_name)

var current_exoplanet = ""

func set_exoplanet(planet_name):
	current_exoplanet = planet_name
	exoplanet_changed.emit(planet_name)
	print("Exoplanet set to: ", current_exoplanet)
