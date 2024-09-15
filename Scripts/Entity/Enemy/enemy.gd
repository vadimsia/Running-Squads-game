class_name Enemy extends Entity

@export var damage = 5
@export var speed = 20

@onready var player_squad: PlayerSquad = get_node("/root/Main/PlayerPool")
@onready var die_audio_stream: AudioStreamPlayer = $DieAudioStream
@onready var anim_tree: AnimationTree = get_node("Model/AnimationTree")
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	health_changed.connect(_on_enemy_health_changed)
	body_entered.connect(_on_player_body_entered)
	super._ready()


func _on_player_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	body.take_damage(damage)


func _on_enemy_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		anim_tree.set("parameters/conditions/punch", false)
		anim_tree.set("parameters/conditions/death", true)
		set_collision_mask_value(2, false)
		set_collision_mask_value(3, false)
		set_collision_mask_value(4, false)
		set_collision_layer_value(3, false)

		die_audio_stream.play()


func _physics_process(delta: float) -> void:
	anim_tree.set("parameters/conditions/punch", false)

	if health <= 0:
		return

	var first_player = player_squad.get_alive_player()
	if not first_player:
		return
	
	var direction = (first_player.global_position - global_position)
	if direction.length() > 5:
		return

	anim_tree.set("parameters/conditions/punch", true)
	linear_velocity += direction.normalized() * speed * delta
	look_at(global_position - direction, Vector3.UP)
