class_name SatanicPanic
extends MiniGame

@export var enemies: Array[PackedScene]

@export var prob_weight: Array[float]
@export var speed_increase := 0.025

var score := 0

func _ready() -> void:
	super._ready()
	$SpawnDelay.timeout.connect(_on_spawn_timeout)
	$Player.set_process(false)
	$Player.died.connect(_on_player_died)

func _on_player_died() -> void:
	$SpawnDelay.stop()
	var new_magic = max(1, int(score / 16))
	GlobalInfo.duck_info.magic += new_magic
	GlobalInfo.update_duck_info()
	UI.game_over_label.text = "Your duck gained %d magic points! Yay!" % new_magic
	await UI.game_over()
	finished.emit()

func _on_enemy_died(score_add: int) -> void:
	score += score_add
	UI.score_label.text = str(score)

func _on_started() -> void:
	$SpawnDelay.start()
	$Player.set_process(true)

func _on_spawn_timeout() -> void:
	var new_time: float = $SpawnDelay.wait_time - speed_increase
	$Background/AnimationPlayer.playback_speed *= 1.025
	new_time = max(new_time, 0.4)
	$SpawnDelay.start(new_time)
	score += 1
	UI.score_label.text = str(score)
	for _i in range(randi() % 3 + 1):
		spawn()

func spawn() -> void:
	var prob: float = randf()
	var new_enemy: Node2D
	for i in range(len(prob_weight)):
		if prob < prob_weight[i]:
			new_enemy = enemies[i].instantiate()
			break
	add_child(new_enemy)
	move_child(new_enemy, 2)
	new_enemy.speed += new_enemy.speed * randf_range(-0.15, 0.25)
	new_enemy.global_position.x = randi() % int(get_viewport().get_visible_rect().size.x) 
	new_enemy.global_position.x = clamp(new_enemy.global_position.x, 16, get_viewport().get_visible_rect().size.x - 16)
	new_enemy.global_position.y = -64
	if new_enemy is SatanicPanicEnemy:
		new_enemy.player = $Player
		new_enemy.died.connect(_on_enemy_died)
