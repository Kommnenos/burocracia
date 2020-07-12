extends Control


func _on_VoltarDoCredito_pressed():
	$VoltarDoCredito/BotaoAudio.play()
	get_tree().change_scene("res://Scenes/MenuPricipal.tscn")
