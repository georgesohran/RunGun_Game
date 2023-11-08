extends Node2D

var test_with = 10
var block_with = 256

onready var seconds = 3

var blocks = [
	preload("res://Source/Blocks/Tutorial/Block1.tscn"),
	preload("res://Source/Blocks/Tutorial/Block2.tscn"),
	preload("res://Source/Blocks/Tutorial/Block3.tscn"),
	preload("res://Source/Blocks/Tutorial/Block4.tscn"),
	preload("res://Source/Blocks/Tutorial/Block5.tscn"),
	preload("res://Source/Blocks/Tutorial/Block6.tscn"),
	preload("res://Source/Blocks/Tutorial/Block7.tscn"),
	preload("res://Source/Blocks/Tutorial/Block8.tscn"),
	]


func _ready():
	PlayerStats.connect("health_changed",self,"respawn")
	
	get_node("Player1").position = get_node("StartPosition").position
	var RNG = RandomNumberGenerator.new()
	RNG.randomize()
	for i in range(test_with):
		var a = RNG.randf_range(0,len(blocks)-1)
		var block = blocks[a].instance()
		get_node("Blocks").add_child(block)
		block.global_position.x = i*block_with
	
	get_node("Block_finish").global_position.x = (test_with) * block_with
	
	get_node("BackGround").scale.x = test_with+4
	get_node("BackGround").global_position.x = (test_with/2)*block_with
	get_node("BackGround").global_position.y = 0
	get_node("End of the map").global_position = Vector2((test_with+1) * block_with,0)
	
	
	

func _process(delta):
	get_node("BackGround").global_position.y = get_node("Player1").global_position.y/2
	
	
func respawn():
	get_node("Player1").position = get_node("StartPosition").position
			
func countdown():
	get_node("Timer").start(1)
	
func _on_End_of_the_map_body_entered(body):
	get_tree().change_scene("res://Source/GUI/Win_screen.tscn")

func _on_Timer_timeout():
	seconds -= 1 
	if seconds > 0:
		get_node("UI/CountDown/Label").text = str(seconds)
	elif seconds == 0:
		get_node("UI/CountDown/Label").text = "GO!"
		get_node("wall_before").queue_free()
	else:
		get_node("UI/CountDown/Label").text = ""
		
