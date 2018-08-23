extends Node2D

var FlatButton = load("res://ui/FlatButton.tscn")

func _ready():
	var easyButton = FlatButton.instance()
	easyButton.get_node("Button").text = "Easy"
	easyButton.get_node("Button").connect("pressed", self, "easy_game");
	#levelsButton.position = Vector2(0, -100)
	get_node("Easy").add_child(easyButton)
	
	
func fadeInWithDelay():
	var timer = Timer.new()
	timer.connect("timeout",self,"fadeIn")
	timer.wait_time = .5
	timer.one_shot = true
	add_child(timer)
	timer.start()
	
func fadeIn():
	show()
	get_node("anim").play("fadeIn")
	
func menuBG():
	return get_parent().get_parent().get_node("MainMenuBG")
	
func gameBG():
	return get_parent().get_parent().get_node("GameLayer")
	
func game():
	return get_parent().get_parent().get_node("GameLayer/Game")

func easy_game():
	start_game(4, "Recursive", game().EASY)

func _on_Medium_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		start_game(6, "Kruskals", game().MEDIUM)

func _on_Hard_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		start_game(8, "Kruskals", game().HARD)


func start_game(size, algorithm, difficulty):
	get_node("anim").play_backwards()
	game().width = size
	game().height = size
	game().algorithm = algorithm
	game().difficulty = difficulty
	game().prepare_maze()
	
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = 1
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	menuBG().hide()

	get_tree().root.get_node("Main/playarea/SplashMenuBG").hide()

	gameBG().show()
	#gameBG().get_node("Game").get_node("anim").play("fadeIn")