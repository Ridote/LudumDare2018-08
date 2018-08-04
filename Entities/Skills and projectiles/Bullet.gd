extends KinematicBody2D

var velocity = Vector2(-900,0)

func fire_right():
	$Fire.process_material.set_shader_param("right", true);
	$Fire.process_material.set_shader_param("speed", abs(velocity.x));
	$Fire.emitting = true;

func fire_left():
	$Fire.process_material.set_shader_param("right", false);
	$Fire.process_material.set_shader_param("speed", abs(velocity.x));
	$Fire.emitting = true;

func _physics_process(delta):
	move_and_slide(velocity, Vector2(0, -1))
	if(get_slide_collision(0)):
		queue_free()

func _on_Lifetime_timeout():
	queue_free()