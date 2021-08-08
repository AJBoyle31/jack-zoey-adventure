extends KinematicBody2D

var chain = preload("res://traps/ChainPiece.tscn")
var velocity: = Vector2.ZERO
var move_vec: = Vector2.ZERO
var block_position

export var rotating_float: float = 0.01
export var chain_length: int = 3
export var rotation_limit: float = 1

onready var parent = get_parent()
onready var spike = $Spike
onready var spikeCollision = $spikeCollision


func _ready():
	block_position = parent.get_node("SpikeBlock").global_position
	global_position = block_position
	add_chain()

func _physics_process(delta):
	rotate(rotating_float)
	if get_rotation() > rotation_limit or get_rotation() < -rotation_limit:
		rotating_float *= -1

func add_chain():
	for _x in range(chain_length):
		var chain_instance = chain.instance()
		#parent.get_node("SpikeBall").call_deferred("add_child", chain_instance)
		parent.get_node("SpikeBall").add_child(chain_instance)
		chain_instance.global_position.y -= _x * -12
		if _x == chain_length - 1:
			spike.global_position.y -= ((_x + 1) * -12) - 6
			spikeCollision.global_position.y = spike.global_position.y 
		
		
		
