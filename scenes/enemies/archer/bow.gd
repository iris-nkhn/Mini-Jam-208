extends Node2D

@onready var archer = get_parent()
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
	arrow = arrow.instantiate() as AnimatableBody2D
	get_tree().root.add_child(arrow)
	arrow.global_position = global_position
