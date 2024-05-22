extends Node2D
var npc_interaction : bool = false 

const FIRE_WIZARD = preload("res://player/Fire_Wizard/Fire_Wizard.tscn")
const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")

func _ready():
	if GameManager.character_id == 1:
		var Character1 = KNIGHT_PLAYER.instantiate()
		add_child(Character1)
		Character1.global_position = Vector2(52, -66)
		
		pass
	if GameManager.character_id == 2:
		var Character2 = FIRE_WIZARD.instantiate()
		add_child(Character2)
		Character2.global_position = Vector2(52, -66)
		pass
	
	if GameManager.character_id == null:
		var Character2 = FIRE_WIZARD.instantiate()
		add_child(Character2)
		Character2.global_position = Vector2(52, -66)
	
func _physics_process(delta):
	pass
