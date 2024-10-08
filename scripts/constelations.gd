extends Node

@export var camera : Camera3D

var current_constelation = []

func _ready():
	Global.create_constelation.connect(_on_create_constelation)
	Global.complete_constelation.connect(_on_complete_constelation)

func _on_create_constelation(pos1: Vector3, pos2: Vector3):
	var line = ImmediateMesh.new()
	line.surface_begin(Mesh.PRIMITIVE_LINES)
	line.surface_set_color(Color(0.2, 0.2, 0.0))
	line.surface_add_vertex(pos1)
	line.surface_add_vertex(pos2)
	line.surface_end()
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = line
	
	var emmisive_material = StandardMaterial3D.new()
	emmisive_material.emission_enabled = true
	emmisive_material.emission = Color(0.2, 0.2, 0.0)
	emmisive_material.emission_energy = 1.0
	mesh_instance.material_override = emmisive_material
	
	mesh_instance.set_visibility_range_end(5000)
	add_child(mesh_instance)
	
	Global.last_constelation_pos = pos2

	if current_constelation.is_empty():
		Global.start_constelation.emit()
	
	current_constelation.append(mesh_instance)

func _on_complete_constelation():
	current_constelation = []
