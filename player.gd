extends KinematicBody2D
var dir = "right"
var anim = "idle"
var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
var ticket = 0
var shot_cooldown = 0.3
var current_cooldown = -1
var grenades = 3
var grenade_cooldown = 1
var grenade_current_cooldown = 0
onready var jegy = $Camera2D/jegy
var health = 100
var touch_ui = {"up":false,"down":false,"right":false,"left":false,"shoot":false,"grenade":false}
var coll = 0.5
var current_col = 0
var time = 0
var username = Globalvars.username
var ded = false
var http_sendt = false

func _ready():
	print("Time: ",Globalvars.time)
	Globalvars.current_level+=1

func get_input():
	velocity = Vector2.ZERO
	
	
	
#	var move_input = Vector2(
#		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
#		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	).clamped(1) #just in case someone uses buttons - Joystick already returns clamped value
#
#	if move_input.length()>Vector2.ZERO.length():
#		if abs(move_input.y)>abs(move_input.x):
#			if move_input.y > 0:
#				dir = "left"
#				anim = "run"
#				$aim.set_rotation_degrees(90)
#			else:
#				dir = "right"
#				anim = "run"
#				$aim.set_rotation_degrees(270)
#		else:
#			if move_input.x > 0:
#				dir = "right"
#				anim ="run"
#				$aim.set_rotation_degrees(0)
#			else:
#
#				$aim.set_rotation_degrees(180)
#				dir = "left"
#				anim = "run"
#		pass
#	velocity = move_input.normalized() * speed

	if Input.is_action_pressed('down') or touch_ui["down"]:
		dir = "right"
		anim = "run"
		$aim.set_rotation_degrees(90)
		velocity.y += 1
	if Input.is_action_pressed('up') or touch_ui["up"]:
		dir = "left"
		anim = "run"
		$aim.set_rotation_degrees(270)
		velocity.y -= 1
	if Input.is_action_pressed('right') or touch_ui["right"]:
		dir = "right"
		anim ="run"
		$aim.set_rotation_degrees(0)
		velocity.x += 1
	if Input.is_action_pressed('left') or touch_ui["left"]:
		$aim.set_rotation_degrees(180)
		dir = "left"
		anim = "run"
		velocity.x -= 1
	velocity = velocity.normalized()*speed





func _physics_process(delta):
	
	get_input()
	jegy.text = str(ticket)
	if velocity != Vector2(0,0):
		animation()
	else:
		$AnimationPlayer.play("idle_"+dir)
		anim ="idle"
	velocity = move_and_slide(velocity)
	if Input.is_action_pressed("shoot") or touch_ui["shoot"]:
		shoot()
	if Input.is_action_just_pressed("grenade") or touch_ui["grenade"]:
		grenade()

func _process(delta):
#	if anim == "run" and not $walk.playing:
#		$walk.play()
#	elif anim =="idle":
#		$walk.playing = false
	Globalvars.time += delta
	if Http.success:
		get_tree().change_scene("res://Ui/Win.tscn")
	if ticket > 0 and Globalvars.tickets ==0 and Globalvars.mobs ==0 and not http_sendt:
		if Globalvars.levels.size() == Globalvars.current_level:

			Http.http_request(username,Globalvars.time)
			http_sendt = true
		else:
			get_tree().change_scene(Globalvars.levels[Globalvars.current_level])
		
	if $Camera2D/ProgressBar.value != health:
		$Camera2D/ProgressBar.value = health
	if int($Camera2D/grenade.text) != grenades:
		$Camera2D/grenade.text = str(grenades)
	if current_cooldown >0:
		current_cooldown-=delta
	if grenade_current_cooldown >0:
		grenade_current_cooldown-=delta
	if current_col >0:
		current_col-=delta
	if current_col <0:
		$Sprite.material.set_shader_param("line_color",Color(0,0,0))
		
		
func animation():
	var _anim = anim + "_" +dir
	$AnimationPlayer.play(_anim)

func shoot():
	if current_cooldown < 0:
		$shoot.play()
		current_cooldown = shot_cooldown
		var shot = load("res://items/shot.tscn").instance()
		shot.vector = transform.get_origin().direction_to($aim/Position2D.get_global_transform().get_origin())
		shot.set_global_transform(self.get_global_transform())
		get_parent().add_child(shot)

func grenade():
	if grenade_current_cooldown <=0:
		if grenades >=1:
			var grenade = load("res://items/grenade.tscn").instance()
			grenade.vector = transform.get_origin().direction_to($aim/Position2D.get_global_transform().get_origin())
			grenade.set_global_transform(self.get_global_transform())
			get_parent().add_child(grenade)
			grenades-=1
			grenade_current_cooldown = grenade_cooldown
	pass


func got_shot(i = 25):
	if current_col <=0:
		current_col = coll
		$Sprite.material.set_shader_param("line_color",Color(150,150,150))
		health-=i
		if health < 0:
			get_tree().paused = true
			var ded  = load("res://Ui/ded.tscn").instance()
			ded.rect_position = Vector2(-200,-100)
			$Camera2D.add_child(ded)
		
			ded=true


func _on_TouchScreenButton_pressed():
	shoot()
	pass # Replace with function body.


func _on_TouchScreenButton2_released():
	grenade()
	pass # Replace with function body.
