extends Spatial

export var num_grapples := 20
export var min_grapple_distance := 3.5
export var max_grapple_distance := 6.5
var list_of_grapple_positions = []
var last_grapple_transform = null
var distance_from_last_grapple = null
var new_grapple_origin = null


# Called when the node enters the scene tree for the first time.
func _ready():
	last_grapple_transform = global_transform
	list_of_grapple_positions.append(last_grapple_transform.origin)
	generate_grapples()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func generate_grapples():
	var grapple_sphere_scene = load("res://scenes/Level3GrappleSphere.tscn")
	var platform_scene = load("res://scenes/Level3Platform.tscn")
	var grapple_sphere_instance = null
	var platform_instance = null
	var random = RandomNumberGenerator.new()
	random.randomize()
	for i in num_grapples-1:
		var choice = random.randi()%2
		if choice == 0:
			platform_instance = platform_scene.instance()
			add_child(platform_instance)
			platform_instance.global_transform = last_grapple_transform
			var origin_to_test = create_new_grapple_origin()
			while distance_ok_from_other_grapples(origin_to_test) == false:
				origin_to_test = create_new_grapple_origin()
			platform_instance.global_transform.origin = origin_to_test
			list_of_grapple_positions.append(new_grapple_origin)
			last_grapple_transform = platform_instance.global_transform
		
		if choice == 1:
			grapple_sphere_instance = grapple_sphere_scene.instance()
			add_child(grapple_sphere_instance)
			grapple_sphere_instance.global_transform = last_grapple_transform
			var origin_to_test = create_new_grapple_origin()
			while distance_ok_from_other_grapples(origin_to_test) == false:
				origin_to_test = create_new_grapple_origin()
			grapple_sphere_instance.global_transform.origin = origin_to_test
			list_of_grapple_positions.append(new_grapple_origin)
			last_grapple_transform = grapple_sphere_instance.global_transform


func create_new_grapple_origin():
	var random = RandomNumberGenerator.new()
	random.randomize()
	distance_from_last_grapple = Vector3(random.randf_range(-max_grapple_distance,max_grapple_distance), random.randf_range(0.0,max_grapple_distance), random.randf_range(-max_grapple_distance,0))
	new_grapple_origin = last_grapple_transform.origin + distance_from_last_grapple
	return new_grapple_origin
	
func distance_ok_from_other_grapples(position_to_check):
	var distance_ok =  true
	for each_position in list_of_grapple_positions.size()-1:
		if (position_to_check-list_of_grapple_positions[each_position]).length() < min_grapple_distance:
			distance_ok = false
	return distance_ok
	

