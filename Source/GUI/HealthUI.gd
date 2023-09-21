extends Control

func _ready():
	PlayerStats.connect("health_changed",self,"update_health")
	$TextureRect.rect_size.x = PlayerStats.health*16

func update_health():
	$TextureRect.rect_size.x = PlayerStats.health*16
