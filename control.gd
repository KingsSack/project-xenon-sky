extends Control
@export var tween_intensity: float
@export var tween_duration: float

@onready var play: Button = $Button

func _process(delta: float) -> void:
	btn_hovered(play)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	
func btn_hovered(button: Button):
	button.pivot_offset = button.size/2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
