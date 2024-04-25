extends CharacterBody2D

var bullet = preload("res://player/bullet.tscn")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var muzzle : Marker2D = $Muzzle

@export var GRAVITY : int = 1000

@export var SPEED : int = 1000
@export var MAX_HORIZONTAL_SPEED : int = 300
@export var SLOW_DOWN_SPEED : int = 1700

@export var JUMP : int = -300
@export var JUMP_HORIZONTAL : int = 1000
@export var MAX_JUMP_HORIZONTAL_SPEED : int = 300

enum State { Idle, Running, Jumping, Shooting }

var current_state : State
var muzzle_position

func _ready():
	current_state = State.Idle
	muzzle_position = muzzle.position

func _physics_process(delta : float):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	player_muzzle_position()
	player_shooting(delta)
	
	
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

func player_shooting(delta : float):
	var direction = input_movement()
	
	if direction != 0 and Input.is_action_just_pressed("attack"):
		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = direction
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		
		current_state = State.Shooting 

func player_muzzle_position():
	var direction = input_movement()
	
	if direction > 0:
		muzzle.position.x = muzzle_position.x
	elif direction < 0:
		muzzle.position.x = -muzzle_position.x

func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")

	elif current_state == State.Running and animated_sprite_2d.animation != "Run_shoot":
		animated_sprite_2d.play("Running")
		
	elif current_state == State.Jumping:
		animated_sprite_2d.play("Jumping")
		
	elif current_state == State.Shooting:
		animated_sprite_2d.play("Run_shoot")
