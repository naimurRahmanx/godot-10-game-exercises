extends CharacterBody2D

@export var SPEED := 300.0
@onready var SPRITE : Sprite2D = $Sprite2D 

func _physics_process(delta: float):
	var direction := 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		
	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
	
	var half_width = SPRITE.texture.get_size().x * SPRITE.scale.x / 2
	var screen_width = get_viewport_rect().size.x
	position.x = clamp(position.x, 0+half_width , screen_width-half_width)
