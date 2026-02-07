extends Area2D
# Area2D is used for detection (signals like body_entered)
# It is NOT used for physics movement like CharacterBody2D

@export var fall_speed := 800.0
# block falling speed (editable from inspector)

signal hit_player
# This is a custom signal.
# It means: "I touched the player!"

func _process(delta: float) -> void:
	# _process runs every frame (not fixed)
	# This is fine because block is just moving straight down

	position.y += fall_speed * delta
	# delta makes movement consistent:
	# - 30 FPS
	# - 60 FPS
	# - 144 FPS
	# It will fall same distance per second in all cases.

	# OPTIONAL: delete block if it goes out of screen (recommended)
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()
		# queue_free removes this block from memory
		# prevents your game from becoming slow later

func _on_body_entered(body: Node) -> void:
	# This function runs when ANY physics body enters this Area2D.
	# It works only if:
	# - the signal body_entered is connected to this method

	if body.name == "Player":
		# If the thing that entered is the Player

		emit_signal("hit_player")
		# Emit (send) the signal.
		# Main scene will listen to this.
