extends KinematicBody2D

const MAX_SPEED = 100

export var speed = 100
export var gravity_force = 60
export var bounce_force = 50

var gravity = Physics.Force.new(Vector2.DOWN,gravity_force)
var run = Physics.Force.new(Vector2.RIGHT,speed)
var shoot_knockback = Physics.Force.new(Vector2.ZERO,0)

var constant_forces = [gravity,run]
var active_forces = [shoot_knockback]
var can_shoot = true

func _physics_process(delta):
	var move_vector:Vector2
	
	if $Left.is_colliding() or $Right.is_colliding():
		$Bouncing/Forward.enabled = true
		$Bouncing/Back.enabled = true
		$Sprite.play("Run")
		gravity.force = gravity_force
		run.add_aceleration(1.10)
		run.force = clamp(run.force,1,speed)
		if active_forces.has(shoot_knockback):
			active_forces.erase(shoot_knockback)
	else:
		$Bouncing/Forward.enabled = false
		$Bouncing/Back.enabled = false
		$Sprite.play("InAir")
		run.add_friction(0.98)
		gravity.add_aceleration(1.03)
		
		
	if $Bouncing/Up.is_colliding():
		active_forces.append(Physics.Force.new(Vector2.DOWN,bounce_force))
	if $Bouncing/Forward.is_colliding():
		active_forces.append(Physics.Force.new(Vector2.LEFT,bounce_force))
	if $Bouncing/Back.is_colliding():
		active_forces.append(Physics.Force.new(Vector2.RIGHT,bounce_force))
		
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot_knockback = Physics.Force.new((-to_local($Gun.shoot_direction)).normalized(),$Gun.knockback_force)
		active_forces.append(shoot_knockback)
#		can_shoot = false
		$ShootTimer.start($Gun.recharge_time)
	
	move_vector += gravity.get_force()
	move_vector += run.get_force()
	
	for force in active_forces:
		move_vector += force.get_force()
		force.add_friction()
		if force.force < 0.1:
			active_forces.erase(force)
		
#	move_vector.x = clamp(move_vector.x,-MAX_SPEED,MAX_SPEED)
#	move_vector.y = clamp(move_vector.y,-MAX_SPEED,MAX_SPEED)
	
	move_vector = move_and_slide(move_vector*delta*speed)
	

func _on_ShootTimer_timeout():
	can_shoot = true



