extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var already_played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(5), "timeout") 
	play()# Replace with function body.
	yield(get_tree().create_timer(4), "timeout") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Voiceover_finished():
	if already_played == false:
		self.stream = load("res://sounds/You_can_perform_slow_274.mp3") # Replace with function body.
		play()
		already_played = true
