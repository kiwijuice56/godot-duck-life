class_name State
extends Node

var fighter: Fighter

func enter(info: Dictionary) -> void:
	print(str(fighter.name) + " " + str(name))

func exit() -> void:
	pass

func physics_step(delta: float) -> void:
	pass

