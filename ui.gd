extends Control

var matches = []
@onready var items = $ScrollContainer/VBoxContainer.get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text == "":
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
