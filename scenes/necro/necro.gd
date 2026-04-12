class_name necro extends CharacterBody2D


const SPEED = 50

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	# We create a local variable to store the input direction.
	var direction = Vector2.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("Right"):
		direction.x += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Up"):
		direction.y -= 1

	if direction:
		print(direction)
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
