extends NPC

var bee_bullet = load("res://npc/projectiles/BeeBullet.tscn")
var is_attacking: bool = false

onready var beeAnimationPlayer: = $BeeAnimationPlayer

func _ready():
	change_animation("idle")
	beeAnimationPlayer.play("idle")


func _on_DetectionBox_body_entered(body):
	bee_attack()


func bee_attack():
	if !is_attacking: 
		print(beeAnimationPlayer.current_animation_position)
		is_attacking = true
		change_animation("attack")
		beeAnimationPlayer.play("attack")
		

func shoot_bee_bullet():
	var bee_bullet_instance = bee_bullet.instance()
	bee_bullet_instance.global_position = global_position
	get_parent().add_child(bee_bullet_instance)
	bee_bullet_instance.global_position.y += 12

func _on_BeeAnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		change_animation("idle")
		beeAnimationPlayer.play("idle")
		is_attacking = false
		


#func _on_BeeAnimationPlayer_animation_changed(old_name, new_name):
#	change_animation(new_name)
