extends AnimatedSprite





func _ready():
	play("idle")


func _on_HitBox_body_entered(_body):
	play("pressed")
	
