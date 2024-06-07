extends AnimatedSprite2D
@onready var arrow = $"."

var bullet_speed : int = 500
var direction : int

var damage

func _physics_process(delta):
	Arrow_moving(delta)
	
	
func Arrow_moving(delta):
	move_local_x(direction * bullet_speed * delta)
	
func _on_timer_timeout():
	self.queue_free()


func _on_hitbox_area_entered(area):
	print("Bullet area entered")
	

func _on_hitbox_body_entered(body):
	print("Bullet body entered")
	self.queue_free()
	
