class_name SatanicCoin
extends Coin

@export var speed := 700

func _physics_process(delta) -> void:
	global_position.y += delta * speed

func collect() -> void:
	speed *= .1
	super.collect()
