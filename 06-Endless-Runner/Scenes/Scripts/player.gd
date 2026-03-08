extends CharacterBody2D

@export var jump_force := -550.0
@export var gravity := 1000.0
@export var jump_cut_multiplier := 0.5
@export var fall_multiplier := 1.8

# Jump polish
var coyote_time := 0.15
var coyote_timer := 0.0

var jump_buffer_time := 0.15
var jump_buffer_timer := 0.0

# Landing detection
var was_on_floor := false
var landing_timer := 0.0


func _physics_process(delta: float) -> void:

	landing_timer -= delta

	# Gravity
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += gravity * fall_multiplier * delta
		else:
			velocity.y += gravity * delta

	# Coyote time
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

	# Jump buffer
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta

	# Execute jump
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y = jump_force
		jump_buffer_timer = 0.0
		coyote_timer = 0.0
		print("[PLAYER] Jump executed")

	# Variable jump height
	if Input.is_action_just_released("ui_accept") and velocity.y < 0.0:
		velocity.y *= jump_cut_multiplier

	move_and_slide()

	# Detect landing (only once)
	if not was_on_floor and is_on_floor() and landing_timer <= 0.0:
		on_landed()

	was_on_floor = is_on_floor()

	# Smooth scale recovery
	scale.y = lerp(scale.y, 1.0, 8.0 * delta)


func on_landed() -> void:
	scale.y = 0.75
	landing_timer = 0.15
