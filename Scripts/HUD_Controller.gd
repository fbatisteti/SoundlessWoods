extends CanvasLayer

var mcguffins
var battery

func _ready():
	mcguffins = GlobalData.McGuffins
	battery = GlobalData.battery

func _process(delta):
	mcguffins = GlobalData.McGuffins
	battery = GlobalData.battery
	
	$Label.text = "x" + str(mcguffins)
	
	if battery > 0.75:
		$Batteries1.animation = "full"
		$Batteries2.animation = "full"
		$Batteries3.animation = "full"
		$Batteries4.animation = "full"
	elif battery > 0.50:
		$Batteries1.animation = "full"
		$Batteries2.animation = "full"
		$Batteries3.animation = "full"
		$Batteries4.animation = "empty"
	elif battery > 0.25:
		$Batteries1.animation = "full"
		$Batteries2.animation = "full"
		$Batteries3.animation = "empty"
		$Batteries4.animation = "empty"
	elif battery > 0.0:
		$Batteries1.animation = "full"
		$Batteries2.animation = "empty"
		$Batteries3.animation = "empty"
		$Batteries4.animation = "empty"
	else:
		$Batteries1.animation = "empty"
		$Batteries2.animation = "empty"
		$Batteries3.animation = "empty"
		$Batteries4.animation = "empty"
