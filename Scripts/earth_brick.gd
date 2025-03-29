extends Node2D
# Called when the node enters he scene tree for the first time.
func _ready():
	modulate = Color(0,255,0) # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func set_x_y(x: float , y: float): #Called in diffrent node for spwaning at hand sprite
	position.x = x
	position.y = y
