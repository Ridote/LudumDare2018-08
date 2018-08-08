extends Area2D

func _ready():
	print($Line.get_point_position(1))
	$Line.set_point_position(1, Vector2(20,50))

#func _process(delta):
#	pass
