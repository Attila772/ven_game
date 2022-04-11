extends Node2D


func _ready():
	Globalvars.tickets+=1
	pass


func _on_Area2D_area_entered(area):
	print(area)
	if area.get_parent().is_in_group("player"):
		
		area.get_parent().ticket+=1
		get_parent().call_deferred("remove_child",self)
		Globalvars.tickets-=1
	pass # Replace with function body.
