extends Node2D
@onready var body = $Body
@export var debug_color : Color
@export var speed : float = 10000
@export var safe_dist : float = 50
var goal : Node2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Body/RemoteTransform2D.remote_path = get_parent().get_path()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	body.speed = speed
	var goal_pos: Vector2 = get_goal_position()
	body.set_goal(goal_pos) 
	queue_redraw()
	
	pass

func get_goal_position() ->  Vector2:
	return goal.global_position
	

		
#func move_attached(node : Node2D) -> void:
	#node.global_position = body.global_position
	#body.position = Vector2(0,0)
