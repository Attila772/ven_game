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
var health = 80
var touch_ui = {"up":false,"down":false,"right":false,"left":false,"shoot":false,"grenade":false}
func get_input():
	velocity = Vector2.ZERO
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
	
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	
	get_input()
	jegy.text = str(ticket)
	if velocity != Vector2(0,0):
		animation()
	else:
		$AnimationPlayer.play("idle_"+dir)
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("shoot") or touch_ui["shoot"]:
		shoot()
	if Input.is_action_just_pressed("grenade") or touch_ui["grenade"]:
		grenade()

func _process(delta):
	if $Camera2D/ProgressBar.value != health:
		$Camera2D/ProgressBar.value = health
	if int($Camera2D/grenade.text) != grenades:
		$Camera2D/grenade.text = str(grenades)
	if current_cooldown >0:
		current_cooldown-=delta
	if grenade_current_cooldown >0:
		grenade_current_cooldown-=delta
		
		
func animation():
	var _anim = anim + "_" +dir
	$AnimationPlayer.play(_anim)

func shoot():
	if current_cooldown < 0:
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






