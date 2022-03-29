extends Control


func _ready():
	pass


func _on_Button_pressed():
	Globalvars.username = $TextEdit.text
	if Globalvars.username.length()>0:
		get_parent().remove_child(self)
	pass # Replace with function body.
