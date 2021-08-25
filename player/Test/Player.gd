extends KinematicBody2D



var move_vec: Vector2 = Vector2.ZERO
var is_jump_interrupted: bool
var dead: bool = false
var hit_delay: bool = false
var current_animation
var flip_player: bool = false
var effect_in_process: bool = false

onready var characterMover = $CharacterMover
onready var animationPlayer = $AnimationPlayer
onready var animations = $Animations
onready var effectTimer = $EffectTimer


var AppearingEffect = preload("res://effects/AppearingEffect.tscn")
var DisappearingEffect = preload("res://effects/DisappearingEffect.tscn")

func _ready():
	characterMover.set_body_to_move(self)
	animationPlayer.set_body_to_animate(self)
	Stats.connect("player_dead", self, "player_dead")
	Stats.connect("character_changed", self, "change_character")
	
	

func _physics_process(_delta):
	if dead:
		return
	if Input.is_action_just_pressed("reset_scene"):
		get_tree().reload_current_scene()
	move_vec = get_direction()
	characterMover.set_move_vec(move_vec)
	animationPlayer.enable_double_jump(characterMover.double_jump)
	animationPlayer.update_animation(move_vec, characterMover.body_velocity)
	
	
func get_direction():
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -Input.get_action_strength("jump") if is_on_floor() or is_on_wall() and Input.is_action_just_pressed("jump") else 0.0)


func change_animation(anim_name: String):
	if !effect_in_process:
		for animation in animations.get_children():
			if animation.name != anim_name:
				animation.hide()
			else:
				current_animation = animation
		set_facing_direction()
		current_animation.show()

func set_facing_direction() -> void:
	if flip_player:
		current_animation.scale.x = -1
	else:
		current_animation.scale.x = 1


func _on_HurtBox_area_entered(area):
	if area.damage == 0:
		return
	elif !hit_delay:
		hit_delay = true
		animationPlayer.player_hurt(true)
		Stats.health = area.damage



func change_character():
	effect_in_process = true
	visible = false
	create_appearing_effect()
	

func change_character_animations(_character: int):
	var x = 0
	for animation in animations.get_children():
		animation.texture = load(animationPlayer.textures[x][_character])
		x += 1
	visible = true
	effect_in_process = false
	
	

func create_appearing_effect():
	effectTimer.start(0.3)
	var effect = AppearingEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
	
	

func create_disappearing_effect():
	var effect = DisappearingEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
	
func _on_EffectTimer_timeout():
	change_character_animations(Stats.character)


func _on_AnimationPlayer_animation_finished(anim_name):
	#print(animatedSprite.get_animation())
	if anim_name == "doublejump":
		animationPlayer.pause_animation(false)
		characterMover.set_jump_ability(false, false)
	if anim_name == "hit":
		animationPlayer.pause_animation(false)
		animationPlayer.player_hurt(false)
		hit_delay = false


func player_dead():
	dead = true
	#print("bummer")
	queue_free()



