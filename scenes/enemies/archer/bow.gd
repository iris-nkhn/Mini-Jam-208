extends Node2D

@onready var archer : Enemy = get_parent()
var arrow_speed : float = 5000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	archer.attack_delay_counter += delta
	if archer.attack_delay_counter >= archer.attack_delay:
		archer.attack_delay_counter = 0
		fire_bow()
	pass

func fire_bow() -> void:
	var arrow = load("res://scenes/enemies/archer/arrow.tscn")
	arrow = arrow.instantiate() as RigidBody2D
	get_tree().root.add_child(arrow)
	arrow.global_position = global_position
	arrow.apply_force(firing_calculations())
	arrow.rotation = firing_calculations().angle()
	
func firing_calculations() -> Vector2:

	var dir = archer.target.global_position - archer.global_position
	dir = dir.normalized()
	return dir * arrow_speed
