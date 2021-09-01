extends PopupMenu

signal change_player


func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_pressed("pause_menu"):
		get_tree().set_pause(true)



func _on_Close_pressed():
	hide()
	get_tree().set_pause(false)


func _on_Change_pressed():
	emit_signal("change_player")
