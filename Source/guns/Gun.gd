extends Position2D

export(float) var damage
export(float) var recharge_time = 1.2
export(float) var knockback_force = 230
var shoot_direction:Vector2

func _physics_process(delta):
	shoot_direction = get_global_mouse_position()
	look_at(shoot_direction)
	
	
