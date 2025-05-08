extends Node3D
#
## Track our objects
#@export var player: CharacterBody3D
#var player_velocity = player.velocity
#
#@export var player_money: int = 50
#
#@export var speeding_ticket_timer: Timer
#@export var GUI_speeding_ticket: Timer
#@export var speeding_ticket_image: Image
#
#func issue_speeding_ticket():
	#player_money = player_money - 100
	#speeding_ticket_timer.start()
	#
	#
#func _process(delta: float) -> void:
	#if(player_velocity > 200 and speeding_ticket_timer.is_stopped()):
		#issue_speeding_ticket()
