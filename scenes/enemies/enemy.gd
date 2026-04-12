class_name Enemy extends CharacterBody2D

enum undead_types{NORMAL, SWORD, ARCHER, HALBERD}
@export var type : undead_types
var target : Node2D = self
@export var speed : float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

func _physics_process(delta: float) -> void:
	move_towards_target()
	
	pass

func turn_undead() -> undead_types:
	print("TUMBA EN CIRCULO")
	get_parent().queue_free()

	return undead_types.NORMAL


func move_towards_target() -> void:
	velocity = target.global_position - global_position
	velocity = velocity.normalized() * speed
	move_and_slide()
