
Copy

extends CharacterBody2D

# ─────────────────────────────────────────
#  SETTINGS  (edit these in the Inspector)
# ─────────────────────────────────────────

@export var jump_force        := -550.0   # how high the player jumps (negative = up)
@export var gravity           := 1000.0   # how fast the player falls
@export var jump_cut_multiplier := 0.5    # releasing jump early makes the jump shorter
@export var fall_multiplier   := 1.8      # falling is faster than rising


# ─────────────────────────────────────────
#  JUMP POLISH TIMERS
# ─────────────────────────────────────────

# Coyote time: lets you jump a tiny moment AFTER walking off a ledge
var coyote_time  := 0.15
var coyote_timer := 0.0

# Jump buffer: remembers your jump press if you press JUST before landing
var jump_buffer_time  := 0.15
var jump_buffer_timer := 0.0


# ─────────────────────────────────────────
#  JUICE (squash & stretch) VARIABLES
# ─────────────────────────────────────────

var was_on_floor  := false   # did we touch the floor last frame?
var landing_timer := 0.0     # cooldown so the squash only plays once per landing


# ════════════════════════════════════════════════════════
#  MAIN LOOP  –  runs every frame
# ════════════════════════════════════════════════════════
func _physics_process(delta: float) -> void:

	# ── CORE: Gravity ──────────────────────────────────
	if not is_on_floor():
		if velocity.y > 0:
			# falling down → apply extra gravity so it feels snappier
			velocity.y += gravity * fall_multiplier * delta
		else:
			# rising up → apply normal gravity
			velocity.y += gravity * delta


	# ── POLISH: Coyote timer ───────────────────────────
	# While on the floor: keep the timer full.
	# Once in the air: count it down to zero.
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta


	# ── POLISH: Jump buffer ────────────────────────────
	# Pressed jump? Start the buffer countdown.
	# Otherwise: keep counting it down.
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta


	# ── CORE: Execute the jump ─────────────────────────
	# Jump only when BOTH the buffer AND coyote timer are still active.
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y       = jump_force   # launch upward
		jump_buffer_timer = 0.0         # consume the buffer
		coyote_timer      = 0.0         # consume the coyote window
		print("[PLAYER] Jump executed")


	# ── CORE: Variable jump height ─────────────────────
	# Released jump while still going up? Cut speed in half → shorter hop.
	if Input.is_action_just_released("ui_accept") and velocity.y < 0.0:
		velocity.y *= jump_cut_multiplier


	# ── CORE: Move the character ───────────────────────
	move_and_slide()


	# ── JUICE: Detect landing ──────────────────────────
	# Trigger squash only on the FIRST frame we touch the floor.
	landing_timer -= delta
	if not was_on_floor and is_on_floor() and landing_timer <= 0.0:
		on_landed()
	was_on_floor = is_on_floor()   # remember this frame for next frame


	# ── JUICE: Smooth scale recovery ───────────────────
	# lerp slowly brings scale.y back to 1.0 (normal height) each frame.
	scale.y = lerp(scale.y, 1.0, 8.0 * delta)


# ════════════════════════════════════════════════════════
#  JUICE FUNCTION  –  called once every time we land
# ════════════════════════════════════════════════════════
func on_landed() -> void:
	scale.y       = 0.75   # squash the sprite downward instantly
	landing_timer = 0.15   # set cooldown so this doesn't fire twice