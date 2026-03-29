extends Area2D

@export var speed: float = 600.0
@export var lifetime: float = 1.5

var direction: Vector2 = Vector2.ZERO
var active: bool = false
var life_timer: float = 0.0



func _physics_process(delta):

	if not active:
		return

	position += direction * speed * delta

	life_timer += delta

	if life_timer >= lifetime:
		deactivate()

func _on_body_entered(body):
	if not active:
		return
	
	if body.is_in_group("player"):
		return
	
	# 1. Check for the method first
	if body.has_method("_take_damage"):
		body._take_damage(10)
	
	# 2. Deactivate AFTER calling the damage function
	deactivate()

func activate(pos: Vector2, dir: Vector2):
	var offset_distance = 80
	global_position = pos + dir.normalized() * offset_distance

	direction = dir.normalized()
	
	# Reset state
	active = true
	visible = true
	life_timer = 0.0
	
	# Enable physics immediately
	set_physics_process(true)
	monitoring = true 
	monitorable = true


func deactivate():
	active = false
	visible = false
	set_physics_process(false)
	
	# Use set_deferred for both to be safe during collisions
	set_deferred("monitoring", false) 
	set_deferred("monitorable", false)
