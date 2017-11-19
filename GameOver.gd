extends PanelContainer

onready var global = get_node("/root/global")

func _ready():
	pass

func _onTryAgain():
	# THIS IS BROKEN!
	# get_tree().change_scene("res://Main.tscn")
	pass	