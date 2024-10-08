extends Button

func _on_begin_pressed():
	get_tree().change_scene_to_file("res://scenes/map.tscn")
