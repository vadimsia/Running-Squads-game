class_name Wall extends Entity

@onready var health_label: Label3D = $HealthLabel


func _ready() -> void:
	health_changed.connect(_on_health_changed)
	super._ready()


func _on_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		queue_free()

	health_label.text = str(new_value)
