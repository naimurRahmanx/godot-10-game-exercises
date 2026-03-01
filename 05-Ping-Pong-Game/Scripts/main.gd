extends Node2D

@onready var player := $player
@onready var enemy := $enemy
@onready var ball := $ball

@onready var player_score_label := $UI/PlayerScore
@onready var enemy_score_label := $UI/EnemyScore

var player_score: int = 0
var enemy_score: int = 0

func _ready() -> void:
	ball.goal_scored.connect(_on_goal_scored)
	_update_ui()
	_reset_round()

func _on_goal_scored(side: String) -> void:
	if side == "player":
		player_score += 1
	else:
		enemy_score += 1

	_update_ui()
	_reset_round()

func _update_ui() -> void:
	player_score_label.text = "Player: " + str(player_score)
	enemy_score_label.text = "Enemy: " + str(enemy_score)

func _reset_round() -> void:
	# Put paddles near center vertically
	var screen := get_viewport_rect().size

	player.global_position = Vector2(60, screen.y * 0.5)
	enemy.global_position = Vector2(screen.x - 60, screen.y * 0.5)

	# Ball in center
	ball.global_position = screen * 0.5
	ball.serve()
