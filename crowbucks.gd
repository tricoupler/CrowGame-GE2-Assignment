extends RichTextLabel

@export var game_manager: Node3D

func _on_game_manager_change_in_player_money(new_value: Variant) -> void:
	text = str(new_value) + ' Crow Bucks'
