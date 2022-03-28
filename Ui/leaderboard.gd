extends Node2D
var loaded = false

func _ready():
	Http.leaderboard()
	pass

func _process(delta):
	if Http.success and not loaded:
		loaded = true
		var data = Http.leaderboard
		var dynamic_font = DynamicFont.new()
		dynamic_font.font_data = load("res://Ui/font.tres")
		for key in data.result:
			var str_ = key+" : "+ str(data.result[key])
			$ScrollContainer/VBoxContainer/Label.text+= str_+"s"+"\n"
		Http.success = false


func _on_Button_pressed():
	get_tree().change_scene("res://Ui/Control.tscn")
	pass # Replace with function body.
