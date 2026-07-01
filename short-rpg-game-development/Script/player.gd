extends CharacterBody2D

const speed = 150
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("down_idle")


func _physics_process(delta: float) -> void:
	player_movement(delta)

func player_movement(delta):
	
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		player_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		player_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		player_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		player_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		player_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func player_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("run")
		elif movement == 0:
			anim.play("idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_left")
		elif movement == 0:
			anim.play("left_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_down")
		elif movement == 0:
			anim.play("down_idle")
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_up")
		elif movement == 0:
			anim.play("up_idle")
