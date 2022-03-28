extends Control


func _ready():
	pass


func _on_Button_pressed():
	if Globalvars.username.length()>1:
		get_tree().change_scene("res://levels/level_1/level1.tscn")
	else:
		$Label.text = "hoszab plzs"
	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Button4_pressed():
	Globalvars.username = $TextEdit.text
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://Ui/leaderboard.tscn")
	pass # Replace with function body.
