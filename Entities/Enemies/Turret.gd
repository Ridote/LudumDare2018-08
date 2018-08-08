extends StaticBody2D
var bulletScene = preload("res://Entities/Skills and projectiles/Bullet.tscn")
var bullet = null

var awakeningDistance = 400
var sleepingDistance = 600

var player = null
var awaken = false
var reloading = false
var cannonReady = true


func _ready():
	player = get_node("/root/Main/Player")
	$Cannon.flip_h = true
	sleep()
	
func _process(delta):
	var distance2Hero = global_position.distance_to(player.global_position);
	if(distance2Hero < awakeningDistance && ! awaken):
		wakeUp()
		awaken = true
	elif(distance2Hero > sleepingDistance):
		sleep()
		awaken = false
	if(awaken):
		$Cannon.look_at(player.global_position)
		shoot()

func wakeUp():
	$Base/BaseAnimation.play("WakeUp")
	yield($Base/BaseAnimation, "animation_finished" )
	$CannonBase/CannonBaseAnimation.play("WakeUp")
	yield($CannonBase/CannonBaseAnimation, "animation_finished" )
	$Cannon/CannonAnimation.play("WakeUp")
	yield($Cannon/CannonAnimation, "animation_finished")
	awaken = true
func sleep():
	$Base/BaseAnimation.play("Slept")
	$CannonBase/CannonBaseAnimation.play("Slept")
	$Cannon/CannonAnimation.play("Slept")
	awaken = false
	
func shoot():
	if reloading:
		reloading = false
		$Reload.start()
	elif cannonReady:
		bullet = bulletScene.instance()
		bullet.set_collision_layer_bit(16,1)
		#Character and floors (1+4)
		bullet.set_collision_mask(5)
		bullet.position = global_position
		bullet.fire_right()
		bullet.velocity.x = -150
		bullet.velocity.y = 50
		
		get_parent().add_child(bullet)
		bullet = null
		cannonReady = false
		reloading = true
			
func _on_Reload_timeout():
	reloading = false
	cannonReady = true
