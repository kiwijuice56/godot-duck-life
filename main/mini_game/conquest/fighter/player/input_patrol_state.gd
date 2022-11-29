class_name InputPatrolState
extends State

var dir := Vector2()

func input() -> void:
	dir = Vector2()
	if Input.is_action_just_pressed("shoot2"):
		fighter.state_machine.transition_to("AttackState", {"target": null, "return_state" : "PatrolState", "attack": "Fireball"})
		return
	if Input.is_action_just_pressed("shoot"):
		fighter.state_machine.transition_to("AttackState", {"target": null, "return_state" : "PatrolState", "attack": "Physical"})
		return
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if dir.x != 0:
		fighter.get_node("Directional").scale.x = sign(dir.x)
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	dir = dir.normalized()
	
	if dir == Vector2():
		if fighter.get_node("AnimationPlayer").current_animation != "idle":
			fighter.get_node("AnimationPlayer").play("idle")
	else:
		if fighter.get_node("AnimationPlayer").current_animation != "walk":
			fighter.get_node("AnimationPlayer").play("walk")

func physics_step(delta: float) -> void:
	input()
	fighter.velocity = dir * speed(fighter.agility)
	fighter.move_and_slide()

func speed(agility: int) -> float:
	return -10000.0 / (agility + 50.0) + 250.0 
