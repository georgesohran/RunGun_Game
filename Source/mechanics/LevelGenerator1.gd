extends Node2D

var test_with = 10
var block_with = 256

var blocks = [
	preload("res://Source/Blocks/Tutorial/Block1.tscn"),
	preload("res://Source/Blocks/Tutorial/Block2.tscn"),
	preload("res://Source/Blocks/Tutorial/Block3.tscn"),
	preload("res://Source/Blocks/Tutorial/Block4.tscn"),
	preload("res://Source/Blocks/Tutorial/Block5.tscn"),
	preload("res://Source/Blocks/Tutorial/Block6.tscn")
	]

func _ready():
	var RNG = RandomNumberGenerator.new()
	RNG.randomize()
	for i in range(test_with):
		var a = RNG.randf_range(0,len(blocks))
		var block = blocks[a].instance()
		get_node("Blocks").add_child(block)
		block.global_position.x = i*block_with
	
	get_node("BackGround").scale.x = test_with
	get_node("BackGround").global_position.x = (test_with/2)*block_with

func _process(delta):
	get_node("BackGround").global_position.y = get_node("Player1").global_position.y/2
	
