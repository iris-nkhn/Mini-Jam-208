extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_parent().target = get_closest_target()
	pass

func get_closest_target() -> Node2D:
	
	var list : Array[Node2D]
	var closest = get_parent().target
	list = get_overlapping_bodies()
	for i in list:
		var a = global_position.distance_squared_to(i.global_position)
		#print(a)
		var b = global_position.distance_squared_to(closest.global_position)
		#print(b)
		var c = min(a,b)
		if a == c:
			closest = i
		elif b == c:
			closest = closest
	
	return closest
