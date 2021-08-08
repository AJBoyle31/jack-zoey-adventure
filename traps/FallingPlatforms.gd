extends KinematicBody2D

export var falling_velocity: int = 200
var velocity: Vector2 = Vector2.ZERO
var falling: bool = false

onready var animatedSprite = $AnimatedSprite
onready var collisionShape = $CollisionShape2D
onready var timer = $Timer

func _ready():
	animatedSprite.play("on")

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if falling:
			queue_free()


func _on_Timer_timeout():
	animatedSprite.play("off")
	velocity = Vector2.DOWN
	velocity.y = falling_velocity
	falling = true


func _on_Area2D_body_entered(body):
	if body.has_method("player_dead"):
		timer.start()
