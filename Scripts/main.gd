extends Node2D
var score = 0
var max_enemy = 10
@onready var enemy = preload("res://Scenes/shooting_enemy.tscn")
var dt = 0
var game = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void: # Replace with function body.
	$Hand.game_lost.connect(end) # This connects the signal that is emited to an action, the end function

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt += delta
	#print(get_child_count(false))
	if dt > 1 and game and get_child_count(false) < max_enemy: # This is to prevent 30 enemys on the field in the begining, diffictlty climbs with experince and also bricks count as childeren
		dt -= 1
		max_enemy += 1
		#spawn new enemy
		var hold = enemy.instantiate()
		hold.died.connect(update_score)
		hold.set_x_y(randi_range(6, 500), 509)
		get_tree().current_scene.add_child(hold)
	if !game:
		await get_tree().create_timer(.5).timeout # If the player is dead game closes
		get_tree().quit()
	
func update_score():
	#print("Changed") # https://docs.godotengine.org/en/stable/getting_started/first_2d_game/06.heads_up_display.html
	score += 1
	$Label.text = "Score: " + str(score)
func end(): # I can't figure out if Godot has lambda so I just made a function to call
	game = false
