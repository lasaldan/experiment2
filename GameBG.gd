extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("backButton").position = Vector2(0, 600)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_backButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		hide()
		get_parent().get_node("MainMenuBG").get_node("MainMenu").get_node("anim").play("fadeIn")
		get_parent().get_node("MainMenuBG/MainMenu").show()

