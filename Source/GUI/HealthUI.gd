extends Control

func _process(delta):
	$TextureRect.rect_size.x = PlayerStats.health*16
