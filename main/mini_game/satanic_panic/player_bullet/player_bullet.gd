class_name PlayerBullet
extends Area2D

@export var speed := 800
var dir := Vector2(randf_range(-.05, .05), -1)

func _ready() -> void:
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)

func _physics_process(delta) -> void:
	global_position += delta * speed * dir
