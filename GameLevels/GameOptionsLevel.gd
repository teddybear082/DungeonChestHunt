extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level_select_snap = $LevelSelectSnapZone
onready var level_select_slider = $LevelSelectSliderSnap
onready var chest_area = $ChestArea
var level_chosen = 0
var coin_original_transform = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$BackgroundMusic.play(PlayerMasterControls.backgroundmusictimestamp)
	preload("res://GameLevels/GameLevel1.tscn")
	preload("res://GameLevels/GameLevel2.tscn")
	preload("res://GameLevels/GameLevel3.tscn")
	preload("res://GameLevels/GameLevel4.tscn")
	for i in PlayerMasterControls.chests_collected:
		var new_chest = load("res://scenes/PickableChest.tscn").instance()
		chest_area.add_child(new_chest)
		new_chest.global_transform = chest_area.global_transform
	coin_original_transform = $CoinPickable.global_transform	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $CoinPickable.transform.origin.y < .2 and $CoinPickable.picked_up_by == null:
		$CoinPickable.transform = coin_original_transform



func _on_LevelSelectSnapZone_has_picked_up(what):
	if what.name == "CoinPickable":
		level_chosen = level_select_slider.level# Replace with function body.
	if level_chosen == 1:
		get_tree().change_scene("res://GameLevels/GameLevel1.tscn")
	if level_chosen == 2:
		get_tree().change_scene("res://GameLevels/GameLevel2.tscn")
	if level_chosen == 3:
		get_tree().change_scene("res://GameLevels/GameLevel3.tscn")
	if level_chosen == 4:
		get_tree().change_scene("res://GameLevels/GameLevel4.tscn")
