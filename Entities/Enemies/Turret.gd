extends StaticBody2D
var awakeningDistance = 400
var sleepingDistance = 600

var player = null
var awaken = false

func _ready():
	player = get_node("/root/Main/Player")
	sleep()
func wakeUp():
	$Sprite/AnimationPlayer.play("WakeUp")
	yield( get_node("AnimationPlayer"), "finished" )
func sleep():
	$Sprite/AnimationPlayer.play("Slept")
	yield( get_node("AnimationPlayer"), "finished" )
	
func _process(delta):
	var distance2Hero = global_position.distance_to(player.global_position);
	if(distance2Hero < awakeningDistance && ! awaken):
		wakeUp()
		awaken = true
	elif(distance2Hero > sleepingDistance):
		sleep()
		awaken = false
