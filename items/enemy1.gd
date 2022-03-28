extends KinematicBody2D
var health = 100
var coll = 0.3
var ded = false
var current_col = 0

func _ready():
	
	pass


func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("bullet"):
		got_shot()
	pass # Replace with function body.
	
func _process(delta):
	if current_col >=0:
		current_col-=delta
	else:
		$Sprite.material.set_shader_param("line_color",Color(0,0,0))
		pass

	if ded and not $AnimationPlayer.is_playing():
			get_parent().remove_child(self)

func got_shot(i = 25):
	if current_col <=0:
		current_col = coll
		$Sprite.material.set_shader_param("line_color",Color(150,150,150))
		health-=i
		if health < 0:
			$AnimationPlayer.play("die")
			ded=true
			
