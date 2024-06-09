extends Node
var character_id = null
var map
var talking_npc : String
var playerBody: CharacterBody2D
var arrow_damage : int
var The_City_Checkpoint : bool

func _ready():
	RenderingServer.set_default_clear_color(Color(0.44, 0.12, 0.53, 1.00))

const KNIGHT_PLAYER = preload("res://player/Knight/knight_player.tscn")
const ARCHER = preload("res://player/Archer/Archer.tscn")
