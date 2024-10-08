extends Node

@export var camera : Camera3D

var constelation_scene := preload("res://scenes/constelation.tscn")

var star_one : String
var current_constelation : Control

func _ready():
	Global.complete_constelation.connect(_on_complete_constelation)
	Global.create_constelation.connect(_on_creae_constelation)

func start_constelation():
	current_constelation = constelation_scene.instantiate()
	get_node("/root/Node3D/CanvasLayer").add_child(current_constelation)

func _on_creae_constelation(pos1: Vector3, pos2: Vector3):
	if not current_constelation:
		start_constelation()
	
	var line = ImmediateMesh.new()
	line.surface_begin(Mesh.PRIMITIVE_LINES)
	line.surface_set_color(Color(1.0, 0.0, 0.0))
	line.surface_add_vertex(pos1)
	line.surface_add_vertex(pos2)
	line.surface_end()
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = line
	
	var emmisive_material = StandardMaterial3D.new()
	emmisive_material.emission_enabled = true
	emmisive_material.emission = Color(1.0, 0.0, 0.0)
	emmisive_material.emission_energy = 1.0
	mesh_instance.material_override = emmisive_material
	
	mesh_instance.set_visibility_range_end(1000)
	add_child(mesh_instance)
	
	current_constelation.set_pos(camera.unproject_position(pos2))
	current_constelation.lines.append(mesh_instance)
	current_constelation.pos_3D = pos2

func _on_complete_constelation():
	print("Completing constelation...")
	current_constelation.get_child(1).hide()
	current_constelation.get_child(0).show()
	current_constelation = null
