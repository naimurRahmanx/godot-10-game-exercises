extends Node

@onready var ui = $"../UI"
@onready var spawner = $"../Spawner"
@onready var spawn_timer: Timer = $"../Spawner/SpawnTimer"

var score := 0.0
var game_speed := 300.0

var is_game_over := false
var is_paused := false


func _process(delta: float) -> void:
	if is_game_over or is_paused:
		return

	# Distance-based score
	score += game_speed * delta
	ui.update_score(score)

	# Difficulty scaling with cap
	if game_speed < 700.0:
		game_speed += 4.0 * delta


func on_player_hit() -> void:

	if is_game_over:
		return

	is_game_over = true
	spawn_timer.stop()

	# Ensure final score is shown
	ui.update_score(score)
	ui.show_game_over(score)
	print("[GAME] Game Over")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

	if is_game_over and event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()


func toggle_pause() -> void:
	if is_game_over:
		return

	is_paused = !is_paused
	get_tree().paused = is_paused

	if is_paused:
		ui.show_pause()
	else:
		ui.hide_pause()

	print("[GAME] Pause:", is_paused)
