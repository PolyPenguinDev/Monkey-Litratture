extends Node2D
signal showpaper()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sprite_2d_stop():
	$AnimatedSprite2D.stop()


func _on_sprite_2d_start():
	$AnimatedSprite2D.play("default")
	emit_signal("showpaper")
