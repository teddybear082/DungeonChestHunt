extends Spatial

export var num_rungs := 50
export var min_rung_distance := .4
export var max_rung_distance := 1.2
var list_of_rung_positions = []
var last_rung_transform = null
var distance_from_last_rung = null
var rung_rotation_degrees = null
var new_rung_origin = null

signal victory_platform_generated(transformy)
# Called when the node enters the scene tree for the first time.
func _ready():
	last_rung_transform = $FirstClimbingRung.global_transform
	list_of_rung_positions.append(last_rung_transform.origin)
	generate_climbing_rungs()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func generate_climbing_rungs():
	var rung_scene = load("res://scenes/ClimbingRung.tscn")
	var platform_scene = load("res://scenes/VictoryPlatformLevel2.tscn")
	var rung_instance = null
	var platform_instance = null
	
	for i in num_rungs-1:
		rung_instance = rung_scene.instance()
		add_child(rung_instance)
		rung_instance.global_transform = last_rung_transform
		var origin_to_test = create_new_rung_origin()
		while distance_ok_from_other_rungs(origin_to_test) == false:
			origin_to_test = create_new_rung_origin()
		rung_instance.global_transform.origin = origin_to_test
		list_of_rung_positions.append(new_rung_origin)
		rung_instance.rotation_degrees.z = random_rung_rotation_degrees()
		assign_random_color(rung_instance)
		last_rung_transform = rung_instance.global_transform

	platform_instance = platform_scene.instance()
	add_child(platform_instance)
	platform_instance.global_transform = global_transform
	platform_instance.global_transform.origin = last_rung_transform.origin + Vector3(0,min_rung_distance, -2)
	emit_signal("victory_platform_generated", platform_instance.global_transform.origin.y)

func create_new_rung_origin():
	var random = RandomNumberGenerator.new()
	random.randomize()
	distance_from_last_rung = Vector3(random.randf_range(-max_rung_distance,max_rung_distance), random.randf_range(0.0,max_rung_distance), random.randf_range(-max_rung_distance,0))
	new_rung_origin = last_rung_transform.origin + distance_from_last_rung
	return new_rung_origin
	
func distance_ok_from_other_rungs(position_to_check):
	var distance_ok =  true
	for each_position in list_of_rung_positions.size()-1:
		if (position_to_check-list_of_rung_positions[each_position]).length() < min_rung_distance:
			distance_ok = false
	return distance_ok
	
func random_rung_rotation_degrees():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var degrees_to_rotate = random.randi() % 180
	var negative_or_positive = random.randi() % 2
	if negative_or_positive == 0:
		degrees_to_rotate = -degrees_to_rotate
	return degrees_to_rotate
	
func assign_random_color(rung):
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_color = null
	var other_color = null
	random.randomize()
	var metal_or_wood = random.randi() % 2
	if metal_or_wood == 0:
		random_color = load("res://materials/leverhandlematerial.tres")
		other_color = load("res://materials/leverboxmaterial.tres")
	if metal_or_wood == 1:
		random_color = load("res://materials/leverboxmaterial.tres")
		other_color = load("res://materials/leverhandlematerial.tres")
	rung.get_node("Handle").set_surface_material(0, random_color)
	rung.get_node("HandleBar1").set_surface_material(0, other_color)
	rung.get_node("HandleBar2").set_surface_material(0, other_color)
