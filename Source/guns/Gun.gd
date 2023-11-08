extends Position2D


export(float) var recharge_time = 1
export(float) var knockback_force = 260
export(float) var bullet_speed = 400
var shoot_direction:Vector2

func _physics_process(delta):
	shoot_direction = get_global_mouse_position()
	if get_parent().name == "Player1":
		look_at(shoot_direction)
	elif get_parent().name == "Enemy1":
		var target = get_parent().get_node("DetactionArea").target
		if get_parent().get_node("DetactionArea").can_see_target():
			look_at(target.global_position)
			
		$Sprite.flip_v = rotation < -PI or rotation > PI
			
func shoot(tar):
	var Bullet = preload("res://Source/Projectiles/Bullet.tscn").instance()
	var HostBullet = preload("res://Source/Projectiles/HostileBullet.tscn").instance()
	
	if get_parent().name == "Player1":
		get_tree().current_scene.add_child(Bullet)
		Bullet.global_position = global_position
		Bullet.global_rotation = global_position.direction_to(tar).angle()
		Bullet.direction =  global_position.direction_to(tar).normalized()
		
	if get_parent().name == "Enemy1":
		get_tree().current_scene.add_child(HostBullet)
		HostBullet.global_position = global_position
		HostBullet.global_rotation = tar.angle()
		HostBullet.direction = tar.normalized()
		

