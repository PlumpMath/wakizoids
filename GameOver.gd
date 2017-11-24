extends PanelContainer

onready var global = get_node("/root/global")
onready var scoreLabel = get_node("Panel/ScoreLabel")

var player

func _ready():
	player = global.getPlayerShip()
	scoreLabel.set_text("Final score: " + str(player.score))

func _onTryAgain():
	global.tryAgain()
	queue_free()