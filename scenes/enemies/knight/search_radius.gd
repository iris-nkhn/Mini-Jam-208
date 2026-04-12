extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	owner.target = get_closest_target()
	pass

func get_closest_target() -> Node2D:
	
	var list : Array[Node2D]
	var closest = owner.target
	list = get_overlapping_bodies()
	for i in list:
		if i is follower or i is necro:
			if global_position.distance_squared_to(i.global_position) < global_position.distance_squared_to(closest.global_position):
				closest = i
	return closest
