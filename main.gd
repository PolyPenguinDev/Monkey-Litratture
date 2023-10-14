extends Node2D
var y = 298
var x = 0
var d = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x+=delta*1000*d
	
	if x <0:
		x = 0
	if x > 1000:
		x = 1000
	y = ((2**(-(x-1000)/101.125087))/948.0)*650+298
	$Paper.position.y = round(y/5)*5
	$Label.position.y = round(y/5)*5-200


func _on_monkey_showpaper():
	x=0
	d=1
	$Paper.position.y = 948
	$Label.position.y = 948-200
	y = 948
	$Paper.visible = true
	$Label.visible = true
	$Control/TextureButton.visible = true
	$Control/TextureButton2.visible = true


func _on_texture_button_pressed():
	x=1000
	d=-1
	$Paper.position.y = 298
	$Label.position.y = 298-200
	y = 298
	$Paper.visible = true
	$Label.visible = true
	$Control/TextureButton.visible = false
	$Control/TextureButton2.visible = false
