extends Node2D

onready var global = get_node("/root/global")
var player

func _ready():
	randomize()
	player = global.getPlayerShip()
	player.set_pos(Vector2(512, 300))
	add_child(player)
	createRocks()
	createShips()
	set_fixed_process(true)

func createRocks():
	createRock("res://rock1.tscn", 0, 0)
	createRock("res://rock2.tscn", 0, 600)
	createRock("res://rock3.tscn", 1000, 0)
	createRock("res://rock4.tscn", 1000, 600)
	createRock("res://rock1.tscn", -1000, -1000)
	createRock("res://rock2.tscn", 1000, 1600)
	createRock("res://rock3.tscn", 2000, 1000)
	createRock("res://rock4.tscn", 2000, 1600)
	createRock("res://rock5.tscn", -16000, 0)
	createRock("res://rock6.tscn", 16000, 0)
	
func createShips():
	for i in range(4):
		createBoxShip("res://boxship.tscn")

func createRock(name, x, y):
	var rock = load(name)
	var node = rock.instance()
	node.set_pos(Vector2(x + randi() % 200, y + randi() % 200))
	node.add_to_group("rocks")
	add_child(node)
	
func createBoxShip(name):
	var ship = load(name)
	var node = ship.instance()
	node.set_pos(Vector2(randi() * 65536 - 32768, randi() * 65536 - 32768))
	node.add_to_group("ships")
	add_child(node)
	
func _fixed_process(delta):
	pass