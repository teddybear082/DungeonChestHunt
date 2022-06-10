extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#onready var player_body = get_owner().get_node("FPController/PlayerBody/KinematicBody")
onready var player_body = get_tree().current_scene.get_node("FPController/PlayerBody/KinematicBody")
#onready var player_body = get_node("/root/World/FPController/PlayerBody/KinematicBody")
#onready var player_body = get_node("/root/FPController/PlayerBody/KinematicBody")
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
var enemy_alive = true
var death_anim_playing = false

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
	perform_enemy_animation(distance_to_target, enemy_alive)
	if enemy_alive == false:
		yield($EnemyMesh1/AnimationPlayer, "animation_finished") 
		queue_free()
	
	
func perform_enemy_animation(distance, isEnemyAlive):
	if isEnemyAlive == false and death_anim_playing == false:
		var deathchoices = ["DeathFromRight", "FallingBackDeath", "FlyingBackDeath", "MutantDying", "StandingDeathForward02"]
		var deathselection = (randi() % 5)
		var playingdeath = deathchoices[deathselection]
#		$EnemyMesh1/AnimationPlayer.stop()
#		$EnemyMesh1/AnimationPlayer.animation_set_next($EnemyMesh1/AnimationPlayer.current_animation, playingdeath)
#		$EnemyMesh1/AnimationPlayer.advance(0)
		$EnemyMesh1/AnimationPlayer.play(playingdeath)
		$EnemySounds.play()
#		print("performing death anim")
#		$EnemyMesh1/AnimationPlayer.advance(0)
#		yield($EnemyMesh1/AnimationPlayer, "animation_finished")
		death_anim_playing = true
		return
	
	if isEnemyAlive == true:	
#		print("running alive scripts")
		if distance_to_target >= enemy_alert_range:
			$EnemyMesh1/AnimationPlayer.play("MutantBreathingIdle")
			return
		
		if distance_to_target <= enemy_attack_range:
			#$EnemyMesh1/AnimationPlayer.animation_set_next("MutantWalking", "MutantPunch")
			var attackchoices = ["MutantPunch", "MutantSwiping"]
			var attackselection = (randi() % 2)
			var playingattack = attackchoices[attackselection]
			$EnemyMesh1/AnimationPlayer.animation_set_next($EnemyMesh1/AnimationPlayer.current_animation, playingattack)
	#		$EnemyMesh1/AnimationPlayer.play(playingattack)
	#		$EnemyMesh1/AnimationPlayer.advance(0)
			yield($EnemyMesh1/AnimationPlayer, "animation_finished") 
			return
		
		if distance_to_target > enemy_attack_range and distance_to_target < enemy_alert_range:
			$EnemyMesh1/AnimationPlayer.play("MutantWalking")
		#	print("Enemy moved and slid")
			look_at(player_body.translation+height_offset, Vector3.UP)
			enemy_velocity = move_and_slide(enemy_velocity, Vector3.UP)
			return
	


func _on_HitArea_body_entered(body):
	if body.is_in_group("bullets"):
		enemy_alive = false
		body.queue_free()# Replace with function body.
