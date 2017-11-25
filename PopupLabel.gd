extends Node2D

onready var label = get_node("Label")
onready var timer = get_node("Timer")

func _ready():
	hide()
	
func setText(text):
	show()
	label.set_text(text)
	timer.start()

func _onTimerTimeout():
	hide()
