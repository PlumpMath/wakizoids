extends PanelContainer

onready var global = get_node("/root/global")
onready var versionLabel = get_node("Panel/VersionLabel")

func _ready():
	var version = global.getVersion()
	versionLabel.set_text("Version: " + version)

func _onStart():
	get_tree().change_scene("res://ChooseShip.tscn")

func _onHelpPressed():
	get_tree().change_scene("res://HelpScene.tscn")

func _onCreditsButton():
	get_tree().change_scene("res://Credits.tscn")
