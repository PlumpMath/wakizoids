extends Node2D

onready var global = get_node("/root/global")
onready var scoreLabel = get_node("HUD/ScoreLabel")

var player

func _ready():
	randomize()
	player = global.getPlayerShip()
	player.set_pos(Vector2(512, 300))
	add_child(player)
	createRocks()
	createShips()
	add_child(global.getExplosion())
	set_fixed_process(true)

func createRocks():
	createRock("res://rock1.tscn", 0, 0, 1)
	createRock("res://rock2.tscn", 0, 600, 2)
	createRock("res://rock3.tscn", 1000, 0, 3)
	createRock("res://rock4.tscn", 1000, 600, 4)
	createRock("res://rock1.tscn", -1000, -1000, 1)
	createRock("res://rock2.tscn", 1000, 1600, 2)
	createRock("res://rock3.tscn", 2000, 1000, 3)
	createRock("res://rock4.tscn", 2000, 1600, 4)
	createRock("res://rock5.tscn", -16000, 0, 5)
	createRock("res://rock6.tscn", 16000, 0, 6)
	
func createShips():
	createAlienShip()
	for i in range(4):
		createShip("res://boxship.tscn")

func createRock(name, x, y, sub):
	var rock = load(name)
	var node = rock.instance()
	node.subRocks = sub
	node.set_pos(Vector2(x + randi() % 200, y + randi() % 200))
	node.add_to_group("rocks")
	add_child(node)
	
func createAlienShip():
	createShip("res://alienship.tscn")
	
func createShip(name):
	var ship = load(name)
	var node = ship.instance()
	node.set_pos(Vector2(randi() % 65536 - 32768, randi() % 65536 - 32768))
	node.add_to_group("ships")
	add_child(node)
	
func setHUDScore():
	scoreLabel.set_text("Score: " + str(player.getScore()))

func _fixed_process(delta):
	setHUDScore()
	