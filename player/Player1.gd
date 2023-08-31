extends KinematicBody2D

const MAX_SPEED = 200
var speed = 80
var acel = 2

var gravity = Physics.Force.new(Vector2.DOWN,100)
var run = Physics.Force.new(Vector2.RIGHT,speed)
var enertia = Physics.Force.new(Vector2.RIGHT,1000)

var active_forces = [gravity,run]

func _physics_process(delta):
	var move_vector:Vector2
	
	if $Left.is_colliding() or $Right.is_colliding():
		run.add_aceleration()
		if not active_forces.has(run):
			active_forces.append(run)
			
	else:
		run.add_friction()
		gravity.add_aceleration()
		if not active_forces.has(gravity):
			active_forces.append(gravity)
	if Input.is_action_just_pressed("shoot"):
		active_forces.append(Physics.Force.new(-to_local($Gun.shoot_direction),10))
		
	for force in active_forces:
		move_vector += force.get_force()
		if force != run and gravity:
			force.add_friction()
		if force.force < 0.1:
			active_forces.erase(force)
		
			
	move_vector.x = clamp(move_vector.x,-MAX_SPEED,MAX_SPEED)
	move_vector.y = clamp(move_vector.y,-MAX_SPEED,MAX_SPEED)
	
	move_and_slide(move_vector*delta*speed)
	


