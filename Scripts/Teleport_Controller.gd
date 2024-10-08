extends Node2D

@export var target: String

var port = false

func _process(delta):
	var parent_node = get_parent()
	
	if Input.is_action_just_pressed("Dpad_UP") and port:
		GlobalData.current_map = parent_node.name
		get_tree().change_scene_to_file("res://Scenes/" + target + ".tscn")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		port = true
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		port = false
