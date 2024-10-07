extends Control

var constelation_label_scene := preload("res://constelation_label.tscn")
var lines = []
var constelation_name : String
var pos_3D : Vector3

func set_pos(pos: Vector2):
	$LineEdit.position = pos
	$Button.position = pos
	print($Button.position)

func _on_line_edit_text_submitted(new_text):
	$LineEdit.hide()
	constelation_name = new_text
	var label = constelation_label_scene.instantiate()
	label.pos = pos_3D
	label.get_child(0).text = constelation_name
	get_node("/root/Node3D/Constelations").add_child(label)

func _on_button_pressed():
	Global.complete_constelation.emit()
