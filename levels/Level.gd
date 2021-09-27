extends Node2D

class_name Level


#var player = preload("res://player/Player.tscn")
var camera_zoom = Vector2(0.1,0.1)
var is_game_over: bool = false

onready var start = $Checkpoints/Start
onready var finish = $Checkpoints/Finish
onready var levelCamera = $LevelCamera
onready var cameraDelayTimer = $CameraDelayTimer
onready var spawnDelayTimer = $SpawnDelayTimer
onready var player = $Player

func _ready():
	Stats.connect("player_dead", self, "player_dead")
	Stats.connect("game_over", self, "game_over")
	player.start_position = Vector2(start.global_position.x + 11, start.global_position.y + 5)
	player.global_position = Vector2(start.global_position.x + 11, start.global_position.y + 5)
	print("start position: " + str(Vector2(start.global_position.x + 11, start.global_position.y + 5)))
	
	

func _process(_delta):
	if is_game_over:
		if camera_zoom < Vector2(1.5, 1.5):
			camera_zoom += Vector2(0.01, 0.01)
		levelCamera.set_zoom(camera_zoom)


func spawn_player():
	pass


func player_dead():
	pass

	

func game_over():
	print('game over')
	cameraDelayTimer.start(0.3)
	


func _on_SpawnDelayTimer_timeout():
	spawn_player()


func _on_CameraDelayTimer_timeout():
	levelCamera.make_current()
	levelCamera.position = Vector2(300, 300)
	is_game_over = true
