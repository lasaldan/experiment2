extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var buttonHeight = 150
var color = Color(255,255,255,1)
var buttonWidth = 600
var lineWidth = 4

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _draw():

	draw_line( Vector2( -buttonWidth/2, -buttonHeight/2 ), Vector2( buttonWidth/2, -buttonHeight/2 ), color, lineWidth ) # top
	draw_line( Vector2( -buttonWidth/2, buttonHeight/2 ), Vector2( buttonWidth/2, buttonHeight/2 ), color, lineWidth ) # bottom
	
	draw_line( Vector2( -buttonWidth/2, -buttonHeight/2 ), Vector2( -buttonWidth/2, buttonHeight/2 ), color, lineWidth ) # left
	draw_line( Vector2( buttonWidth/2, -buttonHeight/2 ), Vector2( buttonWidth/2, buttonHeight/2 ), color, lineWidth ) # right
	