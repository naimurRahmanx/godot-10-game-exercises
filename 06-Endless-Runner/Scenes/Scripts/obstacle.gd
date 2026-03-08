extends Area2D

signal player_hit
signal returned_to_pool(obstacle: Area2D)

@export var speed := 300.0

var pooled := false


func _process(delta: float) -> void:
	position.x -= speed * delta

	# Off-screen -> return to pool instead of queue_free()
	if position.x < -150.0:
		return_to_pool()


func _on_body_entered(body: Node) -> void:
	print("[OBSTACLE] collided with:", body.name)

	if body.is_in_group("player"):
		player_hit.emit()


func activate(start_position: Vector2, new_speed: float) -> void:
	position = start_position
	speed = new_speed
	visible = true
	monitoring = true
	monitorable = true
	set_process(true)
	pooled = false


func return_to_pool() -> void:
	if pooled:
		return

	pooled = true
	visible = false
	monitoring = false
	monitorable = false
	set_process(false)

	returned_to_pool.emit(self)
