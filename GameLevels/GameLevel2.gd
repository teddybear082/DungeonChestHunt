extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var victoryheight = 0
var already_won = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$OverlayHelper/OverlayLabel3D.text = "Climb to the top to beat the level!"
	yield(get_tree().create_timer(4), "timeout")
	$Voiceovers.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $FPController/PlayerBody/KinematicBody.global_transform.origin.y > victoryheight:
		if already_won == false:
			$OverlayHelper/OverlayLabel3D.text = "You won and made it to the top! Returning to options menu..."
			already_won = true
			PlayerMasterControls.chests_collected +=1
			yield(get_tree().create_timer(10), "timeout")
			get_tree().change_scene("res://GameLevels/GameOptionsLevel.tscn")
	if $FPController.transform.origin.y < -2:
		$FPController.transform.origin = Vector3(0,0,22)		


func _on_ClimbingNodeGenerator_victory_platform_generated(transformy):
	victoryheight = transformy # Replace with function body.
