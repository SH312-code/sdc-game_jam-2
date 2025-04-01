extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(0,0,255)  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= 500 *delta
	if position.y < 0: # Bullets despawn when of screen
		queue_free()
func set_x_y(x: float, y: float):
	position = Vector2(x,y)
