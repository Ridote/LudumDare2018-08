extends KinematicBody2D

var velocity = Vector2(-500,0)

func _physics_process(delta):
	move_and_slide(velocity, Vector2(0, -1))


func _on_Lifetime_timeout():
	queue_free()