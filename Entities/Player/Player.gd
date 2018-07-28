extends KinematicBody2D

export (int) var walk_speed

const GRAVITY = 0
var velocity = Vector2(0,0)
var motion = 0

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	if Input.is_action_pressed("ui_left"):
		velocity.x -= walk_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x += walk_speed
	else:
		velocity.x = 0
	move_and_slide(velocity, Vector2(0,-1))