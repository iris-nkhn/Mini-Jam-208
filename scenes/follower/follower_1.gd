extends Node2D

@onready var controller = $Controller
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controller.goal = Leader
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	controller.move_attached(self)
	pass
