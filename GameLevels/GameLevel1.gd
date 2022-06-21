extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemies = []
var enemy_count = 0
var refresh_count = 0
var ok_to_display_enemy_count = false
var max_enemies = 0
var waves_remaining = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	$OverlayHelper/OverlayLabel3D.text = ""
	yield(get_tree().create_timer(5), "timeout") 
	$OverlayHelper/OverlayLabel3D.text = "Avoid the rock monsters!"
	yield(get_tree().create_timer(5), "timeout") 
	$OverlayHelper/OverlayLabel3D.text = "Test out bullet time"
	yield(get_tree().create_timer(5), "timeout") 
	$OverlayHelper/OverlayLabel3D.text = "Test out max payne bullet dives"
	yield(get_tree().create_timer(5), "timeout") 
	$OverlayHelper/OverlayLabel3D.text = "Eliminate all Rock Monsters"
	yield(get_tree().create_timer(5), "timeout")
	ok_to_display_enemy_count = true
	
func _process(delta):
#	enemies = get_tree().get_nodes_in_group("enemies")	
#	enemy_count = enemies.size()
#	if ok_to_display_enemy_count == true:
#		refresh_count +=1
#		if refresh_count >= 60:
#			if enemy_count >= 1:
#				$OverlayHelper/OverlayLabel3D.text = "Rock Monsters: " + str(enemy_count)
#			else:
#				$OverlayHelper/OverlayLabel3D.text = "You defeated all the Rock Monsters!"
#			refresh_count = 0
	
	enemies = get_tree().get_nodes_in_group("enemies")	
	enemy_count = enemies.size()
	if ok_to_display_enemy_count == true:
		refresh_count +=1
		if refresh_count >= 30:
			if enemy_count >= 1:
				$OverlayHelper/OverlayLabel3D.text = "Rock Monsters Left This Wave: " + str(enemy_count)
			else:
				if waves_remaining > 0:
					waves_remaining -=1
					$OverlayHelper/OverlayLabel3D.text = "Wave Completed! You have " + str(waves_remaining) + " waves left!"
					yield(get_tree().create_timer(5), "timeout")
					$EnemySpawner.spawn_enemies(10)
			if waves_remaining == 0 and enemy_count == 0:
				$OverlayHelper/OverlayLabel3D.text = "You defeated all the Rock Monsters!"
			refresh_count = 0
		


func _on_EnemySpawner_maxnumberofzombies(number):
	max_enemies = number # Replace with function body.
	waves_remaining = max_enemies/10
