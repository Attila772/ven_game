extends Control

var time = Globalvars.time

func _ready():
	$Label.text += " "+Globalvars.username
	$Label2.text = str(time)+"s"
	pass


func _on_Button_pressed():
	Globalvars.set_to_0()
	queue_free()
	get_tree().change_scene("res://Ui/Control.tscn")
	pass # Replace with function body.
