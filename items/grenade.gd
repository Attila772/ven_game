extends KinematicBody2D
var vector = Vector2.UP
var max_dist = 1000
var one_shot = false
var collided = false
func _ready():
	pass

func _process(delta):
	
	var collision = move_and_collide(vector*delta*400)
	if collision:
		collided = true
		$gren.visible=false
		$Sprite.visible = true
		if not one_shot:
			$AnimationPlayer.play("boom")
			one_shot = true
			for body in $Area2D.get_overlapping_bodies():
				print(body.name)
				if body.is_in_group("entity"):
					body.got_shot(150)
	if collided and not $AnimationPlayer.is_playing():
		get_parent().remove_child(self)
	
