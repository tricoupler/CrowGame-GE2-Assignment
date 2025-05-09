extends Node3D

signal bread_collected

func _ready():
	$Area3D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		bread_collected.emit()
		print('PICKED UP PIECE OF BREAD')
	
	# Delete it anyhow
	queue_free()
