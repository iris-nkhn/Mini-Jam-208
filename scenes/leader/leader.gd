extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controller.goal = $MouseFollower.banner
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Controller.move_attached(self)
	pass
