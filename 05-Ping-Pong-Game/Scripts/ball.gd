extends CharacterBody2D

signal goal_scored(side: String)

@export var speed: float = 500.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	serve()

func serve() -> void:
	randomize()

	var x := 1.0
	if randf() < 0.5:
		x = -1.0

	var y := randf_range(-0.6, 0.6)

	direction = Vector2(x, y).normalized()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)

	if collision:
		var collider = collision.get_collider()

		# Goal detection
		if collider != null and collider.name == "left_wall":
			emit_signal("goal_scored", "enemy")
			return

		if collider != null and collider.name == "right_wall":
			emit_signal("goal_scored", "player")
			return

		# Bounce on everything else (walls, paddles)
		direction = direction.bounce(collision.get_normal()).normalized()
