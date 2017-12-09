extends RigidBody2D

onready var global = get_node("/root/global")

func _ready():
	pass

func hitByBullet():
	global.setFugitive()
	destroy()

func destroy():
	queue_free()
