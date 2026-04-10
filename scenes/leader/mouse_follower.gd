extends Node2D

var banner : Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	banner = Banner
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_parent().set_goal(banner.global_position)
	pass
