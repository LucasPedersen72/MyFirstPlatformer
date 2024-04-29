extends AnimatedSprite2D

var bullet_speed : int = 600
var direction : int

func _physics_process(delta):
	move_local_x(direction * bullet_speed * delta)

func _on_timer_timeout():
	queue_free()
