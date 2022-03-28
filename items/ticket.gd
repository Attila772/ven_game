extends Node2D


func _ready():
	pass


func _on_Area2D_area_entered(area):
	print(area)
	if area.get_parent().is_in_group("player"):
		
		area.get_parent().ticket+=1
		get_parent().remove_child(self)
	pass # Replace with function body.
