extends Position2D


export(float) var recharge_time = 1
export(float) var knockback_force = 230
export(float) var bullet_speed = 400
var shoot_direction:Vector2

func _physics_process(delta):
	shoot_direction = get_global_mouse_position()
	look_at(shoot_direction)
	
func shoot():
	var Bullet = preload("res://Source/Projectiles/Bullet.tscn").instance()
	add_child(Bullet)
	Bullet.global_rotation = shoot_direction.normalized().angle()
#	Bullet.direction = shoot_direction.normalized()
