class_name InputPatrolState
extends State

var dir := Vector2()

func input() -> void:
	dir = Vector2()
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	dir = dir.normalized()

func physics_step(delta: float) -> void:
	input()
	fighter.global_position += speed(fighter.agility) * dir * delta

func speed(agility: int) -> float:
	return -10000.0 / (agility + 50.0) + 250.0 
