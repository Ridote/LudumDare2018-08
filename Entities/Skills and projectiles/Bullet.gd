extends KinematicBody2D

var velocity = Vector2(-900,0)

func fire():
	material = $Fire.process_material.duplicate();
	material.set_shader_param("speed", abs(velocity.x));
	$Fire.process_material = material;
	$Fire.emitting = true;
	
func _physics_process(delta):
	var kinemObject = move_and_collide(velocity*delta)
	#We need to check whether there are collisions or not and then if there are take the first one cause we don't care about the rest, we will just be destroyed for now
	
	if(kinemObject != null):
		if kinemObject.get_collider().has_method("getDamage"):
			kinemObject.get_collider().getDamage(getAtackDamage())
		queue_free()

func _on_Lifetime_timeout():
	queue_free()
func getAtackDamage():
	return 25
