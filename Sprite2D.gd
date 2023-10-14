extends Sprite2D
var full = 0.0
@onready var x = position.x-1
var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	full += delta
	if full >= 0.4:
		i+=1
		if i > 7:
			position.x = -11
			x = -11
			position.y = 10
			i = 1
			full = full-0.4
		else:
			print(i)
			full = full-0.4
			position.y-=1
			x-=0.25
			position.x = round(x)
