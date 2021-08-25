extends AnimatedSprite


func _ready():
	play("moving")
#	var player = Stats.character.instance()
#	player.global_position = Vector2(global_position.x + 11, global_position.y)
#	get_parent().call_deferred("add_child", player)



func _on_HitBox_body_entered(_body):
	play("moving")


func _on_Start_animation_finished():
	play("idle")
