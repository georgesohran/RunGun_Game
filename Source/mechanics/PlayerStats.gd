extends Node

export(int) var health = 3 setget set_health
export(int) var max_health = 3

signal no_health
signal health_changed

func set_health(value):
	health = value
	emit_signal("health_changed")
	if health <= 0 :
		emit_signal("no_health")
