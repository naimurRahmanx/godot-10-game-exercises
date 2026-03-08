extends Node2D

var debug_enabled := true
var spawn_position := Vector2(900.0, 400.0)


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	if not debug_enabled:
		return

	# Spawn point
	draw_circle(spawn_position, 8.0, Color.RED)

	# Spawn zone
	draw_rect(
		Rect2(spawn_position.x - 20.0, spawn_position.y - 60.0, 40.0, 120.0),
		Color(1, 0, 0, 0.3)
	)

	# Minimum spacing line
	draw_line(
		Vector2(650.0, 0.0),
		Vector2(650.0, 800.0),
		Color.YELLOW,
		2.0
	)

	# Optional player marker
	var player := get_parent().get_node_or_null("Player")
	if player != null:
		draw_circle(player.global_position, 20.0, Color.GREEN)
