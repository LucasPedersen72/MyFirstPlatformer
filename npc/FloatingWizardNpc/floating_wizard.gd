extends CharacterBody2D

var player_in_chat_zone : bool
var is_chatting : bool
var player

func _ready():
	$Dialogue.visible = false
	$AnimatedSprite2D.play("default")

func _physics_process(delta : float):
	if Input.is_action_just_pressed("interact") && player_in_chat_zone == true && is_chatting == false:
		print("Is chatting")
		is_chatting = true
		$Dialogue.start()
		GameManager.talking_npc = "floating_wizard"
		$Dialogue.visible = true


func _on_detection_area_body_entered(body):
	if body.is_in_group("PLAYER"):
		player = body
		player_in_chat_zone = true


func _on_detection_area_body_exited(body):
	if body.is_in_group("PLAYER"):
		player_in_chat_zone = false
