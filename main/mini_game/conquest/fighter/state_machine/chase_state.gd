class_name ChaseState
extends State

@export var chase_speed := 80
@export var attack_distance := 64
@export var bored_distance := 256
var target: Fighter

func physics_step(delta: float) -> void:
	if not is_instance_valid(target):
		fighter.state_machine.transition_to("PatrolState")
		return
	var distance: Vector2 = target.global_position - fighter.global_position
	if distance.x != 0:
		fighter.get_node("Directional").scale.x = sign(distance.x)
	if distance.length() >= attack_distance:
		var dir := distance.normalized()
		fighter.velocity = dir * chase_speed
		fighter.move_and_slide()
	else:
		fighter.state_machine.transition_to("AttackState", {"target" : target, "return_state" : "ChaseState"})
	if distance.length() >= bored_distance:
		fighter.state_machine.transition_to("PatrolState")

func enter(info: Dictionary) -> void:
	if info.target != null:
		target = info.target
	fighter.get_node("AnimationPlayer").play("walk")
