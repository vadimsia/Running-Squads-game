class_name Player extends Entity

const SPEED = 10


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, -1)).normalized()
	if direction:
		linear_velocity.x = direction.x * SPEED
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
	