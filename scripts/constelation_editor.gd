extends CheckButton

var editor_enabled := false

func _on_toggled(toggled_on):
	editor_enabled = toggled_on
