extends TextureProgressBar #https://www.reddit.com/r/godot/comments/174s1n6/how_to_make_a_health_bar_in_godot_4_also_known_as/

@onready var Hand = get_parent().get_parent().get_parent().get_node("Hand") # I had to do back untill I got to root main that is why there are so many get parent
# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	Hand.health_changed.connect(update)
	update() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = (Hand.health * 100)/10
