extends RigidBody2D

const ACCELERATION = 20

var size

func _ready():
	size = get_viewport().get_rect().size
	var a = randf() * 360.0
	apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(deg2rad(a)))
