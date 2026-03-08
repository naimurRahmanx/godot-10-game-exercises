extends CharacterBody2D

# ─────────────────────────────────────────
# SETTINGS (editable in Inspector)
# ─────────────────────────────────────────

@export var jump_force := -550.0   
# negative because in Godot Y axis goes DOWN.
# So negative velocity means moving UP.

@export var gravity := 1000.0      
# constant force pulling the player down.

@export var jump_cut_multiplier := 0.5
# when player releases jump early, we multiply the upward velocity
# by this value to reduce the jump height (short hop).

@export var fall_multiplier := 1.8
# falling faster than rising makes jumps feel better in platformers.


# ─────────────────────────────────────────
# JUMP POLISH TIMERS
# ─────────────────────────────────────────

# COYOTE TIME -> Just stepped of a platform/floor
# small grace time after leaving the floor where jumping is still allowed
var coyote_time := 0.15
var coyote_timer := 0.0

# JUMP BUFFER -> Recently pressed jump
# remembers jump input if player presses jump just before landing
var jump_buffer_time := 0.15
var jump_buffer_timer := 0.0


# ─────────────────────────────────────────
# JUICE VARIABLES (for animation polish)
# ─────────────────────────────────────────

var was_on_floor := false
# stores if player was on the floor in the PREVIOUS frame
# used to detect the exact moment of landing

var landing_timer := 0.0
# cooldown so landing squash effect only happens once


# ═══════════════════════════════════════════════
# MAIN LOOP – runs every physics frame
# ═══════════════════════════════════════════════
func _physics_process(delta: float) -> void:

	# ─────────────────────────────────
	# GRAVITY
	# ─────────────────────────────────
	if not is_on_floor():

		# velocity.y > 0 means falling
		# because Y increases downward in Godot
		if velocity.y > 0:
			# apply extra gravity while falling
			velocity.y += gravity * fall_multiplier * delta
		else:
			# normal gravity while going up
			velocity.y += gravity * delta


	# ─────────────────────────────────
	# COYOTE TIMER
	# ─────────────────────────────────
	# If player is on the floor:
	# reset timer to full value
	if is_on_floor():
		coyote_timer = coyote_time

	else:
		# if player walked off a ledge
		# timer counts down toward zero
		coyote_timer -= delta


	# ─────────────────────────────────
	# JUMP BUFFER
	# ─────────────────────────────────
	# If jump button is pressed
	# remember the input for a short time
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer_time

	else:
		# if jump wasn't pressed
		# the memory slowly expires
		jump_buffer_timer -= delta


	# ─────────────────────────────────
	# EXECUTE JUMP
	# ─────────────────────────────────
	# Jump only if BOTH conditions are true:
	# 1) player recently pressed jump
	# 2) player is on floor OR just left floor (coyote time)

	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:

		velocity.y = jump_force
		# apply upward velocity

		jump_buffer_timer = 0.0
		# consume the buffered jump input

		coyote_timer = 0.0
		# consume the coyote time so we don't jump again


	# ─────────────────────────────────
	# VARIABLE JUMP HEIGHT
	# ─────────────────────────────────
	# If player releases jump button while still rising
	# we cut the upward velocity

	if Input.is_action_just_released("ui_accept") and velocity.y < 0.0:

		velocity.y *= jump_cut_multiplier
		# reduces upward speed
		# result: shorter jump


	# ─────────────────────────────────
	# MOVE PLAYER
	# ─────────────────────────────────
	# uses velocity and handles collisions automatically
	move_and_slide()


	# ─────────────────────────────────
	# LANDING DETECTION
	# ─────────────────────────────────

	landing_timer -= delta
	# countdown every frame

	if not was_on_floor and is_on_floor() and landing_timer <= 0.0:
		# this means:
		# last frame = in air
		# this frame = touching floor
		# so we JUST landed

		on_landed()

	# store current floor state for next frame
	was_on_floor = is_on_floor()


	# ─────────────────────────────────
	# SCALE RECOVERY
	# ─────────────────────────────────
	# after squash, smoothly return to normal size

	scale.y = lerp(scale.y, 1.0, 8.0 * delta)

	# lerp explanation:
	# 1st value = current value
	# 2nd value = target value
	# 3rd value = speed of interpolation


# ═══════════════════════════════════════════════
# LANDING EFFECT
# ═══════════════════════════════════════════════
func on_landed() -> void:

	scale.y = 0.75
	# squash the player vertically

	landing_timer = 0.15
	# cooldown so landing effect doesn't repeat immediately