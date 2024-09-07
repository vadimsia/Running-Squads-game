class_name Road extends Node3D

const SPEED = 10
const ROAD_SIZE = 50.0

@export var road_assets: Array[PackedScene]

@onready var obstructions_node: Node3D = $Obstructions


func _ready() -> void:
	var obstructions = 1
	var obstruction_interval = ROAD_SIZE / obstructions

	for i in range(0, obstructions):
		var asset: Node3D = road_assets[randi() % road_assets.size()].instantiate()
		obstructions_node.add_child(asset)
		asset.global_position = Vector3(global_position.x + randf_range(-5, 5), 1.2, global_position.z - obstruction_interval)
		



func _process(delta: float) -> void:
	position.z += SPEED * delta

	
