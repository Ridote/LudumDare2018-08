extends CanvasLayer

func _ready():
	pass

#Use percentages
func setHP(number):
	$VerticalSeparator/TopSeparator/HBoxContainer/HPBar.size_flags_stretch_ratio = number/100.0
	$VerticalSeparator/TopSeparator/HBoxContainer/HPBarEmpty.size_flags_stretch_ratio = 1.0 - number/100.0
func setMP(number):
	$VerticalSeparator/TopSeparator/HBoxContainer/MPBar.size_flags_stretch_ratio = number/100.0
	$VerticalSeparator/TopSeparator/HBoxContainer/MPBarEmpty.size_flags_stretch_ratio = 1.0 - number/100.0