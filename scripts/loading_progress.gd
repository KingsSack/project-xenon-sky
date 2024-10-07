extends ProgressBar

@onready var node := get_node("/root/Node3D")

func _ready():
	max_value = node.max_exoplanet_data + node.max_star_data

func _process(_delta):
	value = node.exoplanet_data_recieved + node.star_data_recieved
