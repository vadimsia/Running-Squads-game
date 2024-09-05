class_name Player extends Entity

const PATH_LEN = 1
const SPEED = 10

@onready var player_pool: Node3D = get_parent()
@onready var anim_tree: AnimationTree = get_node("Model/AnimationTree")
@onready var collision_shape: CollisionShape3D = $CollisionShape3D


func _ready() -> void:
	super._ready()
	health_changed.connect(_on_health_changed)
	body_entered.connect(_on_player_body_entered)


func _on_player_body_entered(body: Node) -> void:
	if body is not Enemy:
		return

	take_damage(body.damage)
	# body.queue_free()


func _on_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		anim_tree.set("parameters/conditions/death", true)
		collision_shape.set_deferred("disabled", true)
		# queue_free()


func _physics_process(delta: float) -> void:
	var direction = (player_pool.global_position - global_position)
	if direction.length() < PATH_LEN:
		return


	direction = direction.normalized()
	move_and_collide(direction * SPEED * delta)