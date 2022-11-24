class_name SatanicPanicEnemy
extends Area2D

@export var bullet: PackedScene
@export var death_sound: Resource
@export var hurt_sound: Resource
@export var speed := 63
@export var health := 3
@export var score := 1

var player: SatanicPanicPlayer

signal died(score)

func _ready() -> void:
	$ShootDelay.timeout.connect(_on_delay_timeout)
	$ShootDelay.start()
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if health <= 0:
		return
	health -= 1
	area.queue_free()
	$AnimationPlayer.stop()
	if health == 0:
		var audio := AudioStreamPlayer.new()
		audio.stream = death_sound
		audio.pitch_scale = randf_range(0.8, 1.2)
		audio.finished.connect(audio.queue_free)
		get_parent().add_child(audio)
		audio.play()
		
		get_parent().get_node("ScreenShakeCamera").add_trauma(2)
		$AnimationPlayer.play("death")
		speed /= 3
		died.emit(score)
		await $AnimationPlayer.animation_finished
		queue_free()
	else:
		var audio := AudioStreamPlayer.new()
		audio.stream = hurt_sound
		audio.pitch_scale = randf_range(0.6, 1.2)
		audio.finished.connect(audio.queue_free)
		audio.volume_db = -4
		get_parent().add_child(audio)
		audio.play()
		
		$AnimationPlayer.play("hurt")
		speed /= 3
		await $AnimationPlayer.animation_finished
		speed *= 3

func _on_delay_timeout() -> void:
	if health <= 0:
		return
	var new_bullet: EnemyBullet = bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 2)
	new_bullet.global_position = global_position
	var dir := (player.global_position - global_position).normalized()
	new_bullet.rotation = rad_to_deg(Vector2(1, 0).angle_to(dir))
	new_bullet.dir = dir

func _physics_process(delta) -> void:
	physics_step(delta)

func physics_step(delta: float) -> void:
	global_position.y += delta * speed
