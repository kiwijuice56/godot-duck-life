class_name SatanicPanicPlayer
extends Area2D

@export var player_bullet: PackedScene
@export var speed := 512

signal died

var dir := Vector2()

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if not is_physics_processing():
		return
	get_parent().get_node("ScreenShakeCamera").add_trauma(512)
	set_physics_process(false)
	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished
	died.emit()

func _physics_process(delta) -> void:
	input()
	global_position += dir.normalized() * delta * speed
	global_position.x = clamp(global_position.x, 16, get_viewport().get_visible_rect().size.x - 16)
	global_position.y = clamp(global_position.y, 16, 600 - 16)

func input() -> void:
	if Input.is_action_pressed("shoot"):
		shoot()
	
	dir = Vector2()
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	dir = dir.normalized()

func shoot() -> void:
	if not $ShootDelay.is_stopped():
		return
	var new_bullet: PlayerBullet = player_bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 2)
	new_bullet.global_position = global_position
	
	new_bullet = player_bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 1)
	new_bullet.global_position = global_position
	new_bullet.dir = Vector2(0, -1).rotated(2 * PI / 3)
	
	new_bullet = player_bullet.instantiate()
	get_parent().add_child(new_bullet)
	get_parent().move_child(new_bullet, 1)
	new_bullet.global_position = global_position
	new_bullet.dir = Vector2(0, -1).rotated(2 * PI / 3).rotated(2 * PI / 3)
	
	$ShootDelay.start()
