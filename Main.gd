extends Node2D

func _ready():
	randomize()
	createRocks()

func createRocks():
	createRock("res://rock1.tscn", 0, 0)
	createRock("res://rock2.tscn", 0, 600)
	createRock("res://rock3.tscn", 1000, 0)
	createRock("res://rock4.tscn", 1000, 600)
			
func createRock(name, x, y):
	var rock = load(name)
	var node = rock.instance()
	node.set_pos(Vector2(x + randi() % 200, y + randi() % 200))
	add_child(node)
	