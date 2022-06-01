extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NameLineEdit_text_entered(new_text):
	PlayerMasterControls.playername = new_text # Replace with function body.
	$ConfirmEntryLabel.text = "Player name accepted"
	yield(get_tree().create_timer(3), "timeout")
	$ConfirmEntryLabel.text = "Edit name and press enter to change"
