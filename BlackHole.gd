extends RigidBody2D

var direction

func _ready():
	changeDirection()
	set_fixed_process(true)
	
func _fixed_process(delta):
	var pos = get_pos()
	var rad = deg2rad(direction)
	pos.x += cos(rad) * 0.1
	pos.y += sin(rad) * 0.1
	if (pos.x < -32768 || pos.x > 32768):
		changeDirection()
	elif (pos.y < -32768 || pos.y > 32768):
		changeDirection()
	set_pos(pos)
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if (body.is_in_group("rocks")):
			body.destroy()
			
		if (body.is_in_group("ships")):
			body.destroy()
			
		if (body.is_in_group("powerups")):
			body.destroy()
			
		if body.is_in_group("player"):
			body.destroy()
			
	var blackholePos = get_pos()
	
	var rocks = get_tree().get_nodes_in_group("rocks")
	for rock in rocks:
		var pos = rock.get_pos()
		var dist = blackholePos.distance_to(pos)
		if (dist < 800):
			var vec = blackholePos - pos
			rock.apply_impulse(Vector2(), vec * 0.001)
			
	var ships = get_tree().get_nodes_in_group("ships")
	for ship in ships:
		var pos = ship.get_pos()
		var dist = blackholePos.distance_to(pos)
		if (dist < 800):
			var vec = blackholePos - pos
			ship.apply_impulse(Vector2(), vec * 0.001)

	var player = global.getPlayerShip()
	if (player.destroyed):
		return
		
	var pos = player.get_pos()
	var dist = blackholePos.distance_to(pos)
	if (dist < 800):
		var vec = blackholePos - pos
		player.apply_impulse(Vector2(), vec * 0.001)
	
func changeDirection():
	direction = randf() * 360.0