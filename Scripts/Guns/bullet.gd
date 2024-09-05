class_name Bullet extends RigidBody3D

@export var damage = 5

@onready var free_timer: Timer = $FreeTimer


func _ready() -> void:
    free_timer.timeout.connect(queue_free)
    gravity_scale = 0
    axis_lock_angular_x = true
    axis_lock_angular_y = true
    axis_lock_angular_z = true
