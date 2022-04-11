extends Node
var mobs=0
var tickets=0
var username = ""
var time = 0
# Declare member variables here. Examples:
# var a = 2  ,"res://levels/level_2/level2.tscn" ,"res://levels/level_3/level3.tscn" 
# var b = "text"
var levels = ["res://levels/level_1/level1.tscn","res://levels/level_2/level2.tscn" ,"res://levels/level_3/level3.tscn"  ]
var current_level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_to_0():
	time = 0
	Http.success = false
	current_level = 0
	mobs=0
	tickets=0
