extends Node2D
signal showpaper(qual)
var rng = RandomNumberGenerator.new()
@onready var quality = rng.randf_range(0.0, 1.0)

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
	emit_signal("showpaper", quality+rng.randf_range(-0.3, 0.3))
