extends CharacterBody2D


const SPEED = 300.0
@onready var ball : CharacterBody2D = get_parent().get_node("ball")


func _physics_process(delta: float) -> void:
	if ball == null:
		return
		
	var dir := 0.0
	if ball.position.y > position.y + 10:
		dir = 1.0
	elif ball.position.y < position.y - 10:
		dir = -1.0
	else:
		dir = 0.0
		
	velocity = Vector2(0, dir * SPEED)

	move_and_slide()
