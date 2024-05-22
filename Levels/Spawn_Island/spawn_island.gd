extends Node2D
const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
const ARCHER = preload("res://player/Archer/Archer.tscn")
# Called when the node enters the scene tree for the first time.
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
