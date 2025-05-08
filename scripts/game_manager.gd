extends Node3D

# Track our objects
@export var player: CharacterBody3D
signal change_in_player_money(new_value)
@export var player_money: int = 50

@export var speeding_ticket_timer: Timer
@export var GUI_speeding_ticket: Timer
@export var speeding_ticket_image: TextureRect
@export var speeding_ticket_camera_shutter: AudioStreamPlayer

@export var bread_timer: Timer
@export var bread_notification_timer: Timer
@export var bread_notification_audio: AudioStreamPlayer
@export var bread_text: RichTextLabel

@export var calm_background_audio: AudioStreamPlayer
@export var dramatic_background_audio: AudioStreamPlayer

func spawn_bread():
	pass

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


func _on_bread_timer_timeout() -> void:
	print('NEW PIECE OF BREAD DROPPED??!?!?!')
	bread_text.visible = true
	bread_notification_audio.play()
	bread_notification_timer.start()
	calm_background_audio.stop()
	dramatic_background_audio.play()
	spawn_bread()

func _on_bread_notification_timer_timeout() -> void:
	bread_text.visible = false
	calm_background_audio.play()
	dramatic_background_audio.stop()
