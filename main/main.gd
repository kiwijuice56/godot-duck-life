class_name Main
extends Node

@export var home: PackedScene
@export var ui: TitleUI

func _ready() -> void:
	ui.started.connect(_on_started)

func _on_started() -> void:
	randomize()
	await Transition.trans_in()
	ui.queue_free()
	var new_home: Home = home.instantiate()
	add_child(new_home)
	await Transition.trans_out()
