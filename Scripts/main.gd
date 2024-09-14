class_name Main extends Node


@onready var road_scene = preload("res://Scripts/Level/Road/road.tscn")
@onready var roads_node = $Roads
@onready var camera: Camera3D = $Camera3D


func spawn_roads(amount: int) -> void:
	for i in range(0, amount):
		var road: Road = road_scene.instantiate()
		roads_node.add_child(road)
		
		var roads = roads_node.get_children()
		if len(roads) == 1:
			continue
		
		road.position.z = roads[-2].position.z - Road.ROAD_SIZE
		road.spawn_obstructions()


func _ready() -> void:
	spawn_roads(2)


func _process(_delta: float) -> void:
	var first_child: Road = roads_node.get_child(0)
	print(first_child.position.z)
	if first_child.position.z - Road.ROAD_SIZE / 2 > camera.position.z:
		first_child.queue_free()
		spawn_roads(1)
