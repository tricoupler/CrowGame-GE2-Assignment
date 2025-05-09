extends CharacterBody3D

@export var target:Vector3
@export var force:Vector3
@export var accel:Vector3
@export var mass:float = 1
@export var max_speed = 25
@export var seek_enabled = false
@export var slowing_distance = 20
@export var banking:float = 1
@export var damping:float = 0.3
@export var s_force:float = 10
@export var path:Path3D
@export var path_follow_enabled:bool = true
@export var boid_seek_timer: Timer
var path_index = 0
var looped = true

func follow_path():	
	var p = path.global_transform * path.get_curve().get_point_position(path_index)
	var d = (p - global_position).length()
	if d < 2:
		path_index = (path_index + 1) % path.get_curve().point_count
	
	return seek(p)
	

func seek(target) -> Vector3:
	print('Seeking: ' + str(target))
	var to_target:Vector3 = target - global_position
	var desired = to_target.normalized() * max_speed
	return desired - velocity


func calculate():
	var f:Vector3 = Vector3.ZERO
	
	if seek_enabled:
		f += seek(target)
	
	if path_follow_enabled:
		f += follow_path()
	
	return f

func _process(delta: float) -> void:
	
	if(Input.is_action_just_pressed('birdspeed1')):
		max_speed = 25
	if(Input.is_action_just_pressed('birdspeed2')):
		max_speed = 100
	if(Input.is_action_just_pressed('birdspeed3')):
		max_speed = 1000
	
	force = calculate()
	accel = force / mass
	velocity = (velocity + accel * delta)
	
	if velocity.length() > 0:
		var tempUp = transform.basis.y.lerp(Vector3.UP + (accel * banking), delta * 5.0)
		look_at(global_transform.origin - velocity, tempUp)
		
		velocity = velocity.limit_length(max_speed)
		velocity = velocity - (velocity * damping * delta)
	
	move_and_slide()
	
	pass


func _on_bread_timer_timeout() -> void:
	path_follow_enabled = false
	seek_enabled = true
	
	boid_seek_timer.start()
	


func _on_boid_seek_timer_timeout() -> void:
	seek_enabled = false
	path_follow_enabled = true


func _on_game_manager_new_bread_position(bread_position: Variant) -> void:
	target = bread_position
