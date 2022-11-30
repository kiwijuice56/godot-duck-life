class_name IdleState
extends State

@export var min_time := 3.0
@export var max_time := 6.0

func _ready() -> void:
	await get_parent().ready
	fighter.vision_entered.connect(_on_vision_entered)
	$Timer.timeout.connect(_on_timeout)

func _on_vision_entered(area: Area2D) -> void:
	if fighter.state_machine.active_state == self:
		fighter.state_machine.transition_to("ChaseState", {"target" : area.get_parent()})

func _on_timeout() -> void:
	if fighter.state_machine.active_state == self:
		fighter.state_machine.transition_to("PatrolState", {"direction": -1 if randf() < 0.5 else 1})

func enter(info: Dictionary) -> void:
	fighter.get_node("AnimationPlayer").play("idle")
	$Timer.start(randf_range(min_time, max_time))
