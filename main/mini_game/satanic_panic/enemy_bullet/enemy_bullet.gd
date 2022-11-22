class_name EnemyBullet
extends Area2D

@export var speed := 300

var dir: Vector2

func _ready() -> void:
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)

func _physics_process(delta) -> void:
	global_position += delta * speed * dir
