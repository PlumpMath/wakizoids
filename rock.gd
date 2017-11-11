extends RigidBody2D

const ACCELERATION = 50

export var score = 50
export var subRocks = -1

var main

onready var global = get_node("/root/global")

func _ready():
	var a = randf() * 360.0
	apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(deg2rad(a)))

func destroy():
	global.fireExplosion(get_pos())
	if (subRocks != -1):
		createSubRocks()
	queue_free()
	
func createSubRocks():
	var pos = get_pos()
	main = get_node("/root/Main")
	
	if (subRocks == 1):
		createSubRock("res://rock1a.tscn", pos, -100, -100)
		createSubRock("res://rock1b.tscn", pos, 100, -100)
		createSubRock("res://rock1c.tscn", pos, 100, 100)
		createSubRock("res://rock1d.tscn", pos, -100, 100)

	elif (subRocks == 2):
		createSubRock("res://rock2a.tscn", pos, -100, -100)
		createSubRock("res://rock2b.tscn", pos, 100, -100)
		createSubRock("res://rock2c.tscn", pos, 100, 100)
		
	elif (subRocks == 3):
		createSubRock("res://rock3a.tscn", pos, -100, -100)
		createSubRock("res://rock3b.tscn", pos, 100, -100)
		createSubRock("res://rock3c.tscn", pos, 100, 100)
	
	elif (subRocks == 4):
		createSubRock("res://rock4a.tscn", pos, -100, -100)
		createSubRock("res://rock4b.tscn", pos, 100, -100)
		createSubRock("res://rock4c.tscn", pos, 100, 100)
		
	elif (subRocks == 5):
		createSubRock("res://rock5a.tscn", pos, -100, -100)
		createSubRock("res://rock5b.tscn", pos, 100, -100)
		createSubRock("res://rock5c.tscn", pos, 100, 100)
		
	elif (subRocks == 6):
		createSubRock("res://rock6a.tscn", pos, -100, -100)
		createSubRock("res://rock6b.tscn", pos, 100, -100)
		createSubRock("res://rock6c.tscn", pos, 100, 100)

func createSubRock(res, pos, x, y):
	var _rock = load(res)
	var rock = _rock.instance()
	rock.set_pos(Vector2(pos.x + x, pos.y + y))
	rock.score = 75
	rock.add_to_group("rocks")
	main.add_child(rock)