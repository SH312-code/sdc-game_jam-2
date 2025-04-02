extends Node2D
var regex = RegEx.new()	 #https://docs.godotengine.org/en/stable/classes/class_regex.html
var dt = 0
func _ready():
	modulate = Color(0,255,0) 
	#https://docs.godotengine.org/en/stable/classes/class_regex.html
	regex.compile("^Area2D_fire")#This is a regular exprsion used for string lookups. The ^ means to start maching characters at the begining of a string. It then checks if the first part of the string matches the criteria. In this case that criteria is the first part of the string is "Area2D_fire". The last part of the string can be anything. This is faster then looping throgh a list of every character in the string

func _process(delta): # The way collions work is by looping throgh a list of every item in contact with the sprite, this is the reson for the area 2d as a child of the rigid body, for each item in the list I am using a regular exprssion to perform string serches to make sure it is a fire block, if it is I wait half a second and then kill the block
	dt += delta
	for i in $RigidBody2D/Area2D_earth.get_overlapping_areas():
		if regex.search(str(i)):
			#await get_tree().create_timer(.5).timeout# The reason for this is if we want to add a breaking animnation
			queue_free()
func set_x_y(x: float , y: float): #Called in diffrent node for spwaning at hand sprite
	position.x = x
	position.y = y
