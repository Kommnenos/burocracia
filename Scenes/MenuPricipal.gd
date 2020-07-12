extends Control



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Play_pressed():
	$Play/BotaoAudio.play()
	get_tree().change_scene("res://Scenes/CenaInicial.tscn")


func _on_Play2_pressed():
	$Play2/BotaoAudio.play()
	get_tree().change_scene("res://Scenes/How to Play.tscn")


func _on_Play3_pressed():
	$Play3/BotaoAudio.play()
	get_tree().change_scene("res://Scenes/Creditos.tscn")

func _on_Play4_pressed():
	$Play4/BotaoAudio.play()
	get_tree().quit()
	
