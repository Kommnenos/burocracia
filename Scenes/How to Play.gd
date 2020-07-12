extends Control



func _on_VolaterHTP_pressed():
	$VolaterHTP/BotaoAudio.play()
	get_tree().change_scene("res://Scenes/MenuPricipal.tscn")
