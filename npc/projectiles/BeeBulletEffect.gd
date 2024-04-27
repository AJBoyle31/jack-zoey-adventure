extends Node2D


onready var bullet_effect_animation_player = $AnimationPlayer

func _ready():
	bullet_effect_animation_player.play("breakapart")
	



func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
