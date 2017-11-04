extends RigidBody2D

const ACCELERATION = 20

var size

func _ready():
	size = get_viewport().get_rect().size
	var a = randf() * 360.0
	apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(deg2rad(a)))
	set_fixed_process(true)
	
func _fixed_process(delta):
	var pos = get_pos()
	if (pos.x < 0):
		pos.x = size.x - 1
	if (pos.x > size.x):
		pos.x = 1
	if (pos.y < 0):
		pos.y = size.y - 1
	if (pos.y > size.y):
		pos.y = 1
	set_pos(pos)

