tool
class_name Function_Max_Payne_Dive_movement
extends MovementProvider

##
## Movement Provider for Max Payne Style Diving Bullet Time Movement
##
## @desc:
##     This script provides "Max Payne Dive" movement aka player dives to the side in slow motion.  The user
##     can determine for how long it works and what button triggers the motion.
##


## Movement provider order
export var order := 45

## Length of bullet time effect
export var max_payne_time := 1.25

## Set ease in and out time
export var max_payne_ease := .25

## Set max payne dive speed (impacts how long it takes to get from beginning to end of dive motion)
export var max_payne_dive_speed = 2

## Set max payne dive lateral distance in units
export var max_payne_dive_distance = 4

## Set max payne dive height in units
export var max_payne_dive_height = 1.5

## Bullet time scale (percentage of engine speed)
export var max_payne_time_scale = .20

## Normal time scale
export var normal_time_scale = 1.0

## Determine if max payne dive is active or not
var is_max_payne_diving := false

## enum our buttons, should find a way to put this more central
enum Buttons {
	VR_BUTTON_BY = 1,
	VR_GRIP = 2,
	VR_BUTTON_3 = 3,
	VR_BUTTON_4 = 4,
	VR_BUTTON_5 = 5,
	VR_BUTTON_6 = 6,
	VR_BUTTON_AX = 7,
	VR_BUTTON_8 = 8,
	VR_BUTTON_9 = 9,
	VR_BUTTON_10 = 10,
	VR_BUTTON_11 = 11,
	VR_BUTTON_12 = 12,
	VR_BUTTON_13 = 13,
	VR_PAD = 14,
	VR_TRIGGER = 15
}

## Bullet time activate button
export (Buttons) var max_payne_dive_button_id = Buttons.VR_BUTTON_BY

## Controller node
onready var _controller : ARVRController = get_parent()

## ARVR Camera node
onready var _arvrcamera = get_parent().get_parent().get_node("ARVRCamera")

## PlayerBody node
onready var _playerbody = get_parent().get_parent().get_node("PlayerBody")

## Variable to stop buttons from triggering action again when held by player
var button_states = []

## Tell other nodes when Bullettime is active or not
signal player_max_payne_dove
signal player_stopped_max_payne_diving


# Activate max payne dive
func physics_movement(delta: float, player_body: PlayerBody, is_active: bool):
	
	# Skip if the controller isn't active
	if !_controller.get_is_active():
		return

	# Toggle bullet time on button press
	if button_pressed(max_payne_dive_button_id):
		is_max_payne_diving = !is_max_payne_diving
		if is_max_payne_diving:
			#code for slowing down world, starting timer and tween, naturally end if no intervention
			emit_signal("player_max_payne_dove")
			$MP_Sound.play()
			$MP_Tween.stop_all()
			
			
			#trigger start of player movement into dive
			
			#get current player position before movement started
			var curr_transform = player_body.kinematic_node.global_transform #could try regular transform instead
			
			
			#pick designated "dive" target point
			var leap_target = curr_transform.translated(Vector3(-max_payne_dive_distance * ARVRServer.world_scale, max_payne_dive_height * ARVRServer.world_scale, 0))  #give a vector to a global transform origin that will be the target of the leap
			#var leap_target = leap_target.orthonormalized() #possible to try
			#var leap_target = curr_transform.origin - Vector3(-4,0,0) #possible to try
			#var leap_target_x = curr_transform.origin.x - 4
			#var leap_target_y = curr_transform.origin.y + 1
			#var leap_target = Vector3(leap_target_x, leap_target_y, curr_transform.z)  #possible to try then would modify the reference to leap target origin below to just leap target
			
			
			#start moving player toward dive point
			player_body.velocity = player_body.move_and_slide(leap_target.origin - curr_transform.origin) * max_payne_dive_speed * ARVRServer.world_scale
			
			#slow time to max payne time while diving
			Engine.time_scale = max_payne_time_scale
			$MP_Tween.interpolate_property(Engine, "time_scale", Engine.time_scale, max_payne_time_scale, max_payne_ease, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			$MP_Tween.start()
			yield($MP_Tween, "tween_completed")
			yield(get_tree().create_timer(max_payne_time), "timeout")
			Engine.time_scale = normal_time_scale 
			is_max_payne_diving = false
			return true
			
		if is_max_payne_diving == false:	
			emit_signal("player_stopped_max_payne_diving")
			$MP_Tween.stop_all()
			$MP_Tween.interpolate_property(Engine, "time_scale", Engine.time_scale, normal_time_scale, max_payne_ease, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			$MP_Tween.start()
			yield($MP_Tween, "tween_completed")
			$MP_Sound.play()
				


func button_pressed(b):
	if _controller.is_button_pressed(b) and !button_states.has(b):
		button_states.append(b)
		return true
	if not _controller.is_button_pressed(b) and button_states.has(b):
		button_states.erase(b)
	
	return false
	
# This method verifies the MovementProvider has a valid configuration.
func _get_configuration_warning():
	# Check the controller node
	var test_controller = get_parent()
	if !test_controller or !test_controller is ARVRController:
		return "Unable to find ARVR Controller node"

	# Call base class
	return ._get_configuration_warning()
