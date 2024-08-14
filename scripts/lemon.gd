extends CharacterBody2D
var speed : int = -250
var dead : bool = false
@onready var ray_cast = $RayCast2D

func _ready():
	$AnimatedSprite2D.play("walk")

func _physics_process(_delta):
	if not dead:
		if ray_cast.is_colliding() and not ray_cast.get_collider().is_in_group("player"):
			flip()
		velocity.x = speed 
		#print(velocity.x)
		move_and_slide()
	

func flip():
	$AnimatedSprite2D.flip_h = !($AnimatedSprite2D.flip_h)
	$RayCast2D.position.x *= -1
	$RayCast2D.set_rotation_degrees(180 if $RayCast2D.get_rotation_degrees() == 0 else 0)
	speed *= -1




func stabbed(body):
	if body.is_in_group("weapon"):
		dead = true
		$AnimatedSprite2D.play("death")
		$CollisionShape2D.position.y = -6.765
		$CollisionShape2D.rotation = 90
		$hurtbox/CollisionShape2D.disabled = true
		$RayCast2D.enabled = false
