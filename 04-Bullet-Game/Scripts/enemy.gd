extends Area2D

signal enemy_killed
signal player_hit

@export var speed: float = 200.0
var cleanup_margin: float = 100.0

func _ready():
	add_to_group("enemy")

func _process(delta: float) -> void:
	position.y += speed * delta
	
	if global_position.y > get_viewport_rect().size.y + cleanup_margin:
		queue_free()

func die():
	enemy_killed.emit()
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_hit.emit()
