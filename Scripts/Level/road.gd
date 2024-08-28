class_name Road extends Node3D

const SPEED = 5


func _process(delta: float) -> void:
	position.z += SPEED * delta

	
