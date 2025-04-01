extends Node2D
var direction = 1
@onready var bullet = preload("res://Scenes/bullet.tscn")
var dt =0
var regex = RegEx.new()
var regex2 = RegEx.new()
signal died
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(0,0,255) 
	regex.compile("^Area2D2") 
	regex2.compile("^Area2D_for_damage")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt += delta
	position.x += 250 *delta*direction
	if position.x > 500 or position.x < 0:
		direction *= -1
	if dt > 1:
		dt -= 1
		var hold = bullet.instantiate()
		hold.set_x_y(position.x, position.y) 
		get_tree().current_scene.add_child(hold)
	for i in $Area2D_for_damage.get_overlapping_areas():
		if not regex.search(str(i)):
			died.emit()
			#print("Killed")
			queue_free()
	if len($Area2D2.get_overlapping_areas()) != 0:
			position.y -= 1
	else:
		position.y += 1
func set_x_y(x: float, y: float):
	position = Vector2(x,y)
