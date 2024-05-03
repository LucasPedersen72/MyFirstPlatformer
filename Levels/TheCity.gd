extends Node2D
var npc_interaction : bool = false 
@onready var ab_npc_area = $AnimatedSprite2D/npc_area

const FIRE_WIZARD = preload("res://player/Fire_Wizard/Fire_Wizard.tscn")
const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")

func _ready():
	#area_2d.connect("area_entered", self, "_on_ab_shop_npc_tree_entered")
	#area_2d.connect("area_exited", self, "_on_ab_shop_npc_tree_entered")
	pass
	
func _physics_process(delta):
	interact_with_npc()

func _on_npc_area_body_entered(body):
	npc_interaction == true
	pass # Replace with function body.


func _on_npc_area_body_exited(body):
	npc_interaction == false
	pass # Replace with function body.

func interact_with_npc(): #
	if npc_interaction == true && Input.is_action_just_pressed("interact"):
		print("tjooo")
		pass


