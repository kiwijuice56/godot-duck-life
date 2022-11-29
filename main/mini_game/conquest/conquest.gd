class_name Conquest
extends MiniGame

func _on_started() -> void:
	get_node("ConquestPlayer/StateMachine").is_running = true
