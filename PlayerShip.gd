extends RigidBody2D

const ROTATE_SPEED = 250
const ACCELERATION = 5
const BULLET_ACCELERATION = 400

var size
var lastFired = 0
var score = 0
var energy = 100
var shields = 0
var lastTime = 0

onready var firingPosition = get_node("firingPosition")
onready var engine = get_node("engineParticles")

func _ready():
	size = get_viewport().get_rect().size
	add_to_group("player")
	set_fixed_process(true)

func _fixed_process(delta):
	var now = OS.get_ticks_msec()
	if (now - lastTime > 100):
		energy += 1
		lastTime = now
	
	if (energy > 100):
		energy = 100
		
	if (Input.is_action_pressed("ui_spin_left")):
		rotate(deg2rad(delta * ROTATE_SPEED))
		
	if (Input.is_action_pressed("ui_spin_right")):
	 	rotate(-deg2rad(delta * ROTATE_SPEED))
	
	if (Input.is_action_pressed("ui_thrust")):
		if (energy >= 10):
			apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(get_rot()))
			engine.set_emitting(true)
	else:
		engine.set_emitting(false)
		
	if (Input.is_action_pressed("ui_fire")):
		createFiring()
		
	var bodies = get_colliding_bodies()
	for body in bodies:
		if (body.is_in_group("rocks")):
			reduceShields(30)
			body.destroy()

func createFiring():
	if (energy >= 10):
		var now = OS.get_ticks_msec()
		if (now - lastFired) > 100:
			lastFired = OS.get_ticks_msec()
			var pos = firingPosition.get_global_pos()
			var bulletResource = load("res://bullet.tscn")
			var bullet = bulletResource.instance()
			bullet.set_pos(pos)
			bullet.apply_impulse(Vector2(), Vector2(0, -BULLET_ACCELERATION).rotated(get_rot()))
			get_parent().add_child(bullet)
			energy -= 10
		
func reduceShields(delta):
	if (shields > delta):
		shields -= delta
	else:
		delta -= shields
		shields = 0
		energy -= delta
		
	if (energy < 0):
		energy = 0

func addScore(delta):
	score += delta

func getScore():
	return score
	
func getEnergy():
	return energy

func addShields(delta):
	shields += delta
	
func getShields():
	return shields