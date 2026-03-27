extends Node2D
@export var SPEED :float = 400.0
var direction : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	position += direction * SPEED * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("_take_damage"):
			body._take_damage(10)
	
	queue_free()
