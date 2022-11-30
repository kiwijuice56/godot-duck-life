class_name MageChaseState
extends ChaseState

@export var accuracy := 32
@export var pursuit_distance := 32

func physics_step(delta: float) -> void:
	if not is_instance_valid(target):
		fighter.state_machine.transition_to("PatrolState")
		return
	var distance: Vector2 = target.global_position - fighter.global_position
	if distance.x != 0:
		fighter.get_node("Directional").scale.x = sign(distance.x)
	
	var error: float = abs(distance.y)
	
	if distance.length() >= bored_distance:
		fighter.state_machine.transition_to("PatrolState", {"direction": -1 if randf() < 0.5 else 1})
		return
		
	if distance.length() >= attack_distance:
		if distance.length() >= pursuit_distance:
			var dir := distance.normalized()
			fighter.velocity = dir * chase_speed
			fighter.move_and_slide()
		elif error < accuracy:
			fighter.state_machine.transition_to("AttackState", {"target" : target, "return_state" : "ChaseState", "attack": "Fireball"})
		else:
			var dir := Vector2(0, sign(distance.y))
			fighter.velocity = dir * chase_speed
			fighter.move_and_slide()
	else:
		var dir := -distance.normalized()
		fighter.velocity = dir * chase_speed
		fighter.move_and_slide()

func enter(info: Dictionary) -> void:
	if info.target != null:
		target = info.target
	fighter.get_node("AnimationPlayer").play("walk")
