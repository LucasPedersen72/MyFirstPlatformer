extends CharacterBody2D

var speed = 300.0
var direction = Vector2.RIGHT
@export var GRAVITY : int = 1000
@export var damage_amount : int = 1

var is_enemy_in_chase : bool

enum State { Idle, Walking, hanging, falling, dead, resurrecting }
var current_state : State
@onready var animated_sprite_2d = $AnimatedSprite2D


var health : int = 100


func _ready():
	current_state = State.hanging
	GameManager.arrow_damage = 25

func _physics_process(delta):
	idle()
	falling(delta)
	move_and_slide()
	animations()

func idle():
	if is_on_floor() and current_state != State.dead:
		current_state = State.Idle
		animated_sprite_2d.play("idle")
	pass

func falling(delta : float):
	if !is_on_floor() && current_state != State.hanging:
		velocity.y += GRAVITY * delta

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 0.8])
	if is_enemy_in_chase == false:
		direction = choose([Vector2.RIGHT, Vector2.LEFT])
	

func animations():
	#var animated_sprite = $AnimatedSprite2D
	#if current_state != State.hanging:
		#animated_sprite.play("idle")
		#if direction.x == -1:
			#animated_sprite.flip_h == true
		#elif direction.x == 1:
			#animated_sprite.flip_h == false
	#else:
		#animated_sprite.play("hanging")
	pass

func choose(array):
	array.shuffle()
	return array.front()
	

func _on_skeleton_trap_entered(body, extra_arg_0):
	if body.is_in_group("PLAYER"):
		print(extra_arg_0)  # Debug print to check the value of extra_arg_0
		if extra_arg_0 == 1:
			make_skeleton_fall("SkeletonGroupLeft")
		elif extra_arg_0 == 2:
			make_skeleton_fall("SkeletonGroupRight")
			
func make_skeleton_fall(group_name):
	var enemies = $".."
	for skeletons in enemies.get_children():
		if skeletons.is_in_group(group_name):
			skeletons.current_state = State.falling

func _on_hurtbox_area_entered(area):
	if current_state != State.dead:
		health -= GameManager.arrow_damage
		if health <= 0:
			death()
		
	
func death():
	# Play death animation and change state
	var animated_sprite = $AnimatedSprite2D
	animated_sprite.play("death")
	current_state = State.dead
	# Disable the collision shape
	$hurtbox/CollisionShape2D.disabled = true
	$DeathTimer.start()


# Update the idle function to respect the new states
func _process(delta):
	if is_on_floor() and current_state == State.Idle:
		var animated_sprite = $AnimatedSprite2D
		animated_sprite.play("idle")


func _on_death_timer_timeout():
	self.queue_free()
