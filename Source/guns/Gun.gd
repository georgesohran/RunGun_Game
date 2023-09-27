extends Position2D


export(float) var recharge_time = 1
export(float) var knockback_force = 230
export(float) var bullet_speed = 400
var shoot_direction:Vector2

#func _ready():
#	if get_parent().name == "Enemy1":
#		get_parent().connect("left",self,"turn_gun_left")
#		get_parent().connect("right",self,"turn_gun_right")

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
	if get_parent().name == "Player1":
		Bullet.get_node("Hitbox").collision_mask == 5
#		Bullet.collision_layer
	elif get_parent().name == "Enemy1":
		Bullet.get_node("Hitbox").collision_mask == 4
	get_tree().current_scene.add_child(Bullet)
	Bullet.global_position = global_position
	
	#don't touch!!!  VVV
	Bullet.global_rotation = global_position.direction_to(tar).angle()
	Bullet.direction =  global_position.direction_to(tar).normalized()


#func turn_gun_left():
#	rotate(PI)
#func turn_gun_right():
#	rotate(PI)
	
