extends CharacterBody3D


# Input mapping
# add_speed, slow_down, hover, left and right

@export var min_speed: float = 2.5
@export var max_speed: float = 250.0

@export var force:Vector3
@export var accel:Vector3
@export var mass:float = 1

@export var banking:float = 0.1
@export var damping:float = 0.3
@export var s_force:float = 10

func calculate():
	var f:Vector3 = Vector3.ZERO

	var s = Input.get_axis("slow_down", "add_speed")
		
	f = global_basis.z * s * s_force
	
	var l = Input.get_axis("left", "right")
	var xz_dir = global_basis.x
	xz_dir.y = 0
	f -= xz_dir * l * s_force
	xz_dir = xz_dir.normalized()
	
	var v = Input.get_axis("descend", "ascend")
	f += global_basis.y * v * s_force
	
	return f

func _process(delta: float) -> void:
	
	force = calculate()
	accel = force / mass
	velocity = (velocity + accel * delta)
	
	if velocity.length() > 0:
		var tempUp = transform.basis.y.lerp(Vector3.UP + (accel * banking), delta * 5.0)
		look_at(global_transform.origin - velocity, tempUp)
		
		velocity = velocity.limit_length(max_speed)
		velocity = velocity - (velocity * damping * delta)

	move_and_slide()
