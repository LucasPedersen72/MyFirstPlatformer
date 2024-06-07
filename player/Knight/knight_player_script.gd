extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sword_hitbox = $Sword_Hitbox
@onready var timer_sword_hitbox_right = $Timer_sword_hitbox_right
@onready var timer_sword_hitbox_left = $Timer_sword_hitbox_left



@export var GRAVITY : int = 1000

@export var SPEED : int = 1000
@export var MAX_HORIZONTAL_SPEED : int = 300
@export var SLOW_DOWN_SPEED : int = 1700

@export var JUMP : int = -300
@export var JUMP_HORIZONTAL : int = 1000
@export var MAX_JUMP_HORIZONTAL_SPEED : int = 300

enum State { Idle, Running, Jumping, Attacking, Falling }
var current_state : State

var facing_right : bool


func _ready():
	current_state = State.Idle
	$Sword_Hitbox/CollisionShape2D_right.disabled = true
	$Sword_Hitbox/CollisionShape2D2_left.disabled = true
	
	GameManager.playerBody = self

func _physics_process(delta : float):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_attack(delta)
	
	move_and_slide()
	
	player_animations()
	
func input_movement():
	var direction : float = Input.get_axis("move_left", "move_right")
	return direction

func player_falling(delta : float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		current_state = State.Falling
		
func player_idle(delta : float):
	if is_on_floor() && player_attack(delta) == false:
		current_state = State.Idle
		#print("state: ", State.keys()[current_state]) 
	elif is_on_floor() && Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left"):
		current_state = State.Idle
		pass
		
func player_run(delta : float):
	if !is_on_floor():
		return
	var direction = input_movement()
	if direction:
		velocity.x += direction * SPEED * delta
		velocity.x = clamp(velocity.x , -MAX_HORIZONTAL_SPEED, MAX_HORIZONTAL_SPEED)

	else:
		velocity.x = move_toward(velocity.x, 0, SLOW_DOWN_SPEED * delta)
	
	if direction != 0 && current_state != State.Attacking:
		current_state = State.Running
		#print("state: ", State.keys()[current_state])
		animated_sprite_2d.flip_h = false if direction > 0 else true

	if  animated_sprite_2d.flip_h == false:
		facing_right = true
	else:
		facing_right = false
	
func player_jump(delta : float):
	var direction = input_movement()
	#print("state: ", State.keys()[current_state])
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP
		current_state = State.Jumping
		
	if !is_on_floor() && current_state == State.Jumping:
		velocity.x += direction * JUMP_HORIZONTAL * delta
		velocity.x = clamp(velocity.x, -MAX_JUMP_HORIZONTAL_SPEED, MAX_JUMP_HORIZONTAL_SPEED)
		
	if is_on_floor() && current_state == State.Falling:
		current_state = State.Idle
		
func player_attack(delta : float):
	var direction = input_movement()
	if Input.is_action_just_pressed("attack") && direction == 0 && facing_right == true:
		$Sword_Hitbox/CollisionShape2D_right.disabled = false
		timer_sword_hitbox_right.start()
		current_state = State.Attacking
		animated_sprite_2d.animation = "Attack_no_movement"
		print("state: " + State.keys()[current_state])
		
	elif Input.is_action_just_pressed("attack") && direction == 0 && facing_right == false:
		$Sword_Hitbox/CollisionShape2D2_left.disabled = false
		timer_sword_hitbox_left.start()
		current_state = State.Attacking
		animated_sprite_2d.animation = "Attack_no_movement"
		print("state: " + State.keys()[current_state])
	
	elif Input.is_action_just_pressed("attack") && direction > 0:
		$Sword_Hitbox/CollisionShape2D_right.disabled = false
		timer_sword_hitbox_right.start()
		current_state = State.Attacking
		animated_sprite_2d.animation = "Attack_no_movement"
		print("state: " + State.keys()[current_state])

	elif Input.is_action_just_pressed("attack") && direction < 0:
		$Sword_Hitbox/CollisionShape2D2_left.disabled = false
		timer_sword_hitbox_left.start()
		current_state = State.Attacking
		animated_sprite_2d.animation = "Attack_no_movement"
		print("state: " + State.keys()[current_state])
	
func _on_timer_sword_hitbox_right_timeout():
	$Sword_Hitbox/CollisionShape2D_right.disabled = true
	current_state = State.Idle


func _on_timer_sword_hitbox_left_timeout():
	$Sword_Hitbox/CollisionShape2D2_left.disabled = true
	current_state = State.Idle

func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")

	elif current_state == State.Running:
		animated_sprite_2d.play("Running")

	elif current_state == State.Jumping:
		animated_sprite_2d.play("Jumping")





