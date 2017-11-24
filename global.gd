extends Node

var explosion
var PlayerShip = null
var popupLabel = null

onready var _gameOver = load("res://GameOver.tscn")

func _ready():
	var _explosion = load("res://explosion.tscn")
	explosion = _explosion.instance()
	
func getVersion():
	return "0.4"
	
func getPlayerShip():
	return PlayerShip
	
func getExplosion():
	return explosion
	
func fireExplosion(pos):
	explosion.set_pos(pos)
	explosion.set_emitting(true)
	
func setPopupLabel(label):
	popupLabel = label
	
func setPopupText(text):
	popupLabel.setText(text)
	
func setShipType(type):
	if (type == 1):
		var ship = load("res://RedPlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 2):
		var ship = load("res://GreenPlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 3):
		var ship = load("res://BluePlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 4):
		var ship = load("res://YellowPlayerShip.tscn")
		PlayerShip = ship.instance()
	elif (type == 5):
		var ship = load("res://PurplePlayerShip.tscn")
		PlayerShip = ship.instance()
		
func tryAgain():
	PlayerShip.tryAgain()

func gameOver():
	var root = get_node("/root/Main/HUD")
	var gameOver = _gameOver.instance()
	root.add_child(gameOver)