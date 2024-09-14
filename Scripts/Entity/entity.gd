class_name Entity extends RigidBody3D

@export var health = 20
@export var hit_effect: PackedScene

@onready var vfx_pool: Node3D = get_node("/root/Main/VFXPool")

signal health_changed(old_value, new_value)


func take_damage(damage: int) -> void:
	var old_value = health
	health -= damage
	health_changed.emit(old_value, health)


func _ready() -> void:
	health_changed.emit(health, health)
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body is not Bullet:
		return

	var old_health = health
	health -= body.damage
	health_changed.emit(old_health, health)

	var effect: GPUParticles3D = hit_effect.instantiate()
	vfx_pool.add_child(effect)
	effect.global_position = body.global_position
	effect.emitting = true
	effect.finished.connect(effect.queue_free)

	body.queue_free()


func _process(_delta: float) -> void:
	if abs(global_position.y) > 10:
		queue_free()
