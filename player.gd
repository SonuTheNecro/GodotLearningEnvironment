extends CharacterBody2D
var speed : int = 500
const jump_power: int = -2000
const acc : int = 50
const friction : int = 70 # > than acc
const gravity : int = 140
const max_jumps : int = 2
var current_jumps : int = 0

func _physics_process(delta):
	var input_dir : Vector2 = input()
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0
	if input_dir != Vector2.ZERO:
		if Input.is_action_pressed("run"):
			speed = 750
		else:
			speed = 500
		velocity = velocity.move_toward(speed * input_dir, acc) #Accerlate
		play_animation()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
		play_animation()
	jump()
	move_and_slide()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right") # Left = -1, Right = +1
	return input_dir
func play_animation():
	if Input.is_action_pressed("jump"):
		$AnimatedSprite2D.animation = "jump"
	elif Input.is_action_pressed("duck"):
		$AnimatedSprite2D.animation = "duck"
	elif velocity.x != 0:
		if speed == 500:
			$AnimatedSprite2D.animation = "walk"
		else:
			$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
func jump():
	if Input.is_action_pressed("jump"):
		if current_jumps < max_jumps:
			velocity.y = jump_power
			current_jumps += 1
		if is_on_floor():
			current_jumps = 0
