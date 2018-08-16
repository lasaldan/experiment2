extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _draw():

	var screenRect = Rect2(-1000,-1000,2000,2000);
	var bgTex = 

	draw_rect(texture, screenRect, true)
	#draw_line(Vector2(0,-15), Vector2(0,size/2), Color(255,255,255), 30)
	#draw_line(Vector2(-15,0), Vector2(-size/2,0), Color(255,255,255), 30)
