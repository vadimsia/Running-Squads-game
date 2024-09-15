class_name Bullet extends RigidBody3D

@export var damage = 5
@export var speed = 20

@onready var free_timer: Timer = $FreeTimer


func _ready() -> void:
	free_timer.timeout.connect(queue_free)
	gravity_scale = 0

	linear_velocity.z = -speed
