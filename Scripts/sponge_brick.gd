extends Node2D

var regex = RegEx.new() # RegEx is for string lookup
var durribilty = 2
var old_areas = [] #Never has more then 2 values
var dt = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	regex.compile("^Area2D_fire") #This is a regular exprsion used for string lookups. The ^ means to start maching characters at the begining of a string. It then checks if the first part of the string matches the criteria. In this case that criteria is the first part of the string is "Area2D_fire". The last part of the string can be anything. This is faster then looping throgh a list of every character in the string

func _process(delta: float) -> void:
	dt += delta
	for i in $RigidBody2D/Area2D.get_overlapping_areas(): # More or less the same as the method for the earth block. It adds the value of i to the old_areas to prevent it from reacting to the same block twice
		if regex.search(str(i)) and i not in old_areas:
			durribilty -= 1
			old_areas.append(i)
	if durribilty <= 0 or dt > 10:
		#await get_tree().create_timer(.5).timeout # The reason for this is if we want to add a breaking animnation
		queue_free()
func set_x_y(x: float , y: float): #Called in diffrent node for spwaning at hand sprite
	position.x = x
	position.y = y
