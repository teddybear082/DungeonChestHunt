extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var backgroundmusic = true
onready var bgmusicaudiostream = get_owner().get_node("BackgroundMusic")
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


func handle_background_music():
	if backgroundmusic == true:
		if bgmusicaudiostream.playing == true:
			return
		bgmusicaudiostream.play()
	if backgroundmusic == false:
		if bgmusicaudiostream.playing == false:
			return
		bgmusicaudiostream.stop()

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
	
