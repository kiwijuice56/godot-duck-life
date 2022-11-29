class_name StateMachine
extends Node

@onready var fighter: Fighter = get_parent()
@export var active_state: State
@export var is_processing := true

func _ready() -> void:
	for child in get_children():
		child.fighter = fighter

func physics_step(delta: float) -> void:
	if not is_processing:
		return
	active_state.physics_step(delta)

func transition_to(new_state_name: String) -> void:
	var new_state: State = get_node(new_state_name)
	active_state.exit()
	active_state = new_state
	active_state.enter()
