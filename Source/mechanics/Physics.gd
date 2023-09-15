extends Reference
class_name Physics

var active_forces = []

class Force:
	var direction:Vector2
	var power:float 
	var friction:float = 0.98
	var aceleration:float = 1.02
	var force = direction * power
	
	func add_friction(fri:float = friction):
		if power >= 0.1:
			power *= fri
	
	func add_aceleration(acel:float = aceleration):
		if power <= 300 :
			power *= acel
	
	func get_force():
		return direction * power
	
	func _init(dir:Vector2,power:float):
		direction = dir
		self.power = power
	
	
