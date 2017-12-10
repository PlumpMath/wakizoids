extends Node

var explosion
var PlayerShip = null
var popupLabel = null
var samplePlayer = null
var tracking = null

var engine
var alarm
var fire
var enableSound = true
var enablePet = true
var enablePudding = true
var alarmStarted = false
var fireStarted = false
var engineStarted = false

onready var _gameOver = load("res://scenes/GameOver.tscn")
onready var _policeShip = load("res://scenes/policeship.tscn")

func _ready():
	var _explosion = load("res://scenes/explosion.tscn")
	explosion = _explosion.instance()
	
func getVersion():
	return "1.4-2 Xmas Edition"
	
func getPlayerShip():
	return PlayerShip

# func setEnableSound(enable):
#	enableSound = enable

func startEngine():
	if (!enableSound):
		return
		
	if (!engineStarted):
		engine = samplePlayer.play("engine")
		engineStarted = true
	
func stopEngine():
	if (!enableSound):
		return
		
	if (engineStarted):
		samplePlayer.stop(engine)
		engineStarted = false
		
func soundAlarm():
	if (!enableSound):
		return
		
	if (!alarmStarted):
		alarm = samplePlayer.play("alarm")
		alarmStarted = true
	else:
		if (!samplePlayer.is_voice_active(alarm)):
			alarm = samplePlayer.play("alarm")
			
func soundFire():
	if (!enableSound):
		return
		
	if (!fireStarted):
		fire = samplePlayer.play("fire")
		fireStarted = true
	else:
		if (!samplePlayer.is_voice_active(fire)):
			fire = samplePlayer.play("fire")
			
func soundPickup():
	if (!enableSound):
		return
		
	samplePlayer.play("pickup")
	
func soundExplosion():
	if (!enableSound):
		return
		
	samplePlayer.play("explosion")
	
func soundWarpJump():
	if (!enableSound):
		return
		
	samplePlayer.play("warpjump")
	
func setTracking(track):
	tracking = track
	
func setShortRangeScan():
	tracking.setShortRangeScan()
	
func setLongRangeScan():
	tracking.setLongRangeScan()
	
func setScanFilter(value):
	tracking.setScanFilter(value)
	
func getExplosion():
	return explosion
	
func fireExplosion(pos):
	explosion.set_pos(pos)
	explosion.set_emitting(true)
	soundExplosion()
	
func setPopupLabel(label):
	popupLabel = label
	
func setSamplePlayer(player):
	samplePlayer = player
	
func setPopupText(text):
	popupLabel.setText(text)
	
func setShipType(type):
	if (type == 1):
		var ship = load("res://scenes/RedPlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 2):
		var ship = load("res://scenes/GreenPlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 3):
		var ship = load("res://scenes/BluePlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 4):
		var ship = load("res://scenes/YellowPlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 5):
		var ship = load("res://scenes/PurplePlayerShip.tscn")
		PlayerShip = ship.instance()
		
func setFugitive():
	var pos = PlayerShip.get_pos()
	createPoliceShip(pos, -400, -400)
	createPoliceShip(pos,  400, -400)
	createPoliceShip(pos,  400,  400)
	createPoliceShip(pos, -400,  400)

func createPoliceShip(playerPos, x, y):
	var police = _policeShip.instance()
	police.set_pos(Vector2(playerPos.x + x, playerPos.y + y))
	var main = get_node("/root/Main")
	main.add_child(police)
		
func tryAgain():
	PlayerShip.tryAgain()
	var main = get_node("/root/Main")
	main.tryAgain()

func gameOver():
	var root = get_node("/root/Main/HUD")
	var gameOver = _gameOver.instance()
	root.add_child(gameOver)