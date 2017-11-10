extends RigidBody2D

const ACCELERATION = 20

export var score = 50
export var subRocks = -1

func _ready():
	var a = randf() * 360.0
	apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(deg2rad(a)))

func destroy():
	queue_free()