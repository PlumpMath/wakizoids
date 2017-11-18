extends RigidBody2D

export var score = 75

onready var firingPosition = get_node("FiringPos")
onready var _bullet = load("res://bullet.tscn")
onready var global = get_node("/root/global")

var lastFired = 0
var shield = 100

func _ready():
	pass
	
func fireAtPlayer(vector):
	var now = OS.get_ticks_msec()
	if (now - lastFired) > 100:
		lastFired = now
		var bullet = _bullet.instance()
		bullet.set_pos(firingPosition.get_global_pos())
		bullet.apply_impulse(Vector2(), vector)
		get_parent().add_child(bullet)
		
func hitByBullet():
	shield -= 10
	if (shield < 0):
		var player = global.getPlayerShip()
		player.addScore(10)
		destroy()

func destroy():
	global.fireExplosion(get_pos())
	queue_free()
