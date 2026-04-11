extends CharacterBody2D

#esto es un global coords
var goal : Vector2 
var speed: float = 10000
var segments = 10
var tail : Array[PathFollow2D]
var debug_color : Color = Color(0.808, 0.0, 0.0, 1.0)
var path : Curve2D = Curve2D.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_tail()
	$Path2D.set_curve(path)


		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_tail()
	path.add_point(position)
	if path.point_count > 300:
		path.remove_point(0)
	queue_redraw()

	if check_closed_loop():
		var points = path.get_baked_points()
		var polygon : CollisionPolygon2D = CollisionPolygon2D.new()
		polygon.set_polygon(points)
	pass
	
func _draw() -> void:
	if goal != null:
		draw_line(Vector2(0,0),  goal - position , debug_color, 1.0)
	if tail.size() > 2:
		var A = tail.back().position
		var B = position
		
		draw_circle(A - global_position,50,Color.RED,false)
		draw_circle(B - global_position,30,Color.PINK,false)

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

func initialize_tail() -> void:
	for i in segments - 1 :
		var segment : PathFollow2D = new_segment()
		tail.append(segment)
		$Path2D.add_child(segment)
		segment.set_progress(16 * i)

func update_tail() -> void:
	for i in tail.size():
		tail[i].progress_ratio = 1 - 0.10 * i

func check_closed_loop() -> bool:
	var A = path.get_closest_point(position)
	var B = position
	draw
	if to_global(path.get_closest_point(position)).distance_to(global_position) <= 10:
		return true
	else: return false
