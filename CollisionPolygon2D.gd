extends CollisionPolygon2D
var polygon_2d = Polygon2D.new()




# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(polygon_2d)
	polygon_2d.set_polygon(polygon)
	polygon_2d.set_color(Color(0,1,0,1))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
