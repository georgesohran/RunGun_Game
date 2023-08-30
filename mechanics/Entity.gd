extends KinematicBody2D
class_name Entity

var active_forces = []

#
#var direction:Vector2
#var power:float
#var friction:float
#var gravity_direction:Vector2 = Vector2.ZERO
#var force:Vector2 = direction*power
#
#func apply_friction():
#	power *= friction
#func apply_gravity():
#	direction = (direction - gravity_direction)
#
#func get_force():
#	force = direction*power
#	return force
#
#func _init(dir:Vector2,fce:float):
#	direction = dir
#	power = fce

class Force:
	var direction:Vector2
	var force:float 
	var friction:float = 0.98
	
	func add_friction():
		force *= friction
	
	func get_force():
		return direction*force
	
	func _init(dir:Vector2,force:float):
		direction = dir
		self.force = force

