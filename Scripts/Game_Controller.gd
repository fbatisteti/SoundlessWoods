extends Node2D

@export var monster: Node2D

func _process(delta):		
	if GlobalData.run and GlobalData.seen:
		$Music.volume_db = clampf($Music.volume_db - delta * 10, -60, -18)
		$MusicMonster.volume_db = clampf($MusicMonster.volume_db + delta * 30, -60, -18)
	else:
		GlobalData.seen = false
		$Music.volume_db = clampf($Music.volume_db + delta * 30, -60, -18)
		$MusicMonster.volume_db = clampf($MusicMonster.volume_db - delta * 60, -60, -18)

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		if GlobalData.tutorial:
			$Area2D/AudioStreamPlayer.play()
			
			if body.global_position.x > 200:
				# spawn left
				monster.global_position.x = -140
			else:
				# spawn right
				monster.global_position.x = 320
			
			monster.global_position.y = 108
		
		GlobalData.tutorial = false
