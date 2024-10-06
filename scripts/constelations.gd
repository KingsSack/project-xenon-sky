extends Node2D

func _ready():
	Global.constelation_create.connect(_on_constelation_create)

func _on_constelation_create(pos1 : Vector3, pos2 : Vector3):
	var line = ImmediateMesh.new()
	line.surface_begin(Mesh.PRIMITIVE_LINES)
	line.surface_set_color(Color(1.0, 0.0, 0.0))
	line.surface_add_vertex(pos1)
	line.surface_add_vertex(pos2)
	line.surface_end()
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = line
	add_child(mesh_instance)
