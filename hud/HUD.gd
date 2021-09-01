extends CanvasLayer

var fruit_score = load("res://hud/fruitHUD.tscn")
var fruits = [
	"res://assets/Items/Fruits/Apple.png",
	"res://assets/Items/Fruits/Bananas.png",
	"res://assets/Items/Fruits/Cherries.png",
	"res://assets/Items/Fruits/Kiwi.png",
	"res://assets/Items/Fruits/Melon.png",
	"res://assets/Items/Fruits/Orange.png",
	"res://assets/Items/Fruits/Pineapple.png",
	"res://assets/Items/Fruits/Strawberry.png"
]


onready var score = $Scores/Score/Bananas/Number
onready var health = $Health/Health/Label
onready var pauseMenu = $PauseMenu
onready var characterSelect = $CharacterSelect
onready var lives = $Health/Lives/Label
onready var gameOver = $GameOver


var t = true

func _ready():
	Score.connect("score_changed", self, "update_score")
	Stats.connect("health_changed", self, "update_health")
	Stats.connect("lives_changed", self, "update_lives")
	pauseMenu.connect("change_player", self, "show_characters")
	update_health(Stats.health)
	update_lives(Stats.lives)
	gameOver.visible = false
	

func _process(_delta):
	if Input.is_action_just_pressed("pause_menu"):
		pauseMenu.show()
	# SET UP FOR TESTING
#	yield(get_tree().create_timer(2.0), "timeout")
#	if t:
#		print('done')
#		add_fruit_scorekeeper(6, "123")
#		t = false

#func add_fruit_scorekeeper(_fruit_number: int, _score: String) -> void:
#	var scorekeeper = fruit_score.instance()
#	var scorekeeper_children = scorekeeper.get_children()
#	scorekeeper_children[0].texture = load(fruits[_fruit_number])
#	scorekeeper_children[1].text = _score
#	score.add_child(scorekeeper)

func update_health(_value):
	health.text = "Health: " + str(_value)


func update_score(_value):
	score.text = str(_value)
	
func update_lives(_value):
	if _value >= 0:
		lives.text = "Lives Left: " + str(_value)
	elif _value < 0:
		gameOver.visible = true


func _on_Restart_pressed():
	get_tree().reload_current_scene()


func show_characters():
	pauseMenu.hide()
	characterSelect.show()


func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
