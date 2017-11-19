extends RigidBody2D

const ACCELERATION = 50

export var score = 5
export var subRocks = -1

var main

onready var global = get_node("/root/global")

onready var _rock1a = load("res://rock1a.tscn")
onready var _rock1b = load("res://rock1b.tscn")
onready var _rock1c = load("res://rock1c.tscn")
onready var _rock1d = load("res://rock1d.tscn")

onready var _rock2a = load("res://rock2a.tscn")
onready var _rock2b = load("res://rock2b.tscn")
onready var _rock2c = load("res://rock2c.tscn")

onready var _rock3a = load("res://rock3a.tscn")
onready var _rock3b = load("res://rock3b.tscn")
onready var _rock3c = load("res://rock3c.tscn")

onready var _rock4a = load("res://rock4a.tscn")
onready var _rock4b = load("res://rock4b.tscn")
onready var _rock4c = load("res://rock4c.tscn")

onready var _rock5a = load("res://rock5a.tscn")
onready var _rock5b = load("res://rock5b.tscn")
onready var _rock5c = load("res://rock5c.tscn")

onready var _rock6a = load("res://rock6a.tscn")
onready var _rock6b = load("res://rock6b.tscn")
onready var _rock6c = load("res://rock6c.tscn")

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
		createSubRock(_rock1a, pos, -100, -100)
		createSubRock(_rock1b, pos, 100, -100)
		createSubRock(_rock1c, pos, 100, 100)
		createSubRock(_rock1d, pos, -100, 100)

	elif (subRocks == 2):
		createSubRock(_rock2a, pos, -100, -100)
		createSubRock(_rock2b, pos, 100, -100)
		createSubRock(_rock2c, pos, 100, 100)
		
	elif (subRocks == 3):
		createSubRock(_rock3a, pos, -100, -100)
		createSubRock(_rock3b, pos, 100, -100)
		createSubRock(_rock3c, pos, 100, 100)
	
	elif (subRocks == 4):
		createSubRock(_rock4a, pos, -100, -100)
		createSubRock(_rock4b, pos, 100, -100)
		createSubRock(_rock4c, pos, 100, 100)
		
	elif (subRocks == 5):
		createSubRock(_rock5a, pos, -100, -100)
		createSubRock(_rock5b, pos, 100, -100)
		createSubRock(_rock5c, pos, 100, 100)
		
	elif (subRocks == 6):
		createSubRock(_rock6a, pos, -100, -100)
		createSubRock(_rock6b, pos, 100, -100)
		createSubRock(_rock6c, pos, 100, 100)

func createSubRock(res, pos, x, y):
	var rock = res.instance()
	rock.set_pos(Vector2(pos.x + x, pos.y + y))
	rock.score = 10
	rock.add_to_group("rocks")
	main.add_child(rock)