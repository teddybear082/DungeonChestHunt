extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var backgroundmusic = true
export var playername = "Guest"


onready var _left_controller = null
onready var _right_controller = null

var left_haptic = false
var right_haptic = false
var backgroundmusiclaststate = true
var backgroundmusictimestamp = 0.0
var chests_collected = 0
var options_menu_voice_played = false

signal background_music_state(state)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	handle_background_music()
	handle_player_controls()
	handle_player_sounds()
	handle_player_score()
	handle_player_lives()
	handle_player_health()
	handle_haptics()

func handle_background_music():
	if backgroundmusiclaststate != backgroundmusic:
		if backgroundmusic == true:
			emit_signal("background_music_state", true)
			backgroundmusiclaststate = backgroundmusic
		
		if backgroundmusic == false:
			emit_signal("background_music_state", false)
			backgroundmusiclaststate = backgroundmusic

func handle_player_controls():
	pass

func handle_player_sounds():
	pass
	
func handle_player_score():
	pass
	
func handle_player_lives():
	pass
	
func handle_player_health():
	pass
	
func handle_haptics():
	
	if left_haptic == true:
		_left_controller.set_rumble(.3) 
		yield(get_tree().create_timer(.2), "timeout") 
		_left_controller.set_rumble(0)
		left_haptic = false
		
	if right_haptic == true:
		_right_controller.set_rumble(.3) 
		yield(get_tree().create_timer(.2), "timeout") 
		_right_controller.set_rumble(0)
		right_haptic = false
