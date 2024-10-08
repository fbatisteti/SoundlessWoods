extends Node2D

var min = -3
var max = 3
var step = 0.05
var going = true
var gpos

func _ready():
	gpos = global_position.y

func _process(delta):
	if GlobalData.tutorial == false and $button.animation != "up":
		$button.visible = false
		
	var pos = global_position.y
	
	if going:
		global_position.y = pos + step
		if pos > (gpos + max):
			going = false
	else:
		global_position.y = pos - step
		if pos < (gpos + min):
			going = true

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$button.visible = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$button.visible = false
