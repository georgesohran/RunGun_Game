extends KinematicBody2D

const MAX_SPEED = 200

export var speed = 80

var gravity = Physics.Force.new(Vector2.DOWN,50)
var run = Physics.Force.new(Vector2.RIGHT,speed)

var active_forces = [gravity,run]
var can_shoot = true

func _physics_process(delta):
	
	var move_vector:Vector2
	
	if $Left.is_colliding() or $Right.is_colliding():
		run.add_aceleration(1.09)
		run.force = clamp(run.force,1,MAX_SPEED)
	else:
		run.add_friction(0.99)
		gravity.add_aceleration(1.02)
	if Input.is_action_just_pressed("shoot") and can_shoot:
		active_forces.append(Physics.Force.new((-to_local($Gun.shoot_direction)).normalized(),400))
		can_shoot = false
		$ShootTimer.start(1)
		
		
	for force in active_forces:
		move_vector += force.get_force()
		if force != run and force != gravity:
			force.add_friction()
			if force.force < 0.1:
				active_forces.erase(force)
		
			
	move_vector.x = clamp(move_vector.x,-MAX_SPEED,MAX_SPEED)
	move_vector.y = clamp(move_vector.y,-MAX_SPEED,MAX_SPEED)
	
	move_and_slide(move_vector*delta*speed)
	

func _on_ShootTimer_timeout():
	can_shoot = true
