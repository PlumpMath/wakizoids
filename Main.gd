extends Node2D

onready var global = get_node("/root/global")
onready var statusLabel = get_node("HUD/StatusLabel")
onready var popupLabel = get_node("HUD/PopupLabel")
onready var scoreLabel = get_node("HUD/ScoreLabel")
onready var energyLabel = get_node("HUD/EnergyLabel")
onready var shieldsLabel = get_node("HUD/ShieldsLabel")
onready var jumpLabel = get_node("HUD/JumpLabel")
onready var livesLabel = get_node("HUD/LivesLabel")
onready var samplePlayer = get_node("SamplePlayer")
onready var _powerup = load("res://powerup.tscn")
onready var _rock1 = load("res://rock1.tscn")
onready var _rock2 = load("res://rock2.tscn")
onready var _rock3 = load("res://rock3.tscn")
onready var _rock4 = load("res://rock4.tscn")
onready var _rock5 = load("res://rock5.tscn")
onready var _rock6 = load("res://rock6.tscn")

var player
var status = 0

func _ready():
	randomize()
	global.setSamplePlayer(samplePlayer)
	global.setPopupLabel(popupLabel)
	player = global.getPlayerShip()
	player.set_pos(Vector2(512, 300))
	add_child(player)
	createRocks()
	createShips()
	createPowerups()
	createBlackHole()
	add_child(global.getExplosion())
	set_fixed_process(true)
	
func tryAgain():
	var rocks = get_tree().get_nodes_in_group("rocks")
	if (rocks.size() > 30):
		return
		
	createRocks()
	createShips()
	createPowerups()
	
func randomRange(value):
	return randi() % value - value / 2

func createRocks():
	createRock(_rock1, randomRange(200), randomRange(200), 1)
	createRock(_rock2, randomRange(200), 600 + randomRange(200), 2)
	createRock(_rock3, randomRange(200) + 1000, randomRange(200), 3)
	createRock(_rock4, randomRange(200) + 1000, randomRange(200) + 600, 4)
	
	for i in range(20):
		createRandomRock(_rock1, 1)
		createRandomRock(_rock2, 2)
		createRandomRock(_rock3, 3)
		createRandomRock(_rock4, 4)
		createRandomRock(_rock5, 5)
		createRandomRock(_rock6, 6)
	
func createShips():
	for i in range(32):
		createAlienShip()
	for i in range(16):
		createShip("res://boxship.tscn")
		
func createPowerups():
	for i in range(8):
		createPowerup(1)
	for i in range(8):
		createPowerup(2)
	for i in range(8):
		createPowerup(3)
		
func createPowerup(type):
	var powerup = _powerup.instance()
	powerup.powerupType = type
	powerup.set_pos(Vector2(randomRange(65536), randomRange(65536)))
	powerup.add_to_group("powerups")
	add_child(powerup)

func createRandomRock(resource, sub):
	createRock(resource, randomRange(65536), randomRange(65536), sub)
	
func createRock(resource, x, y, sub):
	var node = resource.instance()
	node.subRocks = sub
	node.set_pos(Vector2(x, y))
	node.add_to_group("rocks")
	add_child(node)
	
func createAlienShip():
	createShip("res://alienship.tscn")
	
func createShip(name):
	var ship = load(name)
	var node = ship.instance()
	node.set_pos(Vector2(randomRange(65536), randomRange(65536)))
	node.add_to_group("ships")
	add_child(node)
	
func createBlackHole():
	var _blackHole = load("res://BlackHole.tscn")
	var blackHole = _blackHole.instance()
	# blackHole.set_pos(Vector2(100, 100))
	blackHole.set_pos(Vector2(randomRange(65536), randomRange(65536)))
	add_child(blackHole)
	
func setHUDdetails():
	if (status == 0):
		statusLabel.set_text("Status: Green")
	elif (status == 1):
		global.soundAlarm()
		statusLabel.set_text("Status: Red")
		
	scoreLabel.set_text("Score: " + str(player.getScore()))
	energyLabel.set_text("Energy: " + str(player.getEnergy()))
	shieldsLabel.set_text("Shields: " + str(player.getShields()))
	jumpLabel.set_text("Jump: " + str(player.getJump()))
	livesLabel.set_text("Lives: " + str(player.getLives()))

func _fixed_process(delta):
	setHUDdetails()
	enemyShipBehaviour()

# THE ALIENS AI
func enemyShipBehaviour():
	status = 0
	if (player.destroyed || player.locked):
		return
		
	var playerPos = player.get_pos()
	var aliens = get_tree().get_nodes_in_group("ships")
	for alien in aliens:
		var pos = alien.get_pos()
		var dist = playerPos.distance_to(pos)
		if (dist > 400 && dist < 800):
			var vec = playerPos - pos
			alien.apply_impulse(Vector2(), vec * 0.004) 
			alien.look_at(playerPos)
			alien.fireAtPlayer(vec)
			status = 1
		else:
			var powerups = get_tree().get_nodes_in_group("powerups")
			for powerup in powerups:
				var powerupPos = powerup.get_pos()
				dist = powerupPos.distance_to(pos)
				if (dist < 500):
					var vec = powerupPos - pos
					alien.apply_impulse(Vector2(), vec * 0.008)
					alien.look_at(powerupPos)