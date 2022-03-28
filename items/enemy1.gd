extends KinematicBody2D
var health = 100
var coll = 0.3
var ded = false
var current_col = 0
var player_pos
var current_cooldown = -1
var shot_cooldown = 2

func _ready():

	pass



	
func _process(delta):
	if current_cooldown >0:
		current_cooldown-=delta
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
		if $RayCast2D.is_colliding() && $RayCast2D.get_collider().name == "Player":
			shoot()
			print (get_node("RayCast2D").get_collider().name)


func got_shot(i = 25):
	if current_col <=0:
		current_col = coll
		$Sprite.material.set_shader_param("line_color",Color(150,150,150))
		health-=i
		if health < 0:
			$AnimationPlayer.play("die")
			ded=true
			
func shoot():
	if current_cooldown < 0:
		current_cooldown = shot_cooldown
		var shot = load("res://items/shot_enemy.tscn").instance()
		shot.vector = transform.get_origin().direction_to((get_parent().get_node('Player').get_global_position()))
		shot.set_global_transform(self.get_global_transform())
		get_parent().add_child(shot)
