class_name Entity extends RigidBody3D

@export var health = 20

signal health_changed(old_value, new_value)


func _ready() -> void:
	health_changed.emit(health, health)
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	print(body)
	if body is not Bullet:
		return

	var old_health = health
	health -= body.damage
	health_changed.emit(old_health, health)


func _process(delta: float) -> void:
	pass
