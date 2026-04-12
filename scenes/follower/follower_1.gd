class_name follower extends Node2D

@onready var controller = $Controller
@onready var sprite = $Sprite2D
@onready var animator = $Sprite2D/CharacterAnimationPlayer
var direction : Vector2
var last_pos : Vector2
var i : float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _draw() -> void:
	
	draw_line(Vector2.ZERO,direction * 10,Color(0.792, 0.629, 0.92, 1.0))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	i = i + delta
	
	if i >= 0.05:
		play_animation_direction(get_direction(last_pos))
		i = 0
	
	last_pos = global_position
	pass

func set_sprite(type : leader.undead_types) -> void:
	if type==0:
		sprite.texture = load("res://assets/characters/skelly_spritesheet.png")
	if type==1:
		sprite.texture = load("res://assets/characters/skelly_sword_spritesheet.png")
	if type==2:
		sprite.texture = load("res://assets/characters/skelly_archer_spritesheet.png")
	if type==3:
		sprite.texture = load("res://assets/characters/skelly_halberd_spritesheet.png")
	pass

func get_direction(pos : Vector2) -> String:
	var A := pos # last position
	var B := global_position # current position
	var _direction := B - A
	_direction = _direction.normalized()
	self.direction = _direction

	var angle = _direction.angle()
	var cos_angle = rad_to_deg(cos(angle))
	var sin_angle = rad_to_deg(sin(angle))
	queue_redraw()

	var abs_sin = abs(sin_angle)
	var abs_cos = abs(cos_angle)
  # up and down are switched for me because I'm actually playing an animation, and the animation points up or down when moving down or up, respectively
	if abs_cos > abs_sin: # if direction is mostly lateral
		if cos_angle > 0:
			return "Right"
		else:
			return "Left"
	else:
		if sin_angle < 0:
			return "Up"
		else:
			return "Down"
func play_animation_direction(_direction : String) -> void:
	if _direction == "Left":
		animator.play("move_left")
	if _direction == "Right":
		animator.play("move_right")
	if _direction == "Up":
		animator.play("move_up")
	if _direction == "Down":
		animator.play("move_down")
