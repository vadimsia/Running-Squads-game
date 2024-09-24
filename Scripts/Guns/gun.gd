class_name Gun extends Node3D

@onready var barrel: Node3D = $Barrel
@onready var shoot_timer: Timer = $ShootTimer

@export var bullet_scene: PackedScene
@export var spread: float = 0.1
@export var shoot_interval = 0.1
@export var initial_rotation: Vector3
@export var bullets_amount = 1
@export var sound: AudioStream

var bullet_pool: BulletPool


func _ready() -> void:
	shoot_timer.timeout.connect(_on_shoot_timeout)
	bullet_pool = get_node("/root/Main/BulletPool")
	shoot_timer.wait_time = shoot_interval


func spread_rand() -> float:
	return randf_range(-spread, spread)


func stop_shooting() -> void:
	shoot_timer.stop()
	remove_child(barrel)


func _on_shoot_timeout() -> void:
	for i in range(0, bullets_amount):
		var bullet: Bullet = bullet_scene.instantiate() 
		bullet_pool.add_child(bullet)
		bullet.global_position = barrel.global_position
		bullet.linear_velocity += Vector3(spread_rand(), spread_rand(), spread_rand())


func _process(_delta: float) -> void:
	pass
