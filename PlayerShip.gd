extends RigidBody2D

const ROTATE_SPEED = 250
const ACCELERATION = 5
const BULLET_ACCELERATION = 400

const FADEINOUT_IDLE = 0
const FADEINOUT_JUMP = 1
const FADEINOUT_JUMPED = 2
const FADEINOUT_DESTROYED = 3
const FADEINOUT_RESURRECTED = 4

const FADEINOUT_PROPERTY = "visibility/opacity"

var size
var lastFired = 0
var score = 0
var lives = 3
var energy = 100
var shields = 100
var lastTime = 0
var jump = 1
var fadeInOutState = FADEINOUT_IDLE
var testMode = false
var destroyed = false
var locked = false

onready var global = get_node("/root/global")
onready var firingPosition = get_node("firingPosition")
onready var tweenFader = get_node("TweenFader")
onready var engine = get_node("engineParticles")
onready var sprite = get_node("Sprite")
onready var _bullet = load("res://bullet.tscn")
onready var _brokenShip1 = load("res://brokenship1.tscn")
onready var _brokenShip2 = load("res://brokenship2.tscn")
onready var _brokenShip3 = load("res://brokenship3.tscn")
onready var _brokenShip4 = load("res://brokenship4.tscn")

func _ready():
	size = get_viewport().get_rect().size
	add_to_group("player")
	set_fixed_process(true)

func _fixed_process(delta):
	var now = OS.get_ticks_msec()
	
	if (!destroyed && !locked):
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
			var velocity = get_linear_velocity()
			if (velocity.length() < 500):
				apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(get_rot()))
			global.startEngine()
			engine.set_emitting(true)
	else:
		engine.set_emitting(false)
		global.stopEngine()
		
	if (Input.is_action_pressed("ui_fire")):
		createFiring()
		
	if (Input.is_action_pressed("ui_jump")):
		if (jump > 0 && !locked):
			fadeInOutState = FADEINOUT_JUMP
			locked = true
			tweenFader.interpolate_property(sprite, FADEINOUT_PROPERTY, 1.0, 0.0, 3.0, Tween.TRANS_QUAD, Tween.EASE_OUT)
			tweenFader.start()
			
	if (Input.is_action_pressed("ui_volume_on")):
		global.setPopupText("Sound ON")
		global.setEnableSound(true)
		
	if (Input.is_action_pressed("ui_volume_off")):
		global.setPopupText("Sound OFF")
		global.setEnableSound(false)
			
#	if (Input.is_action_pressed("ui_test_mode")):
#		global.setPopupText("Entering test mode... score frozen")
#		testMode = true
#		
#	if (testMode):
#		if (Input.is_action_pressed("ui_jump_blackhole")):
#			jumpBlackhole()
			
	var pos = get_pos()
	if (pos.x < -32000 || pos.x > 32000 || pos.y < -32000 || pos.y > 32000):
		global.setPopupText("WARNING! Reaching edge of Universe!!!")

	if (pos.x < -32800 || pos.x > 32800 || pos.y < -32800 || pos.y > 32800):
		destroy()
		
	var bodies = get_colliding_bodies()
	for body in bodies:
		if (body.is_in_group("rocks")):
			reduceShields(30)
			body.destroy()
		
		if (body.is_in_group("powerups")):
			var powerup = body.powerupType
			
			if (powerup == 1):
				energy += 50
				global.setPopupText("Energy increased!")
				if (energy > 100):
					energy = 100
			elif (powerup == 2):
				shields += 50
				global.setPopupText("Shields increased!")
				if (shields > 100):
					shields = 100
			elif (powerup == 3):
				global.setPopupText("Jump available!")
				jump += 1

			global.soundPickup()
			body.destroy()

func createFiring():
	if (energy >= 10):
		var now = OS.get_ticks_msec()
		if (now - lastFired) > 100:
			lastFired = now
			var pos = firingPosition.get_global_pos()
			var bullet = _bullet.instance()
			bullet.set_pos(pos)
			
			global.soundFire()
			
			# If we don't compensate for our speed, we could
			# catch up with out bullets!
			var velocity = get_linear_velocity()
			var acceleration = velocity.length()
			bullet.apply_impulse(Vector2(), Vector2(0, -BULLET_ACCELERATION - acceleration).rotated(get_rot()))
			
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
		destroy()
		
func jumpBlackhole():
	var blackholes = get_tree().get_nodes_in_group("blackholes")
	var firstBlackhole = blackholes[0]
	var pos = firstBlackhole.get_pos()
	set_pos(Vector2(pos.x + 400, pos.y + 400))

func addScore(delta):
	if (!testMode):
		score += delta

func getScore():
	return score
	
func getEnergy():
	return energy

func addShields(delta):
	shields += delta
	
func getShields():
	return shields
	
func getJump():
	return jump
	
func getLives():
	return lives
	
func tryAgain():
	lives = 3
	score = 0
	energy = 30
	shields = 0
	locked = false
	destroyed = false
	show()
	var pos = Vector2(randi() % 65536 - 32768, randi() % 65536 - 32768)
	set_pos(pos)
	
func destroy():
	if (destroyed || locked):
		return
		
	global.setPopupText("You lost a life!")
	lives -= 1
	if (lives > 0):
		var pos = get_pos()
		var broken1 = _brokenShip1.instance()
		var broken2 = _brokenShip2.instance()
		var broken3 = _brokenShip3.instance()
		var broken4 = _brokenShip4.instance()
		broken1.set_pos(Vector2(pos.x - 100, pos.y - 100))
		broken2.set_pos(Vector2(pos.x + 100, pos.y - 100))
		broken3.set_pos(Vector2(pos.x + 100, pos.y + 100))
		broken4.set_pos(Vector2(pos.x - 100, pos.y + 100))
		get_parent().add_child(broken1)
		get_parent().add_child(broken2)
		get_parent().add_child(broken3)
		get_parent().add_child(broken4)

		locked = true
		fadeInOutState = FADEINOUT_DESTROYED
		global.soundExplosion()
		tweenFader.interpolate_property(sprite, FADEINOUT_PROPERTY, 1.0, 0.0, 3.0, Tween.TRANS_QUAD, Tween.EASE_OUT);
		tweenFader.start()
	else:
		hide()
		destroyed = true
		global.gameOver()

func _on_TweenFaderComplete( object, key ):
	if (fadeInOutState == FADEINOUT_JUMP):
		var pos = Vector2(randi() % 65536 - 32768, randi() % 65536 - 32768)
		set_pos(pos)
		jump -= 1
		fadeInOutState = FADEINOUT_JUMPED
		global.soundWarpJump()
		tweenFader.interpolate_property(sprite, FADEINOUT_PROPERTY, 0.0, 1.0, 1.0, Tween.TRANS_QUAD, Tween.EASE_IN)
		tweenFader.start()
	elif (fadeInOutState == FADEINOUT_JUMPED):
		locked = false
	elif (fadeInOutState == FADEINOUT_DESTROYED):
		var pos = Vector2(randi() % 65536 - 32768, randi() % 65536 - 32768)
		set_pos(pos)
		energy = 40
		shields = 0
		fadeInOutState = FADEINOUT_RESURRECTED
		tweenFader.interpolate_property(sprite, FADEINOUT_PROPERTY, 0.0, 1.0, 3.0, Tween.TRANS_QUAD, Tween.EASE_IN)
		tweenFader.start()
	elif (fadeInOutState == FADEINOUT_RESURRECTED):
		locked = false
