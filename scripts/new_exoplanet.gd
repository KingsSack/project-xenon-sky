extends Button

signal load_exoplanet(planet_name: String)

func _ready():
	load_exoplanet.connect(get_tree().root.get_child(0)._on_load_exoplanet)

func _on_load_exoplanet_pressed():
	load_exoplanet.emit(get_text())
