extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var pause_panel: Control = $PausePanel
@onready var game_over_panel: Control = $GameOverPanel
@onready var final_score_label: Label = $GameOverPanel/FinalScoreLabel


func _ready() -> void:
	pause_panel.visible = false
	game_over_panel.visible = false
	score_label.visible = true
	update_score(0)


func update_score(score: float) -> void:
	score_label.text = "Score: " + str(int(score))


func show_pause() -> void:
	pause_panel.visible = true


func hide_pause() -> void:
	pause_panel.visible = false


func show_game_over(score: float) -> void:
	game_over_panel.visible = true
	pause_panel.visible = false
	score_label.visible = false
	final_score_label.text = "Score: " + str(int(score))
