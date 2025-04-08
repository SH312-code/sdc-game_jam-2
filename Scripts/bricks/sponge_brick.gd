extends "base_brick.gd"

var fire_brick_hits = 1

func _ready() -> void:
	super()
	type = 'sponge'

func decrease_hits():
	fire_brick_hits -= 1
	if fire_brick_hits < 0:
		queue_free()
