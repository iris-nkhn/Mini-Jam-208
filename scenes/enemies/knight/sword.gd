extends Node2D

@onready var knight = get_parent() as Enemy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	knight.attack_delay_counter += delta
	if knight.attack_delay_counter >= knight.attack_delay:
		knight.attack_delay_counter = 0
		attack_target()
	pass


func attack_target() -> void:
	#print(global_position.distance_to(target.global_position))
	if global_position.distance_to(knight.target.global_position) <= knight.attack_radius:
		print("daño")
		#knight.animator.play("move_right")
		knight.target.take_damage(knight.damage)

#func play_attack() -> void:
	
