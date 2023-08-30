extends Entity

const MAX_SPEED = 200
var speed = 100
var acel = 2

func _physics_process(delta):
	var move_vector:Vector2
	if $RayCast2D.is_colliding():
		active_forces.append(Force.new(Vector2.RIGHT,30))
	else:
		move_vector.y += 30
	if Input.is_action_just_pressed("shoot"):
		active_forces.append(Force.new(-to_local($Gun.shoot_direction),30))
		
	for force in active_forces:
		move_vector += force.get_force()
		force.add_friction()
		if force.force < 0.1:
			active_forces.erase(force)
			
	move_vector.x = clamp(move_vector.x,-MAX_SPEED,MAX_SPEED)
	move_vector.y = clamp(move_vector.y,-MAX_SPEED,MAX_SPEED)
	
	move_and_slide(move_vector)
	


