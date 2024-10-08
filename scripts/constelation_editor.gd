extends Control

var constelation_label_scene := preload("res://scenes/constelation_label.tscn")

var editor_enabled := false

func _ready():
	Global.start_constelation.connect(_on_start_constelation)
	Global.complete_constelation.connect(_on_complete_constelation)

func _on_toggled(toggled_on):
	editor_enabled = toggled_on
	if editor_enabled:
		$Button.show()
	else:
		$Button.hide()
	reset()

func reset():
	$LineEdit.hide()
	$Button.disabled = true

func _on_start_constelation():
	$Button.disabled = false

func _on_button_pressed():
	$Button.disabled = true
	Global.complete_constelation.emit()

const POSITION_MODIFIER := Vector3.UP * 10
var label_pos : Vector3

func _on_complete_constelation():
	$LineEdit.show()
	label_pos = Global.last_constelation_pos

func _on_line_edit_text_submitted(new_text):
	$LineEdit.hide()
	var label = constelation_label_scene.instantiate()
	label.position = label_pos + POSITION_MODIFIER
	label.text = new_text
	get_node("/root/Node3D/Constelations").add_child(label)
