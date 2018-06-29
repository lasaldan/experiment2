extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization her
	get_node("anim").play("fadeIn")
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
		start_game(4, "Recursive")

func _on_Medium_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		start_game(6, "Kruskals")

func _on_Hard_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		start_game(8, "Kruskals")


func start_game(size, algorithm):
	get_node("anim").play_backwards()
	game().width = size
	game().height = size
	game().algorithm = algorithm
	game().prepare_maze()
	
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	hide()
	gameBG().show()
	gameBG().get_node("Game").get_node("anim").play("fadeIn")