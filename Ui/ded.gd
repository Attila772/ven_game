extends Control


func _ready():
	pass


func _on_Button_button_down():
	Globalvars.set_to_0()
	get_tree().change_scene("res://levels/level_1/level1.tscn")
	get_tree().paused = false
	pass # Replace with function body.


func _on_Button2_button_down():
	get_tree().quit()
	pass # Replace with function body.
