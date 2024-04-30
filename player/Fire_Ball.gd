extends AnimatedSprite2D
@onready var fire_ball = $"."

var bullet_speed : int = 300
var direction : int

func _physics_process(delta):
	move_local_x(direction * bullet_speed * delta)
	
	if direction < 0:
		fire_ball.flip_h == true
	else:
		fire_ball.flip_h == false

func _on_timer_timeout():
	queue_free()
