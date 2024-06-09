extends CharacterBody2D

const speed = 30
var direction : Vector2

var is_enemy_in_chase : bool
var player: CharacterBody2D

var health : int = 100
var damage_amount : int = 1

enum state {dead, alive}
var current_state 

func _ready():
	is_enemy_in_chase = false
	current_state = state.alive
	
func _process(delta):
	move(delta)
	animations()

func move(delta):
	if is_enemy_in_chase == true:
		player = GameManager.playerBody
		velocity = position.direction_to(player.position) * speed
		direction.x = abs(velocity.x) / velocity.x
		pass

	elif is_enemy_in_chase == false:
		velocity += direction * speed * delta
	
	move_and_slide()


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 0.8])
	if is_enemy_in_chase == false:
		direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])

func animations():
	var animated_sprite = $AnimatedSprite2D
	animated_sprite.play("fly")
	if direction.x == -1:
		animated_sprite.flip_h == true
	elif direction.x == 1:
		animated_sprite.flip_h == false

func choose(array):
	array.shuffle()
	return array.front()


func _on_hurt_box_body_entered(body):
	print(body.get_groups())
	if current_state == state.alive and body.is_in_group("PROJECTILE"):
		health -= GameManager.arrow_damage
		
	if health <= 0:
		death()

func death():
	self.queue_free()
