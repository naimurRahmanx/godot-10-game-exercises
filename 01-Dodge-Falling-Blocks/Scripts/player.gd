extends CharacterBody2D
# CharacterBody2D is used when you want:
# - velocity
# - move_and_slide()
# - collision support with physics

@export var SPEED := 300.0
# export means: you can edit SPEED from the inspector without changing code

@onready var SPRITE: Sprite2D = $Sprite2D
# onready means: this variable will be assigned AFTER the scene is ready
# $Sprite2D means: get the child node named "Sprite2D"

func _physics_process(delta: float) -> void:
	# _physics_process runs in a fixed physics rate (usually 60 times/sec)
	# Best for movement + collisions
	
	var direction := 0
	# direction will store:
	# -1 = left
	#  0 = no movement
	#  1 = right

	if Input.is_action_pressed("ui_right"):
		direction += 1
		# pressing right adds 1
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		# pressing left subtracts 1

	velocity.x = direction * SPEED
	# velocity means "movement speed per second"
	# move_and_slide() will use this velocity automatically
	
	velocity.y = 0
	# we are not jumping or falling in this game
	# so keep Y movement always 0

	move_and_slide()
	# This is the key method of CharacterBody2D
	# It moves the player using velocity
	# It also handles collisions

	# ------------------------------
	# Screen clamping (keep player inside screen)
	# ------------------------------

	var half_width = SPRITE.texture.get_size().x * SPRITE.scale.x / 2
	# SPRITE.texture.get_size().x = original width in pixels of the image
	# SPRITE.scale.x = how much the sprite is scaled in the editor
	# /2 because we want HALF width (left edge and right edge)

	var screen_width = get_viewport_rect().size.x
	# get_viewport_rect() gives the visible screen rectangle
	# .size.x gives the screen width

	position.x = clamp(position.x, half_width, screen_width - half_width)
	# clamp keeps position.x between:
	# minimum = half_width
	# maximum = screen_width - half_width
	#
	# so the player cannot go outside the screen
