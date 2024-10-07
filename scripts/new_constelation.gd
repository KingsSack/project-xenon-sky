extends Control

var constelation_name : String

func set_pos(pos):
	$LineEdit.rect_position = pos
	$Label.rect_position = pos

func _on_line_edit_text_submitted(new_text):
	$LineEdit.hide()
	constelation_name = new_text
	$Label.text = constelation_name
	$Label.show()
