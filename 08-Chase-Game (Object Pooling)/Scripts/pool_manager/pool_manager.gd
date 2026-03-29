extends Node

@export var bullet_scene: PackedScene
@export var pool_size: int = 30

var pool: Array = []
var container: Node

func setup(_container):

	container = _container
	create_pool()

func create_pool():

	for i in range(pool_size):

		var bullet = bullet_scene.instantiate()
		bullet.visible = false
		bullet.set_physics_process(false)

		# ❗ VERY IMPORTANT
		bullet.set_deferred("monitoring", false)
		#bullet.set_deferred("monitorable", false)

		container.add_child(bullet)
		pool.append(bullet)

func get_bullet():
	# Simply look for a bullet that is NOT currently being used
	for bullet in pool:
		if not bullet.active:
			return bullet

	# If all 30 bullets are on screen, return null (or expand the pool safely)
	return null
