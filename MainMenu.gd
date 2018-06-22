extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization her
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func menuBG():
	return get_parent().get_parent().get_node("MainMenuBG")
	
func gameBG():
	return get_parent().get_parent().get_node("GameBG")
	
func game():
	return get_parent().get_parent().get_node("GameBG/Game")

func _on_Easy_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		menuBG().hide()
		start_game(5)
		gameBG().show()

func _on_Hard_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		menuBG().hide()
		start_game(9)
		gameBG().show()


func _on_Medium_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		menuBG().hide()
		start_game(7)
		gameBG().show()

func start_game(size):
	game().width = size
	game().height = size
	game().prepare_maze()