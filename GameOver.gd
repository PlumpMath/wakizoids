extends PanelContainer

const HIGHSCORE_FILENAME = "user://wakizoids.high_scores"

onready var global = get_node("/root/global")
onready var scoreLabel = get_node("Panel/ScoreLabel")
onready var scoreList = get_node("Panel/HighScoreList")
onready var lineEdit = get_node("Panel/LineEdit")

var player
var highScores = {
	"PG1" : 100,
	"PG2" : 100,
	"PG3" : 100,
	"PG4" : 100,
	"PG5" : 100
}

func _ready():
	player = global.getPlayerShip()
	scoreLabel.set_text("Final score: " + str(player.score))
	readHighScores()
	displayHighScores()
	
func displayHighScores():
	var items = Array()
	scoreList.clear()
	for score in highScores:
		items.append(score)
		
	items.sort_custom(self, "sortItem")
	
	for item in items:
		scoreList.add_item(item + " - " + str(highScores[item]))
	
func sortItem(obj1, obj2):
	var score1 = highScores[obj1]
	var score2 = highScores[obj2]
	if (score1 < score2):
		return false
	return true

func _onTryAgain():
	writeHighScores()
	global.tryAgain()
	queue_free()
	
func readHighScores():
	var file = File.new()
	if (!file.file_exists(HIGHSCORE_FILENAME)):
		return
		
	if (file.open(HIGHSCORE_FILENAME, File.READ) != 0):
		return
		
	highScores = {}
	highScores.parse_json(file.get_line())
	file.close()
	
func writeHighScores():
	var file = File.new()
	if (file.open(HIGHSCORE_FILENAME, File.WRITE) != 0):
		return
	
	file.store_line(highScores.to_json())
	file.close()

func _onAddOK():
	var id = lineEdit.get_text()
	if (player.score == 0):
		return
		
	if (id.length() < 2):
		return
	
	var lowest = 99999
	var highest = 0
	for score in highScores:
		var value = highScores[score]
		if (value < lowest):
			lowest = value
		if (value > highest):
			highest = value
	
	if (player.score > lowest):
		highScores[id] = player.score
		displayHighScores()
		writeHighScores()