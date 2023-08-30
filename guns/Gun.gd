extends Position2D



var shoot_direction

func _physics_process(delta):
	shoot_direction = get_global_mouse_position()
	look_at(shoot_direction)
	
	
