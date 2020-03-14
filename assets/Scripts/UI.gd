extends Control

onready var GameManager = get_node("res://assets/Scripts/GameManager.gd")




func _on_SaveButton_pressed():
	GameManager.save_game_state("MyGame")
	print("Save Complete")

func _on_LoadButton_pressed():
	GameManager.load_game_state("MyGame")
	print("Load Complete")
