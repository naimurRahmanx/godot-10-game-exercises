extends Node2D

@export var enemy_scene: PackedScene

@onready var player = $Player
@onready var spawn_timer: Timer = $SpawnTimer

var player_spawn_position: Vector2
var game_over := false

func _ready() -> void:
	randomize()
	player_spawn_position = player.position
	spawn_timer.timeout.connect(_spawn_enemy)

func _spawn_enemy() -> void:
	if game_over:
		return
	
	var enemy: Enemy = enemy_scene.instantiate()
	var screen_size := get_viewport_rect().size
	
	enemy.position = Vector2(
		randf_range(100.0, screen_size.x - 100.0),
		randf_range(100.0, screen_size.y - 100.0)
	)
	
	add_child(enemy)
	enemy.player_hit.connect(_on_game_over)

func _on_game_over() -> void:
	if game_over:
		return
	
	game_over = true
	print("Game Over")
	_reset_game()

func _reset_game() -> void:
	for child in get_children():
		if child is Enemy:
			child.queue_free()
	
	player.position = player_spawn_position
	game_over = false
