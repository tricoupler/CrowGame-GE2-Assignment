extends RichTextLabel

@export var game_manager: Node3D

func _on_game_manager_change_in_player_money(new_value: Variant) -> void:
	if(new_value < 0):
		self["theme_override_colors/default_color"] = Color(255,0,0)
	else:
		self["theme_override_colors/default_color"] = Color(255, 255, 255)
	text = str(new_value) + ' Crow Bucks'
	
