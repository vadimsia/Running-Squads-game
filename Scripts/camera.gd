extends Camera3D

const DISTANCE = 5
const SPEED = 10

@onready var player_pool: PlayerSquad = get_node("/root/Main/PlayerPool")


func _process(delta: float) -> void:
	var player = player_pool.get_alive_player()
	if not player:
		return

	global_position = global_position.lerp(player.global_position, delta)
	global_position.y = 3.5
