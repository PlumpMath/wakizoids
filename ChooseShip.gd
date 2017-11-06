extends PanelContainer

onready var global = get_node("/root/global")

func _ready():
	pass

func _onBack():
	get_tree().change_scene("res://welcome.tscn")

func _onRedShip():
	global.setShipType(1)
	get_tree().change_scene("res://Main.tscn")

func _onGreenShip():
	global.setShipType(2)
	get_tree().change_scene("res://Main.tscn")

func _onBlueShip():
	global.setShipType(3)
	get_tree().change_scene("res://Main.tscn")

func _onYellowShip():
	global.setShipType(4)
	get_tree().change_scene("res://Main.tscn")

func _onPurpleShip():
	global.setShipType(5)
	get_tree().change_scene("res://Main.tscn")
