extends Node2D
var npc_interaction : bool = false 

const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
const ARCHER = preload("res://player/Archer/Archer.tscn")

func _ready():
	if GameManager.character_id == 1:
		var Character1 = KNIGHT_PLAYER.instantiate()
		add_child(Character1)
		Character1.global_position = Vector2(52, -66)
		
		pass
	if GameManager.character_id == 2:
		var Character2 = ARCHER.instantiate()
		add_child(Character2)
		Character2.global_position = Vector2(52, -66)
		pass
	
	if GameManager.character_id == null:
		var Character2 = ARCHER.instantiate()
		add_child(Character2)
		Character2.global_position = Vector2(52, -66)
	
func _physics_process(delta):
	pass
