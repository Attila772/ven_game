extends Control


func _ready():
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://levels/level_1/level1.tscn")
	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().quit()
	pass # Replace with function body.
