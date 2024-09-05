class_name PlayerSquad extends Node3D

var SPEED = 10

@onready var player_pool: Node3D = $Bodies

@export var player_assets: Array[PackedScene]
@export var current_player_asset: PackedScene


func spawn_players(amount: int) -> void:
	for i in range(0, amount):
		if player_pool.get_child_count() > 20:
			return

		var player: Player = current_player_asset.instantiate()
		player_pool.add_child(player)

		var dir = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)) * 10
		player.global_position += dir



func remove_players(amount: int) -> void:
	for i in range(0, amount):
		var player: Player = player_pool.get_child(i)
		if not player:
			return
		
		player.queue_free()


func _process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, -1)).normalized()
	position.x += direction.x * SPEED * delta