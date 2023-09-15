extends Node2D

var test_with = 10
var block_with = 256

var blocks = [
	preload("res://Source/Blocks/Tutorial/TutorialBlock1.tscn"),
	preload("res://Source/Blocks/Tutorial/TutorialBlock2.tscn"),
	preload("res://Source/Blocks/Tutorial/TutorialBlock3.tscn")
	]

func _ready():
	var RNG = RandomNumberGenerator.new()
	RNG.randomize()
	for i in range(test_with):
		var a = RNG.randf_range(0,len(blocks))
		print(a)
		var block = blocks[a].instance()
		get_node("Blocks").add_child(block)
		block.global_position.x = i*block_with
		
