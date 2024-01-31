extends Control

var button_n =1

func _on_VolaterHTP_pressed():
	if button_n == 1:
		$VolaterHTP/BotaoAudio.play()
		button_n += 1
		$Label.visible = false
		$Label2.visible = true
		$VolaterHTP/Label.text = "Back"
	else: 
		get_tree().change_scene_to_file("res://Scenes/MenuPricipal.tscn")
