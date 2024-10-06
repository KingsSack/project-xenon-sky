extends Node2D

@export var camera : Camera3D

func _ready():
	Global.constelation_create.connect(_on_constelation_create)

func _on_constelation_create(pos1 : Vector2, pos2 : Vector2):
	var screen_pos1 = camera.project_position(pos1, 0)
	var screen_pos2 = camera.project_position(pos2, 0)
	
	var line = Line2D.new()
	line.default_color = Color(0, 1, 0)
	line.width = 2
	line.add_point(screen_pos1)
	line.add_point(screen_pos2)
	add_child(line)
