extends Control

var matches = []

func _on_line_edit_text_changed(new_text: String) -> void:
	var items = $ScrollContainer/VBoxContainer.get_children()
	print(items)
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
