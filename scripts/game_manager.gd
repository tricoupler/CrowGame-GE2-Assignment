extends Node3D

# Track our objects
@export var player: CharacterBody3D
signal change_in_player_money(new_value)
@export var player_money: int = 50

@export var speeding_ticket_timer: Timer
@export var GUI_speeding_ticket: Timer
@export var speeding_ticket_image: TextureRect
@export var speeding_ticket_camera_shutter: AudioStreamPlayer

func issue_speeding_ticket():
	print('SPEEDING TICKET ISSUED!')
	player_money = player_money - 100
	change_in_player_money.emit(player_money)
	speeding_ticket_timer.start()
	GUI_speeding_ticket.start()
	speeding_ticket_image.visible = true
	speeding_ticket_camera_shutter.play()


func _on_speeding_ticket_image_timer_timeout() -> void:
	speeding_ticket_image.visible = false


func _on_speeding_ticket_timer_timeout() -> void:
	if(player.velocity.length() > 30):
		issue_speeding_ticket()
