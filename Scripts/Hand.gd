extends Node2D

const speed = 250
var direction = 1
var health = 1
const max_health = 1
var bullet_detection = RegEx.new()
var can_shoot: bool = true
var left: bool = false
var right: bool = false
var stop_standing = 0
var next_brick = randi_range(0,100)
signal game_lost
signal health_changed

#This gets the sprites that are not in the scene 
@onready var block = preload("res://Scenes/bricks/earth_brick.tscn")
@onready var fire_block = preload("res://Scenes/bricks/fire_brick.tscn")
@onready var sponge_brick = preload("res://Scenes/bricks/sponge_brick.tscn")

func _ready():
	bullet_detection.compile("^Area2D_of_bullet")
	next_brick_display()
	# Replace with function body.

func next_brick_display():
	if next_brick > 30: 
		$earth.visible = true
		$fire.visible = false
		$sponge.visible = false
	elif next_brick > 10:
		$earth.visible = false
		$fire.visible = false
		$sponge.visible = true
	else:
		$earth.visible = false
		$fire.visible = true
		$sponge.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #This makes the back and forth motion. The speed is multiplied by delta for consitency across diffrent computers.
	if right and position.x < 430:
		position.x += speed *delta
	elif left and position.x > 0:
		position.x -= speed *delta
	if health <= 0: # when dead a signal is relased and used somewhere else
		game_lost.emit()
		queue_free()
	for i in $Area2D.get_overlapping_areas(): # Checks for collison 
		if bullet_detection.search(str(i)) and i:
			health -= 1
			health_changed.emit()
	$CanvasLayer.offset = global_position
	
func spawn(item:Object): # This first instantiates an object (creates a version of it in memory). After it sets the objects x position to the x position of this sprite then finally adds the block to the main scene 
	var hold = item.instantiate()
	hold.position.x = position.x + 11 
	get_tree().current_scene.add_child(hold)
	
func _input(event): #This is used for player input and is as of 3/29/2025 being used to spwan eneimes
	if event.is_action_pressed("Space_key") and can_shoot: # Launches bricks
		var current_brick = next_brick
		next_brick = randi_range(0,100)
		can_shoot = false
		if current_brick > 30: spawn(block)
		elif current_brick > 10: spawn(sponge_brick)
		else: spawn(fire_block)
		next_brick_display()
		await get_tree().create_timer(.5).timeout
		can_shoot = true
	if event.is_action_pressed("ui_left") and position.x > 10:
		left = true
	if event.is_action_released("ui_left"):
		left = false
	if event.is_action_pressed("ui_right") and position.x < 430:
		right = true
	if event.is_action_released("ui_right"):
		right = false
