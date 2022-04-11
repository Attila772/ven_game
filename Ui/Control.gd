extends Control
var changed = false

func _ready():
	Globalvars.set_to_0()
	if Globalvars.username.length() <1:
		var usern = load("res://Ui/username.tscn").instance()
		usern.rect_position = Vector2(200,100)
		add_child(usern)
	pass

func _process(delta):
	if $Label.text != Globalvars.username:
		$Label.text = Globalvars.username
		
func _on_Button_pressed():
	get_tree().change_scene("res://levels/level_1/level1.tscn")
	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://Ui/leaderboard.tscn")
	pass # Replace with function body.


func _on_Button4_pressed():
	if not changed:
		Music.get_node("AudioStreamPlayer").playing = false
		Music.get_node("AudioStreamPlayer").autoplay = false
		Music.get_node("AudioStreamPlayer2").play()
		$Label2.visible = true
		changed = true
	pass # Replace with function body.
