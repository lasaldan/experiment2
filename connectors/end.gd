extends Sprite

var size = 0

func _ready():
	size = get_tree().root.get_node("Main/playarea/GameLayer/Game").pieceSize

func _draw():
	draw_line(Vector2(0,0), Vector2(-size/2,0), Color(255,255,255), 30)
	draw_line(Vector2(-15,0), Vector2(15,0), Color(255,0,0), 30)
