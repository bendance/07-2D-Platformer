extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var direction = 1
export var speed = 100
export var gravity = 10
export var jump_force = -400


func _physics_process(delta):
	motion.x = -speed * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	motion.y += gravity
	$AnimatedSprite.play("roll")
	motion = move_and_slide(motion, UP)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
func _on_hitbox_body_entered(body):
	if body.name == "Player":
			get_tree().change_scene("res://assets/Levels/LoseScreen.tscn")
