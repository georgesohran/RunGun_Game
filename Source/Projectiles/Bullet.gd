extends KinematicBody2D

var direction
var speed = 300

func _process(delta):
	translate(direction*speed*delta)


func _on_Hurtbox_body_entered(body):
	queue_free()
