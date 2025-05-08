extends RichTextLabel

@export var player: CharacterBody3D

func _process(_delta: float) -> void:
	var speed = snapped(player.velocity.length(), 0)
	if(speed > 30):
		self["theme_override_colors/default_color"] = Color(255,0,0)
	else:
		self["theme_override_colors/default_color"] = Color(255, 255, 255)
	text = str(speed) + ' km/hr'
	
