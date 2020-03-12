extends CollisionShape2D

func on_Enemy_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://assets/Levels/LoseScreen.tscn")
