extends KinematicBody2D
var vector = Vector2.UP
var max_dist = 1000
var red=true
func _ready():
	pass

func _process(delta):
	
	var collision = move_and_collide(vector*delta*100)
	if !red:
		red=true
		$Sprite.modulate=(Color(255,0,0))
		$Sprite.self_modulate=(Color(255,0,0))
	else:
		$Sprite.modulate=(Color(200,200,0))
		$Sprite.self_modulate=(Color(200,200,0))
		red=false
	if collision:
		print(collision.collider.name)
		if collision.collider.is_in_group("player"):
			collision.collider.got_shot()
		get_parent().remove_child(self)
