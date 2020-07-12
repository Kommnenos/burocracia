extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/MenuPricipal.tscn")
