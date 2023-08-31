extends Position2D

export(int) var damage
export(float) var soot_recharge
export(Vector2) var shoot_direction

func _physics_process(delta):
	shoot_direction = get_global_mouse_position()
	look_at(shoot_direction)
	
	
