extends Camera2D

@export var player: Node2D

func _process(delta):
	if player:
		global_position.x = player.global_position.x
	
	var parent_node = get_parent()
	
	var target_y: float
	var lerp_speed: float = 0.1
	
	if parent_node and parent_node.name == "Pier":
		target_y = 73
	
	if parent_node and parent_node.name == "Mansion":
		if player.global_position.y > 0:
			target_y = 63
		else:
			target_y = -56
	
	if parent_node and parent_node.name == "Tower":
		if player.global_position.y > 80:
			target_y = 80
		elif player.global_position.y > 0:
			target_y = 25
		elif player.global_position.y > -80:
			target_y = -60
		elif player.global_position.y > -160:
			target_y = -140
		elif player.global_position.y > -240:
			target_y = -220
		elif player.global_position.y > -320:
			target_y = -300
		else:
			target_y = -380
		
	if parent_node and parent_node.name == "Cavern":
		if player.global_position.y < 135:
			target_y = 65
		elif player.global_position.y < 255:
			target_y = 200
		elif player.global_position.y < 385:
			target_y = 320
		elif player.global_position.y < 515:
			target_y = 450
		elif player.global_position.y < 640:
			target_y = 575
		elif player.global_position.y < 420:
			target_y = 685
		else:
			target_y = 730
	
	global_position.y = lerp(global_position.y, target_y, lerp_speed)
