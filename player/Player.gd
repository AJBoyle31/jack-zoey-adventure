extends KinematicBody2D

class_name Player

var move_vec: Vector2 = Vector2.ZERO
var is_jump_interrupted: bool
var dead: bool = false
var hit_delay: bool = false

onready var animatedSprite = $AnimatedSprite
onready var characterMover = $CharacterMover


func _ready():
	characterMover.set_body_to_move(self)
	animatedSprite.set_body_to_animate(self)
	Stats.connect("player_dead", self, "player_dead")
	

func _physics_process(delta):
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

func player_dead():
	dead = true
	#print("bummer")
	queue_free()
