extends Node2D

class_name CharacterMover

var GRAVITY: int = 600
var SPEED: Vector2 = Vector2(200, 200)
var DOUBLE_JUMP_SPEED_ADJUSTMENT = 0.5
var WAll_FRICTION: = 0.85
var move_vec: Vector2
var _velocity: Vector2
var body_to_move: KinematicBody2D
var body_velocity: Vector2
var jump_one: bool
var double_jump: bool

func set_body_to_move(_body_to_move: KinematicBody2D):
	body_to_move = _body_to_move

func set_move_vec(_move_vec: Vector2):
	move_vec = _move_vec

func set_jump_ability(_jump_one: bool, _double_jump: bool):
	jump_one = _jump_one
	double_jump = _double_jump


func calculate_move_velocity(
	linear_velocity: Vector2,
	_move_vec: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool,
	is_double_jump: bool
) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * _move_vec.x
	if move_vec.y != 0.0:
		jump_one = true
		velocity.y = -speed.y
	if is_double_jump:
		velocity.y = -speed.y * DOUBLE_JUMP_SPEED_ADJUSTMENT
	if is_jump_interrupted:
		velocity.y = 0.0
	if body_to_move.is_on_wall() and velocity.y > 0:
		velocity.y *= WAll_FRICTION
	flip_player(velocity)
	return velocity


func flip_player(_player_movement):
	if _player_movement.x > 0.01:
		body_to_move.flip_player = false
	elif _player_movement.x < -0.01:
		body_to_move.flip_player = true


func _ready():
	pass 


func _physics_process(delta):
	if body_to_move == null:
		return
	if body_to_move.is_on_floor():
		jump_one = false
		double_jump = false
	_velocity.y += GRAVITY * delta
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	if Input.is_action_just_pressed("jump"):
		if jump_one:
			if !double_jump:
				double_jump = true
	_velocity = calculate_move_velocity(_velocity, move_vec, SPEED, is_jump_interrupted, double_jump)
	if _velocity.y > SPEED.y * 1.5:
		_velocity.y = SPEED.y * 1.5
	_velocity = body_to_move.move_and_slide(_velocity, Vector2.UP)
	body_velocity = _velocity
