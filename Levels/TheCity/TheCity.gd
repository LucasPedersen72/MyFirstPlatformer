extends Node2D
var npc_interaction : bool = false 

const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
const ARCHER = preload("res://player/Archer/Archer.tscn")

const THE_CAVE = preload("res://Levels/TheCave/TheCave.tscn")
const THE_SKY = preload("res://Levels/TheSky/TheSky.tscn")
const THE_CITY = preload("res://Levels/TheCity/TheCity.tscn")
const THE_WOODS = preload("res://Levels/TheWoods/TheWoods.tscn")

var TheSkyEntrance : bool = false
var TheCaveEntrance : bool = false
var CheckPointEntrance : bool = false

func _ready():
	if GameManager.character_id == 1:
		var Character1 = KNIGHT_PLAYER.instantiate()
		add_child(Character1)
		if GameManager.The_City_Checkpoint == true:
			Character1.global_position = Vector2(1160, -6)
		else:
			Character1.global_position = Vector2(52, -66)
			
	if GameManager.character_id == 2:
		var Character2 = ARCHER.instantiate()
		add_child(Character2)
		if GameManager.The_City_Checkpoint == true:
			Character2.global_position = Vector2(1160, -6)
		else:
			Character2.global_position = Vector2(52, -66)
	
	if GameManager.character_id == null:
		var Character2 = ARCHER.instantiate()
		add_child(Character2)
		if GameManager.The_City_Checkpoint == true:
			Character2.global_position = Vector2(1160, -6)
		else:
			Character2.global_position = Vector2(52, -66)
		
	
	HealthManager.current_health = HealthManager.max_health
	
func _physics_process(delta):
	if Input.is_action_just_pressed("interact") && TheCaveEntrance == true:
			get_tree().change_scene_to_packed(THE_CAVE)
	
	if Input.is_action_just_pressed("interact") && TheSkyEntrance == true:
			get_tree().change_scene_to_packed(THE_SKY)
	
func _on_the_cave_entrance_body_entered(body):
	if body.is_in_group("PLAYER"):
		TheCaveEntrance = true

func _on_the_cave_entrance_body_exited(body):
	if body.is_in_group("PLAYER"):
		TheCaveEntrance = false

func _on_the_sky_entrance_body_entered(body):
	if body.is_in_group("PLAYER"):
		TheSkyEntrance = true

func _on_the_sky_entrance_body_exited(body):
	if body.is_in_group("PLAYER"):
		TheSkyEntrance = false

func _on_checkpoint_body_entered(body):
	if body.is_in_group("PLAYER"):
		GameManager.The_City_Checkpoint = true 


func _on_fall_area_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_tree().reload_current_scene()


func _on_the_woods_entrance_body_entered(body):
	if body.is_in_group("PLAYER"):
		get_tree().change_scene_to_packed(THE_WOODS)
