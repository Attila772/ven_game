extends KinematicBody2D
var vector = Vector2.UP
var max_dist = 1000
var red=true
var change_timer = 0.5
var change_const = 0.5
func _ready():
	pass

func _process(delta):
	change_timer-=delta
	var collision = move_and_collide(vector*delta*100)
	if !red and change_timer <0:
		red=true
		$Sprite.modulate=(Color(255,0,0))
		$Sprite.self_modulate=(Color(255,0,0))
		change_timer = change_const
	else:
		if change_timer <0:
			$Sprite.modulate=(Color(200,200,0))
			change_timer = change_const
			$Sprite.self_modulate=(Color(200,200,0))
			red=false
	if collision:
		print(collision.collider.name)
		if collision.collider.is_in_group("player"):
			collision.collider.got_shot()
		get_parent().remove_child(self)
