extends Node2D
var end_hight =600

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var thing = position.y + 1000*delta
	if thing < end_hight:
		position.y += 1000*delta 
	else:
		position.y = end_hight
func set_x_y(x: float , y: float):
	position.x = x
	position.y = y

func _on_area_2d_area_entered(_area: Area2D) -> void:
	end_hight= position.y
