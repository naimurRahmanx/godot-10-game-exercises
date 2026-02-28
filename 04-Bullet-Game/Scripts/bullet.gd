extends Area2D

@export var speed: float = 600.0
var velocity: Vector2
var cleanup_margin: float = 50.0

func _ready():
	velocity = Vector2.UP * speed

func _process(delta: float) -> void:
	position += velocity * delta
	
	if global_position.y < -cleanup_margin:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.die()
		queue_free()
