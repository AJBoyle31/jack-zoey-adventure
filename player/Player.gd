extends KinematicBody2D

class_name Player

var move_vec: Vector2 = Vector2.ZERO
var is_jump_interrupted: bool
var dead: bool = false
var hit_delay: bool = false

var AppearingEffect = preload("res://effects/AppearingEffect.tscn")
var DisappearingEffect = preload("res://effects/DisappearingEffect.tscn")

onready var animatedSprite = $AnimatedSprite
onready var characterMover = $CharacterMover
onready var effectTimer = $EffectTimer



func _ready():
	characterMover.set_body_to_move(self)
	animatedSprite.set_body_to_animate(self)
	Stats.connect("player_dead", self, "player_dead")
	Stats.connect("character_changed", self, "change_character")
	
	

func _physics_process(_delta):
	if dead:
		return
	if Input.is_action_just_pressed("reset_scene"):
		get_tree().reload_current_scene()
	move_vec = get_direction()
	characterMover.set_move_vec(move_vec)
	animatedSprite.enable_double_jump(characterMover.double_jump)
	animatedSprite.update_animation(move_vec, characterMover.body_velocity)
	
	
func get_direction():
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -Input.get_action_strength("jump") if is_on_floor() or is_on_wall() and Input.is_action_just_pressed("jump") else 0.0)


func _on_AnimatedSprite_animation_finished():
	#print(animatedSprite.get_animation())
	if animatedSprite.get_animation() == "doublejump":
		animatedSprite.pause_animation(false)
		characterMover.set_jump_ability(false, false)
	if animatedSprite.get_animation() == "hit":
		animatedSprite.pause_animation(false)
		animatedSprite.player_hurt(false)
		hit_delay = false


func _on_HurtBox_area_entered(area):
	if area.damage == 0:
		return
	elif !hit_delay:
		hit_delay = true
		animatedSprite.player_hurt(true)
		Stats.health = area.damage


func change_character():
	create_appearing_effect()
	


#NONE OF THIS IS WORKING RIGHT. THE CAMERA CUTS OUT WHEN THE PLAYER IS QUEUE_FREE AND THEN CUTS IN WHEN PLAYER
#IS ADDED TO THE SCENE. FEEL LIKE THIS HAS TO BE COMPLETELY RETHOUGHT
func add_new_character():
	var player = Stats.character.instance()
	player.global_position = global_position
	queue_free()
	get_parent().add_child(player)
	
	

func create_appearing_effect():
	animatedSprite.visible = false
	effectTimer.start(0.35)
	var effect = AppearingEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
	
	

func create_disappearing_effect():
	var effect = DisappearingEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
	


func player_dead():
	dead = true
	#print("bummer")
	queue_free()


func _on_EffectTimer_timeout():
	add_new_character()
