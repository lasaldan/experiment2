extends Node

func _ready():
	#get_node("playarea/GameBG").hide()
	get_node("playarea/GameBG").hide()
	#get_node("Sounds/gameMusic").volume_db = -80
	get_node("Sounds/gameMusic").play()
	#get_node("Sounds/anim").play("gameMusicFadeIn")
	pass
