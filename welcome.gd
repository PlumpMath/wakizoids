extends PanelContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _onStart():
	get_tree().change_scene("res://ChooseShip.tscn")

func _onHelpPressed():
	get_tree().change_scene("res://HelpScene.tscn")
