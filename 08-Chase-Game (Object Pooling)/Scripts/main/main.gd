extends Node2D

@onready var pool = $PoolManager
@onready var bullet_container = $BulletContainer
@onready var player = $Player

func _ready():

	pool.setup(bullet_container)
	player.setup(pool)
