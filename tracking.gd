extends Panel

const TRACKING_WIDTH = 192
const TRACKING_HEIGHT = 160

var trackingRange = 10000.0
var trackingRange2 = trackingRange / 2.0
var trackingRatio = TRACKING_HEIGHT / trackingRange

onready var global = get_node("/root/global")

func _ready():
	set_process(true)
	
func _process(delta):
	update()
	
func _draw():
	var player = global.getPlayerShip()
	
	var playerPos = player.get_pos()
	
	var rect = Rect2(TRACKING_WIDTH / 2, TRACKING_HEIGHT / 2, 4, 4)
	var colour = Color(192, 192, 192, 0.7)
	draw_rect(rect, colour)
	
	var rocks = get_tree().get_nodes_in_group("rocks")
	for rock in rocks:
		var pos = rock.get_pos()
		var dist = playerPos.distance_to(pos)
		if dist < trackingRange2:
			var x = (pos.x - playerPos.x) * trackingRatio + TRACKING_WIDTH / 2
			var y = (pos.y - playerPos.y) * trackingRatio + TRACKING_HEIGHT / 2
			rect = Rect2(x - 1, y - 1, 3, 3)
			colour = Color(0.5, 0.5, 1.0, 0.7)
			draw_rect(rect, colour)
	
	var ships = get_tree().get_nodes_in_group("ships")
	for ship in ships:
		var pos = ship.get_pos()
		var dist = playerPos.distance_to(pos)
		if dist < trackingRange2:
			var x = (pos.x - playerPos.x) * trackingRatio + TRACKING_WIDTH / 2
			var y = (pos.y - playerPos.y) * trackingRatio + TRACKING_HEIGHT / 2
			rect = Rect2(x - 1, y - 1, 3, 3)
			colour = Color(1.0, 0, 0, 0.7)
			draw_rect(rect, colour)
	
	var powerups = get_tree().get_nodes_in_group("powerups")
	for powerup in powerups:
		var pos = powerup.get_pos()
		var dist = playerPos.distance_to(pos)
		if dist < trackingRange2:
			var x = (pos.x - playerPos.x) * trackingRatio + TRACKING_WIDTH / 2
			var y = (pos.y - playerPos.y) * trackingRatio + TRACKING_HEIGHT / 2
			rect = Rect2(x - 1, y - 1, 3, 3)
			colour = Color(0.5, 1.0, 0.5, 0.7)
			draw_rect(rect, colour)
		