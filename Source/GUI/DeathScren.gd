extends Control


func _on_Restart_pressed():
	PlayerStats.health = PlayerStats.max_health
	get_tree().change_scene("res://Source/Levels/Main1.tscn")

func _on_Quit_pressed():
	get_tree().quit()
