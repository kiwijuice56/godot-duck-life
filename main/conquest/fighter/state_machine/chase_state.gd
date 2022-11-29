class_name ChaseState
extends State

@export var chase_speed := 80
@export var attack_distance := 64
@export var bored_distance := 256
var target: Fighter

func physics_step(delta: float) -> void:
	var distance: Vector2 = target.global_position - fighter.global_position
	fighter.scale.x = sign(distance.x)
	if distance.length() >= attack_distance:
		var dir := distance.normalized()
		fighter.global_position += dir * chase_speed * delta
	else:
		fighter.state_machine.transition_to("AttackState", {"target" : target, "return_state" : "ChaseState"})
	if distance.length() >= bored_distance:
		fighter.state_machine.transition_to("PatrolState")

func enter(info: Dictionary) -> void:
	target = info.target
