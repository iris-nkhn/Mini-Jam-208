extends CharacterBody2D

var goal : Vector2 
var speed: float = 10000
var segments = 10
var tail : BodySegment
var debug_color : Color = Color(0.808, 0.0, 0.0, 1.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tail = $BodySegment.new_segment()
	
	tail.next_segment(segments-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass
	
func _draw() -> void:
	if goal != null:
		draw_line(Vector2(0,0),  goal - position , debug_color, 1.0)

func _physics_process(delta: float) -> void:
	var distance = global_position.distance_to(goal)
	var max_speed = (distance / delta)
	velocity = goal.normalized() * min(speed,max_speed) * delta
	move_and_slide()
	rotation = rotate_toward(rotation,goal.angle(),5)
	
	pass

func set_goal(_goal_global: Vector2) -> void:
	goal = (_goal_global)
