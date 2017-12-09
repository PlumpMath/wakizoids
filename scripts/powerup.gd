extends RigidBody2D

const POWERUP_ENERGY = 1
const POWERUP_SHIELDS = 2
const POWERUP_JUMP = 3

export var powerupType = -1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func destroy():
	queue_free()
