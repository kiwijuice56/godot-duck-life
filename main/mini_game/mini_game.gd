class_name MiniGame
extends Node

@export var UI: MiniGameUI

signal finished

func _ready() -> void:
	UI.started.connect(_on_started)

func _on_started() -> void:
	pass
