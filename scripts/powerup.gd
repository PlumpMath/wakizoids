extends RigidBody2D

const POWERUP_ENERGY = 1
const POWERUP_SHIELDS = 2
const POWERUP_JUMP = 3
const POWERUP_LIFE = 4

export var powerupType = -1

func _ready():
	pass
	
func destroy():
	queue_free()
