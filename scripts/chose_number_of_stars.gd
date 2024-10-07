extends SpinBox

func _on_exit_tree():
	Global.max_stars = get_value()
