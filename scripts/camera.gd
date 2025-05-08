extends Marker3D


@export var player: CharacterBody3D

func _process(delta: float) -> void:
	global_position = lerp(global_position, player.global_position, delta * 5)
	look_at(player.global_position)
