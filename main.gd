extends Node2D
var y = 298
var reputation = 100
var x = 0
var mns = 0
var tmns = 0
var sheets = []
var currentshhet = 0
var currentmoney = 0
var allowed = 6
var cost = 0
var d = 1
var selected = []
var monkeycost = 100
var rng = RandomNumberGenerator.new()
@export var monkey: PackedScene
signal delete_monke(nums)
func asmony(mon):
	if "." in str(mon):
		var mny = str(mon)+"00"
		var ind = mny.find('.')
		var full = ""
		var te = ind + 3
		for i in mny:
			if te > 0:
				full += i
			te-=1
		return full
	else:
		return str(mon)+".00"
func createnewmonkey(qual):
	tmns += 1
	mns += 1
	var new = monkey.instantiate()
	new.position.y = 165
	if tmns == 7:
		mns = 1
		new.position.y = 465
	elif tmns > 7:
		new.position.y = 465
	
	new.MONKENUM = tmns
	new.quality = qual
	new.position.x = (mns-1)*200+175
	new.showpaper.connect(showpaperf)
	new.select.connect(select)
	$monkeys.add_child(new)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/TextureButton3.disabled = true
	createnewmonkey(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/TextureButton4.visible = currentshhet > 0 and $Control/TextureButton.visible
	$Control/TextureButton5.visible = currentshhet+1 < len(sheets) and $Control/TextureButton.visible
	if tmns == 6 and allowed == 6:
		$lock.visible = true
	else:
		$lock.visible = false
	if currentmoney >= monkeycost and tmns != allowed:
		$Control/TextureButton3.disabled = false
	else:
		$Control/TextureButton3.disabled = true
	x+=delta*1000*d
	
	if x <0:
		x = 0
	if x > 1000:
		x = 1000
	y = ((2**(-(x-1000)/101.125087))/948.0)*650+298
	$Paper.position.y = (round(y*1.25/5)*5)
	$Label.position.y = (round(y*1.25/5)*5)-200

func splittext(text):
	var done = []
	var line = ""
	for i in len(text):
		line += text[i]
		if i % 15 == 0 and i != 0:
			done.append(line)
			line = ""
	done.append(line)
	return done
func showpaperf(qual):
	currentshhet = 0
	cost = qual
	x=0
	d=1
	$Paper.position.y = 948
	$Label.position.y = 948-200
	y = 948
	$Paper.visible = true
	$Label.visible = true
	var SPtxt = $monkeys.generate(qual, 1000).split("\n")
	for i in len(SPtxt):
		SPtxt[i]+="\n"
	sheets = []
	var SP2 = []
	for i in SPtxt:
		for J in splittext(i):
			SP2.append(J)
	SPtxt = SP2
	var text = ""
	for i in len(SPtxt):
		if i%8==0 and i != 0:
			sheets.append(text)
			text = ""
		text += SP2[i]
	sheets.append(text)
	
	$Label.text = sheets[0]
	$Control/TextureButton.visible = true
	$Control/TextureButton2.visible = true


func _on_texture_button_pressed():
	currentmoney += (round(cost*10000)/100)*reputation/100
	reputation += round(((cost*reputation/100)-0.5)*10)
	$Label4.text = str(reputation)+"%"
	$Label2.text = "$"+asmony(currentmoney)
	x=1000
	d=-1
	$Paper.position.y = 298
	$Label.position.y = 298-200
	y = 298
	$Paper.visible = true
	$Label.visible = true
	$Control/TextureButton.visible = false
	$Control/TextureButton2.visible = false


func _on_texture_button_2_pressed():
	x=1000
	d=-1
	$Paper.position.y = 298
	$Label.position.y = 298-200
	y = 298
	$Paper.visible = true
	$Label.visible = true
	$Control/TextureButton.visible = false
	$Control/TextureButton2.visible = false


func _on_texture_button_3_pressed():
	currentmoney -= monkeycost
	monkeycost *= 1.5
	$Label2.text = "$"+asmony(currentmoney)
	$Label3.text = "$"+asmony(monkeycost)
	createnewmonkey(rng.randf_range(0.0,1.0))


func _on_texture_button_4_pressed():
	if currentmoney >= 10000:
		currentmoney -= 10000
		$Label2.text = "$"+asmony(currentmoney)
		allowed = 12
		$Sprite2D5.visible = false
func delet(nums):
	tmns -= 1
	if mns == 0:
		mns = 5
	else:
		mns -= 1
	tmns -= 1
	if mns == 0:
		mns = 5
	else:
		mns -= 1
	emit_signal("delete_monke", nums)
func select(num, qual):
	#delet(num)
	if not {"id":num,"quality":qual} in selected:
		selected.append({"id":num,"quality":qual})
		if len(selected) ==2:
			delet([selected[0]["id"],selected[1]["id"]])
			createnewmonkey((selected[0]["quality"] + selected[1]["quality"])/2 + rng.randf_range(0, 0.3))
			selected = []
	else:
		selected.remove_at(selected.find({"id":num,"quality":qual}))


func left():
	currentshhet -= 1
	$Label.text = sheets[currentshhet]


func right():
	currentshhet += 1
	$Label.text = sheets[currentshhet]
