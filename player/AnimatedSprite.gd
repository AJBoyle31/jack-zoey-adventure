extends AnimatedSprite

class_name CharacterAnimations


var move_vec: Vector2
var velocity: Vector2
var body_to_animate: KinematicBody2D
var double_jump: bool
var state
var pause_animations: bool = false
var hurt = false


enum animations {
	IDLE,
	RUN,
	JUMP,
	FALL,
	DOUBLEJUMP,
	HIT,
	WALL
}

func set_facing_direction(_move_vec) -> void:
	if _move_vec.x < -0.01:
		flip_h = true
	if _move_vec.x > 0.01:
		flip_h = false


func enable_double_jump(_double_jump):
	double_jump = _double_jump

func set_body_to_animate(_body_to_animate: KinematicBody2D):
	body_to_animate = _body_to_animate

func player_hurt(_hurt):
	hurt = _hurt

func pause_animation(_pause_animations: bool):
	pause_animations = _pause_animations

func _ready():
	pass # Replace with function body.

func update_animation(_move_vec: Vector2, _velocity: Vector2) -> void:
	if hurt:
		state = animations.HIT
	elif body_to_animate.is_on_wall() and _velocity.y > 0:
		state = animations.WALL
	elif double_jump:
		state = animations.DOUBLEJUMP
	else: 
		if _velocity.y < 0:
			state = animations.JUMP
		elif _velocity.y > 0:
			state = animations.FALL
		elif _move_vec.x > 0.01 or _move_vec.x < -0.01:
			state = animations.RUN
		else:
			state = animations.IDLE
	
	if !pause_animations:
		match state:
			animations.RUN:
				play('run')
			animations.IDLE:
				play('idle')
			animations.JUMP:
				play('jump')
			animations.FALL:
				play('fall')
			animations.WALL:
				play('wall')
			animations.DOUBLEJUMP:
				pause_animations = true
				play('doublejump')
			animations.HIT:
				pause_animations = true
				play("hit")
			
	
	set_facing_direction(_move_vec)

