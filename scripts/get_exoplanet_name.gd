extends Label

func _ready():
	Global.exoplanet_changed.connect(_on_load_exoplanet)

func _on_load_exoplanet(planet_name):
	text = "Current exoplanet: " + planet_name
