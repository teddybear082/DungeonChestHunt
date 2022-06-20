extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$BackgroundMusic.play(PlayerMasterControls.backgroundmusictimestamp)
	#mesh.text = "Dungeon Chest Hunt"
	#yield(get_tree().create_timer(6), "timeout")# Replace with function body.
	#mesh.text = "Dungeon Chest Hunt \nPress A to Start..."
	#yield(get_tree().create_timer(5), "timeout")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
