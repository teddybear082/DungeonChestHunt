extends XRToolsPickable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var bullet_scene
export var bullet_speed = 10.0
var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func action():
	emit_signal("action_pressed", self)
	
	if can_shoot:
		var bullet = bullet_scene.instance()
		get_owner().add_child(bullet)
		bullet.global_transform = $BulletSpawnPoint.global_transform
		#bullet.apply_impulse(Vector3(), Vector3(0,0,-1)*10)
		bullet.linear_velocity = -bullet.global_transform.basis.z * bullet_speed
		
		can_shoot = false
		$ShotTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ShotTimer_timeout():
	can_shoot = true # Replace with function body.
