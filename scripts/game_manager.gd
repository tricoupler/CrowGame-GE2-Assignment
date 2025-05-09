extends Node3D

@export var player: CharacterBody3D
signal change_in_player_money(new_value)
signal new_bread_position(bread_position)
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

@export var location1: Marker3D
@export var location2: Marker3D
@export var location3: Marker3D
@export var locationIndex: int = 0
@export var bread_scene: PackedScene
var current_bread: Node3D

func spawn_bread():
	if current_bread and is_instance_valid(current_bread):
		current_bread.queue_free()
	
	current_bread = bread_scene.instantiate()

	if(locationIndex == 0):
		current_bread.global_position = location1.global_position
		new_bread_position.emit(location1.global_position)
	if(locationIndex == 1):
		current_bread.global_position = location2.global_position
		new_bread_position.emit(location2.global_position)
	if(locationIndex == 2):
		current_bread.global_position = location3.global_position
		new_bread_position.emit(location3.global_position)

	current_bread.bread_collected.connect(_on_bread_collected)
	
	add_child(current_bread)
	locationIndex = (locationIndex + 1) % 3 

func _on_bread_collected():
	player_money = player_money + 50
	change_in_player_money.emit(player_money)
	
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
