extends Control

var matches = []
@onready var menu = $ScrollContainer
@onready var search = $LineEdit
func _on_line_edit_text_changed(new_text: String) -> void:
	var items = $ScrollContainer/VBoxContainer.get_children()
	if new_text == "":
		for i in items:
			i.visible = true
		return
	matches.clear()
	for i in items:
		if new_text.to_lower() in i.text.to_lower():
			matches.append(i)
	for i in items:
		if i in matches:
			i.visible = true
		else:
			i.visible = false


func _on_button_pressed() -> void:
	menu.visible = false
	search.visible = false
	


func _on_button_2_pressed() -> void:
	menu.visible = true
	search.visible = true
