class_name PlayerSquad extends Node3D

@export var player_assets: Array[PackedScene]
@export var current_player_asset: PackedScene


func spawn_players(amount: int) -> void:
	for i in range(0, amount):
		if get_child_count() > 20:
			return

		var player: Player = current_player_asset.instantiate()
		add_child(player)

		var dir = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)) * 10
		player.global_position += dir


func remove_players(amount: int) -> void:
	for i in range(0, amount):
		var player: Player = get_child(i)
		if not player:
			return
		
		player.take_damage(player.health)
