extends RigidBody2D

const ACCELERATION = 10

export var score = 75
export var rateOfFire = 500
export var damageByBullet = 30

onready var firingPosition = get_node("FiringPos")
onready var _bullet = load("res://bullet.tscn")
onready var global = get_node("/root/global")

var lastFired = 0
var shield = 100

func _ready():
	var angle = randf() * 360.0
	apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(angle))
	set_fixed_process(true)
	
func fireAtPlayer(vector):
	var now = OS.get_ticks_msec()
	if (now - lastFired) > rateOfFire:
		lastFired = now
		var bullet = _bullet.instance()
		bullet.set_pos(firingPosition.get_global_pos())
		bullet.apply_impulse(Vector2(), vector)
		get_parent().add_child(bullet)
		
func hitByBullet():
	shield -= damageByBullet
	if (shield < 0):
		var player = global.getPlayerShip()
		player.addScore(25)
		destroy()
		var ships = get_tree().get_nodes_in_group("ships")
		var shipCount = ships.size()
		if (shipCount == 0):
			global.gameOver()
		else:
			global.setPopupText(str(shipCount) + " ships left to kill!")

func destroy():
	global.fireExplosion(get_pos())
	queue_free()

func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if (body.is_in_group("rocks")):
			global.fireExplosion(body.get_pos())
			body.destroy()
		elif (body.is_in_group("powerups")):
			global.setPopupText("Powerup destroyed by alien!")
			body.destroy()
		elif (body.is_in_group("pet")):
			global.setPopupText("Pet captured by alien!")
			body.destory()
		elif (body.is_in_group("xmas")):
			global.setPopupText("You lost your christmas pudding!")
			body.destory()