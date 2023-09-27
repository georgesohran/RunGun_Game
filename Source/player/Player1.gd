extends KinematicBody2D

const MAX_SPEED = 100

export var speed = 100
export var gravity_force = 60
export var bounce_force = 50
export var jump_force = 200

var gravity = Physics.Force.new(Vector2.DOWN,gravity_force)
var run = Physics.Force.new(Vector2.RIGHT,speed)
var shoot_knockback = Physics.Force.new(Vector2.ZERO,0)

var constant_forces = [gravity,run]
var active_forces = []
var can_shoot = true

func _ready():
	PlayerStats.connect("no_health",self,"death")

func _physics_process(delta):
	var move_vector:Vector2
	
	if $Left.is_colliding() or $Right.is_colliding():
		gravity.power = gravity_force
		$Bouncing/Forward.enabled = true
		$Bouncing/Back.enabled = true
		$Sprite.play("Run")
		run.add_aceleration(1.08)
		run.power = clamp(run.power,1,speed)
	else:
		$Bouncing/Forward.enabled = false
		$Bouncing/Back.enabled = false
		$Sprite.play("InAir")
		run.add_friction(0.99)
		gravity.add_aceleration(1.03)
		
	if $Bouncing/Up.is_colliding():
		active_forces.append(Physics.Force.new(Vector2.DOWN,bounce_force))
	if $Bouncing/Forward.is_colliding():
		active_forces.append(Physics.Force.new(Vector2.LEFT,bounce_force))
	if $Bouncing/Back.is_colliding():
		active_forces.append(Physics.Force.new(Vector2.RIGHT,bounce_force))
		
	if Input.is_action_just_pressed("shoot") and can_shoot:
		$Gun.shoot($Gun.shoot_direction)
		shoot_knockback = Physics.Force.new((-to_local($Gun.shoot_direction)).normalized(),$Gun.knockback_force)
		active_forces.append(shoot_knockback)
		can_shoot = false
		$ShootTimer.start($Gun.recharge_time)
	
	if Input.is_action_just_pressed("jump") and ($Left.is_colliding() or $Right.is_colliding()):
		active_forces.append(Physics.Force.new(Vector2.UP,jump_force))
	
	move_vector += gravity.get_force()
	move_vector += run.get_force()
	
	for force in active_forces:
		move_vector += force.get_force()
		force.add_friction()
		if force.power < 0.1:
			active_forces.erase(force)
	
	move_vector = move_and_slide(move_vector*delta*speed)
	

func _on_ShootTimer_timeout():
	can_shoot = true

func _on_Hurtbox_area_entered(area):
	PlayerStats.health -= 1
	if PlayerStats.health > 0 :
		position = get_parent().get_node("StartPosition").position

func death():
	get_tree().change_scene("res://Source/GUI/DeathScren.tscn")
	queue_free()
	
