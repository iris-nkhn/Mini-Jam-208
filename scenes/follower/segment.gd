extends PathFollow2D

var tail : PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_segment() -> Node2D:
	var scene = load("res://scenes/follower/follower_1.tscn")
	scene = scene.instantiate()

	return scene


func next_segment(remaining_segments : int) -> void:
	remaining_segments = remaining_segments - 1
	if remaining_segments >= 1:
		tail = new_segment()
		tail.a
