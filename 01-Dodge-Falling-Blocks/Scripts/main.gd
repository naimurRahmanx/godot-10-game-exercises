extends Node2D
# Node2D is good for a main controller script

@export var block_scene: PackedScene
# PackedScene means: a scene file (.tscn)
# You will drag your Block.tscn into this in the inspector

@onready var spawn_timer: Timer = $SpawnTimer
# Get the Timer node from this scene

func _ready() -> void:
	# _ready runs once when the scene starts

	spawn_timer.start()
	# Starts the timer
	# After its wait time finishes, timeout signal happens

func _on_spawn_timer_timeout() -> void:
	# This function runs every time the timer finishes.
	# Example: if timer wait_time = 1 second
	# then this runs every 1 second.

	var block = block_scene.instantiate()
	# Create a new instance of Block.tscn
	# block is now a real object

	var screen_width = get_viewport_rect().size.x
	# Get screen width

	block.position.x = randf_range(0, screen_width)
	# Spawn block at random x position across the screen

	block.position.y = -50
	# Spawn block above the screen
	# so it falls into view

	add_child(block)
	# VERY IMPORTANT:
	# Until you add_child, the block will not appear in the game.
	# It exists only in memory.

	# ------------------------------
	# Signal connection
	# ------------------------------

	block.hit_player.connect(_on_game_over)
	# This means:
	# When block emits hit_player,
	# call _on_game_over() in this script.

func _on_game_over() -> void:
	# Runs when any block touches the player

	spawn_timer.stop()
	# Stop spawning new blocks

	get_tree().paused = true
	# Pause the whole game:
	# - player movement stops
	# - blocks stop falling
	# - everything freezes

	print("Game Over!")
	# Print in output for debugging
