extends CharacterBody2D

@export var speed : float = 50.0
@export var jump_force : float = 200.0
@export var gravity : float = 500.0

func _ready():
	var parent_node = get_parent()
	
	if parent_node and parent_node.name == "MainScene":
		$AnimatedSprite2D.flip_h = true
		$Flashlight.rotation_degrees = 180
		
		if GlobalData.current_map == "Pier":
			global_position.x = -680
			
		if GlobalData.current_map == "Tower":
			global_position.x = -300
		
		if GlobalData.current_map == "Mansion":
			global_position.x = 472
			$AnimatedSprite2D.flip_h = true
			$Flashlight.rotation_degrees = 180
		
		if GlobalData.current_map == "Cavern":
			global_position.x = 840
			$AnimatedSprite2D.flip_h = true
			$Flashlight.rotation_degrees = 180
	
	if parent_node and parent_node.name == "Pier":
		$AnimatedSprite2D.flip_h = true
		$Flashlight.rotation_degrees = 180

func _process(delta):
	velocity.y += gravity * delta
	
	if Input.is_action_pressed("Dpad_DOWN"):
			collision_mask = disable_bit(collision_mask, 1)
			set_collision_mask(collision_mask)
	
	if Input.is_action_just_released("Dpad_DOWN"):
			collision_mask = enable_bit(collision_mask, 1)
			set_collision_mask(collision_mask)
	
	if !GlobalData.waiting:
		if Input.is_action_pressed("Dpad_LEFT"):
			velocity.x = -speed
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.play("walk")
			$Flashlight.rotation_degrees = 180
			$Music.rotation_degrees = 180
		elif Input.is_action_pressed("Dpad_RIGHT"):
			velocity.x = speed
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.play("walk")
			$Flashlight.rotation_degrees = 0
			$Music.rotation_degrees = 0
		else:
			velocity.x = 0
			$AnimatedSprite2D.animation = "idle"
	
	if !GlobalData.waiting:
		if is_on_floor() and Input.is_action_just_pressed("A") and !Input.is_action_pressed("Dpad_DOWN"):
			velocity.y = -jump_force
	
	if !GlobalData.waiting:
		move_and_slide()
	
	if Input.is_action_just_pressed("B"):
		$Flashlight.enabled = !$Flashlight.enabled
	
	if $Flashlight.enabled:
		GlobalData.battery -= delta / 40
		
		if GlobalData.battery <= 0:
			$Flashlight.enabled = false
			GlobalData.battery = 0
	
func _on_alert_area_body_entered(body):
	if body.name == "Monster":
		body.chasing = true

func _on_alert_area_body_exited(body):
	if body.name == "Monster":
		body.chasing = false

func enable_bit(mask: int, index: int) -> int:
	return mask | (1 << index)

func disable_bit(mask: int, index: int) -> int:
	return mask & ~(1 << index)

func _on_timer_timeout():
	if $Flashlight.enabled and (GlobalData.battery * 100) < 25:
		var flicker = randf()
		Flick(flicker)
	
func Flick(timer):
	$Flashlight.enabled = false	
	$FlickerTimer.start(timer / 10)
	
func _on_flicker_timer_timeout():
	$Flashlight.enabled = true

func _on_music_body_entered(body):
	if body.name == "Monster":
		GlobalData.seen = true
