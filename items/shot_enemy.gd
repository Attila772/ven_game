extends KinematicBody2D
var vector = Vector2.UP
var max_dist = 1000
func _ready():
	pass

func _process(delta):
	
	var collision = move_and_collide(vector*delta*200)
	if collision:
		print(collision.collider.name)
		if collision.collider.is_in_group("player"):
			collision.collider.got_shot()
		get_parent().remove_child(self)
