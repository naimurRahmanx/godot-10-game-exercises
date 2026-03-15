extends Node2D
@onready var player = $player
@onready var destination = $Destination
@onready var game_win_panel = $GameOverCanvas
var spawn_pos:Vector2 = Vector2.ZERO

func _ready() -> void:
	spawn_pos = player.position
	game_win_panel.visible = false
	destination.player_hit.connect(_destination_reached)

func _process(delta: float) -> void:
	if player.position.y > 450:
		player.position = spawn_pos
	
	
		
func _destination_reached():
	get_tree().paused = true
	game_win_panel.visible = true
	
func _restart_game():
	get_tree().paused = false		
	game_win_panel.visible = false
	get_tree().reload_current_scene()
