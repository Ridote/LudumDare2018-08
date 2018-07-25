extends RigidBody2D

export (int) var speed;
var mapSize;

func setMapSize(value):
	mapSize = value

func _ready():
	$AnimatedSprite.animation = "Idle"
	$AnimatedSprite.play()

func _process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	#position.x = clamp(position.x, 0, mapSize.x)
	#position.y = clamp(position.y, 0, mapSize.y)
	if velocity.x != 0:
		$AnimatedSprite.animation = "Running"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "Idle"