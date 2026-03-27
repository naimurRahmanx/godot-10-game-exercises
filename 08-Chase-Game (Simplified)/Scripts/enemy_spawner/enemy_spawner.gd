extends Node2D

@export var enemy_scene : PackedScene

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	enemy.global_position = Vector2(
		randf_range(100, 600),
		randf_range(100, 500)
	)
	
	get_tree().current_scene.add_child(enemy)
