extends Node

signal health_changed(value)
signal lives_changed
signal player_dead
signal character_changed
signal game_over

enum characters {
	MASKDUDE,
	NINJAFROG,
	PINKMAN,
	VIRTUALGUY
}


var health: int = 4 setget health_changed
var character = characters.MASKDUDE setget character_changed
var lives: int = 3 setget lives_changed

func _ready():
	set_lives(lives)

func set_health(_health: int):
	health = _health
	emit_signal("health_changed", health)

func set_lives(_lives: int):
	lives = _lives
	emit_signal("lives_changed", lives)

func lives_changed(_value: int):
	lives -= _value
	emit_signal("lives_changed", lives)
	if lives < 0:
		lives = 0
		emit_signal("game_over")
		

func health_changed(_value: int):
	health -= _value
	emit_signal("health_changed", health)
	if health < 1 and lives == 0:
		emit_signal("game_over")
	elif health < 1 and lives > 0:
		emit_signal("player_dead")

func character_changed(_character: String):
	match _character:
		"pink_man":
			character = characters.PINKMAN
		"ninja_frog":
			character = characters.NINJAFROG
		"masked_dude":
			character = characters.MASKDUDE
		"virtual_guy":
			character = characters.VIRTUALGUY
	emit_signal("character_changed")
