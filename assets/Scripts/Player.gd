extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
export var speed = 200
export var gravity = 10
export var jump_force = -400
onready var sprite = get_node("sprite")

func _physics_process(delta):
	motion.y += gravity
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		sprite.play("right")
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		sprite.play("left")
	
	else:
		motion.x = 0
		sprite.play("idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_force
			
	motion = move_and_slide(motion, UP)

func _on_hitbox_body_entered(body: KinematicBody2D):
	if body.name == "Enemy.tcsn":
		get_tree().change_scene("res://assets/Levels/LoseScreen.tscn")
