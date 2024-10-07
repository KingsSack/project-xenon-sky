extends Node2D

var constelation_scene := preload("res://constelation.tscn")

var constelation_lines = []
var star_one : String

func _ready():
	Global.create_constelation.connect(_on_creae_constelation)

func _on_creae_constelation(star_name, pos1 : Vector3, pos2 : Vector3):
	var line = ImmediateMesh.new()
	line.surface_begin(Mesh.PRIMITIVE_LINES)
	line.surface_set_color(Color(1.0, 0.0, 0.0))
	line.surface_add_vertex(pos1)
	line.surface_add_vertex(pos2)
	line.surface_end()
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = line
	add_child(mesh_instance)
	
	if constelation_lines.is_empty():
		star_one = star_name
		print("Starting new constelation with ", star_name)
	elif star_one == star_name:
		complete_constelation(Vector2(pos2.x, pos2.y))
		return
	
	constelation_lines.append(mesh_instance)

func complete_constelation(label_pos : Vector2):
	print("Completing constelation...")
	var new_constelation = constelation_scene.instantiate()
	new_constelation.set_pos(label_pos)
	get_node("/root/Node3D/CanvasLayer").add_child(new_constelation)
