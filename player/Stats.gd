extends Node

signal health_changed(value)
signal player_dead
signal character_changed


#const Pink_man = preload("res://player/Characters/PinkMan.tscn")
#const Ninja_frog = preload("res://player/Characters/NinjaFrog.tscn")
#const Masked_dude = preload("res://player/Characters/MaskedDude.tscn")
#const Virtual_guy = preload("res://player/Characters/VirtualGuy.tscn")

enum characters {
	MASKDUDE,
	NINJAFROG,
	PINKMAN,
	VIRTUALGUY
}


export var health: int = 4 setget health_changed
var character = characters.MASKDUDE setget character_changed

func _ready():
	pass

func set_health(_health: int):
	health = _health
	emit_signal("health_changed", health)

func health_changed(_value: int):
	health -= _value
	emit_signal("health_changed", health)
#	print('ouch')
#	print(health)
	if health < 1:
		print("dead :( ")
		emit_signal("player_dead")

func character_changed(_character: String):
	match _character:
		"pink_man":
			#character = Pink_man
			character = characters.PINKMAN
		"ninja_frog":
			#character = Ninja_frog
			character = characters.NINJAFROG
		"masked_dude":
			#character = Masked_dude
			character = characters.MASKDUDE
		"virtual_guy":
			#character = Virtual_guy
			character = characters.VIRTUALGUY
	emit_signal("character_changed")
