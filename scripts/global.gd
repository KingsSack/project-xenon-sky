extends Node

signal exoplanet_changed

var current_exoplanet = ""

func set_exoplanet(planet_name):
	current_exoplanet = planet_name
	emit_signal("exoplanet_changed", current_exoplanet)
	print("Exoplanet set to: ", current_exoplanet)
