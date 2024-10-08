extends Node2D

@export var player: Node2D

func _process(delta):
	var parent_node = get_parent()
	
	if player:
		global_position.x = player.global_position.x

	if parent_node and parent_node.name == "Pier":
		global_position.x = clampf(global_position.x, -600, 100)
	
	if parent_node and parent_node.name == "MainScene":
		global_position.x = clampf(global_position.x, -650, 820)
	
	if parent_node and parent_node.name == "Tower":
		global_position.x = clampf(global_position.x, 45, 270)
