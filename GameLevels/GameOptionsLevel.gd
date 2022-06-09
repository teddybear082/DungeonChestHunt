extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level_select_snap = $LevelSelectSnapZone
onready var level_select_slider = $LevelSelectSliderSnap

var level_chosen = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	preload("res://GameLevels/GameLevel1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if level_select



func _on_LevelSelectSnapZone_has_picked_up(what):
	if what.name == "CoinPickable":
		level_chosen = level_select_slider.level# Replace with function body.
	if level_chosen == 1:
		get_tree().change_scene("res://GameLevels/GameLevel1.tscn")
