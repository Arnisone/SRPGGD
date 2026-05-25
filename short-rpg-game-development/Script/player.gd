extends CharacterBody2D

const speed = 100

func _physics_process(delta: float) -> void:
	pass

func player_movement(delta):
	player_movement(delta)
	
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_ip"):
		velocity.y = -speed
		velocity.x = 0
	else:
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
