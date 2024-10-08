extends Node2D

var canStart = false

func _ready():
	$Timer.start()

func _process(delta):
	if canStart:
		if Input.is_action_just_pressed("Start"):
			canStart = false
			$Timer4.start()
			$CanvasLayer/Story.visible = true
			$CanvasLayer/Background2.visible = true

func _on_timer_timeout():
	$CanvasLayer.visible = true
	$Timer2.start()

func _on_timer2_timeout():
	$CanvasLayer/Credits.visible = false
	$CanvasLayer/Logo.visible = true
	$Timer3.start()

func _on_timer_3_timeout():
	canStart = true
	$CanvasLayer/PressStart.visible = !$CanvasLayer/PressStart.visible

func _on_timer_4_timeout():
	GlobalData.waiting = false
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
