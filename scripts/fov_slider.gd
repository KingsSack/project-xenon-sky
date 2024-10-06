extends VSlider

signal slider_changed(new_value)

func _process(_delta: float) -> void:
	slider_changed.emit((120 - value) / 1.6)
