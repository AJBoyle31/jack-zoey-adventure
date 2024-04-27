extends Area2D

var bee_bullet_gravity: int = 2
var bee_bullet_effect = load("res://npc/projectiles/BeeBulletEffect.tscn")

func _ready():
	pass

func _process(delta):
	position.y += bee_bullet_gravity
	



func _on_BeeBullet_body_entered(body):
	queue_free()
	var bullet_effect = bee_bullet_effect.instance()
	bullet_effect.global_position = global_position
	get_parent().add_child(bullet_effect)
