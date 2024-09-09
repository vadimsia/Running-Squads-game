class_name Wall extends Entity

@onready var health_label: Label3D = $HealthLabel


func _ready() -> void:
	health = randi_range(20, 100)
	health_changed.connect(_on_health_changed)
	body_entered.connect(_on_wall_body_entered)
	super._ready()


func _on_wall_body_entered(body: Node) -> void:
	if body is not Player:
		return
	
	body.take_damage(body.health)


func _on_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		queue_free()

	health_label.text = str(new_value)
