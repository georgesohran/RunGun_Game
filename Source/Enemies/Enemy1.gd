extends KinematicBody2D

export(float) var speed = 50

var move_vector = Vector2.RIGHT
var can_shoot = true

#signal left
#signal right

func _process(delta):
	if $Right.is_colliding():
		turn_left()
	elif $Left.is_colliding():
		turn_right()
		
	if not $Down_right.is_colliding():
		turn_left()
	elif not $Down_left.is_colliding():
		turn_right()
	if $DetactionArea.can_see_target() and can_shoot:
		$Gun.shoot($DetactionArea.target.global_position)
		$ShootTimer.start(3)
		can_shoot = false
		
		
	move_and_slide(move_vector*speed)


	
func turn_right():
	move_vector = Vector2.RIGHT
	$AnimatedSprite.flip_h = false
#	emit_signal("right")

	
func turn_left():
	move_vector = Vector2.LEFT
	$AnimatedSprite.flip_h = true
#	emit_signal("left")



func _on_Hurtbox_area_entered(area):
	queue_free()

func _on_ShootTimer_timeout():
	can_shoot == true
