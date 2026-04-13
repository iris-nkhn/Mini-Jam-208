extends CharacterBody2D

func _ready() -> void:
	damage_taken.connect(Tracker.leader._on_damage_taken)
	
	pass # Replace with function body.

signal damage_taken(damage : int)

func take_damage(damage : int) -> void:
	damage_taken.emit(damage)
