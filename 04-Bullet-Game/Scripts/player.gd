extends CharacterBody2D

@export var speed: float = 400.0
@export var bullet_scene: PackedScene
@export var shoot_cooldown: float = 0.3

var can_shoot: bool = true

func _physics_process(delta: float) -> void:
	var direction := 0
	
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1
	
	velocity.x = direction * speed
	move_and_slide()
	
	clamp_to_screen()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_parent().add_child(bullet)
	
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

func clamp_to_screen():
	var screen_width = get_viewport_rect().size.x
	position.x = clamp(position.x, 0, screen_width)
