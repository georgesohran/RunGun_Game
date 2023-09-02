extends Reference
class_name Physics

var active_forces = []

class Force:
	var direction:Vector2
	var force:float 
	var friction:float = 0.98
	var aceleration:float = 1.02
	
	func add_friction(fri:float = friction):
		if force >= 0.1:
			force *= fri
	
	func add_aceleration(acel:float = aceleration):
		if force < 300 :
			force *= acel
	
	func get_force():
		return direction*force
	
	func _init(dir:Vector2,force:float):
		direction = dir
		self.force = force
	
	
