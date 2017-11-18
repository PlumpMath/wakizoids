extends RigidBody2D

onready var global = get_node("/root/global")

var startTime = 0
var timeNow = 0
var player

func _ready():
	startTime = OS.get_unix_time()
	player = global.getPlayerShip()
	set_process(true)
	set_fixed_process(true)
	
func _process(delta):
	timeNow = OS.get_unix_time()
	var elapsed = timeNow - startTime
	if (elapsed > 1):
		queue_free()
	
func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("rocks"):
			var score = body.score
			player.addScore(score)
			body.destroy()
			queue_free()
			
		if body.is_in_group("ships"):
			body.hitByBullet()
			queue_free()
		
		if body.is_in_group("player"):
			player.reduceShields(30)
			queue_free()