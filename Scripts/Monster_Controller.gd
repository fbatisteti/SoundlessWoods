extends CharacterBody2D

@export var speed : float = 40.0
@export var player: Node2D

var chasing = false
var min_Z = -3
var max_Z = 0

var flee = false
var fleeing = false
var flee_dir = false

var last_x

func _process(delta):
	if !fleeing:
		var parent_node = get_parent()
		
		var target_y: float
		
		if parent_node and parent_node.name == "MainScene":
			if (round(global_position.distance_to(player.global_position))) >= 200:
				if (player.get_node("AnimatedSprite2D").flip_h == true):
					# spawn left
					global_position.x = player.global_position.x - 150
				else:
					# spawn right
					global_position.x = player.global_position.x + 150
			
			if !GlobalData.tutorial:
				global_position.y = 108
		
		if parent_node and parent_node.name == "Mansion":
			if player.global_position.y > 8:
				target_y = 108
			else:
				target_y = -20
			
			if round(player.global_position.y) == 7 or round(player.global_position.y) == 8 or round(player.global_position.y) == 9:
				global_position.x = player.global_position.x + 75
				
			global_position.y = target_y
				
		if parent_node and parent_node.name == "Cavern":
			if player.global_position.y < 255:
				target_y = 235
			elif player.global_position.y < 385:
				target_y = 363
			elif player.global_position.y < 515:
				target_y = 490
			elif player.global_position.y < 640:
				target_y = 620
			else:
				target_y = 700
			
			global_position.y = target_y
				
		if parent_node and parent_node.name == "Tower":
			if player.global_position.y < -240:
				target_y = -260
			elif player.global_position.y < -160:
				target_y = -180
			elif player.global_position.y < -80:
				target_y = -100
			elif player.global_position.y < 0:
				target_y = -20
			elif player.global_position.y < 80:
				target_y = 60
			else:
				target_y = 500
			
			global_position.y = target_y
			
			if round(player.global_position.y) == 79 or round(player.global_position.y) == 80 or round(player.global_position.y) == 81 or round(player.global_position.y) == -81 or round(player.global_position.y) == -80 or round(player.global_position.y) == -79 or round(player.global_position.y) == -239 or round(player.global_position.y) == -240 or round(player.global_position.y) == -241:
				global_position.x = player.global_position.x + 75
				
			if round(player.global_position.y) == -1 or round(player.global_position.y) == 0 or round(player.global_position.y) == 1 or round(player.global_position.y) == -159 or round(player.global_position.y) == -160 or round(player.global_position.y) == -161:
				global_position.x = player.global_position.x - 75
	
		var new_speed = speed
		
		if chasing:
			new_speed = speed
			GlobalData.run = true
		else:
			new_speed = speed
			GlobalData.run = false
		
		if player.global_position.x > global_position.x:
			# player to the right
			velocity.x = new_speed
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D2.flip_h = true
		else:
			# player to the left
			velocity.x = -new_speed
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		
		var dis
		if player.global_position.x > global_position.x:
			dis = player.global_position.x - global_position.x
		else:
			dis = global_position.x - player.global_position.x
			
		if dis <= 5:
			velocity.x = 0
		
		if (round(global_position.distance_to(player.global_position)) <= 27 and !flee):
			flee = true
			last_x = global_position.x
			$DespawnTimer.start()
			
		move_and_slide()
	else:
		var new_speed = speed
		
		if flee_dir:
			velocity.x = -new_speed
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D2.flip_h = false
		else:
			velocity.x = +new_speed
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D2.flip_h = true
	
		move_and_slide()
		
		if (global_position.distance_to(player.global_position)) > 150.0 or DistanceRan():
			flee = false
			fleeing = false
			
			var rand = randi_range(0,1)
			if rand == 0:
				flee_dir = true
			else:
				flee_dir = false

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
	
func _on_despawn_timer_timeout():
	fleeing = true

func DistanceRan():
	if last_x > global_position.x:
		if (last_x - global_position.x) > 75:
			return true
	else:
		if (global_position.x - last_x) > 75:
			return true
	return false
