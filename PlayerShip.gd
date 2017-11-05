extends RigidBody2D

const ROTATE_SPEED = 250
const ACCELERATION = 5
const BULLET_ACCELERATION = 400

var size

onready var firingPosition = get_node("firingPosition")

func _ready():
	size = get_viewport().get_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	if (Input.is_action_pressed("ui_spin_left")):
		rotate(deg2rad(delta * ROTATE_SPEED))
		
	if (Input.is_action_pressed("ui_spin_right")):
	 	rotate(-deg2rad(delta * ROTATE_SPEED))
	
	if (Input.is_action_pressed("ui_thrust")):
		apply_impulse(Vector2(), Vector2(0, -ACCELERATION).rotated(get_rot()))
		
	if (Input.is_action_pressed("ui_fire")):
		createFiring()
		
	var pos = get_pos()
	if (pos.x < 0):
		pos.x = size.x - 1
	if (pos.x > size.x):
		pos.x = 1
	if (pos.y < 0):
		pos.y = size.y - 1
	if (pos.y > size.y):
		pos.y = 1
	set_pos(pos)

func createFiring():
	var pos = firingPosition.get_global_pos()
	var bulletResource = load("res://bullet.tscn")
	var bullet = bulletResource.instance()
	bullet.set_pos(pos)
	bullet.apply_impulse(Vector2(), Vector2(0, -BULLET_ACCELERATION).rotated(get_rot()))
	get_parent().add_child(bullet)