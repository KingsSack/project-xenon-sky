extends VSlider

signal slider_changed(new_value, not_draging)

func _process(_delta: float) -> void:
	slider_changed.emit((120 - value) / 1.6, is_not_draging)

var is_not_draging

func _on_drag_started():
	is_not_draging = false

func _on_drag_ended():
	is_not_draging = true
