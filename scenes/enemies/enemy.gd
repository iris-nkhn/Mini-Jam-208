class_name Enemy extends CharacterBody2D

enum undead_types{NORMAL, SWORD, ARCHER, HALBERD}
@export var type : undead_types
var default_target : Node2D = Necro
var target : Node2D = default_target
@export var speed : float = 10
@export var attack_radius : float = 50
@export var damage : int = 1
@export var attack_delay : float = 0.5
var attack_delay_counter : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _draw() -> void:
	#print(to_local(target.global_position))
	#draw_line(Vector2.ZERO,to_local(target.global_position),Color("Red"))
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	attack_delay_counter += delta
	if attack_delay_counter >= attack_delay:
		attack_delay_counter = 0
		attack_target()
	pass

func _physics_process(delta: float) -> void:
	if target == null:
		target = default_target
	move_towards_target()
	
	pass

func turn_undead() -> undead_types:
	print("ENEMIGO EN CIRCULO")
	get_parent().queue_free()

	return undead_types.NORMAL


func move_towards_target() -> void:
	velocity = target.global_position - global_position
	velocity = velocity.normalized() * speed
	move_and_slide()

func attack_target() -> void:
	#print(global_position.distance_to(target.global_position))
	if global_position.distance_to(target.global_position) <= attack_radius:
		print("daño")
		target.take_damage(damage)
