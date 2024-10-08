extends Node2D

var min = -3
var max = 3
var step = 0.05
var going = true
var gpos

var fixing = false

func _ready():
	gpos = global_position.y

func _process(delta):
	var pos = global_position.y
	
	if going:
		global_position.y = pos + step
		if pos > (gpos + max):
			going = false
	else:
		global_position.y = pos - step
		if pos < (gpos + min):
			going = true
	
	if fixing:
		if Input.is_action_just_pressed("Dpad_DOWN") and !GlobalData.waiting:
			GlobalData.waiting = true
			$Timer.start()
			$"MusicGas".play()
			
	if fixing:
		if Input.is_action_just_pressed("Dpad_DOWN"):
			if GlobalData.carfix >= 5:
				get_tree().change_scene_to_file("res://Scenes/Victory.tscn")
	
	if GlobalData.carfix < 5:
		$AnimatedSprite2D.play(str(GlobalData.carfix))
	else:
		$AnimatedSprite2D.visible = false

func _on_area_2d_body_entered(body):
	if body.name == "Player" and GlobalData.McGuffins >= 5:
		$button.visible = true
		$AnimatedSprite2D.visible = true
		fixing = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$button.visible = false
		$AnimatedSprite2D.visible = false
		fixing = false

func _on_timer_timeout():
	if fixing:
		GlobalData.carfix += 1
		$"MusicGas".playing = false
		GlobalData.waiting = false
