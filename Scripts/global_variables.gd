extends Node

const LEFT_BOUND = 0
const RIGHT_BOUND = 450
const PLAYER_WIDTH = 104
const SCREEN_HEIGHT = 648
var SEARCHING_FOR_BRICK = RegEx.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	SEARCHING_FOR_BRICK.compile("^brick_floor_dectection")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func funkytown():
	print("recieverered")
