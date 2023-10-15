extends Sprite2D
var full = 0.0
@onready var x = -1
@onready var p = get_parent()
var mousein = false
signal stop()
signal start()
var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	full += delta
	if i > 6 and ((Input.is_action_pressed("click") and mousein)):
		p.position.x = 0
		x = -1
		p.position.y = 0
		i = 1
		emit_signal("start")
	if full >= 2:
		i+=1
		if i > 7:
			if i == 8:
				emit_signal("stop")
			
			full = full-2
		else:
			full = full-2
			p.position.y-=5
			x-=0.25
			p.position.x = round(x)*5


func _on_area_2d_mouse_entered():
	mousein = true


func _on_area_2d_mouse_exited():
	mousein = false
