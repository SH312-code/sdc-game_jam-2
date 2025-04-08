extends Node2D
var score = 0
var max_enemy = 1
@onready var enemy = preload("res://Scenes/hostile/shooting_enemy.tscn")
var dt = 0
var game = true
var existing_enemies = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void: # Replace with function body.
	$Hand.game_lost.connect(end) # This connects the signal that is emited to an action, the end function
	$TextureRect.texture = load("res://Sprites/game.png")
	$Label.add_theme_font_size_override("font_size", 19) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt += delta
	'''if dt > .25 and game and existing_enemies < max_enemy: # This is to prevent 30 enemys on the field in the begining, diffictlty climbs with experince and also bricks count as childeren
		dt -= .25
		existing_enemies += 1 
		#spawn new enemy
		var hold = enemy.instantiate()
		hold.died.connect(update_score)
		hold.set_x_y(randi_range(6, 500), 509)
		get_tree().current_scene.add_child(hold)
	if !game:
		for i in get_children():
			if i != $TextureRect and i != $Label:
				i.queue_free()
		$TextureRect.texture = load("res://Sprites/game_over.png")
		$Label.global_position = Vector2(200, 440)
		$Label.add_theme_font_size_override("font_size", 30) '''
	
func update_score(): # https://docs.godotengine.org/en/stable/getting_started/first_2d_game/06.heads_up_display.html
	score += 1
	existing_enemies -= 1
	var random_progress = randi_range(1,2)
	if random_progress > 1:
		max_enemy += 1
	$Label.text = "Score: " + str(score)
func end(): # I can't figure out if Godot has lambda so I just made a function to call
	game = false
