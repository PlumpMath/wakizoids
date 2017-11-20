extends PanelContainer

onready var richTextLabel = get_node("Panel/RichTextLabel")

func _ready():
	richTextLabel.add_text("Game idea by Pete Goodwin, created for Game Off 2017")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("Font: http://www.1001fonts.com/sf-atarian-system-font.html")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("Alien ships")
	richTextLabel.newline()
	richTextLabel.add_text("This work has been released under the Creative Commons BY License: https://creativecommons.org/licenses/by/4.0/")
	richTextLabel.newline()
	richTextLabel.add_text("By MillionthVector (http://millionthvector.blogspot.de)")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("Stars and Rocks created in Filter Forge 6.0")

func _onBackButton():
	get_tree().change_scene("res://welcome.tscn")
