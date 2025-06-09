extends "base_brick.gd"

var dt = 0

func _process(delta: float) -> void:
	super(delta)
	dt += delta
	if dt > 2.5:
		queue_free() # Fire briks die after 3 seconds to create a more balenced game otherwise all sprites will ie on contact

func _ready() -> void:
	super()
	type = 'fire'
	#This is the logic for how the fire brick destroys blocks
	collision_behavior = func():
		for overlapped_area in $RigidBody2D.get_child(2).get_overlapping_areas():
			if GlobalVariables.SEARCHING_FOR_BRICK.search(str(overlapped_area)):
				var overlapped_brick = overlapped_area.get_parent().get_parent()
				if overlapped_brick.type == 'sponge':
					overlapped_brick.decrease_hits()
					can_process_collision = false
				else:
					overlapped_brick.destroy()# Changed from queue free as refall needed to be called
