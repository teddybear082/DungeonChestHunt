extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	preload("res://GameLevels/GameOptionsLevel.tscn") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_InteractableHandle_lever_distance(distance):
#	print(str(distance))
#	if distance > 0.1:
#		get_tree().change_scene("res://GameLevels/GameLevel1.tscn") # Replace with function body.


func _on_InteractableHinge_hinge_moved(angle):
	if angle == -45:
		get_tree().change_scene("res://GameLevels/GameOptionsLevel.tscn")# Replace with function body.
