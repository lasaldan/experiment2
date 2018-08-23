extends Node2D


var FlatButton = load("res://ui/FlatButton.tscn")

func _ready():

	var levelsButton = FlatButton.instance()
	levelsButton.get_node("Button").text = "Levels"
	levelsButton.get_node("Button").connect("pressed", self, "button1action");
	get_node("Levels").add_child(levelsButton)
	
	var freePlayButton = FlatButton.instance()
	freePlayButton.get_node("Button").text = "Free Play"
	freePlayButton.get_node("Button").connect("pressed", self, "freePlayMenu");
	get_node("FreePlay").add_child(freePlayButton)
	

func button1action():
	print("Button 1")
	
func freePlayMenu():
	#get_node("anim").play_backwards("fadeIn")
	get_parent().hide()
	get_tree().root.get_node("Main/playarea/MainMenuBG/MainMenu").fadeInWithDelay()



	
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
