extends KinematicBody2D

var velocity = Vector2(-900,0)

func fire():
	material = $Fire.process_material.duplicate();
	material.set_shader_param("speed", abs(velocity.x));
	$Fire.process_material = material;
	$Fire.emitting = true;
	
func _physics_process(delta):
	move_and_slide(velocity, Vector2(0, -1))
	#We need to check whether there are collisions or not and then if there are take the first one cause we don't care about the rest, we will just be destroyed for now
	if(get_slide_count() > 0 && get_slide_collision(0)):
		queue_free()

func _on_Lifetime_timeout():
	queue_free()