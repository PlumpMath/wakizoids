extends Node

var PlayerShip = null

func _ready():
	pass
	
func getPlayerShip():
	return PlayerShip
	
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
