extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("StandardWalk")
	$Node2/Skeleton/LeftHandIK.start(false)
	$Node2/Skeleton/RightHandIK.start(false) # Replace with function body.
	$Node2/Skeleton/HeadIK.start(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_transform = get_owner().get_node("FPController").global_transform
	global_scale(Vector3(.009,.009,.009))
	global_transform.origin.y = .9
	rotation.y = get_owner().get_node("FPController/ARVRCamera").rotation.y
	

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("StandardWalk") # Replace with function body.


func _on_PlayerBody_player_jumped():
	$AnimationPlayer.play("Jump") # Replace with function body.
