extends Node2D

var speed = 250
var direction = 1
@onready var block = preload("res://Scenes/earth_brick.tscn")
@onready var fire_block = preload("res://Scenes/fire_brick.tscn")
@onready var sponge_block = preload("res://Scenes/sponge_brick.tscn")
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
	elif event.is_action_pressed("F_key"):
		var fire = fire_block.instantiate()
		fire.position.x = position.x
		get_tree().current_scene.add_child(fire)
	elif event.is_action_pressed("A_key"):
		var sponge = sponge_block.instantiate()
		sponge.position.x = position.x
		get_tree().current_scene.add_child(sponge)
