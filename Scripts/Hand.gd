extends Node2D

var speed = 250
var direction = 1
#This gets the sprites that are not in the scene 
@onready var block = preload("res://Scenes/earth_brick.tscn")
@onready var fire_block = preload("res://Scenes/fire_brick.tscn")
@onready var sponge_block = preload("res://Scenes/sponge_brick.tscn")
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #This makes the back and forth motion. The speed is multiplied by delta for consitency across diffrent computers.
	position.x += speed * direction * delta
	if position.x < 0 or position.x > 500 -70: #The direction is multipled by -1 if it is outside the borader so it turns around when it hits the sides
		direction = direction * (-1)
func spawn(item:Object): # This first instantiates an object (creates a version of it in memory). After it sets the objects x position to the x position of this sprite then finally adds the block to the main scene 
	var hold = item.instantiate()
	hold.position.x = position.x
	get_tree().current_scene.add_child(hold)
	
func _input(event): #This is used for player input and is as of 3/29/2025 being used to spwan eneimes
	if event.is_action_pressed("S_key"):
		spawn(block)
	elif event.is_action_pressed("F_key"):
		spawn(fire_block)
	elif event.is_action_pressed("A_key"):
		spawn(sponge_block)
