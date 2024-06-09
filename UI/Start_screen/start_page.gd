extends Control
const SPAWN_ISLAND = preload("res://Levels/Spawn_Island/spawn_island.tscn")

func _ready():
	pass # Replace with function body.
	
func _on_btn_space_woman_character_pressed():
	GameManager.character_id = 2
	print(GameManager.character_id)

func _on_btn_knight_charater_pressed():
	GameManager.character_id = 1
	print(GameManager.character_id)

func _on_button_pressed():
	get_tree().change_scene_to_packed(SPAWN_ISLAND)
	pass
