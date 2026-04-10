extends CharacterBody2D

var goal : Vector2 
var speed: float = 10000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var distance = global_position.distance_to(goal)
	var max_speed = (distance / delta)
	velocity = goal.normalized() * min(speed,max_speed) * delta
	move_and_slide()

	
	
	pass

func set_goal(_goal: Vector2) -> void:
	goal = (_goal - global_position)
