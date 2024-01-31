extends Control



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if not MusiquinhaTutsTuts.playing:
		MusiquinhaTutsTuts.playing = true 

func _on_Play_pressed():
	$VBoxContainer/Play/BotaoAudio.play()
	get_tree().change_scene_to_file("res://Scenes/CenaInicial.tscn")


func _on_Play2_pressed():
	$VBoxContainer/Play2/BotaoAudio.play()
	get_tree().change_scene_to_file("res://Scenes/How to Play.tscn")


func _on_Play3_pressed():
	$VBoxContainer/Play3/BotaoAudio.play()
	get_tree().change_scene_to_file("res://Scenes/Creditos.tscn")

func _on_Play4_pressed():
	$VBoxContainer/Play4/BotaoAudio.play()
	get_tree().quit()
	
