extends Node2D

@export var goaltype : goal_types
var goal : Node2D 
@onready var body = $Body
enum goal_types{BANNER, LEADER}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var goal_pos: Vector2 = get_goal_position()
	body.set_goal(goal_pos) 
	queue_redraw()
	
	pass

func get_goal_position() ->  Vector2:
	return goal.global_position
	
func _draw() -> void:
	draw_line(Vector2(0,0),  goal.global_position - global_position, Color.GREEN, 1.0)
		
func move_attached(node : Node2D) -> void:
	node.global_position = body.global_position
	body.position = Vector2(0,0)
