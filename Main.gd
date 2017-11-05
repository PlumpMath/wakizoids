extends Node2D

onready var player = get_node("PlayerShip")
var rocks = Array()

func _ready():
	randomize()
	createRocks()
	set_fixed_process(true)

func createRocks():
	createRock("res://rock1.tscn", 0, 0)
	createRock("res://rock2.tscn", 0, 600)
	createRock("res://rock3.tscn", 1000, 0)
	# createRock("res://rock4.tscn", 1000, 600)

func createRock(name, x, y):
	var rock = load(name)
	var node = rock.instance()
	node.set_pos(Vector2(x + randi() % 200, y + randi() % 200))
	rocks.append(node)
	add_child(node)
	
func _fixed_process(delta):
	var playerPos = player.get_pos()
	for rock in rocks:
		var dist = rock.get_pos().distance_to(playerPos)
		if (dist > 1000):
			rock.set_pos(Vector2(playerPos.x + randi() * 400 - 200, playerPos.y + randi() * 400 - 200))