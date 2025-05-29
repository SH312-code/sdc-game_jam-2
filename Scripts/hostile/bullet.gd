extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  #pReplace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= 500 *delta
	if position.y < 0: # Bullets despawn when of screen
		queue_free()
func set_x_y(x: float, y: float):
	position = Vector2(x,y)
	


func _on_area_2d_of_bullet_area_entered(area: Area2D): # Replace with function body.
	if GlobalVariables.SEARCHING_FOR_BRICK.search(str(area)):
		var brick = area.get_parent().get_parent()
		if !brick.falling:
			brick.shot()
		queue_free()
