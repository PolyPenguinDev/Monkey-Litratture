extends Node
@onready var json = JSON.new()
var contents
var lastChar = ' '
var characterDatabase = {}
var rng = RandomNumberGenerator.new()

func myload(path):
	var file = FileAccess.open(path,FileAccess.READ)
	var content = json.parse_string(str(file.get_as_text()))
	'''var content = json.parse(path)'''
	return content

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func slice(string, from, to):
	var out = ""
	for i in len(string):
		if not (i < from or i > to):
			out += string[i]
	return out
# Called every frame. 'delta' is the elapsed time since the previous frame.
func generate(quality, numOfChars):
	if quality < 0:
		quality = 0
	elif quality > 1:
		quality = 1
	var maxContext = floor(quality * 4) + 1
	var low = myload("res://databases/characterDatabase"+str(maxContext)+".json")
	var high
	var error = 99999999999
	if (quality - (floor(quality * 4)/4)) != 0 and not quality == 1.0:
		high  =myload("res://databases/characterDatabase"+str(maxContext+1)+".json")
		error = 1/(quality - (floor(quality * 4)/4))
	var text = "ACT I"
	for i in numOfChars:
		var context = maxContext
		var qual = low
		if rng.randi_range(1, round(error))==1:
			context += 1
			qual = high
		var lt = len(text)
		text += generateOne(context, slice(text, lt - context, lt),qual)[0]
	return text.replace("é", "e").replace("`","'")
func generateOne(maxContext, context, characterDatabase):
	var text = ""
	var randAmount = rng.randi_range(1, characterDatabase[context]['total'])
	for i in characterDatabase[context].keys():
		if i == "total":
			continue
		randAmount -= characterDatabase[context][i]
		if randAmount <= 0:
			context = slice(context,1,maxContext) + i
			break
	text += context[-1]
	return [text, context]
