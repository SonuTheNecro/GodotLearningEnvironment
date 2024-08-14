extends CharacterBody2D
var speed : int = -250
var dead : bool = false
@onready var ray_cast = $RayCast2D

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(_delta):
	if not dead and $AnimatedSprite2D.animation != "idle":
		if ray_cast.is_colliding() and not ray_cast.get_collider().is_in_group("player"):
			flip()
		velocity.x = speed 
		#print(velocity.x)
		move_and_slide()
	hitbox_update()

func flip():
	$AnimatedSprite2D.flip_h = !($AnimatedSprite2D.flip_h)
	$RayCast2D.position.x *= -1
	$RayCast2D.set_rotation_degrees(180 if $RayCast2D.get_rotation_degrees() == 0 else 0)
	speed *= -1

func hitbox_update():
	match $AnimatedSprite2D.animation:
		"idle":
			match $AnimatedSprite2D.frame:
				0:
					$AnimatedSprite2D.position.y = -15
				1:
					$AnimatedSprite2D.position.y = -13
		"death":
			$AnimatedSprite2D.position.y = -15
			$CollisionShape2D.position.y = -6.765
			$CollisionShape2D.rotation = 90
		"walk":
			$AnimatedSprite2D.position.y = -15
			$CollisionShape2D.position.y = -12
			$CollisionShape2D.rotation = 0

func stabbed(body):
	if body.is_in_group("weapon") and not dead:
		dead = true
		$AnimatedSprite2D.play("death")

		#$hurtbox/CollisionShape2D.set_deferred("disabled",false)
		#$hurtbox.disable_mode = Node.PROCESS_MODE_DISABLED
		#$RayCast2D.enabled = false


func _on_detection_screen_entered():
	$AnimatedSprite2D.play("walk")
	dead = false
