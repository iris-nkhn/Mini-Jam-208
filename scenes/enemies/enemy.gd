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

var direction: Vector2
var i : float
var last_pos : Vector2

@onready var animator = $SpriteWithAnimationComponent/CharacterAnimationPlayer
@onready var sprite = $SpriteWithAnimationComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_sprite(type)
	pass # Replace with function body.

func _draw() -> void:
	#print(to_local(target.global_position))
	#draw_line(Vector2.ZERO,to_local(target.global_position),Color("Red"))
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	i = i + delta
	
	if i >= 0.05:
		play_animation_direction(get_direction(last_pos))
		i = 0
	
	last_pos = global_position
	pass
	


func _physics_process(_delta: float) -> void:
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
		
func set_sprite(type : Enemy.undead_types) -> void:
	if type==0:
		sprite.texture = load("res://assets/characters/skelly_spritesheet.png")
	if type==1:
		sprite.texture = load("res://assets/characters/knight_sword_spritesheet.png")
	if type==2:
		sprite.texture = load("res://assets/characters/knight_archer_spritesheet.png")
	if type==3:
		sprite.texture = load("res://assets/characters/knight_halberd_spritesheet.png")
	pass
