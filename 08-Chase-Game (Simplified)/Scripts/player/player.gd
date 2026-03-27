extends CharacterBody2D
@onready var gun_pivot := $Marker2D
@onready var shoot_timer := $ShootTimer
@export var bullet_scene : PackedScene
const SPEED = 300.0
var gun_facing_dir : Vector2 = Vector2.RIGHT
@export var player_life := 30

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	var player_input_dir = _get_dir()
	velocity = player_input_dir * SPEED
	
	if player_input_dir != Vector2.ZERO:
		gun_facing_dir = player_input_dir
		
	if Input.get_action_strength("shoot") and shoot_timer.is_stopped():
		_shoot()
		
	move_and_slide()
	_update_gun_pivot()
	

func _get_dir():
	var direction : Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	return direction.normalized()

func _update_gun_pivot():
	gun_pivot.position = gun_facing_dir * 90.0
	# This makes the gun sprite look in the direction of movement
	gun_pivot.rotation = gun_facing_dir.angle()

func _shoot():
	var bullet = bullet_scene.instantiate()
	# 3. Add to the scene tree
	get_tree().current_scene.add_child(bullet)
	# 1. Set the bullet's position to the Marker2D's global position
	var muzzle_offset := 50
	bullet.global_position = gun_pivot.global_position + (gun_facing_dir * muzzle_offset)
	# 2. Use your gun_facing_dir for the bullet's travel direction
	bullet.direction = gun_facing_dir
	
	shoot_timer.start()

func _take_damage(amount):
	player_life -= amount
	print("[Player] player life: ", player_life)
	if player_life <= 0:
		_die()
		
func _die():
	print("game over!")
	get_tree().paused = true
	
