class_name Main extends Node


@onready var road_scene = preload("res://Scripts/Level/Road/road.tscn")
@onready var roads_node = $Roads
@onready var player_pool: PlayerSquad = $PlayerPool
@onready var obstructions_pool: Node3D = $ObstructionsPool
@onready var camera: Camera3D = $Camera3D
@onready var restart_button: Button = $RestartButton
@onready var score_label: Label = $ScoreLabel


func spawn_roads(amount: int) -> void:
	for i in range(0, amount):
		var road: Road = road_scene.instantiate()
		roads_node.add_child(road)
		roads_node.global_position = Vector3.ZERO
		
		var roads = roads_node.get_children()
		if len(roads) <= 1:
			continue
		
		road.position.z = roads[-2].position.z - Road.ROAD_SIZE
		road.spawn_obstructions()


func _ready() -> void:
	spawn_roads(3)
	restart_button.pressed.connect(_on_restart_button_pressed)


func _process(_delta: float) -> void:
	if roads_node.get_child_count() == 0:
		return

	var first_child: Road = roads_node.get_child(0)
	var alive_player = player_pool.get_alive_player()

	if alive_player:
		score_label.text = "Score: " + str(int(abs(alive_player.position.z)))

	restart_button.visible = alive_player == null

	if first_child.position.z - Road.ROAD_SIZE / 2 > camera.position.z:
		first_child.queue_free()
		spawn_roads(1)


func _on_restart_button_pressed() -> void:
	player_pool.clear_pool()
	for road in roads_node.get_children():
		roads_node.remove_child(road)
	
	for obstruction in obstructions_pool.get_children():
		obstructions_pool.remove_child(obstruction)

	camera.position.z = 2
	spawn_roads(3)
	player_pool.spawn_players(1)
