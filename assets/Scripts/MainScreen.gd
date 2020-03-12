extends Node2D

func _on_StartGameButton_pressed():
	get_tree().change_scene("res://assets/Levels/Level01.tscn")


func _on_QuitGame_pressed():
	get_tree().quit()
