class_name Player extends Entity

const PATH_LEN = 3

var gun_attachment: Node3D

@onready var player_pool: PlayerSquad = get_parent()
@onready var anim_tree: AnimationTree = get_node("Model/AnimationTree")
@onready var die_audio_stream: AudioStreamPlayer3D = $DieAudioStream
@onready var model: Node3D = get_node("Model")
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@export var initial_gun: PackedScene
@export var speed = 10


func change_gun(gun_scene: PackedScene):
	if gun_attachment.get_child_count() > 0:
		gun_attachment.remove_child(gun_attachment.get_child(0))
	
	var gun: Gun = gun_scene.instantiate()
	gun_attachment.add_child(gun)
	gun.rotation = gun.initial_rotation * (PI / 180)


func get_actual_gun() -> Gun:
	return gun_attachment.get_child(0)


func _ready() -> void:
	super._ready()
	health_changed.connect(_on_health_changed)
	gun_attachment = model.find_child("GunAttachment")
	change_gun(initial_gun)


func _on_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		anim_tree.set("parameters/conditions/death", true)
		set_collision_mask_value(2, false)
		set_collision_mask_value(3, false)
		set_collision_mask_value(6, false)
		set_collision_layer_value(2, false)

		get_actual_gun().stop_shooting()
		speed = 0

		die_audio_stream.play()
		

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	var first_player = player_pool.get_alive_player()
	if not first_player:
		return
	
	if not direction:
		direction = (first_player.global_position - global_position)
		if direction.length() < PATH_LEN:
			direction = Vector3.ZERO
				
	linear_velocity += direction.normalized() * speed * 2 * delta * Vector3(1, 0, 1)
	linear_velocity.z = -speed
