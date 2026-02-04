extends Area2D
@export var FallSpeed := 800
signal hit_player
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += FallSpeed * delta 
	
func  _on_body_entered(body):
	if body.name == "Player":
		emit_signal("hit_player") 
		
	
	
