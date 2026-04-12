class_name Enemy extends StaticBody2D

enum undead_types{NORMAL, SWORD, ARCHER, HALBERD}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func turn_undead() -> undead_types:
	print("TUMBA EN CIRCULO")
	get_parent().queue_free()

	return undead_types.NORMAL
	
