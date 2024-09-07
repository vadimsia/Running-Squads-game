class_name Player extends Entity

const PATH_LEN = 1
const SPEED = 10

var gun_attachment: Node3D

@onready var player_pool: Node3D = get_parent()
@onready var anim_tree: AnimationTree = get_node("Model/AnimationTree")
@onready var model: Node3D = get_node("Model")
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@export var initial_gun: PackedScene


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
	body_entered.connect(_on_player_body_entered)
	gun_attachment = model.find_child("GunAttachment")
	change_gun(initial_gun)


func _on_player_body_entered(body: Node) -> void:
	if body is not Enemy:
		return

	take_damage(body.damage)
	# body.queue_free()


func _on_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		anim_tree.set("parameters/conditions/death", true)
		collision_shape.set_deferred("disabled", true)
		get_actual_gun().stop_shooting()
		# queue_free()


func _physics_process(delta: float) -> void:
	var direction = (player_pool.global_position - global_position)
	if direction.length() < PATH_LEN:
		return


	direction = direction.normalized()
	# move_and_collide(direction * SPEED * delta)