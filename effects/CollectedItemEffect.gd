extends AnimatedSprite

func _ready():
	frame = 0
	play("collected")



func _on_CollectedItemEffect_animation_finished():
	queue_free()
