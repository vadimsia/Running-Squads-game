class_name EnemySquad extends Node3D

@export var min_squad = 5
@export var max_squad = 25
@export var enemy_assets: Array[PackedScene]


func _ready() -> void:
	for i in range(0, randi_range(min_squad, max_squad)):
		var enemy: Enemy = enemy_assets[randi() % enemy_assets.size()].instantiate()
		add_child(enemy)

		var dir = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)) * 10
		enemy.global_position += dir
