extends Node2D

func _ready() -> void:
	modulate = Color(255,0,0)
func _process(_delta: float) -> void:
	pass
func set_x_y(x: float , y: float): #Called in diffrent node for spwaning at hand sprite
	position.x = x
	position.y = y
