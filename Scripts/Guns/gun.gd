class_name Gun extends Node

@onready var barrel: Node3D = $Barrel
@onready var shoot_timer: Timer = $ShootTimer

@export var bullet_scene: PackedScene
@export var spread: float = 0.1

var bullet_pool: BulletPool


func _ready() -> void:
	shoot_timer.timeout.connect(_on_shoot_timeout)
	bullet_pool = get_node("/root/Main/BulletPool")


func spread_rand() -> float:
	return randf_range(-spread, spread)

func _on_shoot_timeout() -> void:
	var bullet: Bullet = bullet_scene.instantiate() 
	bullet_pool.add_child(bullet)
	bullet.global_position = barrel.global_position
	bullet.linear_velocity += Vector3(spread_rand(), spread_rand(), spread_rand())


func _process(_delta: float) -> void:
	pass
