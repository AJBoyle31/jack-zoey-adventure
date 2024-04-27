extends KinematicBody2D
class_name NPC

var current_animation: Sprite


onready var animations: = $NPCAnimations




func change_animation(anim_name: String):
	for animation in animations.get_children():
		if animation.name != anim_name:
			animation.hide()
		else:
			current_animation = animation
	current_animation.show()
