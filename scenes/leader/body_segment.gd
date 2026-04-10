class_name BodySegment extends Node2D

var head : BodySegment
var tail : BodySegment
@onready var pin = $PinJoint2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pin.node_a = self.get_path()
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
	scene.position = Vector2(0, -50)
	pin.node_b = scene.get_path()
	return scene.get_node("./BodySegment")
