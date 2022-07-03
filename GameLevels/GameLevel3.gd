extends Spatial

var victoryheight = 0
var already_won = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$OverlayHelper/OverlayLabel3D.text = "Grapple and climb to the top to beat the level!"
	yield(get_tree().create_timer(4), "timeout")
	$Voiceovers.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $FPController/PlayerBody/KinematicBody.global_transform.origin.y > victoryheight+.5:
		if already_won == false:
			$OverlayHelper/OverlayLabel3D.text = "You won and made it to the top! Returning to options menu..."
			already_won = true
			PlayerMasterControls.chests_collected += 1
			yield(get_tree().create_timer(10), "timeout")
			get_tree().change_scene("res://GameLevels/GameOptionsLevel.tscn")
	if $FPController/PlayerBody/KinematicBody.global_transform.origin.y < -2:
		$FPController.global_transform.origin = Vector3(0,0,21.250)		



func _on_GrappleSpawner_victory_platform_generated(yorigin):
	victoryheight = yorigin
