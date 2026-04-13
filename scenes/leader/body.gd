class_name leader extends CharacterBody2D

#esto es un global coords
var goal : Vector2 
@export var speed: float = 10000

@export var initial_segments = 5 
var tail : Array[PathFollow2D]
var path : Curve2D = Curve2D.new()
var max_len : int = 200
@export var min_len : int = 4

var debug_color : Color = Color(0.808, 0.0, 0.0, 1.0)



enum undead_types{NORMAL, SWORD, ARCHER, HALBERD}
@export var life : int = 5
var damage : int = 0


@onready var enclosed_area : Area2D = $Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Tracker.leader = self
	initialize_tail()
	$Path2D.set_curve(path)


		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_tail()

	queue_redraw()


	
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

func new_segment(undead_type : undead_types) -> Node2D:
	var scene = load("res://scenes/follower/follower_1.tscn")
	scene = scene.instantiate()
	tail.append(scene)
	$Path2D.add_child(scene)
	scene.set_sprite(undead_type)
	return scene

func remove_segment() -> void:
	var segment_to_lose = tail.pop_back()
	segment_to_lose.queue_free()
	
	pass

func initialize_tail() -> void:
	for i in initial_segments:
		var segment : PathFollow2D = new_segment(undead_types.NORMAL)
		
		segment.set_progress(16 * i)
		

func update_tail() -> void:
	#set progress of each part
	for i in tail.size():
		var progress = 1 - (i * 1.0/(tail.size() -1))
		tail[i].progress_ratio = progress
	
	max_len = tail.size() * 40
	#change line
	path.add_point(position)
	if path.point_count > max_len:
		path.remove_point(0)
	#change length
	

func check_closed_loop() -> bool:

	if to_global(path.get_closest_point(position)).distance_to(global_position) <= 10:
		return true
	else: return false

func _on_area_entered(area: Area2D, source: Area2D) -> void:
	if area.get_parent() == tail[0] && source.get_parent() == tail.back():
		print("circulo cerrado")
		circle_within()
	pass
	
func circle_within() -> void:
	var points = path.get_baked_points()
	var polygon : CollisionPolygon2D = CollisionPolygon2D.new()
	polygon.set_polygon(points)
	enclosed_area.call_deferred("add_child",polygon)
	
	call_deferred("check_within")
	
	pass
func check_within() -> void:
	var polygon = enclosed_area.get_child(0)
	await get_tree().physics_frame
	var body_list = enclosed_area.get_overlapping_bodies()
	for i in body_list:
		print(i.get_class())
		if i is Enemy:
		
			var grave_type = i.turn_undead()
			new_segment(grave_type)
	if polygon != null:
		polygon.queue_free()

func _on_damage_taken(_damage : int) -> void:
	damage += _damage
	if damage >= life:
		damage = 0
		if tail.size() >= min_len:
			lose_life()
		
func lose_life() -> void:
	remove_segment()
	pass
