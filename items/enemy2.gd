extends KinematicBody2D
var health = 100
var coll = 0.3
var ded = false
var current_col = 0
var player_pos
var speed = 130
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
	else:
		player_pos=Vector2(get_parent().get_node('Player').get_global_position()-self.get_global_position())
		get_node("RayCast2D").cast_to=player_pos
		
func _physics_process(delta):
	if $RayCast2D.is_colliding() && $RayCast2D.get_collider().name == "Player":
			movement((player_pos).normalized()*speed)
			
func got_shot(i = 25):
	if current_col <=0:
		current_col = coll
		$Sprite.material.set_shader_param("line_color",Color(150,150,150))
		health-=i
		if health < 0:
			$AnimationPlayer.play("die")
			ded=true
			
func movement(direction):
	move_and_slide(direction)
	pass
