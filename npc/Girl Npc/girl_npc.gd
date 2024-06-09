extends CharacterBody2D

#variabler som går att ädra i inspektören. Detta är saker som man vill kunna ändra snabbt utan att gå in i koden. 
@export var patrol_points : Node
@export var SPEED : int = 1500
@export var wait_time : int = 2

#Variabler som gör att man kan använda timer och animated sprite i koden. Detta gör att man kan göra ändring som tex
#timerns tid eller spritens animation
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

const GRAVITY = 1000

#variabler och en enum som bestämmer vilken state karaktären ska vara i. can_walk bestämmer ifall gubber kan gå eller inte
enum State { Idle, Walking }
var can_walk : bool 
var current_state = State

#Variabler som gör så att rörelsen funkar. Dessa variabler har med Patrol pointsen och göra.
var direction : Vector2 = Vector2.LEFT
var number_of_points : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int

#Olika variabler som fungerar som detecxtion till när playern går in i chatting zone. Detta gör att man kan prata med 
#npcn när man är nära den och inte annars. 
var player
var player_in_chat_zone : bool
var is_chatting : bool


#Detta är allt som ska hönda när scenen laddas in. 
func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol Points")
	
	
	
	timer.wait_time = wait_time
	timer.start()
	current_state = State.Idle
	
	
# Här ligger allt som gör att scenen fungerar. De gör så att gå funktionen fungerar och grativations funktionen funkar osv.
func _physics_process(delta : float):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	
	if player_in_chat_zone == true:
		GameManager.talking_npc = "girl"
		
	if Input.is_action_just_pressed("interact") && player_in_chat_zone == true && is_chatting == false:
		print("Is chatting")
		GameManager.talking_npc = "girl"
		can_walk = false
		is_chatting = true
		current_state = State.Idle
		timer.stop()
		$Dialogue.start()
		
		
	move_and_slide()
	
	enemy_animations()

#Gör så att karaktären faller tills den nuddar marken
func enemy_gravity(delta : float):
	velocity.y += GRAVITY * delta
	
#Gör så att karaktären slutar att röra på sig och går in i idle state
func enemy_idle(delta : float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		current_state = State.Idle
	
#funktionen som gör så att karaktären kan gå. Den gör också så att den stannar vid nästa marker och då startar timern. 
func enemy_walk(delta : float):
	if !can_walk:
		return
		
	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * SPEED * delta
		current_state = State.Walking
	else:
		current_point_position += 1

		if current_point_position >= number_of_points:
			current_point_position = 0

		current_point = point_positions[current_point_position]

		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
		
		can_walk = false
		timer.start()

	animated_sprite_2d.flip_h = direction.x < 0

#Gör så att animations startar när karaktären är i en viss state.
func enemy_animations():
	if current_state == State.Idle && !can_walk:
		animated_sprite_2d.play("Idle")
	elif current_state == State.Walking && can_walk:
		animated_sprite_2d.play("Walk")

#can walk blir sant när timern är klar
func _on_timer_timeout():
	can_walk = true
	
#Gör så att om en body som finns i gruppen "PLAYER" och den går in i arean så blir player_in_chat_zone = true
func _on_detection_area_body_entered(body):
	if body.is_in_group("PLAYER"):
		player = body
		player_in_chat_zone = true

#Gör så att om en body som finns i gruppen "PLAYER" och den går ut ur arean så blir player_in_chat_zone = false
func _on_detection_area_body_exited(body):
	if body.is_in_group("PLAYER"):
		player_in_chat_zone = false


func _on_dialogue_dialogue_finsished():
	is_chatting = false
	can_walk = true
	timer.start()
