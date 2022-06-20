extends Spatial

export var num_zombies = 50

var random_x_coord = 0
var random_z_coord = 0
var y_coord = 1
var list_of_coords = []
var curr_origin = Vector3(0,0,0)
var current_wave = 0
var total_waves = 0
var active_zombie = null

signal maxnumberofzombies(number)
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("maxnumberofzombies", num_zombies)
	call_deferred("spawn_enemies", 10)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	

func spawn_enemies(num_to_spawn):
	var zombie1 = load("res://scenes/EnemyType1.tscn")
	var zombie2 = load("res://scenes/EnemyType2.tscn")
	var random = RandomNumberGenerator.new()
	random.randomize()
	for i in num_to_spawn:
		curr_origin = set_random_coords()
		while list_of_coords.has(curr_origin):
		#while curr_origin in (list_of_coords):
			curr_origin = set_random_coords()
		list_of_coords.append(curr_origin)
		var zombiechoice = (random.randi() % 2)
		if zombiechoice == 0:
			var zombie_instance = zombie1.instance()
			add_child(zombie_instance)
			zombie_instance.enemy_alert_range = 30
			zombie_instance.global_transform.origin = curr_origin
		if zombiechoice == 1:
			var zombie_instance = zombie2.instance()
			add_child(zombie_instance)
			zombie_instance.enemy_alert_range = 30
			zombie_instance.global_transform.origin = curr_origin
		
		
		
func set_random_coords():
	var random = RandomNumberGenerator.new()
	random.randomize()
	random_x_coord = (random.randi() % 40)
	random_z_coord = (random.randi() % 40)
	if random_x_coord > 20:
		random_x_coord = -random_x_coord + 20
	if random_z_coord > 20:
		random_z_coord = -random_z_coord + 20
	return Vector3(random_x_coord, y_coord, random_z_coord)
