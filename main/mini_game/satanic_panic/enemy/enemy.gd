class_name SatanicPanicEnemy
extends Area2D

@export var bullet: PackedScene
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
		get_parent().get_node("ScreenShakeCamera").add_trauma(4)
		$AnimationPlayer.play("death")
		speed /= 3
		died.emit(score)
		await $AnimationPlayer.animation_finished
		queue_free()
	else:
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
