extends PopupPanel



#I GUESS THIS SHOULD CONNECT TO THE PLAYER STATS AUTOLOAD OR MAKE A NEW AUTOLOAD TO SET THE CURRENT PLAYER
#WOULD THEN USE A SIGNAL TO CHANGE THE PLAYER? I GUESS IT COULD LOOK FOR THE NODE.NAME FOR ONE OF THE FOUR AND THEN 
#REPLACE IT WITH THE NEW CHARACTER?

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
#	if Input.is_action_just_pressed("pause_menu"):
#		show()


func _on_VirtualGuy_pressed():
	change_character("virtual_guy")

func _on_PinkMan_pressed():
	change_character("pink_man")

func _on_NinjaFrog_pressed():
	change_character("ninja_frog")

func _on_MaskedDude_pressed():
	change_character("masked_dude")


func change_character(_character):
	hide()
	Stats.character = _character
