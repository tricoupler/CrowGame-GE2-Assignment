extends RichTextLabel

@export var player: CharacterBody3D

func _process(_delta: float) -> void:
	text = str(snapped(player.velocity.length(), 0)) + ' km/hr'
