extends Node2D

var direction = 1 
var shoot_delay = randf_range(.5, 2)
var speed = randi_range(150, 350)
var can_rotate = true
@onready var bullet = preload("res://Scenes/hostile/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready(): # changes color of canvas texture
	modulate = Color(0,0,255) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_amount = delta * speed * direction
	if movement_amount + position.x > GlobalVariables.RIGHT_BOUND or movement_amount + position.x < GlobalVariables.LEFT_BOUND:
		direction *= -1
	else:
		position.x += movement_amount
	can_rotate = true

func _on_enemy_area_area_entered(area):
	var parent_area = area.get_parent().get_parent()
	if parent_area.falling: 
		queue_free()
	elif can_rotate:
		direction *= -1
		can_rotate = false
