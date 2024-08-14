extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	pass

func contact_with_player(play: PhysicsBody2D):
	if play.is_in_group("player"):
		if play.velocity.y >= 0:
			if $AnimatedSprite2D.animation == "idle":
				$AnimatedSprite2D.play("death")
			elif $AnimatedSprite2D.animation == "death":
				$AnimatedSprite2D.play("idle")

