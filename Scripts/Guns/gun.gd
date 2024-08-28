class_name Gun extends Node

@onready var barrel: Node3D = $Barrel
@onready var shoot_timer: Timer = $ShootTimer

@export var bullet: PackedScene


func _ready() -> void:
    shoot_timer.timeout.connect(_on_shoot_timeout)


func _on_shoot_timeout() -> void:
    barrel.add_child(bullet.instantiate())
    pass


func _process(_delta: float) -> void:
    pass

