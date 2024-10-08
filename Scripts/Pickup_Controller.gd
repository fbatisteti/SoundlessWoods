extends Node2D

var min = -3
var max = 3
var step = 0.05
var going = true
var gpos

func _ready():
	gpos = global_position.y
	
	var parent_node = get_parent()
		
	if parent_node and parent_node.name == "MainScene":
		if name == "McGuffin" and GlobalData.main_mcguffin:
			queue_free()
		if name == "Battery" and GlobalData.main_battery:
			queue_free()
			
	if parent_node and parent_node.name == "Pier":
		if name == "McGuffin" and GlobalData.pier_mcguffin:
			queue_free()
		if name == "Battery" and GlobalData.pier_battery:
			queue_free()
			
	if parent_node and parent_node.name == "Tower":
		if name == "McGuffin" and GlobalData.tower_mcguffin:
			queue_free()
		if name == "Battery" and GlobalData.tower_battery:
			queue_free()
			
	if parent_node and parent_node.name == "Mansion":	
		if name == "McGuffin" and GlobalData.mansion_mcguffin == true:
			queue_free()
		if name == "Battery" and GlobalData.mansion_battery == true:
			queue_free()
			
	if parent_node and parent_node.name == "Cavern":
		if name == "McGuffin" and GlobalData.cavern_mcguffin:
			queue_free()
		if name == "Battery" and GlobalData.cavern_battery:
			queue_free()

func _process(delta):
	var show = true
	var parent_node = get_parent()
	
	if parent_node and parent_node.name == "MainScene":
		if name == "McGuffin":
			show = !GlobalData.main_mcguffin
		if name == "Battery":
			show = !GlobalData.main_battery
		
	if parent_node and parent_node.name == "Pier":
		if name == "McGuffin":
			show = !GlobalData.pier_mcguffin
		if name == "Battery":
			show = !GlobalData.pier_battery
		
	if parent_node and parent_node.name == "Tower":
		if name == "McGuffin":
			show = !GlobalData.tower_mcguffin 
		if name == "Battery":
			show = !GlobalData.tower_battery 
		
	if parent_node and parent_node.name == "Mansion":
		if name == "McGuffin":
			show = !GlobalData.mansion_mcguffin
		if name == "Battery":
			show = !GlobalData.mansion_battery
		
	if parent_node and parent_node.name == "Cavern":
		if name == "McGuffin":
			show = !GlobalData.cavern_mcguffin
		if name == "Battery":
			show = !GlobalData.cavern_battery
	
	if show:
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
		var parent_node = get_parent()
		
		if parent_node and parent_node.name == "MainScene":
			if name == "McGuffin":
				GlobalData.main_mcguffin = true
			if name == "Battery":
				GlobalData.main_battery = true
			
		if parent_node and parent_node.name == "Pier":
			if name == "McGuffin":
				GlobalData.pier_mcguffin = true
			if name == "Battery":
				GlobalData.pier_battery = true
			
		if parent_node and parent_node.name == "Tower":
			if name == "McGuffin":
				GlobalData.tower_mcguffin = true
			if name == "Battery":
				GlobalData.tower_battery = true
			
		if parent_node and parent_node.name == "Mansion":
			if name == "McGuffin":
				GlobalData.mansion_mcguffin = true
			if name == "Battery":
				GlobalData.mansion_battery = true
			
		if parent_node and parent_node.name == "Cavern":
			if name == "McGuffin":
				GlobalData.cavern_mcguffin = true
			if name == "Battery":
				GlobalData.cavern_battery = true
		
		if name == "McGuffin":
			GlobalData.GetMcGuffin()
		else: # battery
			GlobalData.GetBattery()
	
		$AudioStreamPlayer.play()
		$Timer.start()

func _on_timer_timeout():
	queue_free()
