extends Node

const SPAWN_X := 900.0
const MIN_SPAWN_DISTANCE_X := 650.0
const MIN_SPAWN_Y := 400.0
const MAX_SPAWN_Y := 420.0

@onready var obstacle_scene: PackedScene = preload("res://Scenes/obstacle.tscn")
@onready var manager = $"../GameManager"
@onready var spawn_timer: Timer = $SpawnTimer

var last_obstacle: Area2D = null
var obstacle_pool: Array[Area2D] = []


func _ready() -> void:
	randomize()


func _on_spawn_timer_timeout() -> void:
	if manager.is_game_over:
		return

	spawn_obstacle()

	# Random spawn timing
	spawn_timer.wait_time = randf_range(1.0, 2.2)
	print("[SPAWNER] Next spawn in:", spawn_timer.wait_time)


func spawn_obstacle() -> void:

	if last_obstacle != null and is_instance_valid(last_obstacle):
		if last_obstacle.visible and last_obstacle.position.x > MIN_SPAWN_DISTANCE_X:
			return

	var obstacle: Area2D = get_obstacle()

	var spawn_position: Vector2 = Vector2(
		SPAWN_X,
		randf_range(MIN_SPAWN_Y, MAX_SPAWN_Y)
	)

	var obstacle_speed: float = manager.game_speed + randf_range(-30.0, 30.0)

	obstacle.activate(spawn_position, obstacle_speed)

	get_tree().current_scene.add_child(obstacle)

	last_obstacle = obstacle


func get_obstacle() -> Area2D:
	if obstacle_pool.size() > 0:
		var reused: Area2D = obstacle_pool.pop_back()
		print("[SPAWNER] Reusing pooled obstacle")
		return reused

	var obstacle: Area2D = obstacle_scene.instantiate()

	# Connect once when first created
	obstacle.player_hit.connect(manager.on_player_hit)
	obstacle.returned_to_pool.connect(_on_obstacle_returned_to_pool)

	print("[SPAWNER] Created new obstacle")
	return obstacle


func _on_obstacle_returned_to_pool(obstacle: Area2D) -> void:
	# Remove from scene tree if still attached
	if obstacle.get_parent() != null:
		obstacle.get_parent().remove_child(obstacle)

	obstacle_pool.append(obstacle)
	print("[SPAWNER] Obstacle returned to pool. Pool size:", obstacle_pool.size())
