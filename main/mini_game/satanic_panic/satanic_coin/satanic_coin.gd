class_name SatanicCoin
extends Coin

@export var speed := 200.0

func _physics_process(delta) -> void:
	global_position.y += delta * speed

func collect() -> void:
	speed *= 0.1
	super.collect()
