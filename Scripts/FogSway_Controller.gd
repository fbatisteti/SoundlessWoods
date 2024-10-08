extends Node2D

const follow_speed: float = 0.05
const sway_amplitude: float = 0.05

func _physics_process(delta: float) -> void:
	var direction = $"..".position - position
	position += direction.normalized() * follow_speed * delta

	var sway_offset = Vector2(sway_amplitude * sin(Time.get_unix_time_from_system()), 0)
	position += sway_offset
