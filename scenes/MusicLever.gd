extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InteractableHinge_hinge_moved(angle):
	if angle == -45:
		PlayerMasterControls.backgroundmusic = false
		$MusicTextMeshLine2.mesh.text = "Off" # Replace with function body.
	if angle >= 0:
		PlayerMasterControls.backgroundmusic = true
		$MusicTextMeshLine2.mesh.text = "On"
