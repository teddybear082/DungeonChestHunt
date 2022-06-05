extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var controller = null
var velocity = Vector3(0,0,0)
var km_collision = null
var button_states = []
var starting_position = null
# Called when the node enters the scene tree for the first time.
func _ready():
	controller = get_owner().get_node("FPController/RightHandController") # Replace with function body.
	global_transform = controller.global_transform
	global_transform.origin += Vector3(0,0,-.30)
	starting_position = global_transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_transform=controller.global_transform
	transform.origin+=Vector3(0,0,-.30)
	if button_pressed(controller.get_node("Function_Pickup").action_button_id):
		km_collision = move_and_collide(Vector3(0,0,-15)*.2)
		print(str(km_collision))
		#if km_collision:
		#	global_transform = controller.global_transform
		#	global_transform.origin+= Vector3(0,0,-.30)
		
func button_pressed(b):
	if controller.is_button_pressed(b) and !button_states.has(b):
		button_states.append(b)
		return true
	if not controller.is_button_pressed(b) and button_states.has(b):
		button_states.erase(b)
	
	return false
	
