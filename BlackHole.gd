extends KinematicBody2D

var direction

func _ready():
	direction = randf() * 360.0
	set_fixed_process(true)
	
func _fixed_process(delta):
	var pos = get_pos()
	var rad = deg2rad(direction)
	pos.x += cos(rad) * 0.1
	pos.y += sin(rad) * 0.1
	set_pos(pos)