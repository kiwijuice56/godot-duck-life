class_name PatrolState
extends State

@export var patrol_speed := 64.0

func _ready() -> void:
	await get_parent().ready
	fighter.vision_entered.connect(_on_vision_entered)

func _on_vision_entered(area: Area2D) -> void:
	if fighter.state_machine.active_state == self:
		fighter.state_machine.transition_to("ChaseState", {"target" : area.get_parent()})

func physics_step(delta) -> void:
	fighter.global_position.x -= patrol_speed * delta 