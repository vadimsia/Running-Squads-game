extends Camera3D

const DISTANCE = 5
const SPEED = 10

@onready var player_pool = get_node("/root/Main/PlayerPool")


func _process(delta: float) -> void:
	if player_pool.get_child_count() == 0:
		return
		
	var player = player_pool.get_child(0)
	global_position = global_position.lerp(player.global_position, delta)
	global_position.y = 3.5
