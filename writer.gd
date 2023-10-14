extends Node

var contents
var lastChar = ' '
var characterDatabase = {}

func myload(path):
	var file = FileAccess.open(path,FileAccess.READ)
	var content = file.get_as_text()
	return content

# Called when the node enters the scene tree for the first time.
func _ready():
	contents = myload("res://database.txt")

	for i in range(len(contents)):
		if contents[i+1] == "🛑":
			break

		if not contents[i].to_lower() in characterDatabase:
			characterDatabase[contents[i].to_lower()] = {"total":0}
		if not contents[i+1].to_lower() in characterDatabase[contents[i].to_lower()]:
			characterDatabase[contents[i].to_lower()][contents[i+1].to_lower()] = 0
		characterDatabase[contents[i].to_lower()][contents[i+1].to_lower()] += 1
		characterDatabase[contents[i].to_lower()]["total"] += 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func generate(characters):
	var text = ""
	for j in characters:
		text += lastChar
		if len(text)%100 == 0:
			text += "\n"
		var randAmount = randi_range(1,characterDatabase[lastChar]['total'])
		for i in characterDatabase[lastChar].keys():
			if i == "total":
				continue
			randAmount -= characterDatabase[lastChar][i]
			if randAmount <= 0:
				lastChar = i
				break
	return text
