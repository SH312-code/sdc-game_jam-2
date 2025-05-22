extends Node2D

var direction = 1 
var shoot_delay = randf_range(.5, 2)
var speed = randi_range(150, 350)
var can_rotate = true
var dt = 0.0
var spawned = false
var killable = false
signal died
@onready var bullet = preload("res://Scenes/hostile/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready(): # changes color of canvas texture
	var r = randf_range(0, 1)
	var g = randf_range(0, 1)
	var b = randf_range(0, 1)
	modulate = Color(r, g, b)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dt += delta
	if dt > 0.5 and not killable:
		killable = true
	if dt > 0.01 and not spawned:
		spawned = true
		for area_colliding in $EnemyArea.get_overlapping_areas():
			if GlobalVariables.SEARCHING_FOR_BRICK.search(str(area_colliding)):
				area_colliding.get_parent().get_parent().destroy()
	var movement_amount = delta * speed * direction
	if movement_amount + position.x > GlobalVariables.RIGHT_BOUND or movement_amount + position.x < GlobalVariables.LEFT_BOUND:
		direction *= -1
	else:
		position.x += movement_amount
	can_rotate = true
	if dt > shoot_delay: #spawns bullet every second
		dt -= shoot_delay
		var hold = bullet.instantiate()
		hold.set_x_y(position.x, position.y) 
		get_tree().current_scene.add_child(hold) 

func _on_enemy_area_area_entered(area):
	var parent_area = area.get_parent().get_parent()
	if parent_area.falling and killable: 
		died.emit()
		queue_free()
	elif can_rotate:
		direction *= -1
		can_rotate = false
