extends Node

signal health_changed(value)
signal player_dead

export var health: int = 4 setget health_changed

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
