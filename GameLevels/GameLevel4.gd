extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$OverlayHelper/OverlayLabel3D.text = "Use all of your skills to beat the level!"
	yield(get_tree().create_timer(4), "timeout")
	$Voiceovers.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
