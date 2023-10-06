extends KinematicBody2D

export(float) var speed = 50

var move_vector = Vector2.RIGHT


func _process(delta):
	if $Right.is_colliding():
		turn_left()
	elif $Left.is_colliding():
		turn_right()
		
	if not $Down_right.is_colliding():
		turn_left()
	elif not $Down_left.is_colliding():
		turn_right()
	
	
		
	move_and_slide(move_vector*speed)


	
func turn_right():
	move_vector = Vector2.RIGHT
	$AnimatedSprite.flip_h = false

	
func turn_left():
	move_vector = Vector2.LEFT
	$AnimatedSprite.flip_h = true



func _on_Hurtbox_area_entered(area):
	queue_free()

func _on_ShootTimer_timeout():
	if $DetactionArea.can_see_target():
		$Gun.shoot(($DetactionArea.target.global_position - global_position))
		$ShootTimer.start(3)
