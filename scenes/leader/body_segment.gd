class_name BodySegment extends Node2D

var head : BodySegment
var tail : BodySegment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func next_segment(remaining_segments: int) -> void:
	tail = new_segment()
	if remaining_segments < 0:
		tail.next_segment(remaining_segments-1)
	

func new_segment() -> BodySegment:
	var scene = load("res://scenes/follower/follower_1.tscn")
	scene = scene.instantiate()
	add_child(scene)
	return scene.get_node("./BodySegment")
