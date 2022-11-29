class_name Attack
extends Area2D

@export var damage := 3.0

func disable() -> void:
	$CollisionShape2D.disabled = true

func enable() -> void:
	$CollisionShape2D.disabled = false
