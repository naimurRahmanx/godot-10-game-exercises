extends CharacterBody2D

# ─────────────────────────────────────────
# SETTINGS (editable in Inspector)
# ─────────────────────────────────────────

@export var jump_force := -550.0
@export var gravity := 1000.0
@export var jump_cut_multiplier := 0.5
@export var fall_multiplier := 1.8

@export var move_speed := 300.0
@export var acceleration := 2000.0
@export var friction := 2000.0
@export var air_control := 0.6


# ─────────────────────────────────────────
# JUMP POLISH TIMERS
# ─────────────────────────────────────────

var coyote_time := 0.15
var coyote_timer := 0.0

var jump_buffer_time := 0.15
var jump_buffer_timer := 0.0


# ─────────────────────────────────────────
# JUICE VARIABLES
# ─────────────────────────────────────────

var was_on_floor := false
var landing_timer := 0.0
var is_squashing := false


# ═══════════════════════════════════════════════
# MAIN LOOP
# ═══════════════════════════════════════════════
func _physics_process(delta: float) -> void:

	# ─────────────────────────────────
	# GRAVITY
	# ─────────────────────────────────
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += gravity * fall_multiplier * delta
		else:
			velocity.y += gravity * delta


	# ─────────────────────────────────
	# HORIZONTAL MOVEMENT
	# ─────────────────────────────────
	var direction := Input.get_axis("ui_left", "ui_right")

	var accel_factor := air_control if not is_on_floor() else 1.0

	if direction != 0.0:
		velocity.x = move_toward(velocity.x, direction * move_speed, acceleration * accel_factor * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * accel_factor * delta)


	# ─────────────────────────────────
	# COYOTE TIMER
	# ─────────────────────────────────
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta


	# ─────────────────────────────────
	# JUMP BUFFER
	# ─────────────────────────────────
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta


	# ─────────────────────────────────
	# EXECUTE JUMP
	# ─────────────────────────────────
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y = jump_force
		jump_buffer_timer = 0.0
		coyote_timer = 0.0

		# stretch upward on jump
		scale.y = 1.3
		is_squashing = true


	# ─────────────────────────────────
	# VARIABLE JUMP HEIGHT
	# ─────────────────────────────────
	if Input.is_action_just_released("ui_accept") and velocity.y < 0.0:
		velocity.y *= jump_cut_multiplier


	# ─────────────────────────────────
	# MOVE PLAYER
	# ─────────────────────────────────
	move_and_slide()


	# ─────────────────────────────────
	# LANDING DETECTION
	# ─────────────────────────────────
	landing_timer -= delta

	if not was_on_floor and is_on_floor() and landing_timer <= 0.0:
		on_landed()

	was_on_floor = is_on_floor()


	# ─────────────────────────────────
	# SCALE RECOVERY
	# ─────────────────────────────────
	if is_squashing:
		scale.y = lerp(scale.y, 1.0, 8.0 * delta)

		if abs(scale.y - 1.0) < 0.01:
			scale.y = 1.0
			is_squashing = false


# ═══════════════════════════════════════════════
# LANDING EFFECT
# ═══════════════════════════════════════════════
func on_landed() -> void:
	scale.y = 0.75
	landing_timer = 0.15
	is_squashing = true
