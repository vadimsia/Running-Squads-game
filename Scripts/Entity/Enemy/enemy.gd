class_name Enemy extends Entity

@export var damage = 5
@export var speed = 20

@onready var player_squad: PlayerSquad = get_node("/root/Main/PlayerPool")
@onready var anim_tree: AnimationTree = get_node("Model/AnimationTree")
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	health_changed.connect(_on_enemy_health_changed)
	super._ready()

	axis_lock_linear_z = true


func _on_enemy_health_changed(_old_value: int, new_value: int) -> void:
	if new_value <= 0:
		anim_tree.set("parameters/conditions/death", true)
		# queue_free()


func _physics_process(delta: float) -> void:
	if health <= 0:
		return

	var direction = (player_squad.global_position - global_position).normalized()
	#linear_velocity += direction * speed * delta
