extends Node2D
var direction = 1 
var shoot_delay = randf_range(.5, 2)
var speed = randi_range(150, 350)
@onready var bullet = preload("res://Scenes/bullet.tscn")
var dt =0 #timer
var regex = RegEx.new() # check string
var regex2 = RegEx.new()# there are 2 strings that neeed to be chekced for diffrent criteria
signal died
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(0,0,255) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt += delta
	position.x += speed *delta*direction # moves the sprite
	if position.x > 500 or position.x < 0: # checks if out of bounds
		direction *= -1 # changes direction if out of bounds
	if dt > shoot_delay: #spawns bullet every second
		dt -= shoot_delay
		var hold = bullet.instantiate()
		hold.set_x_y(position.x, position.y) 
		get_tree().current_scene.add_child(hold) 
	#When climbing they take no damage other wise they are vunerable. This makes the fire brick useful for stratgies 
	if len($Area2D2.get_overlapping_areas()) != 0: # this allows the bricks to climb
			position.y -= 1
	else: # prevents them standing on air
		position.y += 1
		if len($Area2D_for_damage.get_overlapping_areas()) > 0: #checks for collions The reason it is here is to prevent the same brick they climb from killing them
			died.emit()
			queue_free()
func set_x_y(x: float, y: float):
	position = Vector2(x,y)
func kill():
	queue_free()
