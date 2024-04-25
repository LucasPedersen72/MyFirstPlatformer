extends Control

func _ready():
	pass # Replace with function body.
	
func _on_btn_space_woman_character_pressed():
	GameManager.character_id = 2
	print(GameManager.character_id)

func _on_btn_knight_charater_pressed():
	GameManager.character_id = 1
	print(GameManager.character_id)
