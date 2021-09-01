extends AnimatedSprite




func _ready():
	play("moving")
	



func _on_HitBox_body_entered(_body):
	play("moving")


func _on_Start_animation_finished():
	play("idle")


