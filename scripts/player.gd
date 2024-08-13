extends CharacterBody2D
var speed : int = 500
var jump_power: int = -2000
const acc : int = 50
const friction : int = 70 # > than acc
const gravity : int = 140
const max_jumps : int = 2
var current_jumps : int = 0

func _physics_process(_delta):
	var input_dir : Vector2 = input()
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0
	if input_dir != Vector2.ZERO:
		if Input.is_action_pressed("run"):
			speed = 750
		elif Input.is_action_pressed("duck"):
			speed = 250
		else:
			speed = 500
		velocity = velocity.move_toward(speed * input_dir, acc) #Accerlate
		play_animation()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
		play_animation()
	jump()
	move_and_slide()
func _process(_delta):
	pass
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right") # Left = -1, Right = +1
	return input_dir
func play_animation():
	if Input.is_action_pressed("attack"):
		$AnimatedSprite2D.play("attack")
	elif Input.is_action_pressed("jump"):
		$AnimatedSprite2D.play("jump")
	elif Input.is_action_pressed("duck"):
		$AnimatedSprite2D.play("duck")
	elif velocity.x != 0:
		match speed:
			750:
				$AnimatedSprite2D.play("run")
			500:
				$AnimatedSprite2D.play("walk")
			250:
				$AnimatedSprite2D.play("duck")
	else:
		$AnimatedSprite2D.play("idle")
	if abs(velocity.x) > 0.001:
		flip(velocity.x > 0)
		#$AnimatedSprite2D.flip_h = velocity.x > 0
func speed_boost():
	jump_power += -200
func jump():
	if Input.is_action_just_pressed("jump"):
		if current_jumps < max_jumps:
			$AudioStreamPlayer2D.play()
			velocity.y = jump_power
			current_jumps += 1
		if is_on_floor():
			current_jumps = 0
	if Input.is_action_just_pressed("duck"):
		velocity.y = jump_power / -2
func push_back():
	velocity.x = 500 * (-1 if $AnimatedSprite2D.flip_h else 1 )
	velocity.y = jump_power / 1.1
	print(velocity.x)

func hitbox_check(body: PhysicsBody2D):
	if body.is_in_group("wall"):
		push_back()
func flip(value: bool):
	
	if value != $AnimatedSprite2D.flip_h:
		$CollisionShape2D.position.x *= -1
		$AnimatedSprite2D.flip_h = value
		$AnimatedSprite2D/Spear/CollisionShape2D.position.x *= -1
