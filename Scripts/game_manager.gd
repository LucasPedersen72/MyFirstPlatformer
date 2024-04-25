extends Node
var character_id = null

func _ready():
	RenderingServer.set_default_clear_color(Color(0.44, 0.12, 0.53, 1.00))

const SPACE_WOMAN = preload("res://player/SpaceWoman/SpaceWoman.tscn")
const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
