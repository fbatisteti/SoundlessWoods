extends Node2D

var count = 0

func _ready():
	GlobalData.McGuffins = 0
	GlobalData.battery = 0.5
	GlobalData.run = false
	GlobalData.carfix = 0
	GlobalData.waiting = false
	GlobalData.current_map = "Main"
	GlobalData.tutorial = true
	GlobalData.main_mcguffin = false
	GlobalData.main_battery = false
	GlobalData.pier_mcguffin = false
	GlobalData.pier_battery = false
	GlobalData.tower_mcguffin = false
	GlobalData.tower_battery = false
	GlobalData.mansion_mcguffin = false
	GlobalData.mansion_battery = false
	GlobalData.cavern_mcguffin = false
	GlobalData.cavern_battery = false

func _process(delta):
	if count > 3:
		get_tree().change_scene_to_file("res://Scenes/Intro.tscn")
		
	if Input.is_action_just_pressed("A") or Input.is_action_just_pressed("B") or Input.is_action_just_pressed("Start") or Input.is_action_just_pressed("Select"):
		get_tree().change_scene_to_file("res://Scenes/Intro.tscn")

func _on_slash_finished():
	$Timer.start()

func _on_timer_timeout():
	$AnimatedSprite2D.visible = false
	$Laugh.play()
	$TimerLaugh.start(4.0)
	count += 1

func _on_timer_laugh_timeout():
	$Laugh.play()
	count += 1
