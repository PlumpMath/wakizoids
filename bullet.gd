extends RigidBody2D

var startTime = 0
var timeNow = 0

func _ready():
	startTime = OS.get_unix_time()
	set_process(true)
	
func _process(delta):
	timeNow = OS.get_unix_time()
	var elapsed = timeNow - startTime
	if (elapsed > 1):
		queue_free()
	