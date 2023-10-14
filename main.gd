extends Node2D
var y = 298
var x = 0
var monkyx = 175
var monkyy = 150
var mns = 0
var tmns = 0
var currentmoney = 0
var cost = 0
var d = 1
var monkeycost = 100
@export var monkey: PackedScene
func createnewmonkey():
	mns += 1
	tmns += 1
	if mns == 6:
		mns = 1
		monkyx = 175
		monkyy += 200
	var new = monkey.instantiate()
	new.scale = Vector2(5, 5)
	new.position = Vector2(monkyx, monkyy)
	monkyx += 200
	new.showpaper.connect(showpaperf)
	$monkeys.add_child(new)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/TextureButton3.disabled = true
	createnewmonkey()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentmoney >= monkeycost and tmns != 15:
		$Control/TextureButton3.disabled = false
	else:
		$Control/TextureButton3.disabled = true
	x+=delta*1000*d
	
	if x <0:
		x = 0
	if x > 1000:
		x = 1000
	y = ((2**(-(x-1000)/101.125087))/948.0)*650+298
	$Paper.position.y = round(y/5)*5
	$Label.position.y = round(y/5)*5-200


func showpaperf(qual):
	cost = qual
	x=0
	d=1
	$Paper.position.y = 948
	$Label.position.y = 948-200
	y = 948
	$Paper.visible = true
	$Label.visible = true
	$Label.text = "<this is placeholder text for before the ai is made> QUALITY: "+str(qual)
	$Control/TextureButton.visible = true
	$Control/TextureButton2.visible = true


func _on_texture_button_pressed():
	currentmoney += round(cost*10000)/100
	$Label2.text = "$"+str(currentmoney)
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
	$Label2.text = "$"+str(currentmoney)
	$Label2.text = "$"+str(monkeycost)
	createnewmonkey()
