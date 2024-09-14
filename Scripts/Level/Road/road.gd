class_name Road extends StaticBody3D

const SPEED = 10
const ROAD_SIZE = 50.0

@onready var obstructions_node: Node3D = get_node("/root/Main/ObstructionsPool")

@export var road_assets: Array[PackedScene]
@export var obstructions: int = 2


func spawn_obstructions() -> void:
	var obstruction_interval = ROAD_SIZE / obstructions

	for i in range(1, obstructions + 1):
		var asset: Node3D = road_assets[randi() % road_assets.size()].instantiate()
		obstructions_node.add_child(asset)
		asset.global_position = Vector3(global_position.x + randf_range(-7, 7), 3, global_position.z + ROAD_SIZE / 2 - obstruction_interval * i)
