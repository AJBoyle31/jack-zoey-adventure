extends Node

signal score_changed(value)

var score = 0 setget update_score


func update_score(_score):
	score += _score
	emit_signal("score_changed", score)


