extends Button

@export var star : Node3D

func _ready():
	position = Vector2(star.global_transform.origin.x, star.global_transform.origin.y)

func _on_pressed():
	Global.add_star(star)
