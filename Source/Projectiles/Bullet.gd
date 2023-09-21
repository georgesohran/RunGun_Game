extends KinematicBody2D

var direction = Vector2.LEFT

func _process(delta):
	translate(direction*get_parent().bullet_speed*delta)
	
