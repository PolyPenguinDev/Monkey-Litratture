extends Node2D
signal showpaper(qual)
signal select(num, qual)
var rng = RandomNumberGenerator.new()
var MONKENUM
var mousin = false
var mouseex = true
var quality
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().delete_monke.connect(delete)
	$AnimatedSprite2D.play("default")
	var nameIndx = randi_range(0,99)
	var name = ['Ber','Lileoo','Ludddddy','Loo','Be','Be','Be','Zocy','Coelocker','Lunax','Liedy','Budddilerly','Loe','Beddddy','Ducy','Chaisy','Cooliea','Tedy','Ter','Dunar','Be','Lie','Sa','Ropey','Co','Sailarllle','Sax','Zope','Baiey','Saisy','Sterle','Tedie','Dady','Ducky','Mie','Ba','Ste','Lisy','Stedy','Baisy','Darllillla','Budy','Locy','Cha','Zopeope','Duckellly','Barliela','Be','Lely','Cha','Mar','Beopey','Liedy','Lunax','Mie','Lie','Budy','Luke','Te','Be','Lila','Luky','Buna','Ludy','Zope','Bey','Misy','Dunax','Te','Loe','Zoope','Lucky','Bar','Te','Lunar','ChaMaile','Loo','Luckea','Zoeo','Be','Le','MaMaillarladdily','Beloear','Le','Dax','Luddy','Lie','Zocy','Telar','Tea','Da','Buddiladdddy','Rolopey','Roooliearleocy','Rooely','Lieoe','Zolady','Le','Sterlar','Bailo'][nameIndx]
	$Label.text = name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mousin and mouseex and Input.is_action_just_pressed("click"):
		emit_signal("select", MONKENUM, quality)
		$Sprite2D.visible = not $Sprite2D.visible


func _on_sprite_2d_stop():
	$AnimatedSprite2D.stop()


func _on_sprite_2d_start():
	$AnimatedSprite2D.play("default")
	emit_signal("showpaper", quality+rng.randf_range(-0.3, 0.3))
func delete(nums):
	if MONKENUM in nums:
		queue_free()
	elif nums[0]<MONKENUM:
		MONKENUM -= 1
		var usable = MONKENUM
		if MONKENUM > 6:
			usable -= 6
			position.y = 465
		else:
			position.y = 165
		position.x =usable * 200 -25
	if nums[1]<MONKENUM:
		MONKENUM -= 1
		var usable = MONKENUM
		if MONKENUM > 6:
			usable -= 6
			position.y = 465
		else:
			position.y = 165
		position.x =usable * 200 -25

func _on_area_2d_2_mouse_entered():
	mousin = true


func _on_area_2d_2_mouse_exited():
	mousin = false


func _on_area_2d_mouse_entered():
	mouseex = false


func _on_area_2d_mouse_exited():
	mouseex = true
