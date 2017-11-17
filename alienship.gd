extends RigidBody2D

export var score = 75

onready var firingPosition = get_node("FiringPos")
onready var _bullet = load("res://bullet.tscn")
onready var global = get_node("/root/global")

func _ready():
	pass
	
func fireAtPlayer(vector):
	var bullet = _bullet.instance()
	bullet.set_pos(firingPosition.get_pos())
	bullet.apply_impulse(Vector2(), vector)
	get_parent().add_child(bullet)

func destroy():
	global.fireExplosion(get_pos())
	queue_free()
