extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var player_body = get_owner().get_node("FPController/PlayerBody/KinematicBody")


var curr_target = null
var distance_to_target = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(player_body.translation, Vector3.UP) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(player_body.translation, Vector3.UP)
	var direction = player_body.global_transform.origin-global_transform.origin
	move_and_slide(direction.normalized()*1.5, Vector3.UP)
	
