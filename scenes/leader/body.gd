extends CharacterBody2D

#esto es un global coords
var goal : Vector2 
var speed: float = 10000
var segments = 2
var tail : PathFollow2D
var debug_color : Color = Color(0.808, 0.0, 0.0, 1.0)
var path : Curve2D = Curve2D.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path.add_point(position)

	$Path2D.set_curve(path)
	if segments > 1:
		tail = new_segment()
		$Path2D.add_child(tail)

	if segments > 2:
		tail.next_segment(segments-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path.add_point(position)
	if path.point_count > 100:
		path.remove_point(0)
	tail.set_progress_ratio(0.80)
	queue_redraw()

	pass
	
func _draw() -> void:
	if goal != null:
		draw_line(Vector2(0,0),  goal - position , debug_color, 1.0)

func _physics_process(delta: float) -> void:
	var distance = global_position.distance_to(goal)
	var max_speed = (distance / delta)
	velocity = goal_local().normalized() * min(speed,max_speed) * delta
	move_and_slide()
	#rotation = rotate_toward(rotation,goal.angle(),5)
	
	pass

func set_goal(_goal_global: Vector2) -> void:
	goal = (_goal_global)
	
func goal_local() -> Vector2:
	return to_local(goal)

func new_segment() -> Node2D:
	var scene = load("res://scenes/follower/follower_1.tscn")
	scene = scene.instantiate()

	return scene
