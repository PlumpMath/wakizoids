extends PanelContainer

onready var global = get_node("/root/global")
onready var versionLabel = get_node("Panel/VersionLabel")
onready var enableSound = get_node("Panel/EnableSound")
onready var enablePet = get_node("Panel/EnablePet")
onready var petIsCat = get_node("Panel/CatOrDog")
onready var enablePudding = get_node("Panel/EnablePudding")

func _ready():
	var version = global.getVersion()
	versionLabel.set_text("Version: " + version)

func _onStart():
	global.enableSound = enableSound.is_pressed()
	global.enablePet = enablePet.is_pressed()
	global.petIsCat = petIsCat.is_pressed()
	global.enablePudding = enablePudding.is_pressed()
	get_tree().change_scene("res://scenes/ChooseShip.tscn")

func _onHelpPressed():
	get_tree().change_scene("res://scenes/HelpScene.tscn")

func _onCreditsButton():
	get_tree().change_scene("res://scenes/Credits.tscn")
