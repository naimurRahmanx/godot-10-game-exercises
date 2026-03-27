extends Control
@onready var health_label = $HealthLabel
@onready var score_label = $ScoreLabel
@onready var game_over_label = $GameOverLabel
var player
var gm
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	gm = get_tree().get_first_node_in_group("game_manager")
	_update_score(0)
	
	if gm:
		gm.score_changed.connect(_update_score)

	game_over_label.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = "Health: " + str(player.player_life)
	
	if player and player.player_life <= 0:
		game_over_label.visible = true
		
	#restart
	if Input.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()

func _update_score(new_score):
	score_label.text = "Score: " + str(new_score)
