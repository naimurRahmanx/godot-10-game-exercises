extends CharacterBody2D
@export var max_health := 30
@export var speed := 80
@export var damage := 10
var attack_range := 140
var can_attack :bool = true
var health: int
var player 
enum State {
	CHASE,
	ATTACK
}
var state: State = State.CHASE
@onready var attack_timer := $AttackTimer

func _ready() -> void:
	add_to_group('enemy')
	health = max_health
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(_delta):

	if player == null:
		return

	var distance = global_position.distance_to(player.global_position)

	match state:

		State.CHASE:
			update_chase(distance)

		State.ATTACK:
			update_attack(distance)

	move_and_slide()
	
func update_chase(distance):

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed

	if distance < attack_range:
		state = State.ATTACK


func update_attack(distance):

	velocity = Vector2.ZERO

	if can_attack:
		_attack()

	if distance > attack_range:
		state = State.CHASE
	
func _attack():
	if player.has_method("_take_damage"):
		player._take_damage(damage)
		can_attack = false
		attack_timer.start()

func _on_attack_timer_timeout():
	can_attack = true
	
func _take_damage(amount: int):
	health -= amount
	print("[Enemy] enemy HP: ", health)
	if health <= 0:
		_die()
		
func _die():
	var gm = get_tree().get_first_node_in_group("game_manager")
	if gm:
		gm.add_score(10)
	print("[Enemy] enemy died")
	queue_free()
