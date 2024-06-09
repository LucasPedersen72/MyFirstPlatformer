extends Node2D

const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
const ARCHER = preload("res://player/Archer/Archer.tscn")
const THE_CITY = preload("res://Levels/TheCity/TheCity.tscn")

var go_back : bool

func _ready():
	if GameManager.character_id == 1:
		var Character1 = KNIGHT_PLAYER.instantiate()
		add_child(Character1)
		Character1.global_position = Vector2(100, -100)
		
		pass
	if GameManager.character_id == 2:
		var Character2 = ARCHER.instantiate()
		add_child(Character2)
		Character2.global_position = Vector2(100, -100)
		pass
	
	
	if GameManager.character_id == null:
		var Character2 = ARCHER.instantiate()
		add_child(Character2)
		Character2.global_position = Vector2(100, -100)

	HealthManager.current_health = HealthManager.max_health

func _process(delta):
	if Input.is_action_just_pressed("interact") and go_back == true:
		get_tree().change_scene_to_packed(THE_CITY)
		pass
		

func _on_fall_area_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_tree().reload_current_scene()
		print("AOSUJHDAOSHDåopAHd")


func _on_goback_body_entered(body):
	if body.is_in_group("PLAYER"):
		go_back = true
