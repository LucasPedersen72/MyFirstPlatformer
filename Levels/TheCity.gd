extends Node2D
var npc_interaction : bool = false 
@onready var area_2d = $AnimatedSprite2D/Area2D

func _ready():
	#area_2d.connect("area_entered", self, "_on_ab_shop_npc_tree_entered")
	#area_2d.connect("area_exited", self, "_on_ab_shop_npc_tree_entered")
#
#
#func _physics_process(delta):
	#interact_with_npc()
	#pass
#
#
#func _on_ab_shop_npc_tree_entered():
	#npc_interaction = true
	#pass # Replace with function body.
#
#func interact_with_npc():
	#if npc_interaction == true && Input.is_action_just_pressed("interact"):
		#print("tjooo")
		#pass
