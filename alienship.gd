extends RigidBody2D

export var score = 75

func _ready():
	pass
	
func destroy():
	queue_free()
