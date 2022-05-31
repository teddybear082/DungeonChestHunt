extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal level_chosen(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InteractableSlider_slider_moved(position):
	if position == 0:
		emit_signal("level_chosen", 0)
		return
	if position == .1:
		emit_signal("level_chosen", 1)
		return
	if position == .2:
		emit_signal("level_chosen", 2)
		return
	if position == .3:
		emit_signal("level_chosen", 3)
		return
	if position == .4:
		emit_signal("level_chosen", 4)
		return # Replace with function body.
