class_name Main extends Node

const ROAD_SIZE = 50

@onready var road_scene = preload("res://Scripts/Level/road.tscn")
@onready var roads_node = $Roads


func spawn_roads(amount: int) -> void:
	for i in range(0, amount):
		roads_node.add_child(road_scene.instantiate())
		
		var children = roads_node.get_children()
		if len(children) == 1:
			continue
		
		children[-1].position.z = children[-2].position.z - ROAD_SIZE
		


func _ready() -> void:
	spawn_roads(5)


func _process(delta: float) -> void:
	var first_child = roads_node.get_child(0)
	if first_child.position.z > ROAD_SIZE * 2:
		first_child.queue_free()
		spawn_roads(1)
