class_name AttackState
extends State

func enter(info: Dictionary) -> void:
	await fighter.attack(info.target)
	fighter.state_machine.transition_to(info.return_state, info)

