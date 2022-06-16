extends RigidBody

var has_created_hole = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BulletCleanUpTimer_timeout():
	queue_free() # Replace with function body.
	#pass


func _on_Bullet_body_entered(body):
	if has_created_hole == false and body.is_in_group("enemies") == false:
		var new_bullet_hole = load("res://scenes/BulletHole.tscn").instance()
		get_tree().current_scene.add_child(new_bullet_hole)
		new_bullet_hole.global_transform = transform
		new_bullet_hole.global_scale(Vector3(.07,.07,.07))
		has_created_hole = true # Replace with function body.
