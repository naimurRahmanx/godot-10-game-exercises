extends CharacterBody2D


const SPEED = 500.0

func _physics_process(delta: float) -> void:
	var direction := 0
	
	if Input.get_action_strength("move_up"):
		direction -= 1
	if Input.get_action_strength("move_down"):
		direction += 1
		
	velocity.y = direction * SPEED 
	velocity.x = 0

	move_and_slide()
