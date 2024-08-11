extends CharacterBody2D
const speed : int = 500
const jump_power: int = -2000
const acc : int = 50
const friction : int = 70 # > than acc
const gravity : int = 500
const max_jumps : int = 2
var current_jumps : int = 1
func _physics_process(delta):
	var input_dir : Vector2 = input()
	if not is_on_floor():
		velocity.y += gravity * delta
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		play_animation()
	else:
		add_friction()
		play_animation()
	jump(delta)
	player_movement()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("move_left", "move_right")
	return input_dir
func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acc)
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
func player_movement():
	move_and_slide()
func play_animation():
	pass
func jump(delta):
	if Input.is_action_pressed("jump"):
		if current_jumps < max_jumps:
			velocity.y = jump_power
			current_jumps += 1
		if is_on_floor():
			current_jumps = 1
