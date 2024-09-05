class_name Entity extends RigidBody3D

@export var health = 20

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
	body.queue_free()


func _process(_delta: float) -> void:
	if abs(global_position.y) > 10:
		queue_free()
