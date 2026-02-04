extends Node2D

@export var block_scene: PackedScene
@onready var spawn_timer: Timer = $SpawnTimer

func _on_timer_timeout():
	var block = block_scene.instantiate()

	var screen_width = get_viewport_rect().size.x
	block.position.x = randf_range(0, screen_width)
	block.position.y = -50

	add_child(block)

	block.hit_player.connect(_on_game_over)

func _on_game_over():
	spawn_timer.stop()
	get_tree().paused = true
	print("Game Over!")
