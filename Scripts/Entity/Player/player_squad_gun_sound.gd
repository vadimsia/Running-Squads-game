class_name PlayerSquadGunSound extends AudioStreamPlayer

var timer: Timer

@onready var player_pool: PlayerSquad = get_node("/root/Main/PlayerPool")

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.1
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func update_audio(gun: Gun):
	stream = gun.sound
	timer.wait_time = gun.shoot_interval


func _on_timer_timeout() -> void:
	if not player_pool.get_alive_player():
		return

	play()


func _process(_delta: float) -> void:
	var player = player_pool.get_alive_player()
	if not player or stream == player.get_actual_gun().sound:
		return
	
	update_audio(player.get_actual_gun())
