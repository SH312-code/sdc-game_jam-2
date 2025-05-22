extends Node2D

var searching_for_fire_brick = RegEx.new()	 #https://docs.godotengine.org/en/stable/classes/class_regex.html
var searching_for_floor = RegEx.new()
var falling = true
var type = 'earth'
var can_process_collision = true
var collision_behavior = func():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	searching_for_fire_brick.compile("^Area2D_fire")#This is a regular exprsion used for string lookups. The ^ means to start maching characters at the begining of a string. It then checks if the first part of the string matches the criteria. In this case that criteria is the first part of the string is "Area2D_fire". The last part of the string can be anything. This is faster then looping throgh a list of every character in the string
	searching_for_floor.compile("^FloorArea2D") 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		for overlapped_area in $RigidBody2D.get_child(2).get_overlapping_areas():
			if falling:
				if GlobalVariables.SEARCHING_FOR_BRICK.search(str(overlapped_area)):
					var overlapped_brick = overlapped_area.get_parent().get_parent()
					if not overlapped_brick.falling:
						falling = false
						
				elif searching_for_floor.search(str(overlapped_area)):
					falling = false
			if can_process_collision: collision_behavior.call()

func refall():
	for overlapped_area in $RigidBody2D.get_child(2).get_overlapping_areas():
		if GlobalVariables.SEARCHING_FOR_BRICK.search(str(overlapped_area)):
			var connected_brick = overlapped_area.get_parent().get_parent()
			if not connected_brick.falling:
				connected_brick.falling = true
				connected_brick.refall()

func destroy():
	refall()
	queue_free()

func set_x_y(x: float , y: float): #Called in diffrent node for spwaning at hand sprite
	position.x = x
	position.y = y

func set_collision_behavior(behavior: Callable):
	collision_behavior = behavior
