extends Node

func _ready():
	#var n = get_node("playarea/GameLayer/Game")

	#n.prepare_maze()
	get_node("playarea/GameLayer").hide()
	get_node("playarea/MainMenuBG/MainMenu").hide()
	get_node("playarea/SplashMenuBG/SplashMenu").fadeInWithDelay()
	#get_node("playarea/SplashMenuBG/SplashMenu").hide()
	#get_node("Sounds/gameMusic").volume_db = -80
	get_node("Sounds/gameMusic").play()
	#get_node("Sounds/anim").play("gameMusicFadeIn")
	pass


func _on_Second_Ticker_timeout():
	pass # replace with function body
