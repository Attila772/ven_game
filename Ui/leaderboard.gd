extends Node2D
var loaded = false

func _ready():
	Http.leaderboard()
	pass
	
	
class custom_sort:
	static func sort_ascending(a, b):
		if int(a.split('_')[1]) < int(b.split('_')[1]):
			return true
		return false
	
func _process(delta):
	if Http.success and not loaded:
		loaded = true
		var data = Http.leaderboard
		var dynamic_font = DynamicFont.new()
		dynamic_font.font_data = load("res://Ui/font.tres")
		var array = []
		for key in data.result:
			array.append(key+"_"+str(data.result[key]))
		array.sort_custom(custom_sort,"sort_ascending")
		var counter = 1
		for item in array:
			var lbl_str = str(counter) + ". "+item.split('_')[0]+" : "+item.split('_')[1]+"s"	
			$ScrollContainer/VBoxContainer/Label.text+= lbl_str+"\n"
			counter+=1
		Http.success = false


func _on_Button_pressed():
	get_tree().change_scene("res://Ui/Control.tscn")
	pass # Replace with function body.
