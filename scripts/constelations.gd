extends Node2D

func _ready():
	Global.constelation_create.connect(_on_constelation_create)

func _on_constelation_create(pos1 : Vector2, pos2 : Vector2):
	draw_line(pos1, pos2, Color(1,1,1))
