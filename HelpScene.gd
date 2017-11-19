extends PanelContainer

func _ready():
	var richTextLabel = get_node("Panel/RichTextLabel")
	richTextLabel.add_text("WakiZoids has controls to:")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("THRUST - up arrow - Moves the ship forwards")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("SPIN LEFT - left arrow - Rotates the ship left")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("SPIN RIGHT - right arrow - Rotates the ship right")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("JUMP - spacebar - Makes a random jump somewhere else in the universe")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("There are powerups scattered around that will give you energy, shields and more jumps. ")
	richTextLabel.add_text("There is a black hole you cannot detect that is destroying everything!")
	richTextLabel.newline()
	richTextLabel.newline()
	richTextLabel.add_text("Good luck!")

func _onBackPressed():
	get_tree().change_scene("res://welcome.tscn")
