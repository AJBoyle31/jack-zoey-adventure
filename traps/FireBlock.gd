extends StaticBody2D


enum animations {
	OFF,
	HIT,
	ON
}

var state = animations.OFF
var pause_animation = false

onready var graphics = $Graphics
onready var animationPlayer = $AnimationPlayer

func _ready():
	pass

func _process(_delta):
	updateAnimation()

func updateAnimation():
	if !pause_animation:
		match state:
			animations.OFF:
				animationPlayer.play("off")
			animations.HIT:
				animationPlayer.play("hit")
				pause_animation = true
			animations.ON:
				animationPlayer.play("on")



func change_graphics(anim):
	for graphic in graphics.get_children():
		if anim == graphic.name:
			graphic.visible = true
		else:
			graphic.visible = false


func _on_AnimationPlayer_animation_started(anim_name):
	change_graphics(anim_name)
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hit":
		pause_animation = false
		state = animations.ON


func _on_InitialHitBox_area_entered(_area):
	state = animations.HIT
