extends StaticBody2D
var bulletScene = preload("res://Entities/Skills and projectiles/Bullet.tscn")
var bullet = null

var awakeningDistance = 400
var sleepingDistance = 600

var player = null
var awaken = false
var wakingUp = false
var reloading = false
var cannonReady = true


func _ready():
	player = get_node("/root/Main/Player")
	awaken = false
	$Cannon.flip_h = true
	sleep()
	
func _process(delta):
	var distance2Hero = global_position.distance_to(player.global_position);
	if(distance2Hero < awakeningDistance && !awaken):
		wakeUp()
	elif(distance2Hero > sleepingDistance):
		sleep()
	elif(awaken):
		shoot()
	$Cannon.look_at(player.global_position)

func wakeUp():
	if(!wakingUp):
		wakingUp = true
		awaken = false
		$Base/BaseAnimation.play("WakeUp")
		yield($Base/BaseAnimation, "animation_finished" )
		$CannonBase/CannonBaseAnimation.play("WakeUp")
		yield($CannonBase/CannonBaseAnimation, "animation_finished" )
		$Cannon/CannonAnimation.play("WakeUp")
		yield($Cannon/CannonAnimation, "animation_finished")
		awaken = true
		wakingUp = false
	
func sleep():
	awaken = false
	$Base/BaseAnimation.play("Slept")
	$CannonBase/CannonBaseAnimation.play("Slept")
	$Cannon/CannonAnimation.play("Slept")
	
func shoot():
	if reloading:
		reloading = false
		$Reload.start()
	elif cannonReady:
		bullet = bulletScene.instance()
		bullet.set_collision_layer_bit(16,1)
		#Character and floors (1+4)
		bullet.set_collision_mask(5)
		#We calculate the position regarding the cannon
		bullet.position = Vector2($Cannon.global_position.x+32*cos($Cannon.rotation), $Cannon.global_position.y+32*sin($Cannon.rotation))
		#We calculate the normalised speed regarding the cannon and the player position
		bullet.velocity = Vector2(player.global_position.x - $Cannon.global_position.x, player.global_position.y - $Cannon.global_position.y).normalized()*900
		#We need to set the rotation so the shader particles run correctly
		bullet.rotation = $Cannon.rotation + PI
		
		
		get_parent().add_child(bullet)
		bullet = null
		cannonReady = false
		reloading = true
			
func _on_Reload_timeout():
	reloading = false
	cannonReady = true
