extends Control

const START_PAGE = preload("res://UI/Start_screen/start_page.tscn")

# Called when the node enters the scene tree for the first time
func _ready():
	pass
	
func _on_reload_pressed():
	self.queue_free()
	get_tree().reload_current_scene()

func _on_start_over_pressed():
	self.queue_free()
	get_tree().change_scene_to_packed(START_PAGE)
	print("asjdhpiasd")

func _on_exit_game_pressed():
	get_tree().quit()
