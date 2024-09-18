class_name PlayerSquad extends Node3D

@export var player_assets: Array[PackedScene]
@export var current_player_asset: PackedScene


func spawn_players(amount: int) -> void:
	var alive_player = get_alive_player()
	for i in range(0, amount):
		if get_child_count() > 20:
			return

		var player: Player = current_player_asset.instantiate()
		add_child(player)

		if not alive_player:
			continue

		var dir = Vector3(randf_range(-1, 1), 0, randf_range(-0.5, 0.5)) * 5
		player.global_position = alive_player.global_position + dir


func remove_players(amount: int) -> void:
	for i in range(0, amount):
		var player: Player = get_child(i)
		if not player:
			return
		
		player.take_damage(player.health)


func clear_pool() -> void:
	for player in get_children():
		player.queue_free()


func get_alive_player() -> Player:
	var players = get_children()
	if len(players) == 0:
		return null

	for player: Player in players:
		if player.health <= 0:
			continue

		return player

	return null
