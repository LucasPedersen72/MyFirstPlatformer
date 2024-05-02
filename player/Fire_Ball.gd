extends AnimatedSprite2D
@onready var fire_ball = $"."

var bullet_speed : int = 300
var direction : int

func _physics_process(delta):
	fire_ball_moving(delta)
	
func fire_ball_moving(delta):
	move_local_x(direction * bullet_speed * delta)
	
	
func _on_timer_timeout():
	queue_free()
