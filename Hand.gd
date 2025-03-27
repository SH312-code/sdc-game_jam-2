extends Node2D

var speed = 250
var direction = 1
@onready var block = preload("res://earth_brick.tscn")
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * direction * delta
	if position.x < 0 or position.x > 500 -70:
		direction = direction * (-1)
func _input(event):
	if event.is_action_pressed("S_key"):
		var earth = block.instantiate()
		earth.position.x = position.x
		get_tree().current_scene.add_child(earth)
		
