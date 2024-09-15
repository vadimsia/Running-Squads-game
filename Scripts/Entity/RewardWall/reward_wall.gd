class_name RewardWall extends Entity

var reward_gun: PackedScene

@export var rewards: Array[PackedScene]

@onready var health_label: Label3D = $HealthLabel
@onready var reward_node: Node3D = $Reward
@onready var player_squad: PlayerSquad = get_node("/root/Main/PlayerPool")


func set_reward() -> void:
	reward_gun = rewards[randi() % rewards.size()]
	var gun: Gun = reward_gun.instantiate()
	reward_node.add_child(gun)
	gun.stop_shooting()
	gun.rotate_y(90)


func _ready() -> void:
	health = randi_range(20, 100) * player_squad.get_child_count()
	health_changed.connect(_on_health_changed)
	body_entered.connect(_on_wall_body_entered)
	super._ready()

	set_reward()
	health_label.text = "?"


func _on_wall_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	take_damage(body.health)
	body.take_damage(body.health)


func _on_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		for player: Player in player_squad.get_children():
			player.change_gun(reward_gun)
		queue_free()

	health_label.text = str(new_value)
