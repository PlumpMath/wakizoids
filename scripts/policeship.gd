extends RigidBody2D

export var rateOfFire = 400

var lastFired = 0

onready var firingPosition = get_node("FiringPosition")
onready var _bullet = load("res://scenes/bullet.tscn")
onready var global = get_node("/root/global")

func _ready():
	pass

func fireAtPlayer(vector):
	var now = OS.get_ticks_msec()
	if (now - lastFired) > rateOfFire:
		lastFired = now
		var bullet = _bullet.instance()
		bullet.set_pos(firingPosition.get_global_pos())
		bullet.apply_impulse(Vector2(), vector)
		get_parent().add_child(bullet)
