extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sword_hitbox = $Sword_Hitbox
@onready var timer_sword_hitbox = $Timer_sword_hitbox


@export var GRAVITY : int = 1000

@export var SPEED : int = 1000
@export var MAX_HORIZONTAL_SPEED : int = 300
@export var SLOW_DOWN_SPEED : int = 1700

@export var JUMP : int = -300
@export var JUMP_HORIZONTAL : int = 1000
@export var MAX_JUMP_HORIZONTAL_SPEED : int = 300

enum State { Idle, Running, Jumping, attacking }

var current_state : State

func _ready():
	current_state = State.Idle
	sword_hitbox.disabled = true

func _physics_process(delta : float):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	move_and_slide()
	
	player_animations()
	
func input_movement():
	var direction : float = Input.get_axis("move_left", "move_right")
	return direction

func player_falling(delta : float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
		
func player_idle(delta : float):
	if is_on_floor():
		current_state = State.Idle
	print("state: ", State.keys()[current_state])
		
func player_run(delta : float):
	if !is_on_floor():
		return

	var direction = input_movement()

	if direction:
		velocity.x += direction * SPEED * delta
		velocity.x = clamp(velocity.x , -MAX_HORIZONTAL_SPEED, MAX_HORIZONTAL_SPEED)

	else:
		velocity.x = move_toward(velocity.x, 0, SLOW_DOWN_SPEED * delta)

	if direction != 0:
		current_state = State.Running
		print("state: ", State.keys()[current_state])
		animated_sprite_2d.flip_h = false if direction > 0 else true
		
	
func player_jump(delta : float):
	var direction = input_movement()
	print("state: ", State.keys()[current_state])
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP
		current_state = State.Jumping
		
	if !is_on_floor() and current_state == State.Jumping:
		velocity.x += direction * JUMP_HORIZONTAL * delta
		velocity.x = clamp(velocity.x, -MAX_JUMP_HORIZONTAL_SPEED, MAX_JUMP_HORIZONTAL_SPEED)
		
func player_attack():
	if Input.is_action_just_pressed("attack"):
		sword_hitbox.disabled = false
		timer_sword_hitbox.start()
		current_state = State.attacking
		
func _on_timer_sword_hitbox_timeout():
	sword_hitbox.disabled = true

func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")

	elif current_state == State.Running:
		animated_sprite_2d.play("Running")
		
	elif current_state == State.Jumping:
		animated_sprite_2d.play("Jumping")
		
	elif current_state == State.attacking:
		animated_sprite_2d.play("Attack_no_movement")


