class_name Coin
extends Area2D

func collect() -> void:
	$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1)
	$AnimationPlayer.play("collect")
	await $AnimationPlayer.animation_finished
	queue_free()
