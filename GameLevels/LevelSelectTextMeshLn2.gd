extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelSelectSliderSnap_level_chosen(level):
	if level == 0:
		mesh.text = "Level" # Replace with function body.
	if level > 0:
		mesh.text = "Level " + str(level)
	