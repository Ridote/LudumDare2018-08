extends StaticBody2D

func _ready():
	wakeUp()

func wakeUp():
	$Sprite/AnimationPlayer.play("WakeUp")