extends Node2D

func _on_TextureButton_pressed():
	$AudioStreamFechar.play()
	self.visible = false

func _on_TextureButton2_pressed():
	$BotaoAudio.play()
	get_tree().change_scene_to_file("res://Scenes/MenuPricipal.tscn")
