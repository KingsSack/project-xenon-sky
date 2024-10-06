extends Label

func _ready():
	Global.connect("load_exoplanet", Callable(self, "_on_load_exoplanet"))

func _on_load_exoplanet(planet_name):
	text = "Current exoplanet: " + planet_name
