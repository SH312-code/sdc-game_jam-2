extends Node2D
var dt =0
func _ready() -> void:
	modulate = Color(255,0,0) # Changes color to red
func _process(delta: float) -> void:
	dt += delta
	if dt > 3:
		queue_free() # Fire briks die after 3 seconds to create a more balenced game 
func set_x_y(x: float , y: float): #Called in diffrent node for spwaning at hand sprite
	position.x = x
	position.y = y
