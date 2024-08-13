extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if frame < 4 and get_animation() == "attack":
		$Spear.get_child(0).disabled = false
		#print("hitbox out")
	else:
		$Spear.get_child(0).disabled = true
