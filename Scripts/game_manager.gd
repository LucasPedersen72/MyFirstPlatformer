extends Node
var character_id = null
var map : String

func _ready():
	RenderingServer.set_default_clear_color(Color(0.44, 0.12, 0.53, 1.00))

const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
const FIRE_WIZARD = preload("res://player/Fire_Wizard/Fire_Wizard.tscn")
