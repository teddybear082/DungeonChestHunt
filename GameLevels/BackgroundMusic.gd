extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerMasterControls.connect("background_music_state", self, "on_music_state_changed") # Replace with function body.

func on_music_state_changed(state):
	if state == true:
		play()
	if state == false:
		stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerMasterControls.backgroundmusic == true and is_playing() == false:
		play()
	if PlayerMasterControls.backgroundmusic == false:
		stop()
