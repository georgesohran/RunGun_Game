extends Area2D

var target = null

func can_see_target():
	return target != null

func _on_DetactionArea_body_entered(body):
	if body.name == "Player1":
		target = body



func _on_DetactionArea_body_exited(body):
	if body.name == "Player1":
		target = null
		
