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
	$Label.text = str(round(rng.randf_range(0, 10000)))


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
