extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2), "timeout") 
	if PlayerMasterControls.options_menu_voice_played == false:
		play()
	PlayerMasterControls.options_menu_voice_played = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
