extends CharacterBody2D

const speed = 400
var current_dir = "none"
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var attack_cooldown = true
var health = 180
var player_alive = true

var attack_ip = false




func _ready():
	$AnimatedSprite2D.play("down_idle")


func _physics_process(delta: float) -> void:
	player_movement(delta)
	enemy_attack()
	attack()

	if health <= 0:
		player_alive = false 
		health = 0
		print("player death")
		self.queue_free()

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
			if attack_ip == false:
				anim.play("idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_left")
		elif movement == 0:
			if attack_ip == false:
				anim.play("left_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_down")
		elif movement == 0:
			if attack_ip == false:
				anim.play("down_idle")
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_up")
		elif movement == 0:
			if attack_ip == false:
				anim.play("up_idle")
			
			
			
func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false
	
	
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		print("player - 10 health")
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
	

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()



func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
