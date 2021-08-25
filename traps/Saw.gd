extends KinematicBody2D

var SPEED: int = 100
var saw_points
var saw_index: int = 0
var velocity: Vector2 = Vector2.ZERO

#var chain = load("res://assets/Traps/Saw/Chain.png")

onready var animatedSprite = $AnimatedSprite
onready var parent = get_parent()



func _ready():
	animatedSprite.play("on")
	if parent is PathFollow2D:
		saw_points = parent.get_parent().curve.get_baked_points()

func _physics_process(_delta):
	if parent is PathFollow2D:
		var target = saw_points[saw_index]
		if global_position.distance_to(target) < 1:
			saw_index = wrapi(saw_index + 1, 0, saw_points.size())
			target = saw_points[saw_index]
		velocity = (target - global_position).normalized() * SPEED
		velocity = move_and_slide(velocity)
	else:
		return
