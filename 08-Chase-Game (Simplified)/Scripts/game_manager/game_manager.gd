extends Node

var score : int = 0
signal score_changed(new_score)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("game_manager")


func add_score(amount : int):
	score += amount
	print("score: ", score)
	score_changed.emit(score)
