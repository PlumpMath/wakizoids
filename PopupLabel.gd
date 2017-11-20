extends Node2D

onready var label = get_node("Label")
onready var tween = get_node("Tween")

func _ready():
	tween.interpolate_property(label, "visibility/opacity", 1.0, 0.0, 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)	
	
func setText(text):
	label.set_text(text)
	tween.start()
