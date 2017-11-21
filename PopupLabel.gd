extends Node2D

onready var label = get_node("Label")
onready var tween = get_node("Tween")

func _ready():
	label.hide()
	tween.interpolate_property(label, "visibility/opacity", 1.0, 0.0, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT, 3.0)
	
func setText(text):
	label.show()
	label.set_text(text)
	tween.start()
