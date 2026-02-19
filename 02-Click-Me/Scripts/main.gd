extends Control

var score := 0

func _ready():
	update_score_label()

func _on_click_button_pressed():
	score += 1
	update_score_label()

func update_score_label():
	$Layout/ScoreLabel.text = "Score: %d" % score
