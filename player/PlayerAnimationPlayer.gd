extends AnimationPlayer

var move_vec: Vector2
var velocity: Vector2
var body_to_animate: KinematicBody2D
var double_jump: bool
var state
var pause_animations: bool = false
var hurt = false

var doublejump = ["res://assets/Main Characters/Mask Dude/Double Jump (32x32).png", "res://assets/Main Characters/Ninja Frog/Double Jump (32x32).png", "res://assets/Main Characters/Pink Man/Double Jump (32x32).png", "res://assets/Main Characters/Virtual Guy/Double Jump (32x32).png"]
var fall = ["res://assets/Main Characters/Mask Dude/Fall (32x32).png", "res://assets/Main Characters/Ninja Frog/Fall (32x32).png", "res://assets/Main Characters/Pink Man/Fall (32x32).png", "res://assets/Main Characters/Virtual Guy/Fall (32x32).png"]
var hit = ["res://assets/Main Characters/Mask Dude/Hit (32x32).png", "res://assets/Main Characters/Ninja Frog/Hit (32x32).png", "res://assets/Main Characters/Pink Man/Hit (32x32).png", "res://assets/Main Characters/Virtual Guy/Hit (32x32).png"]
var idle = ["res://assets/Main Characters/Mask Dude/Idle (32x32).png", "res://assets/Main Characters/Ninja Frog/Idle (32x32).png", "res://assets/Main Characters/Pink Man/Idle (32x32).png", "res://assets/Main Characters/Virtual Guy/Idle (32x32).png"]
var jump = ["res://assets/Main Characters/Mask Dude/Jump (32x32).png", "res://assets/Main Characters/Ninja Frog/Jump (32x32).png", "res://assets/Main Characters/Pink Man/Jump (32x32).png", "res://assets/Main Characters/Virtual Guy/Jump (32x32).png"]
var run = ["res://assets/Main Characters/Mask Dude/Run (32x32).png", "res://assets/Main Characters/Ninja Frog/Run (32x32).png", "res://assets/Main Characters/Pink Man/Run (32x32).png", "res://assets/Main Characters/Virtual Guy/Run (32x32).png"]
var wall = ["res://assets/Main Characters/Mask Dude/Wall Jump (32x32).png", "res://assets/Main Characters/Ninja Frog/Wall Jump (32x32).png", "res://assets/Main Characters/Pink Man/Wall Jump (32x32).png", "res://assets/Main Characters/Virtual Guy/Wall Jump (32x32).png"]

var textures = [doublejump, idle, fall, hit, jump, run, wall]

enum animations {
	IDLE,
	RUN,
	JUMP,
	FALL,
	DOUBLEJUMP,
	HIT,
	WALL
}


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
				body_to_animate.change_animation("run")
			animations.IDLE:
				play('idle')
				body_to_animate.change_animation("idle")
			animations.JUMP:
				play('jump')
				body_to_animate.change_animation("jump")
			animations.FALL:
				play('fall')
				body_to_animate.change_animation("fall")
			animations.WALL:
				play('wall')
				body_to_animate.change_animation("wall")
			animations.DOUBLEJUMP:
				pause_animations = true
				play('doublejump')
				body_to_animate.change_animation("doublejump")
			animations.HIT:
				pause_animations = true
				play("hit")
				body_to_animate.change_animation("hit")
			
	
	

