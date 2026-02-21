extends CharacterBody2D
class_name Enemy

signal player_hit

@export var speed: float = 200.0

var direction: Vector2
var has_hit_player := false

func _ready() -> void:
	direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

func _physics_process(delta: float) -> void:
	if has_hit_player:
		return
	
	var collision = move_and_collide(direction * speed * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		# Player collision
		if collider.name == "Player":
			has_hit_player = true
			emit_signal("player_hit")
			return
		
		# Bounce on walls (or anything else solid)
		direction = direction.bounce(collision.get_normal()).normalized()
