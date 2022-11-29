class_name Conquest
extends Node2D

func _on_started() -> void:
	get_node("ConquestPlayer/StateMachine").is_processing = true
