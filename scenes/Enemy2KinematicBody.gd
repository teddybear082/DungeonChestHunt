extends KinematicBody


onready var player_body = get_owner().get_node("FPController/PlayerBody/KinematicBody")

#set enemy parameters
export var enemy_speed = 1.5
export var enemy_health = 100
export var enemy_dmg_per_hit = 50
export var enemy_pwr_per_hit = 10
export var enemy_attack_range = 1.5
export var enemy_alert_range = 6

#set other necessary variables
var curr_target = null
var distance_to_target = 0
var enemy_velocity = Vector3.ZERO
var height_offset = 0
var direction = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	height_offset = ARVRServer.world_scale * Vector3(0,1,0)
	look_at(player_body.translation+height_offset, Vector3.UP) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#check distance from player every frame
	enemy_velocity = Vector3.ZERO
	direction = player_body.global_transform.origin+height_offset-global_transform.origin
	#print("Direction is " + str(direction))
	distance_to_target = direction.length()
	#print("Distance to target is " + str(distance_to_target))
	enemy_velocity = direction.normalized()*enemy_speed
	#print("Enemy velocity is " + str(enemy_velocity))
	
	#run function to determine which anmiation is going to play 
	#or move enemy based on distance from player
	perform_enemy_animation(distance_to_target)
	
	
	
func perform_enemy_animation(distance):
	
	if distance_to_target >= enemy_alert_range:
		$Enemy2Mesh/AnimationPlayer.play("Idle")
	
	
	if distance_to_target <= enemy_attack_range:
		#$EnemyMesh1/AnimationPlayer.animation_set_next("MutantWalking", "MutantPunch")
		var attackchoices = ["ZombieAttack", "StandingMeleeAttackDownward", "StandingMeleePunch", "ZombiePunching"]
		var attackselection = (randi() % 4)
		var playingattack = attackchoices[attackselection]
		$Enemy2Mesh/AnimationPlayer.animation_set_next($Enemy2Mesh/AnimationPlayer.current_animation, playingattack)

	
	if distance_to_target > enemy_attack_range and distance_to_target < enemy_alert_range:
		$Enemy2Mesh/AnimationPlayer.play("Walk")
	#	print("Enemy moved and slid")
		look_at(player_body.translation+height_offset, Vector3.UP)
		enemy_velocity = move_and_slide(enemy_velocity, Vector3.UP)
	