extends Control


func _on_restart_pressed():
	PlayerStats.health = PlayerStats.max_health
	get_tree().change_scene("res://Source/Levels/Main1.tscn")


func _on_quit_pressed():
	get_tree().quit()
