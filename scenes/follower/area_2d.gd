extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(Tracker.leader._on_area_entered.bind(self))

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
