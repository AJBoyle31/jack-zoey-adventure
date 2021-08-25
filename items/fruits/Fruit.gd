extends Area2D
class_name Fruit

export var points: int = 1

var CollectedEffect = preload("res://effects/CollectedItemEffect.tscn")
onready var animatedSprite = $AnimatedSprite

func _ready():
	animatedSprite.play("play")

func create_collected_effect():
	var effect = CollectedEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position

func _on_Fruit_body_entered(_body):
	create_collected_effect()
	Score.score = points
	queue_free()
