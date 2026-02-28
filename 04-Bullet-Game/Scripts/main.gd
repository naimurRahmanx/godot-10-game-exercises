extends Node2D

@export var enemy_scene: PackedScene
@onready var spawn_timer: Timer = $Timer
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var game_over_label: Label = $CanvasLayer/GameOverLabel

var score: int = 0

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	game_over_label.visible = false

func _on_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	var screen_width = get_viewport_rect().size.x
	enemy.position = Vector2(
		randf_range(50, screen_width - 50),
		-50
	)
	
	add_child(enemy)
	
	enemy.enemy_killed.connect(_on_enemy_killed)
	enemy.player_hit.connect(_on_player_hit)

func _on_enemy_killed() -> void:
	score += 1
	score_label.text = "Score: %d" % score

func _on_player_hit() -> void:
	spawn_timer.stop()
	get_tree().paused = true
	game_over_label.visible = true
