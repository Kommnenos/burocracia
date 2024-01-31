extends Control


func _on_VoltarDoCredito_pressed():
	$VoltarDoCredito/BotaoAudio.play()
	get_tree().change_scene_to_file("res://Scenes/MenuPricipal.tscn")
