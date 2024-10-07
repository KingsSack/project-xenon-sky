extends SpinBox

signal load_stars(amount)

func _on_tree_exiting():
	load_stars.emit(get_value())
