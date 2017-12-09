extends PanelContainer

onready var global = get_node("/root/global")
onready var versionLabel = get_node("Panel/VersionLabel")
onready var enableSound = get_node("Panel/EnableSound")

func _ready():
	var version = global.getVersion()
	versionLabel.set_text("Version: " + version)

func _onStart():
	global.setEnableSound(enableSound.is_pressed())
	get_tree().change_scene("res://scenes/ChooseShip.tscn")

func _onHelpPressed():
	get_tree().change_scene("res://scenes/HelpScene.tscn")

func _onCreditsButton():
	get_tree().change_scene("res://scenes/Credits.tscn")
